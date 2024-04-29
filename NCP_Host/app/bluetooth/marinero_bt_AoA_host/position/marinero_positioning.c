/***************************************************************************//**
 * @file
 * @brief Single locator positioning calculation, combining AoA + RSSI or AoA + ABR
 *******************************************************************************/
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#include "marinero_positioning.h"
#include "aoa_angle_config.h"
#include "app_log.h"
#include "app_assert.h"

//position calculate definition
enum sl_rtl_error_code marinero_position_calculate(aoa_state_t *aoa_state,
                                                   aoa_angle_t *angle,
                                                   aoa_position_t *position,
                                                   aoa_id_t config_id);


enum sl_rtl_error_code marinero_position(aoa_state_t *aoa_state,
                                         aoa_iq_report_t *iq_report,
                                         aoa_angle_t *angle,
                                         aoa_position_t *position,
                                         aoa_id_t config_id,
                                         aoa_angle_mode_t angle_mode)
{
  enum sl_rtl_error_code ec;
  static unsigned int d_count;
  static float sum_d, stdev_d;
  static float mean_d;

  switch(angle_mode){
    case (RTL):
      ec = aoa_calculate(aoa_state,
                        iq_report,
                        angle,
                        config_id);

      if (ec == SL_RTL_ERROR_ESTIMATION_IN_PROGRESS) {
            // No valid angles are available yet.
            return ec;
          } 
          app_assert(ec == SL_RTL_ERROR_SUCCESS,
                    "[E: %d] Failed to calculate angle." APP_LOG_NL,
                    ec);
                    
      //distance stdev, reject first 10 data points
      d_count++;
      sum_d += angle->distance;
      mean_d = sum_d/(d_count);
      if (d_count > 10){
        stdev_d = sqrt((pow(((angle->distance) - mean_d),2)) / (d_count - 1));
        angle->distance_stdev = stdev_d;
      }
      break;
    case (MUSIC):
      marinero_MUSIC();
      break;
      //imple error checkinga
    default:
      break;
  }
  //call na position_calculate
  ec = marinero_position_calculate(aoa_state, 
                                   angle,
                                   position,
                                   config_id);

  return ec;
}

enum sl_rtl_error_code marinero_position_calculate(aoa_state_t *aoa_state,
                                                   aoa_angle_t *angle,
                                                   aoa_position_t *position,
                                                   aoa_id_t config_id)
{
  enum sl_rtl_error_code ec;

  float x;
  float y;
  float z;
  float d_crt;
  static float sum_x, stdev_x;
  static float sum_y, stdev_y;
  static float sum_z, stdev_z;
  static float mean_x, mean_y, mean_z;
  static unsigned int n_pos;

  n_pos++;

  //position calculate
  d_crt = angle->distance*sin(angle->elevation);
  x = d_crt*cos(angle->azimuth);
  y = d_crt*sin(angle->azimuth);
  z = angle->distance*sin(angle->elevation);
  
  //standard deviation calculate, first 10 data points rejected
  sum_x += x;
  mean_x = sum_x/(n_pos);

  sum_y += y;
  mean_y = sum_y/(n_pos);

  sum_z += z;
  mean_z = sum_z/(n_pos);

  //assign values
  position->x = x;
  position->y = y;
  position->z = z;

  if (n_pos > 10){
    stdev_x = sqrt((pow((x - mean_x),2))/ (n_pos-1));
    stdev_y = sqrt((pow((y - mean_y),2))/ (n_pos-1));
    stdev_z = sqrt((pow((z - mean_z),2))/ (n_pos-1));
    position->x_stdev = stdev_x;
    position->y_stdev = stdev_y;
    position->z_stdev = stdev_z;
  }

  ec = SL_RTL_ERROR_SUCCESS;
  return ec;
}