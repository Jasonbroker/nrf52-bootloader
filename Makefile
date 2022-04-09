# could be 52832 or 52810
mcu_opt := 52810
debug := no

chip_name := nrf$(mcu_opt)
PROJECT_NAME     := secure_bootloader
OUTPUT_DIRECTORY := _build

ifeq ($(strip $(mcu_opt)), 52810)
my_softdevice = s112
else 
my_softdevice = s132
endif
TARGETS          := nrf$(mcu_opt)_xxaa_bootloader_$(my_softdevice)

SDK_ROOT := ../nRF5_SDK_17.1.0
PROJ_DIR := .

ifeq ($(strip $(mcu_opt)), 52810)

  $(OUTPUT_DIRECTORY)/nrf52810_xxaa_s112.out: \
  LINKER_SCRIPT  := secure_bootloader_gcc_nrf52810.ld
else 

  $(OUTPUT_DIRECTORY)/nrf52832_xxaa_bootloader_s132.out: \
  LINKER_SCRIPT  := secure_bootloader_gcc_nrf52.ld
endif


 ifeq ($(strip $(debug)), yes)
 SRC_FILES += \
   $(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_rtt.c \
   $(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_serial.c \
   $(SDK_ROOT)/components/libraries/log/src/nrf_log_default_backends.c \
   $(SDK_ROOT)/components/libraries/log/src/nrf_log_frontend.c \
   $(SDK_ROOT)/components/libraries/log/src/nrf_log_str_formatter.c \
   $(SDK_ROOT)/external/fprintf/nrf_fprintf.c \
   $(SDK_ROOT)/external/fprintf/nrf_fprintf_format.c \
   $(SDK_ROOT)/external/segger_rtt/SEGGER_RTT.c \
   $(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_Syscalls_GCC.c \
   $(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_printf.c \
  
 INC_FOLDERS += \
   $(SDK_ROOT)/external/fprintf \
   $(SDK_ROOT)/external/segger_rtt \

 CFLAGS += -DDEBUG_NRF
 CFLAGS += -DNRF_DFU_DEBUG_VERSION
 CFLAGS += -DNRF_LOG_BACKEND_RTT_ENABLED=1
 CFLAGS += -DNRF_LOG_BACKEND_RTT_TEMP_BUFFER_SIZE=64
 CFLAGS += -DNRF_LOG_BACKEND_RTT_TX_RETRY_DELAY_MS=1
 CFLAGS += -DNRF_LOG_BACKEND_RTT_TX_RETRY_CNT=3
 CFLAGS += -DNRF_LOG_BUFSIZE=512
 CFLAGS += -DSEGGER_RTT_CONFIG_BUFFER_SIZE_UP=512
 CFLAGS += -DSEGGER_RTT_CONFIG_MAX_NUM_UP_BUFFERS=2
 CFLAGS += -DSEGGER_RTT_CONFIG_BUFFER_SIZE_DOWN=16
 CFLAGS += -DSEGGER_RTT_CONFIG_MAX_NUM_DOWN_BUFFERS=2
 CFLAGS += -DSEGGER_RTT_CONFIG_DEFAULT_MODE=0

 ASMFLAGS += -DDEBUG_NRF
 ASMFLAGS += -DNRF_DFU_DEBUG_VERSION
 ASMFLAGS += -DNRF_LOG_BACKEND_RTT_ENABLED=1
 ASMFLAGS += -DNRF_LOG_BACKEND_RTT_TEMP_BUFFER_SIZE=64
 ASMFLAGS += -DNRF_LOG_BACKEND_RTT_TX_RETRY_DELAY_MS=1
 ASMFLAGS += -DNRF_LOG_BACKEND_RTT_TX_RETRY_CNT=3
 ASMFLAGS += -DNRF_LOG_BUFSIZE=512
 ASMFLAGS += -DSEGGER_RTT_CONFIG_BUFFER_SIZE_UP=512
 ASMFLAGS += -DSEGGER_RTT_CONFIG_MAX_NUM_UP_BUFFERS=2
 ASMFLAGS += -DSEGGER_RTT_CONFIG_BUFFER_SIZE_DOWN=16
 ASMFLAGS += -DSEGGER_RTT_CONFIG_MAX_NUM_DOWN_BUFFERS=2
 ASMFLAGS += -DSEGGER_RTT_CONFIG_DEFAULT_MODE=0

 endif

# Source files common to all targets
SRC_FILES += \
  $(SDK_ROOT)/components/libraries/util/app_error_weak.c \
  $(SDK_ROOT)/components/libraries/scheduler/app_scheduler.c \
  $(SDK_ROOT)/components/libraries/util/app_util_platform.c \
  $(SDK_ROOT)/components/libraries/crc32/crc32.c \
  $(SDK_ROOT)/components/libraries/mem_manager/mem_manager.c \
  $(SDK_ROOT)/components/libraries/util/nrf_assert.c \
  $(SDK_ROOT)/components/libraries/atomic_fifo/nrf_atfifo.c \
  $(SDK_ROOT)/components/libraries/atomic/nrf_atomic.c \
  $(SDK_ROOT)/components/libraries/balloc/nrf_balloc.c \
  $(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage.c \
  $(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage_nvmc.c \
  $(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage_sd.c \
  $(SDK_ROOT)/components/libraries/memobj/nrf_memobj.c \
  $(SDK_ROOT)/components/libraries/queue/nrf_queue.c \
  $(SDK_ROOT)/components/libraries/ringbuf/nrf_ringbuf.c \
  $(SDK_ROOT)/components/libraries/experimental_section_vars/nrf_section_iter.c \
  $(SDK_ROOT)/components/libraries/strerror/nrf_strerror.c \
  $(SDK_ROOT)/components/libraries/sha256/sha256.c \
  $(SDK_ROOT)/modules/nrfx/hal/nrf_nvmc.c \
  $(SDK_ROOT)/modules/nrfx/soc/nrfx_atomic.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecc.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecdh.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecdsa.c \
  $(SDK_ROOT)/components/boards/boards.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_svci.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_svci_handler.c \
  $(SDK_ROOT)/components/libraries/svc/nrf_svc_handler.c \
  $(SDK_ROOT)/components/libraries/crypto/nrf_crypto_ecc.c \
  $(SDK_ROOT)/components/libraries/crypto/nrf_crypto_ecdsa.c \
  $(SDK_ROOT)/components/libraries/crypto/nrf_crypto_hash.c \
  $(SDK_ROOT)/components/libraries/crypto/nrf_crypto_init.c \
  $(SDK_ROOT)/components/libraries/crypto/nrf_crypto_shared.c \
  $(PROJ_DIR)/../3mod_module/dfu_public_key.c \
  $(PROJ_DIR)/main.c \
  $(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader.c \
  $(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_app_start.c \
  $(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_app_start_final.c \
  $(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_dfu_timers.c \
  $(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_fw_activation.c \
  $(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_info.c \
  $(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_wdt.c \
  $(SDK_ROOT)/external/nano-pb/pb_common.c \
  $(SDK_ROOT)/external/nano-pb/pb_decode.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/nrf_sw/nrf_sw_backend_hash.c \
  $(SDK_ROOT)/components/ble/common/ble_srv_common.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/dfu-cc.pb.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu.c \
  $(SDK_ROOT)/components/libraries/bootloader/ble_dfu/nrf_dfu_ble.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_flash.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_handling_error.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_mbr.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_req_handler.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_settings.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_settings_svci.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_transport.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_utils.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_validation.c \
  $(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_ver_validation.c \
  $(SDK_ROOT)/components/softdevice/common/nrf_sdh.c \
  $(SDK_ROOT)/components/softdevice/common/nrf_sdh_ble.c \
  $(SDK_ROOT)/components/softdevice/common/nrf_sdh_soc.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_chacha_poly_aead.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_ecc.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_ecdh.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_ecdsa.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_eddsa.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_hash.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_hmac.c \

# Include folders common to all targets
INC_FOLDERS += \
  $(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc \
  $(SDK_ROOT)/components/libraries/memobj \
  $(SDK_ROOT)/components/libraries/sha256 \
  $(SDK_ROOT)/components/libraries/crc32 \
  $(SDK_ROOT)/components/libraries/experimental_section_vars \
  $(SDK_ROOT)/components/libraries/mem_manager \
  $(SDK_ROOT)/components/libraries/fstorage \
  $(SDK_ROOT)/components/libraries/util \
  $(SDK_ROOT)/modules/nrfx \
  $(SDK_ROOT)/external/nrf_oberon/include \
  $(SDK_ROOT)/components/libraries/crypto/backend/oberon \
  $(SDK_ROOT)/components/libraries/crypto/backend/cifra \
  $(SDK_ROOT)/components/libraries/atomic \
  $(SDK_ROOT)/integration/nrfx \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310_bl \
  $(SDK_ROOT)/components/libraries/log/src \
  $(SDK_ROOT)/components/libraries/bootloader/dfu \
  $(SDK_ROOT)/components/ble/common \
  $(SDK_ROOT)/components/libraries/delay \
  $(SDK_ROOT)/components/libraries/svc \
  $(SDK_ROOT)/components/libraries/stack_info \
  $(SDK_ROOT)/components/libraries/crypto/backend/nrf_hw \
  $(SDK_ROOT)/components/libraries/log \
  $(SDK_ROOT)/external/nrf_oberon \
  $(SDK_ROOT)/components/libraries/strerror \
  $(SDK_ROOT)/components/libraries/crypto/backend/mbedtls \
  $(SDK_ROOT)/components/boards \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310 \
  $(SDK_ROOT)/components/libraries/bootloader \
  $(SDK_ROOT)/components/libraries/crypto \
  config \
  $(SDK_ROOT)/components/libraries/crypto/backend/optiga \
  $(SDK_ROOT)/components/libraries/scheduler \
  $(SDK_ROOT)/modules/nrfx/hal \
  $(SDK_ROOT)/components/toolchain/cmsis/include \
  $(SDK_ROOT)/components/libraries/balloc \
  $(SDK_ROOT)/components/libraries/atomic_fifo \
  $(SDK_ROOT)/external/micro-ecc/micro-ecc \
  $(PROJ_DIR) \
  $(SDK_ROOT)/components/libraries/crypto/backend/nrf_sw \
  $(SDK_ROOT)/modules/nrfx/mdk \
  $(SDK_ROOT)/components/libraries/bootloader/ble_dfu \
  $(SDK_ROOT)/components/softdevice/common \
  $(SDK_ROOT)/external/nano-pb \
  $(SDK_ROOT)/components/libraries/queue \
  $(SDK_ROOT)/components/libraries/ringbuf \

# Libraries common to all targets
ifeq ($(strip $(mcu_opt)), 52810)
LIB_FILES += \
  $(SDK_ROOT)/external/nrf_oberon/lib/cortex-m4/soft-float/liboberon_3.0.8.a \
  $(SDK_ROOT)/external/micro-ecc/nrf52nf_armgcc/armgcc/micro_ecc_lib_nrf52.a \

else
LIB_FILES += \
  $(SDK_ROOT)/external/nrf_oberon/lib/cortex-m4/hard-float/liboberon_3.0.8.a \
  $(SDK_ROOT)/external/micro-ecc/nrf52hf_armgcc/armgcc/micro_ecc_lib_nrf52.a \
  
endif

# Optimization flags
OPT = -Os -g3
# Uncomment the line below to enable link time optimization
#OPT += -flto

# C flags common to all targets
CFLAGS += $(OPT)
CFLAGS += -DBLE_STACK_SUPPORT_REQD
CFLAGS += -DBOARD_PCA10040
CFLAGS += -DCONFIG_GPIO_AS_PINRESET
CFLAGS += -DNRF52_PAN_74
CFLAGS += -DNRF_DFU_SETTINGS_VERSION=2
CFLAGS += -DNRF_DFU_SVCI_ENABLED
CFLAGS += -DNRF_SD_BLE_API_VERSION=7
CFLAGS += -DSOFTDEVICE_PRESENT
CFLAGS += -DSVC_INTERFACE_CALL_AS_NORMAL_FUNCTION
CFLAGS += -DuECC_ENABLE_VLI_API=0
CFLAGS += -DuECC_OPTIMIZATION_LEVEL=3
CFLAGS += -DuECC_SQUARE_FUNC=0
CFLAGS += -DuECC_SUPPORT_COMPRESSED_POINT=0
CFLAGS += -DuECC_VLI_NATIVE_LITTLE_ENDIAN=1
CFLAGS += -mcpu=cortex-m4
CFLAGS += -mthumb -mabi=aapcs
CFLAGS += -Wall -Werror
# keep every function in a separate section, this allows linker to discard unused ones
CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
CFLAGS += -fno-builtin -fshort-enums

# C++ flags common to all targets
CXXFLAGS += $(OPT)
# Assembler flags common to all targets
ASMFLAGS += -g3
ASMFLAGS += -mcpu=cortex-m4
ASMFLAGS += -mthumb -mabi=aapcs
ASMFLAGS += -DBLE_STACK_SUPPORT_REQD
ASMFLAGS += -DBOARD_PCA10040
ASMFLAGS += -DCONFIG_GPIO_AS_PINRESET
ASMFLAGS += -DNRF52_PAN_74
ASMFLAGS += -DNRF_DFU_SETTINGS_VERSION=2
ASMFLAGS += -DNRF_DFU_SVCI_ENABLED
ASMFLAGS += -DNRF_SD_BLE_API_VERSION=7
ASMFLAGS += -DSOFTDEVICE_PRESENT
ASMFLAGS += -DSVC_INTERFACE_CALL_AS_NORMAL_FUNCTION
ASMFLAGS += -DuECC_ENABLE_VLI_API=0
ASMFLAGS += -DuECC_OPTIMIZATION_LEVEL=3
ASMFLAGS += -DuECC_SQUARE_FUNC=0
ASMFLAGS += -DuECC_SUPPORT_COMPRESSED_POINT=0
ASMFLAGS += -DuECC_VLI_NATIVE_LITTLE_ENDIAN=1

#####    810     ######
ifeq ($(strip $(mcu_opt)), 52810)

SRC_FILES += \
  $(SDK_ROOT)/modules/nrfx/mdk/gcc_startup_nrf52810.S \
  $(SDK_ROOT)/modules/nrfx/mdk/system_nrf52810.c \

INC_FOLDERS += \
  $(SDK_ROOT)/components/softdevice/s112/headers \
  $(SDK_ROOT)/components/softdevice/s112/headers/nrf52 \

CFLAGS += -DNRF52810_XXAA
CFLAGS += -DS112
CFLAGS += -DFLOAT_ABI_SOFT
CFLAGS += -mfloat-abi=soft
CFLAGS += -DNRF_DFU_APP_DATA_AREA_SIZE=8192

ASMFLAGS += -DNRF52810_XXAA
ASMFLAGS += -DS112
ASMFLAGS += -DFLOAT_ABI_SOFT
ASMFLAGS += -mfloat-abi=soft
ASMFLAGS += -DNRF_DFU_APP_DATA_AREA_SIZE=8192

else # 默认832------------------

INC_FOLDERS += \
  $(SDK_ROOT)/components/softdevice/s132/headers \
  $(SDK_ROOT)/components/softdevice/s132/headers/nrf52 \

SRC_FILES += \
  $(SDK_ROOT)/modules/nrfx/mdk/gcc_startup_nrf52.S \
  $(SDK_ROOT)/modules/nrfx/mdk/system_nrf52.c \

CFLAGS += -DNRF52
CFLAGS += -DNRF52832_XXAA
CFLAGS += -DS132
CFLAGS += -DFLOAT_ABI_HARD
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16

ASMFLAGS += -DNRF52
ASMFLAGS += -DNRF52832_XXAA
ASMFLAGS += -DS132
ASMFLAGS += -DFLOAT_ABI_HARD
ASMFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16

LDFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16

endif #832 end

# Linker flags
LDFLAGS += $(OPT)
LDFLAGS += -mthumb -mabi=aapcs -L$(SDK_ROOT)/modules/nrfx/mdk -T$(LINKER_SCRIPT)
LDFLAGS += -mcpu=cortex-m4
# let linker dump unused sections
LDFLAGS += -Wl,--gc-sections
# use newlib in nano version
LDFLAGS += --specs=nano.specs


$(chip_name)_xxaa_bootloader_$(my_softdevice): CFLAGS += -D__HEAP_SIZE=0
$(chip_name)_xxaa_bootloader_$(my_softdevice): ASMFLAGS += -D__HEAP_SIZE=0

# Add standard libraries at the very end of the linker input, after all objects
# that may need symbols provided by these libraries.
LIB_FILES += -lc -lnosys -lm


.PHONY: default help

# Default target - first one defined
default: $(chip_name)_xxaa_bootloader_$(my_softdevice)

# Print all targets that can be built
help:
	@echo following targets are available:
	@echo		$(chip_name)_xxaa_bootloader_$(my_softdevice)
	@echo		flash_softdevice
	@echo		sdk_config - starting external tool for editing sdk_config.h
	@echo		flash      - flashing binary

TEMPLATE_PATH := $(SDK_ROOT)/components/toolchain/gcc


include $(TEMPLATE_PATH)/Makefile.common

$(foreach target, $(TARGETS), $(call define_target, $(target)))

.PHONY: flash flash_softdevice erase

# Flash the program
flash: default
	@echo Flashing: $(OUTPUT_DIRECTORY)/$(chip_name)_xxaa_bootloader_$(my_softdevice).hex
	nrfjprog -f nrf52 --program $(OUTPUT_DIRECTORY)/$(chip_name)_xxaa_bootloader_$(my_softdevice).hex --sectorerase
	nrfjprog -f nrf52 --reset

# Flash softdevice
flash_softdevice:
  @echo Flashing: $(my_softdevice)_nrf52_7.2.0_softdevice.hex
  # nrfjprog -f nrf52 --program $(SDK_ROOT)/components/softdevice/$(my_softdevice)/hex/$(my_softdevice)_nrf52_7.2.0_softdevice.hex --sectorerase
  # nrfjprog -f nrf52 --reset

erase:
	nrfjprog -f nrf52 --eraseall

SDK_CONFIG_FILE := config/sdk_config.h
CMSIS_CONFIG_TOOL := $(SDK_ROOT)/external_tools/cmsisconfig/CMSIS_Configuration_Wizard.jar
sdk_config:
	java -jar $(CMSIS_CONFIG_TOOL) $(SDK_CONFIG_FILE)
