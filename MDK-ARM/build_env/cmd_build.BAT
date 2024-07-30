@SET CPU_TYPE=STM32F103C8
@SET CPU_VENDOR=STMicroelectronics
@SET UV2_TARGET=STM32_WP
@SET CPU_CLOCK=0x007A1200

@REM Assembler option, compiler option
@SET ASM_OPT=--target=arm-arm-none-eabi -mcpu=cortex-m3 -masm=auto  -Wa,armasm,--diag_suppress=A1950W -c -gdwarf-4 -Wa,armasm,--pd,"__EVAL SETA 1" -I../RTE/_STM32_WP -I %CMSIS_CORE_INC% -I %MCU_DEVICE_INC% -Wa,armasm,--pd,"__UVISION_VERSION SETA 540" -Wa,armasm,--pd,"STM32F10X_MD SETA 1" -Wa,armasm,--pd,"_RTE_ SETA 1"
@SET CC_OPT=-xc -std=c99 --target=arm-arm-none-eabi -mcpu=cortex-m3 -c -fno-rtti -funsigned-char -fshort-enums -fshort-wchar -D__EVAL -gdwarf-4 -O3 -ffunction-sections -Wno-packed -Wno-missing-variable-declarations -Wno-missing-prototypes -Wno-missing-noreturn -Wno-sign-conversion -Wno-nonportable-include-path -Wno-reserved-id-macro -Wno-unused-macros -Wno-documentation-unknown-command -Wno-documentation -Wno-license-management -Wno-parentheses-equality -Wno-reserved-identifier -I ../../Core/Inc -I ../../Drivers/STM32F1xx_HAL_Driver/Inc -I ../../Drivers/STM32F1xx_HAL_Driver/Inc/Legacy -I ../../Drivers/CMSIS/Device/ST/STM32F1xx/Include -I ../../Drivers/CMSIS/Include -I ../RTE/_STM32_WP -I %CMSIS_CORE_INC% -I %MCU_DEVICE_INC% -D__UVISION_VERSION="540" -DSTM32F10X_MD -D_RTE_ -DUSE_HAL_DRIVER -DSTM32F103xB


==========================================================================================================================
@REM Compiling
@echo Building...

@REM Compiling library
@%KEIL_ARMCLANG% %ASM_OPT% -o ../output/startup_stm32f103xb.o "../startup_stm32f103xb.s"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/main.o -MMD "../../Core/Src/main.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_it.o -MMD "../../Core/Src/stm32f1xx_it.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_msp.o -MMD "../../Core/Src/stm32f1xx_hal_msp.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_gpio_ex.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_tim.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_tim_ex.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim_ex.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_rcc.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_rcc_ex.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_gpio.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_dma.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_cortex.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_pwr.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_flash.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_flash_ex.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/stm32f1xx_hal_exti.o -MMD "../../Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_exti.c"
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/system_stm32f1xx.o -MMD "../../Core/Src/system_stm32f1xx.c"

@REM Compiling test suite, test case
@%KEIL_ARMCLANG% %CC_OPT% -o ../output/Demo_%TS%.o -MMD "../TestSuite/%TS%/Demo_%TS%.c"

==========================================================================================================================
@REM Linking
@%KEIL_ARMLINK% --Via "..\TestSuite\%TS%\Demo_%TS%.lnp"

==========================================================================================================================
@REM Create hex file
@%KEIL_FROMELF% "..\output\STM32_WP.axf" --i32combined --output "..\output\STM32_WP.hex"

@echo Done!