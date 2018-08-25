# Kernel
include vendor/fuse/config/BoardConfigKernel.mk

# Qcom-specific bits
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/fuse/config/BoardConfigQcom.mk
endif

# Soong
include vendor/fuse/config/BoardConfigSoong.mk
