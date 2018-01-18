//
//  IMXTabBarViewController.h
//  IMXTabbarKit
//
//  Created by zhoupanpan on 2017/11/27.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import <UIKit/UIKit.h>
//红点展示
#define IMX_TabBar_showReddotAtIndex(index) \
[IMXTabBarViewController postShowReddotAtIndex:(index)]
#define IMX_TabBar_hideReddotAtIndex(index) \
[IMXTabBarViewController posthHideReddotAtIndex:(index)]
//tabbar显示/隐藏
#define IMX_TabBar_show \
[IMXTabBarViewController postShowTabbar]
#define IMX_TabBar_hide \
[IMXTabBarViewController posthHideTabbar]

#define IMX_Show_TabBar_AtIndex(i) \
[IMXTabBarViewController postShowTabbarAtIndex:(i)]

extern NSString *const imx_tabbar_showreddot_notificationname;
extern NSString *const imx_tabbar_hidereddot_notificationname;
#define imx_tabbar_index @"imx_tabbar_index"

@interface IMXTabBarViewController : UITabBarController
@property (nonatomic,assign,getter=isBaseOnNavi)BOOL baseOnNavi;
@property (nonatomic,assign)NSUInteger imxSelectedIndex;

- (void)refreshTabBar:(NSArray *)itemModels;

+ (void)postShowReddotAtIndex:(NSUInteger)index;
+ (void)posthHideReddotAtIndex:(NSUInteger)index;
+ (void)postShowTabbar;
+ (void)posthHideTabbar;
+ (void)postShowTabbarAtIndex:(NSInteger)index;
- (void)showReddotAtIndex:(NSUInteger)index;
- (void)hideReddotAtIndex:(NSUInteger)index;
@end
