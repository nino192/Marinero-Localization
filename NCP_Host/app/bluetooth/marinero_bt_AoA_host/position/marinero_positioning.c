/***************************************************************************//**
 * @file
 * @brief Single locator positioning calculation, combining AoA + RSSI or AoA + ABR
 *******************************************************************************/
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

#include "marinero_positioning.h"
#include "aoa_angle_config.h"
#include "app_log.h"
#include "app_assert.h"




enum sl_rtl_error_code marinero_position(aoa_state_t *aoa_state,
                                         aoa_iq_report_t *iq_report,
                                         aoa_angle_t *angle,
                                         aoa_position_t *position,
                                         aoa_id_t config_id,
                                         aoa_angle_mode_t angle_mode)
{
  enum sl_rtl_error_code ec;


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
      break;
    case (MUSIC):
      marinero_MUSIC();
      break;
      //imple error checkinga
    default:
      break;
  }
  //call na position_calculate
  

  return ec;
}