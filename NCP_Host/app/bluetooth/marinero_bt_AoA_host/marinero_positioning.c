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

enum sl_rtl_error_code marinero_position(aoa_state_t *aoa_state,
                                         aoa_iq_report_t *iq_report,
                                         aoa_position_t *position,
                                         aoa_id_t config_id)
{
  return;
}