################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include Startup/subdir.mk
-include Src/subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

OPTIONAL_TOOL_DEPS := \
$(wildcard ../makefile.defs) \
$(wildcard ../makefile.init) \
$(wildcard ../makefile.targets) \


BUILD_ARTIFACT_NAME := EE2028_AY2324S1_Assign1
BUILD_ARTIFACT_EXTENSION := elf
BUILD_ARTIFACT_PREFIX :=
BUILD_ARTIFACT := $(BUILD_ARTIFACT_PREFIX)$(BUILD_ARTIFACT_NAME)$(if $(BUILD_ARTIFACT_EXTENSION),.$(BUILD_ARTIFACT_EXTENSION),)

# Add inputs and outputs from these tool invocations to the build variables 
EXECUTABLES += \
EE2028_AY2324S1_Assign1.elf \

MAP_FILES += \
EE2028_AY2324S1_Assign1.map \

SIZE_OUTPUT += \
default.size.stdout \

OBJDUMP_LIST += \
EE2028_AY2324S1_Assign1.list \


# All Target
all: main-build

# Main-build Target
main-build: EE2028_AY2324S1_Assign1.elf secondary-outputs

# Tool invocations
EE2028_AY2324S1_Assign1.elf EE2028_AY2324S1_Assign1.map: $(OBJS) $(USER_OBJS) C:\Users\QQ\iCloudDrive\Desktop\Teaching\AY2324_S1\EE2028\Assgn1\Design\EE2028_AY2223S1_Assign1\STM32L475VGTX_FLASH.ld makefile objects.list $(OPTIONAL_TOOL_DEPS)
	arm-none-eabi-gcc -o "EE2028_AY2324S1_Assign1.elf" @"objects.list" $(USER_OBJS) $(LIBS) -mcpu=cortex-m4 -T"C:\Users\QQ\iCloudDrive\Desktop\Teaching\AY2324_S1\EE2028\Assgn1\Design\EE2028_AY2223S1_Assign1\STM32L475VGTX_FLASH.ld" --specs=nosys.specs -Wl,-Map="EE2028_AY2324S1_Assign1.map" -Wl,--gc-sections -static -specs=rdimon.specs --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -u _printf_float -Wl,--start-group -lc -lm -Wl,--end-group
	@echo 'Finished building target: $@'
	@echo ' '

default.size.stdout: $(EXECUTABLES) makefile objects.list $(OPTIONAL_TOOL_DEPS)
	arm-none-eabi-size  $(EXECUTABLES)
	@echo 'Finished building: $@'
	@echo ' '

EE2028_AY2324S1_Assign1.list: $(EXECUTABLES) makefile objects.list $(OPTIONAL_TOOL_DEPS)
	arm-none-eabi-objdump -h -S $(EXECUTABLES) > "EE2028_AY2324S1_Assign1.list"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) EE2028_AY2324S1_Assign1.elf EE2028_AY2324S1_Assign1.list EE2028_AY2324S1_Assign1.map default.size.stdout
	-@echo ' '

secondary-outputs: $(SIZE_OUTPUT) $(OBJDUMP_LIST)

fail-specified-linker-script-missing:
	@echo 'Error: Cannot find the specified linker script. Check the linker settings in the build configuration.'
	@exit 2

warn-no-linker-script-specified:
	@echo 'Warning: No linker script specified. Check the linker settings in the build configuration.'

.PHONY: all clean dependents main-build fail-specified-linker-script-missing warn-no-linker-script-specified

-include ../makefile.targets
