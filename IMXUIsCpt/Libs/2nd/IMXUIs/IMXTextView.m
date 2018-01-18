//
//  IMXTextView.m
//  IMXBaseCpt
//
//  Created by zhoupanpan on 2017/12/14.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import "IMXTextView.h"
#import <Masonry/Masonry.h>
#import <IMXFuncCpt/IMXObjectExtUtil.h>
#import "IMXStyleKit.h"

@interface IMXTextView()<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic,assign)UIEdgeInsets insets;
@property (nonatomic,strong)UILabel *countLB;
@end

@implementation IMXTextView

- (void)dealloc{
}
#pragma mark ======  public  ======
- (instancetype)initWithInsets:(UIEdgeInsets)insets{
    self = [super init];
    if (self) {
        self.insets = insets;
        [self configUIs];
        [self refreshUIs];
    }
    return self;
}
#pragma mark ======  life cycle  ======
- (instancetype)init{
    self = [super init];
    if (self) {
        [self configUIs];
        [self refreshUIs];
    }
    return self;
}
#pragma mark ======  delegate  ======
- (void)textViewDidChange:(UITextView *)textView{
    if([NSString imxStringIsEmpty:textView.text]){
        self.placeholderTF.hidden = NO;
    }else{
        self.placeholderTF.hidden = YES;
    }
    [self showLastNumWithInput:textView.text];
    if(self.textChangeBlock){
        self.textChangeBlock(textView.text);
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if(self.endEditBlock){
        self.endEditBlock(textView);
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.textView becomeFirstResponder];
    return NO;
}
#pragma mark ======  event  ======

#pragma mark ======  private  ======
- (void)configUIs{
    self.textView.delegate = self;
    self.placeholderTF.delegate = self;
    [self addSubview:self.textView];
    [self.textView addSubview:self.placeholderTF];
}
- (void)refreshUIs{
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.insets.left);
        make.top.equalTo(self).offset(self.insets.top);
        make.right.equalTo(self).offset(self.insets.right);
        make.bottom.equalTo(self).offset(self.insets.bottom);
    }];
    [self.placeholderTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView).offset(6);
        make.top.equalTo(self.textView).offset(6);
        make.right.equalTo(self.textView).offset(0);
        make.height.mas_equalTo(20);
    }];
};
- (void)showLastNumWithInput:(NSString *)string{
    if(self.maxCount<=0){
        return ;
    }
    NSInteger length = string.length;
    NSInteger lastNum = self.maxCount - length;
    self.countLB.text = [NSString stringWithFormat:@"%ld",(long)lastNum];
}
#pragma mark ======  getter & setter  ======
- (UITextView *)textView{
    if(!_textView){
        _textView = [[UITextView alloc] init];
        _textView.alwaysBounceVertical = YES;
    }
    return _textView;
}
- (UITextField *)placeholderTF{
    if(!_placeholderTF){
        _placeholderTF = [[UITextField alloc] init];
    }
    return _placeholderTF;
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.textView.textColor = textColor;
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    _imxBackGroundColor = backgroundColor;
    self.textView.backgroundColor = backgroundColor;
}
- (void)setFont:(UIFont *)font{
    _font = font;
    self.textView.font = font;
}
- (void)setImxplaceholderString:(NSAttributedString *)imxplaceholderString{
    _imxplaceholderString = imxplaceholderString;
    self.placeholderTF.attributedPlaceholder = imxplaceholderString;
}
- (UILabel *)countLB{
    if(!_countLB){
        _countLB = [UILabel new];
        _countLB.textColor = [UIColor imxColorWithHex:0x979797];
        _countLB.font = [UIFont imx_helNeueFont:8];
        _countLB.backgroundColor = [UIColor clearColor];
        _countLB.textAlignment = NSTextAlignmentRight;
    }
    return _countLB;
}
- (void)setMaxCount:(NSInteger)maxCount{
    _maxCount = maxCount;
    if(maxCount>0){
        if(!self.countLB.superview){
            [self addSubview:self.countLB];
            [self.countLB mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-6);
                make.left.equalTo(self).offset(0);
                make.height.mas_equalTo(10);
                make.bottom.equalTo(self).offset(-6);
            }];
        }
    }else{
        if(self.countLB.superview){
            [self.countLB removeFromSuperview];
        }
    }
}
- (void)setInitialText:(NSString *)initialText{
    _initialText = initialText;
    if(![NSString imxStringIsEmpty:_initialText]){
        self.textView.text = initialText;
        self.placeholderTF.hidden = YES;
        [self showLastNumWithInput:self.textView.text];
    }
}
@end
