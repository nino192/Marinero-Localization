/***************************************************************************//**
 * @file
 * @brief Core application logic.
 *******************************************************************************
 * # License
 * <b>Copyright 2020 Silicon Laboratories Inc. www.silabs.com</b>
 *******************************************************************************
 *
 * SPDX-License-Identifier: Zlib
 *
 * The licensor of this software is Silicon Laboratories Inc.
 *
 * This software is provided 'as-is', without any express or implied
 * warranty. In no event will the authors be held liable for any damages
 * arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 *
 ******************************************************************************/
#include "em_common.h"
#include "app_assert.h"
#include "sl_bluetooth.h"
#include "app.h"

// The advertising set handle allocated from Bluetooth stack.
static uint8_t advertising_set_handle = 0xff;

//Intervals
uint16_t interval_min = 400;
uint16_t interval_max = 800;

// Flags
#define ADVERTISE_FLAGS_LENGTH 0x02
#define ADVERTISE_FLAGS_TYPE   0x01
#define ADVERTISE_FLAGS_VALUE  0x06
uint32_t flags = SL_BT_PERIODIC_ADVERTISER_INCLUDE_TX_POWER; // 0x1

#define ADVERTISE_MANDATA_LENGTH      0x1A
#define ADVERTISE_MANDATA_TYPE        0xFF
#define ADVERTISE_MANDATA_COMPANY_ID  0x004C
#define ADVERTISE_MANDATA_VALUE       { 0x02, 0x15, 0x01, 0x02, 0x03, 0x04, 0x05,\
    0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10,\
    0x00, 0x01,\
    0x00, 0x02,\
    0x00}

#define UINT16_TO_BYTES(x) { (uint8_t)(x), (uint8_t)((x) >> 8) }

typedef struct
{
  uint8_t flags_length;
  uint8_t flags_type;
  uint8_t flags_value;
  uint8_t mandata_length;
  uint8_t mandata_type;
  uint8_t mandata_company_id[2];
  uint8_t mandata_value[23];
} ble_advertise_data_t;

#define ADVERTISE_DATA_DEFAULT \
{ \
  .flags_length = ADVERTISE_FLAGS_LENGTH, \
  .flags_type = ADVERTISE_FLAGS_TYPE,\
  .flags_value = ADVERTISE_FLAGS_VALUE,\
  .mandata_length = ADVERTISE_MANDATA_LENGTH,\
  .mandata_type = ADVERTISE_MANDATA_TYPE,\
  .mandata_company_id = UINT16_TO_BYTES(ADVERTISE_MANDATA_COMPANY_ID),\
  .mandata_value = ADVERTISE_MANDATA_VALUE\
}

static const ble_advertise_data_t adv_data = ADVERTISE_DATA_DEFAULT;

/**************************************************************************//**
 * Application Init.
 *****************************************************************************/
SL_WEAK void app_init(void)
{
  /////////////////////////////////////////////////////////////////////////////
  // Put your additional application init code here!                         //
  // This is called once during start-up.                                    //
  /////////////////////////////////////////////////////////////////////////////
}

/**************************************************************************//**
 * Application Process Action.
 *****************************************************************************/
SL_WEAK void app_process_action(void)
{
  /////////////////////////////////////////////////////////////////////////////
  // Put your additional application code here!                              //
  // This is called infinitely.                                              //
  // Do not call blocking functions from here!                               //
  /////////////////////////////////////////////////////////////////////////////
}

/**************************************************************************//**
 * Bluetooth stack event handler.
 * This overrides the dummy weak implementation.
 *
 * @param[in] evt Event coming from the Bluetooth stack.
 *****************************************************************************/
void sl_bt_on_event(sl_bt_msg_t *evt)
{
  sl_status_t sc;

  bd_addr address;
  uint8_t address_type;

  switch (SL_BT_MSG_ID(evt->header)) {
    // -------------------------------
    // This event indicates the device has started and the radio is ready.
    // Do not call any stack command before receiving this boot event!
    case sl_bt_evt_system_boot_id:

      app_log("iBeacon example started!\r\n");

      // Retrieve the BT Address.
      sc = sl_bt_system_get_identity_address(&address, &address_type);
      app_assert_status(sc);

      app_log("BT Address: ");
      for (int i=0; i<5; i++)
        {
          app_log("%02X:", address.addr[5-i]);
        }

      app_log("%02X (%s)\r\n", address.addr[0], address_type == 0 ? "Public device address": "Static random address");

      // Create an advertising set.
      sc = sl_bt_advertiser_create_set(&advertising_set_handle);
      app_assert_status(sc);

      // Generate data for advertising
      sc = sl_bt_periodic_advertiser_set_data(advertising_set_handle,
                                              sizeof(adv_data),
                                              (uint8_t *)&adv_data);

      app_assert_status(sc);

      // Start advertising and enable connections.
      sc = sl_bt_periodic_advertiser_start(advertising_set_handle,
                                           interval_min,
                                           interval_max,
                                           flags);
      app_assert_status(sc);
      break;

    // -------------------------------
    // This event indicates that a new connection was opened.
    case sl_bt_evt_connection_opened_id:
      break;

    // -------------------------------
    // This event indicates that a connection was closed.
    case sl_bt_evt_connection_closed_id:
      break;

    ///////////////////////////////////////////////////////////////////////////
    // Add additional event handlers here as your application requires!      //
    ///////////////////////////////////////////////////////////////////////////

    // -------------------------------
    // Default event handler.
    default:
      break;
  }
}
