//
//  IMXTextView.h
//  IMXBaseCpt
//
//  Created by zhoupanpan on 2017/12/14.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 具备占位符的TextView
 */
@interface IMXTextView : UIView
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UITextField *placeholderTF;
@property (nonatomic,strong)UIColor *textColor;
@property (nonatomic,strong)UIColor *imxBackGroundColor;
@property (nonatomic,strong)UIFont *font;
@property (nonatomic,strong)NSAttributedString *imxplaceholderString;
@property (nonatomic,copy)NSString *initialText;//初始文本展示
@property (nonatomic,assign)NSInteger maxCount;

@property (nonatomic, copy) void(^endEditBlock)(UITextView *tw);
@property (nonatomic, copy) void(^textChangeBlock)(NSString *text);

@end
