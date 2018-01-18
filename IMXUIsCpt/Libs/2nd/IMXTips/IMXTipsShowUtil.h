//
//  IMXTipsShowUtil.h
//  IMXNetworkCpt
//
//  Created by zhoupanpan on 2017/8/17.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMXTipsShowUtil : NSObject
+ (void)showTitle:(NSString *)title msg:(NSString *)msg;
+ (void)showTitle:(NSString *)title msg:(NSString *)msg cancel:(NSString *)cancel confirm:(NSString *)confirm handler:(void(^)(BOOL tapConfirm))handler;
#pragma mark ======  loading  ======
+ (void)showLoadingInView:(id)view;
+ (void)showLoadingInView:(id)view loadingTips:(NSString *)tips;
+ (void)hideLoadingViewInView:(id)view;
+ (void)toastShow:(NSString *)msg;
+ (void)toastShow:(NSString *)msg afterDelay:(NSTimeInterval)delay;

@end
