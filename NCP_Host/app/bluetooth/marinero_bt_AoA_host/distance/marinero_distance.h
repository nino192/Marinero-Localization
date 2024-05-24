#ifndef MARINERO_DISTANCE_H
#define MARINERO_DISTANCE_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>
#include "aoa_types.h"
#include "sl_rtl_clib_api.h"

enum sl_rtl_error_code calculate_avg_RSSI(aoa_iq_report_t *iq_report);

#ifdef __cplusplus
};
#endif

#endif //MARINERO_POSITIONING_H