LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
    android_renderscript_RenderScript.cpp
ifeq ($(USE_GMS_LIBS),true)
	LOCAL_MODULE:= librsjni_old
	LOCAL_SHARED_LIBRARIES := libRSSupport_old
	LOCAL_REQUIRED_MODULES := libRSSupport_old
else
	LOCAL_MODULE:= librsjni
	LOCAL_SHARED_LIBRARIES := libRSSupport
	LOCAL_REQUIRED_MODULES := libRSSupport
endif

LOCAL_SHARED_LIBRARIES += \
        libjnigraphics


LOCAL_STATIC_LIBRARIES := \
        libcutils \
        liblog

rs_generated_include_dir := $(call intermediates-dir-for,SHARED_LIBRARIES,libRSSupport,,)

LOCAL_C_INCLUDES += \
	$(JNI_H_INCLUDE) \
	frameworks/rs \
	$(rs_generated_include_dir)

LOCAL_CFLAGS +=

LOCAL_LDLIBS := -lpthread
LOCAL_ADDITIONAL_DEPENDENCIES := $(addprefix $(rs_generated_include_dir)/,rsgApiFuncDecl.h)
LOCAL_ADDITIONAL_DEPENDENCIES += $(rs_generated_source)
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)
