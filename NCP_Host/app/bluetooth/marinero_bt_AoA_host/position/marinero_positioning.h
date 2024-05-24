/***************************************************************************//**
 * @file
 * @brief Single locator positioning calculation, combining AoA + RSSI
 *******************************************************************************/

#ifndef MARINERO_POSITIONING_H
#define MARINERO_POSITIONING_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>
#include "aoa_types.h"
#include "sl_rtl_clib_api.h"
#include "sl_status.h"
#include "aoa_util.h"
#include "antenna_array.h"
#include "aoa_angle.h"
#include "aoa_parse_enum.h"
#include "marinero_angle.h"

#ifndef M_PI
    #define M_PI 3.14159265358979323846
#endif

/***************************************************************************//**
 * Calculate position from angle and distance
 *
 * @param[in] aoa_state Position calculation handler
 * @param[in] iq_report IQ report to convert
 * @param[out] position Estimated position data
 *
 * @return Status returned by the RTL library
 ******************************************************************************/
enum sl_rtl_error_code marinero_position(aoa_state_t *aoa_state,
                                         aoa_iq_report_t *iq_report,
                                         aoa_angle_t *angle,
                                         aoa_position_t *position,
                                         aoa_id_t config_id,
                                         aoa_angle_mode_t angle_mode);

//position calculate definition
enum sl_rtl_error_code marinero_position_calculate(aoa_state_t *aoa_state,
                                                   aoa_angle_t *angle,
                                                   aoa_position_t *position,
                                                   aoa_id_t config_id);
                                                   
#ifdef __cplusplus
};
#endif

#endif //MARINERO_POSITIONING_H