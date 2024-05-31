#include "marinero_distance.h"
#include "marinero_positioning.h"
#include "antenna_array.h"

enum sl_rtl_error_code calculate_avg_RSSI(aoa_iq_report_t *iq_report)
{
  enum sl_rtl_error_code ec;

  int rssi_first_antenna = iq_report->rssi;
  int num_antennas = ANTENNA_ARRAY_MAX_PIN_PATTERN_SIZE;              //for BRD4191A
  int num_ref_samples = ANTENNA_ARRAY_MAX_PATTERN_SIZE - 2;          // ovdje uzimam od 14 clana iq reporta pa nadalje
  int antenna_samples[(num_antennas - 1) * 2];

  double *powers = (double *)malloc((num_antennas) * sizeof(double));
    if (powers == NULL) {
        ec = SL_RTL_ERROR_OUT_OF_MEMORY;
        return ec;
  };

  double *rssi_values = (double *)malloc(num_antennas * sizeof(double));
    if (rssi_values == NULL) {
        free(powers);
        ec = SL_RTL_ERROR_OUT_OF_MEMORY;
        return ec;
  }

  // Skip reference samples
  for (int i = 0; i < ((num_antennas) * 2); i++){
    antenna_samples[i] = iq_report->samples[i + num_ref_samples];
  };

  // Calculate the power for each antenna's IQ pair
  for (int i = 0; i < (num_antennas); i++){
    int I = antenna_samples[i * 2];
    int Q = antenna_samples[i * 2 + 1];
    powers[i] = (double)(I * I + Q * Q);
  }

  double reference_power = powers[0];
  double reference_rssi = (double)rssi_first_antenna;
  double reference_power_dbm = 10.0 * log10(reference_power);

  // Calculate RSSI for each antenna based on the reference
  for (int i = 0; i < num_antennas; i++) {
        rssi_values[i] = 10.0 * log10(powers[i]) - reference_power_dbm + reference_rssi;
  }

  // Calculate average RSSI
  double sum_rssi = 0.0;
  for (int i = 0; i < num_antennas; i++) {
    sum_rssi += rssi_values[i];
  }
  double average_rssi = sum_rssi / num_antennas;

  // Calculate weighted average RSSI
  double rssi_min = rssi_values[0];
  for (int i = 1; i < num_antennas; i++) {
    if (rssi_values[i] < rssi_min) {
      rssi_min = rssi_values[i];
    }
  }

  double denom = 0.0;
  for (int i = 0; i < num_antennas; i++) {
    denom += rssi_values[i] - rssi_min;
  }

  double average_rssi_weighted = 0.0;
  for (int i = 0; i < num_antennas; i++) {
    average_rssi_weighted += ((rssi_values[i] - rssi_min) / denom) * rssi_values[i];
  }

  // Add new RSSI to packet
  iq_report->rssi = round(average_rssi_weighted);
  //iq_report->rssi = round(average_rssi);      //use non-weighted RSSI

  free(powers);
  free(rssi_values);

  ec = SL_RTL_ERROR_SUCCESS;

  return ec;
}