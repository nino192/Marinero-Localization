################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/home/nino/SimplicityStudio/SDKs/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer.c \
/home/nino/SimplicityStudio/SDKs/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.c \
/home/nino/SimplicityStudio/SDKs/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.c \
/home/nino/SimplicityStudio/SDKs/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.c \
/home/nino/SimplicityStudio/SDKs/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer_hal_timer.c 

OBJS += \
./gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer.o \
./gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.o \
./gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.o \
./gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.o \
./gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_timer.o 

C_DEPS += \
./gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer.d \
./gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.d \
./gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.d \
./gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.d \
./gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_timer.d 


# Each subdirectory must supply rules for building sources it contributes
gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer.o: /home/nino/SimplicityStudio/SDKs/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer.c gecko_sdk_4.4.4/platform/service/sleeptimer/src/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM C Compiler'
	arm-none-eabi-gcc -g -gdwarf-2 -mcpu=cortex-m33 -mthumb -std=c99 '-DBGM220PC22HNA=1' '-DHARDWARE_BOARD_DEFAULT_RF_BAND_2400=1' '-DHARDWARE_BOARD_SUPPORTS_1_RF_BAND=1' '-DHARDWARE_BOARD_SUPPORTS_RF_BAND_2400=1' '-DSL_BOARD_NAME="BRD4314A"' '-DSL_BOARD_REV="A02"' '-DSL_COMPONENT_CATALOG_PRESENT=1' '-DMBEDTLS_CONFIG_FILE=<sl_mbedtls_config.h>' '-DMBEDTLS_PSA_CRYPTO_CONFIG_FILE=<psa_crypto_config.h>' '-DSL_RAIL_LIB_MULTIPROTOCOL_SUPPORT=0' '-DSL_RAIL_UTIL_PA_CONFIG_HEADER=<sl_rail_util_pa_config.h>' '-DSLI_RADIOAES_REQUIRES_MASKING=1' -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/autogen" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/config" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/config/btconf" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/Device/SiliconLabs/BGM22/Include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/common/util/app_assert" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/common/util/app_log" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/common/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/bgcommon/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/bgstack/ll/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//hardware/board/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/CMSIS/Core/Include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//hardware/driver/configuration_over_swo/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_cryptoacc_library/include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_cryptoacc_library/src" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/driver/debug/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/device_init/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/dmadrv/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/common/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emlib/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/fem_util" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/bluetooth/common/gatt_service_device_information" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/iostream/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/config" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/config/preset" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/third_party/mbedtls/include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/third_party/mbedtls/library" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/mpu/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/nvm3/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/power_manager/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_psa_driver/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/common" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/ble" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/ieee802154" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/wmbus" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/zwave" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/chip/efr32/efr32xg2x" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/sidewalk" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/pa-conversions" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/pa-conversions/efr32xg22" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/rail_util_power_manager_init" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/rail_util_pti" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/se_manager/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/se_manager/src" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/silicon_labs/silabs_core/memory_manager" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/common/toolchain/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/system/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/sleeptimer/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_protocol_crypto/src" -O0 -Wall -Wextra -fomit-frame-pointer -ffunction-sections -fdata-sections -imacrossl_gcc_preinclude.h -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mcmse --specs=nano.specs -c -fmessage-length=0 -MMD -MP -MF"gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.o: /home/nino/SimplicityStudio/SDKs/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.c gecko_sdk_4.4.4/platform/service/sleeptimer/src/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM C Compiler'
	arm-none-eabi-gcc -g -gdwarf-2 -mcpu=cortex-m33 -mthumb -std=c99 '-DBGM220PC22HNA=1' '-DHARDWARE_BOARD_DEFAULT_RF_BAND_2400=1' '-DHARDWARE_BOARD_SUPPORTS_1_RF_BAND=1' '-DHARDWARE_BOARD_SUPPORTS_RF_BAND_2400=1' '-DSL_BOARD_NAME="BRD4314A"' '-DSL_BOARD_REV="A02"' '-DSL_COMPONENT_CATALOG_PRESENT=1' '-DMBEDTLS_CONFIG_FILE=<sl_mbedtls_config.h>' '-DMBEDTLS_PSA_CRYPTO_CONFIG_FILE=<psa_crypto_config.h>' '-DSL_RAIL_LIB_MULTIPROTOCOL_SUPPORT=0' '-DSL_RAIL_UTIL_PA_CONFIG_HEADER=<sl_rail_util_pa_config.h>' '-DSLI_RADIOAES_REQUIRES_MASKING=1' -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/autogen" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/config" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/config/btconf" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/Device/SiliconLabs/BGM22/Include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/common/util/app_assert" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/common/util/app_log" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/common/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/bgcommon/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/bgstack/ll/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//hardware/board/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/CMSIS/Core/Include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//hardware/driver/configuration_over_swo/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_cryptoacc_library/include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_cryptoacc_library/src" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/driver/debug/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/device_init/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/dmadrv/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/common/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emlib/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/fem_util" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/bluetooth/common/gatt_service_device_information" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/iostream/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/config" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/config/preset" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/third_party/mbedtls/include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/third_party/mbedtls/library" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/mpu/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/nvm3/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/power_manager/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_psa_driver/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/common" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/ble" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/ieee802154" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/wmbus" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/zwave" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/chip/efr32/efr32xg2x" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/sidewalk" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/pa-conversions" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/pa-conversions/efr32xg22" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/rail_util_power_manager_init" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/rail_util_pti" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/se_manager/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/se_manager/src" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/silicon_labs/silabs_core/memory_manager" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/common/toolchain/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/system/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/sleeptimer/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_protocol_crypto/src" -O0 -Wall -Wextra -fomit-frame-pointer -ffunction-sections -fdata-sections -imacrossl_gcc_preinclude.h -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mcmse --specs=nano.specs -c -fmessage-length=0 -MMD -MP -MF"gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.o: /home/nino/SimplicityStudio/SDKs/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.c gecko_sdk_4.4.4/platform/service/sleeptimer/src/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM C Compiler'
	arm-none-eabi-gcc -g -gdwarf-2 -mcpu=cortex-m33 -mthumb -std=c99 '-DBGM220PC22HNA=1' '-DHARDWARE_BOARD_DEFAULT_RF_BAND_2400=1' '-DHARDWARE_BOARD_SUPPORTS_1_RF_BAND=1' '-DHARDWARE_BOARD_SUPPORTS_RF_BAND_2400=1' '-DSL_BOARD_NAME="BRD4314A"' '-DSL_BOARD_REV="A02"' '-DSL_COMPONENT_CATALOG_PRESENT=1' '-DMBEDTLS_CONFIG_FILE=<sl_mbedtls_config.h>' '-DMBEDTLS_PSA_CRYPTO_CONFIG_FILE=<psa_crypto_config.h>' '-DSL_RAIL_LIB_MULTIPROTOCOL_SUPPORT=0' '-DSL_RAIL_UTIL_PA_CONFIG_HEADER=<sl_rail_util_pa_config.h>' '-DSLI_RADIOAES_REQUIRES_MASKING=1' -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/autogen" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/config" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/config/btconf" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/Device/SiliconLabs/BGM22/Include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/common/util/app_assert" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/common/util/app_log" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/common/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/bgcommon/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/bgstack/ll/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//hardware/board/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/CMSIS/Core/Include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//hardware/driver/configuration_over_swo/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_cryptoacc_library/include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_cryptoacc_library/src" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/driver/debug/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/device_init/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/dmadrv/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/common/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emlib/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/fem_util" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/bluetooth/common/gatt_service_device_information" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/iostream/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/config" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/config/preset" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/third_party/mbedtls/include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/third_party/mbedtls/library" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/mpu/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/nvm3/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/power_manager/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_psa_driver/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/common" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/ble" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/ieee802154" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/wmbus" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/zwave" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/chip/efr32/efr32xg2x" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/sidewalk" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/pa-conversions" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/pa-conversions/efr32xg22" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/rail_util_power_manager_init" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/rail_util_pti" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/se_manager/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/se_manager/src" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/silicon_labs/silabs_core/memory_manager" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/common/toolchain/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/system/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/sleeptimer/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_protocol_crypto/src" -O0 -Wall -Wextra -fomit-frame-pointer -ffunction-sections -fdata-sections -imacrossl_gcc_preinclude.h -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mcmse --specs=nano.specs -c -fmessage-length=0 -MMD -MP -MF"gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.o: /home/nino/SimplicityStudio/SDKs/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.c gecko_sdk_4.4.4/platform/service/sleeptimer/src/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM C Compiler'
	arm-none-eabi-gcc -g -gdwarf-2 -mcpu=cortex-m33 -mthumb -std=c99 '-DBGM220PC22HNA=1' '-DHARDWARE_BOARD_DEFAULT_RF_BAND_2400=1' '-DHARDWARE_BOARD_SUPPORTS_1_RF_BAND=1' '-DHARDWARE_BOARD_SUPPORTS_RF_BAND_2400=1' '-DSL_BOARD_NAME="BRD4314A"' '-DSL_BOARD_REV="A02"' '-DSL_COMPONENT_CATALOG_PRESENT=1' '-DMBEDTLS_CONFIG_FILE=<sl_mbedtls_config.h>' '-DMBEDTLS_PSA_CRYPTO_CONFIG_FILE=<psa_crypto_config.h>' '-DSL_RAIL_LIB_MULTIPROTOCOL_SUPPORT=0' '-DSL_RAIL_UTIL_PA_CONFIG_HEADER=<sl_rail_util_pa_config.h>' '-DSLI_RADIOAES_REQUIRES_MASKING=1' -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/autogen" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/config" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/config/btconf" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/Device/SiliconLabs/BGM22/Include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/common/util/app_assert" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/common/util/app_log" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/common/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/bgcommon/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/bgstack/ll/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//hardware/board/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/CMSIS/Core/Include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//hardware/driver/configuration_over_swo/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_cryptoacc_library/include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_cryptoacc_library/src" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/driver/debug/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/device_init/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/dmadrv/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/common/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emlib/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/fem_util" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/bluetooth/common/gatt_service_device_information" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/iostream/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/config" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/config/preset" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/third_party/mbedtls/include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/third_party/mbedtls/library" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/mpu/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/nvm3/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/power_manager/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_psa_driver/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/common" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/ble" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/ieee802154" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/wmbus" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/zwave" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/chip/efr32/efr32xg2x" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/sidewalk" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/pa-conversions" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/pa-conversions/efr32xg22" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/rail_util_power_manager_init" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/rail_util_pti" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/se_manager/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/se_manager/src" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/silicon_labs/silabs_core/memory_manager" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/common/toolchain/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/system/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/sleeptimer/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_protocol_crypto/src" -O0 -Wall -Wextra -fomit-frame-pointer -ffunction-sections -fdata-sections -imacrossl_gcc_preinclude.h -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mcmse --specs=nano.specs -c -fmessage-length=0 -MMD -MP -MF"gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_timer.o: /home/nino/SimplicityStudio/SDKs/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer_hal_timer.c gecko_sdk_4.4.4/platform/service/sleeptimer/src/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM C Compiler'
	arm-none-eabi-gcc -g -gdwarf-2 -mcpu=cortex-m33 -mthumb -std=c99 '-DBGM220PC22HNA=1' '-DHARDWARE_BOARD_DEFAULT_RF_BAND_2400=1' '-DHARDWARE_BOARD_SUPPORTS_1_RF_BAND=1' '-DHARDWARE_BOARD_SUPPORTS_RF_BAND_2400=1' '-DSL_BOARD_NAME="BRD4314A"' '-DSL_BOARD_REV="A02"' '-DSL_COMPONENT_CATALOG_PRESENT=1' '-DMBEDTLS_CONFIG_FILE=<sl_mbedtls_config.h>' '-DMBEDTLS_PSA_CRYPTO_CONFIG_FILE=<psa_crypto_config.h>' '-DSL_RAIL_LIB_MULTIPROTOCOL_SUPPORT=0' '-DSL_RAIL_UTIL_PA_CONFIG_HEADER=<sl_rail_util_pa_config.h>' '-DSLI_RADIOAES_REQUIRES_MASKING=1' -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/autogen" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/config" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte/config/btconf" -I"/home/nino/Marinero_DOA_BLE/bt_beacon_cte" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/Device/SiliconLabs/BGM22/Include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/common/util/app_assert" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/common/util/app_log" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/common/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/bgcommon/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//protocol/bluetooth/bgstack/ll/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//hardware/board/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/CMSIS/Core/Include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//hardware/driver/configuration_over_swo/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_cryptoacc_library/include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_cryptoacc_library/src" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/driver/debug/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/device_init/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/dmadrv/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/common/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emlib/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/fem_util" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//app/bluetooth/common/gatt_service_device_information" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/iostream/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/config" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/config/preset" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_mbedtls_support/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/third_party/mbedtls/include" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/third_party/mbedtls/library" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/mpu/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/emdrv/nvm3/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/power_manager/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_psa_driver/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/common" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/ble" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/ieee802154" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/wmbus" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/zwave" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/chip/efr32/efr32xg2x" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/protocol/sidewalk" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/pa-conversions" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/pa-conversions/efr32xg22" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/rail_util_power_manager_init" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/radio/rail_lib/plugin/rail_util_pti" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/se_manager/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/se_manager/src" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//util/silicon_labs/silabs_core/memory_manager" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/common/toolchain/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/system/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/service/sleeptimer/inc" -I"/home/nino/SimplicityStudio/SDKs/gecko_sdk//platform/security/sl_component/sl_protocol_crypto/src" -O0 -Wall -Wextra -fomit-frame-pointer -ffunction-sections -fdata-sections -imacrossl_gcc_preinclude.h -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mcmse --specs=nano.specs -c -fmessage-length=0 -MMD -MP -MF"gecko_sdk_4.4.4/platform/service/sleeptimer/src/sl_sleeptimer_hal_timer.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


