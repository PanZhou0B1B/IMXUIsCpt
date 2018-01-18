//
//  IMXTabBarItem.m
//  IMXTabbarKit
//
//  Created by zhoupanpan on 2017/11/27.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import "IMXTabBarItem.h"
#import <Masonry/Masonry.h>

#define IMX_REDDOT_SIDE_LENGTH 6.0f

#define TabBarItemWidth ([[UIScreen mainScreen] scale] == 3.0f ? 26 : 23)
#define TabBarItemHeight ([[UIScreen mainScreen] scale] == 3.0f ? 26 : 23)

@interface IMXTabBarItem()
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel *titleLB;
@property (nonatomic, strong)UIView *reddotView;
@end
@implementation IMXTabBarItem
- (void)dealloc{
}
#pragma mark ======  public  ======
- (instancetype)init{
    self = [super init];
    if (self) {
        [self configUIs];
    }
    return self;
}
#pragma mark ======  life cycle  ======
- (void)updateConstraints{
    [super updateConstraints];
    [self refreshUIs];
}
#pragma mark ======  delegate  ======

#pragma mark ======  event  ======
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_selectblock) {
        _selectblock(self);
    }
}
#pragma mark ======  private  ======
- (void)configUIs{
    [self addSubview:self.imgView];
    [self addSubview:self.titleLB];
}
- (void)refreshUIs{
    CGFloat imgCenterYOffset = 0.0f;
    if(self.titleLB.text){
        imgCenterYOffset = -9.0f;
    }
   // [self.imgView sizeToFit];
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(0);
        make.width.mas_equalTo(TabBarItemWidth);
        make.height.mas_equalTo(TabBarItemHeight);
        make.top.equalTo(self).offset(4);
    }];
    [self.titleLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self.imgView.mas_bottom).offset(0);
        make.height.mas_equalTo(14);
    }];
}
#pragma mark ======  getter & setter  ======
- (UIImageView *)imgView{
    if(!_imgView){
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}
- (UILabel *)titleLB{
    if(!_titleLB){
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = [UIFont systemFontOfSize:9];
        _titleLB.backgroundColor = [UIColor clearColor];
        _titleLB.textColor = [UIColor whiteColor];
        _titleLB.textAlignment = NSTextAlignmentCenter;
        _titleLB.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLB;
}
- (UIView *)reddotView{
    if(!_reddotView){
        _reddotView = [[UIView alloc] init];
        _reddotView.backgroundColor = [UIColor redColor];
        _reddotView.layer.cornerRadius = IMX_REDDOT_SIDE_LENGTH/2.0;
        _reddotView.layer.masksToBounds = YES;
        _reddotView.hidden = YES;
    }
    return _reddotView;
}
- (void)setShowReddot:(BOOL)showReddot{
    if(_showReddot == showReddot){
        return;
    }
    _showReddot = showReddot;
    if(![self.reddotView superview]){
        [self addSubview:self.reddotView];
        [self.reddotView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(-IMX_REDDOT_SIDE_LENGTH/2.0);
            make.top.equalTo(self.imgView.mas_top).offset(-IMX_REDDOT_SIDE_LENGTH/2.0);
            make.width.mas_equalTo(IMX_REDDOT_SIDE_LENGTH);
            make.height.mas_equalTo(IMX_REDDOT_SIDE_LENGTH);
        }];
    }
    self.reddotView.hidden = !_showReddot;
}
- (void)setItemTitle:(NSString *)itemTitle{
    _itemTitle = itemTitle;
    if(itemTitle){
        self.titleLB.text = itemTitle;
        self.titleLB.hidden = NO;
    }else{
        self.titleLB.text = nil;
        self.titleLB.hidden = YES;
    }
    self.selected = NO;
    [self layoutIfNeeded];
}
- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if(_selected){
        self.imgView.image = self.itemSelectedImg;
        self.titleLB.textColor = self.selectColor;
    }else{
        self.imgView.image = self.itemImg;
        self.titleLB.textColor = self.normalColor;
    }
}
@end
