//
//  IMXTabBarItem.h
//  IMXTabbarKit
//
//  Created by zhoupanpan on 2017/11/27.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IMXTabBarItem;
typedef void (^imxSelectBlock)(IMXTabBarItem *item);

@interface IMXTabBarItem : UIView
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectColor;
@property (nonatomic, assign,getter=isShowReddot) BOOL showReddot;
@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, strong) UIImage *itemImg;
@property (nonatomic, strong) UIImage *itemSelectedImg;
@property (nonatomic, copy) imxSelectBlock selectblock;
@end
