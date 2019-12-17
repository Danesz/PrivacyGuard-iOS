#deb out folder
THEOS_PACKAGE_DIR_NAME = debs

#set debug
#DEBUG = 0

#set version number
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PrivacyGuard

PrivacyGuard_FILES = Tweak.x
PrivacyGuard_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
