//
//  IMXFlatButton.m
//  IMXBaseCpt
//
//  Created by zhoupanpan on 2017/12/13.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import "IMXFlatButton.h"

@implementation IMXFlatButton

- (void)dealloc{
}
#pragma mark ======  public  ======

#pragma mark ======  life cycle  ======
- (void)layoutSubviews {
    
    [super layoutSubviews];
}
- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect area = CGRectMake(self.bounds.origin.x - self.imx_hotTouchEdgeInset.left, self.bounds.origin.y - self.imx_hotTouchEdgeInset.top, self.bounds.size.width + self.imx_hotTouchEdgeInset.left + self.imx_hotTouchEdgeInset.right, self.bounds.size.height + self.imx_hotTouchEdgeInset.top + self.imx_hotTouchEdgeInset.bottom);
    BOOL result = CGRectContainsPoint(area, point);
    return result;
}
#pragma mark ======  delegate  ======

#pragma mark ======  event  ======

#pragma mark ======  private  ======

#pragma mark ======  getter & setter  ======
- (void)setImx_buttonType:(IMXFlatButtonType)imx_buttonType{
    if(_imx_buttonType == imx_buttonType){
        return;
    }
    _imx_buttonType = imx_buttonType;
    self.layer.masksToBounds = YES;
    switch (_imx_buttonType) {
        case IMXFlatButtonTypeNone:
        {
            
        }
            break;
        case IMXFlatButtonTypeText:
        {
            
        }
            break;
        default:
            break;
    }
}
@end
