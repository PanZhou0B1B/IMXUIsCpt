//
//  IMXFlatButton.h
//  IMXBaseCpt
//
//  Created by zhoupanpan on 2017/12/13.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IMXFlatButtonType) {
    IMXFlatButtonTypeNone = 0,
    IMXFlatButtonTypeText,
};
@interface IMXFlatButton : UIButton
@property (nonatomic,assign)IMXFlatButtonType imx_buttonType;
@property (nonatomic, assign) UIEdgeInsets imx_hotTouchEdgeInset;
@end
