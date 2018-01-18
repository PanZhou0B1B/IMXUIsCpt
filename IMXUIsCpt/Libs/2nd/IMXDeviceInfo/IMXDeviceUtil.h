//
//  IMXDeviceUtil.h
//  IMXBaseModules
//
//  Created by zhoupanpan on 2017/8/10.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IMXDeviceUtil : NSObject
#pragma mark ======  system  ======
+ (float)imx_osVersion;

/// 当前系统名称
+ (NSString *)imx_systemName;
/// 当前系统版本号
+ (NSString *)imx_ystemVersion;
#pragma mark ======  hard  ======
/// 获取电池电量
+ (CGFloat)imx_batteryLevel;
/// 获取精准电池电量
+ (CGFloat)imx_deviceCurrentBatteryLevel;
/// 获取电池当前的状态，共有4种状态
+ (NSString *)imx_deviceBatteryState;
/// 获取设备名称
+ (NSString *)imx_deviceName;
/// 获取总内存大小
+ (long long)imx_deviceTotalMemorySize;
/// 获取当前可用内存
+ (long long)imx_deviceAvailableMemorySize;
/// 获取设备型号
+ (NSString *)imx_deviceSystemName;

#pragma mark ======  other  ======
/// 通用唯一识别码UUID
//并非一成不变，如reset后
+ (NSString *)imx_UUID;
// 获取当前设备IP
+ (NSString *)imx_deviceIPAdress;
/// 获取当前语言
+ (NSString *)imx_DeviceLanguage;
+ (NSString *)imx_currentCountryCode;
+ (NSString *)imx_localDisplayNameForCC:(NSString *)cc lan:(NSString *)lan;
+ (NSArray *)imx_allCountryCode;
@end
