//
//  IMXTabBar.m
//  IMXTabbarKit
//
//  Created by zhoupanpan on 2017/11/27.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import "IMXTabBar.h"
#import "IMXTabBarItem.h"
@interface IMXTabBar()

@end
@implementation IMXTabBar
- (void)removeAllTabbarItemViews{
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:[IMXTabBarItem class]]){
            [subView removeFromSuperview];
        }
    }
}
- (void)configShadow{
    self.layer.shadowColor = [UIColor colorWithRed:235/255.0 green:234/255.0 blue:228/255.0 alpha:1.0].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,-1);
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 3;

}
@end
