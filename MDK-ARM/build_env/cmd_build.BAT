@echo off
SETLOCAL

SET CPU_TYPE=STM32F103C8
SET CPU_VENDOR=STMicroelectronics
SET UV2_TARGET=STM32_WP
SET CPU_CLOCK=0x007A1200

REM Definition of directory
SET OUTPUT_DIR=../output

REM Assembler option, compiler option

SET ASM_OPT_INC=-I../RTE/_STM32_WP -I %CMSIS_CORE_INC_PATH% -I %MCU_DEVICE_INC_PATH%
SET CC_OPT_INC=-I ../../Core/Inc -I ../../Drivers/STM32F1xx_HAL_Driver/Inc -I ../../Drivers/STM32F1xx_HAL_Driver/Inc/Legacy -I ../../Drivers/CMSIS/Device/ST/STM32F1xx/Include -I ../../Drivers/CMSIS/Include -I ../RTE/_STM32_WP -I %CMSIS_CORE_INC_PATH% -I %MCU_DEVICE_INC_PATH%
SET LIST_O_FILE="..\output\startup_stm32f103xb.o" "..\output\main.o" "..\output\stm32f1xx_it.o" "..\output\stm32f1xx_hal_msp.o" "..\output\stm32f1xx_hal_gpio_ex.o" "..\output\stm32f1xx_hal_tim.o" "..\output\stm32f1xx_hal_tim_ex.o" "..\output\stm32f1xx_hal.o" "..\output\stm32f1xx_hal_rcc.o" "..\output\stm32f1xx_hal_rcc_ex.o" "..\output\stm32f1xx_hal_gpio.o" "..\output\stm32f1xx_hal_dma.o" "..\output\stm32f1xx_hal_cortex.o" "..\output\stm32f1xx_hal_pwr.o" "..\output\stm32f1xx_hal_flash.o" "..\output\stm32f1xx_hal_flash_ex.o" "..\output\stm32f1xx_hal_exti.o" "..\output\system_stm32f1xx.o" "..\output\Demo_%TS%.o"


SET ASM_OPT=--target=arm-arm-none-eabi -mcpu=cortex-m3 -masm=auto  -Wa,armasm,--diag_suppress=A1950W -c -gdwarf-4 -Wa,armasm,--pd,"__EVAL SETA 1" %ASM_OPT_INC% -Wa,armasm,--pd,"__UVISION_VERSION SETA 540" -Wa,armasm,--pd,"STM32F10X_MD SETA 1" -Wa,armasm,--pd,"_RTE_ SETA 1"
SET CC_OPT=-xc -std=c99 --target=arm-arm-none-eabi -mcpu=cortex-m3 -c -fno-rtti -funsigned-char -fshort-enums -fshort-wchar -D__EVAL -gdwarf-4 -O3 -ffunction-sections -Wno-packed -Wno-missing-variable-declarations -Wno-missing-prototypes -Wno-missing-noreturn -Wno-sign-conversion -Wno-nonportable-include-path -Wno-reserved-id-macro -Wno-unused-macros -Wno-documentation-unknown-command -Wno-documentation -Wno-license-management -Wno-parentheses-equality -Wno-reserved-identifier %CC_OPT_INC% -D__UVISION_VERSION="540" -DSTM32F10X_MD -D_RTE_ -DUSE_HAL_DRIVER -DSTM32F103xB
SET LINKING_OPT=--cpu Cortex-M3 %LIST_O_FILE% --strict --scatter "..\build_env\STM32_WP.sct" --summary_stderr --info summarysizes --map --load_addr_map_info --xref --callgraph --symbols --info sizes --info totals --info unused --info veneers --list "STM32_WP.map"

==========================================================================================================================
REM Compiling
echo Building...

REM Creating output folder
if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

REM Compiling library
%KEIL_ARMCLANG% %ASM_OPT% -o %OUTPUT_DIR%/startup_stm32f103xb.o "../startup_stm32f103xb.s"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/main.o -MMD "../../Core/Src/main.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_it.o -MMD "../../Core/Src/stm32f1xx_it.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_msp.o -MMD "../../Core/Src/stm32f1xx_hal_msp.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_gpio_ex.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_tim.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_tim_ex.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim_ex.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_rcc.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_rcc_ex.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_gpio.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_dma.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_cortex.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_pwr.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_flash.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_flash_ex.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/stm32f1xx_hal_exti.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_exti.c"
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/system_stm32f1xx.o -MMD "../../Core/Src/system_stm32f1xx.c"

REM Compiling test suite, test case
%KEIL_ARMCLANG% %CC_OPT% -o %OUTPUT_DIR%/Demo_%TS%.o -MMD "../TestSuite/%TS%/Demo_%TS%.c"

==========================================================================================================================
REM Linking
%KEIL_ARMLINK% %LINKING_OPT% -o ..\output\STM32_WP.axf

==========================================================================================================================
REM Create hex file
%KEIL_FROMELF% "..\output\STM32_WP.axf" --i32combined --output "..\output\STM32_WP.hex"

echo Done!

ENDLOCAL