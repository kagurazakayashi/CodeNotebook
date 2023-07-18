# Xcode编译脚本变量 Run Script

${SYMROOT} = ${}/Build/Products
${BUILD_DIR} = ${}/Build/Products
${BUILD_ROOT} =  ${}/Build/Products
# 这三个变量中的${}不会随着Build Settings参数的设置而改变
# 相反，以下可以通过设置而改变

${CONFIGURATION_BUILD_DIR} = ${}/Build/Products/Debug-iphonesimulator
${BUILT_PRODUCTS_DIR} = ${}/Build/Products/Debug-iphonesimulator
${CONFIGURATION_TEMP_DIR} = ${}/Build/Intermediates/UtilLib.build/Debug-iphonesimulator
${TARGET_BUILD_DIR} = ${}/Build/Products/Debug-iphonesimulator
${SDK_NAME} = iphonesimulator5.0
${PLATFORM_NAME} = iphonesimulator
${CONFIGURATION} = Debug
${TARGET_NAME} = UtilLib
${EXECUTABLE_NAME} = libUtilLib.a 可执行文件名
${IPHONEOS_DEPLOYMENT_TARGET} = 5.0
${ACTION} = build
${CURRENTCONFIG_SIMULATOR_DIR} = 当前模拟器路径 
${CURRENTCONFIG_DEVICE_DIR} = 当前设备路径 
${BUILD_DIR}/${CONFIGURATION}${EFFECTIVE_PLATFORM_NAME} = ${}/Build/Products/Debug-iphonesimulator
${PROJECT_TEMP_DIR}/${CONFIGURATION}${EFFECTIVE_PLATFORM_NAME} = ${}/Build/Intermediates/UtilLib.build/Debug-iphonesimulator

# 自定义变量
${CONFIGURATION}-iphoneos = Debug-iphoneos
${CONFIGURATION}-iphonesimulator = Debug-iphonesimulator
${CURRENTCONFIG_DEVICE_DIR} = ${SYMROOT}/${CONFIGURATION}-iphoneos
${CURRENTCONFIG_SIMULATOR_DIR} = ${SYMROOT}/${CONFIGURATION}-iphonesimulator

# 自定义一个设备无关的路径（用来存放各种架构arm6/arm7/i386输出的产品）
${CREATING_UNIVERSAL_DIR} = ${SYMROOT}/${CONFIGURATION}-universal

# 自定义变量代表的值
${CURRENTCONFIG_DEVICE_DIR} = ${}/Build/Products/Debug-iphoneos
${CURRENTCONFIG_SIMULATOR_DIR} = ${}/Build/Products/Debug-iphonesimulator
${CREATING_UNIVERSAL_DIR} = ${}/Build/Products/Debug-universal

# https://blog.csdn.net/boaosady/article/details/127066074