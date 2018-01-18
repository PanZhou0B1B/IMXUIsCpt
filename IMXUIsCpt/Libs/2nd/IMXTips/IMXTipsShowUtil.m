//
//  IMXTipsShowUtil.m
//  IMXNetworkCpt
//
//  Created by zhoupanpan on 2017/8/17.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import "IMXTipsShowUtil.h"
#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "IMXUIKitExtUtil.h"
#import "IMXStyleKit.h"
static BOOL tips_show_flag = NO;
@implementation IMXTipsShowUtil
+ (void)showTitle:(NSString *)title msg:(NSString *)msg{
    if(tips_show_flag){
        return;
    }
    tips_show_flag = YES;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    NSString *ok = NSLocalizedString(@"确定",nil);
    UIAlertAction *action = [UIAlertAction actionWithTitle:ok
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       tips_show_flag = NO;
                                                   }];
    [alert addAction:action];
    UIViewController *ctrl = [UIViewController imx_CurrentViewCtrl];
    [ctrl presentViewController:alert animated:YES completion:nil];
}
+ (void)showTitle:(NSString *)title msg:(NSString *)msg cancel:(NSString *)cancel confirm:(NSString *)confirm handler:(void(^)(BOOL tapConfirm))handler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    if(!cancel && !confirm){
        NSString *ok = NSLocalizedString(@"确定",nil);
        UIAlertAction *action = [UIAlertAction actionWithTitle:ok
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           if(handler){
                                                               handler(NO);
                                                           }
                                                       }];
        [alert addAction:action];
    }else{
        if(cancel){
            NSString *btnmsg = cancel;
            UIAlertAction *action = [UIAlertAction actionWithTitle:btnmsg
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if(handler){
                                                                   handler(NO);
                                                               }
                                                           }];
            [alert addAction:action];
        }
        if(confirm){
            NSString *btnmsg = confirm;
            UIAlertAction *action = [UIAlertAction actionWithTitle:btnmsg
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if(handler){
                                                                   handler(YES);
                                                               }
                                                           }];
            [alert addAction:action];
        }
    }
    
    UIViewController *ctrl = [UIViewController imx_CurrentViewCtrl];
    [ctrl presentViewController:alert animated:YES completion:nil];
}
#pragma mark ======  loading  ======
+ (void)showLoadingInView:(id)view{
    [self showLoadingInView:view loadingTips:nil];
}
+ (void)showLoadingInView:(id)view loadingTips:(NSString *)tips{
    UIView *baseView = view;
    if([view isKindOfClass:[UIViewController class]]){
        UIViewController *ctrl = view;
        baseView = ctrl.view;
    }
    MBProgressHUD *hud = [MBProgressHUD HUDForView:baseView];
    if(!hud){
        hud = [[MBProgressHUD alloc] initWithView:baseView];
        [baseView addSubview:hud];
    }
    hud.bezelView.color = [UIColor imxColorWithHex:0x313130];
    hud.bezelView.alpha = 1.0f;
    hud.contentColor = [UIColor whiteColor];
    hud.userInteractionEnabled = NO;
    [hud setOffset:CGPointMake(hud.offset.x, -50)];
    if(tips){
        hud.label.text = tips;
    }else{
        hud.label.text = NSLocalizedString(@"加载中...",nil);
    }
    hud.label.font = [UIFont systemFontOfSize:12];
    [hud showAnimated:YES];
}
+ (void)hideLoadingViewInView:(id)view{
    UIView *baseView = view;
    if([view isKindOfClass:[UIViewController class]]){
        UIViewController *ctrl = view;
        baseView = ctrl.view;
    }
    [MBProgressHUD hideHUDForView:baseView animated:YES];
}
+ (void)toastShow:(NSString *)msg{
    [self toastShow:msg afterDelay:2.5f];
}
+ (void)toastShow:(NSString *)msg afterDelay:(NSTimeInterval)delay{
    UIWindow *window = [UIViewController imx_window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.bezelView.color = [UIColor imxColorWithHex:0x313130];
    hud.bezelView.alpha = 1.0f;
    hud.contentColor = [UIColor whiteColor];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = msg;
    hud.margin = 10.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
}

@end
