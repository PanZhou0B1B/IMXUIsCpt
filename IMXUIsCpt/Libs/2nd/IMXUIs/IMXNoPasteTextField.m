//
//  IMXNoPasteTextField.m
//  IMXBaseCpt
//
//  Created by zhoupanpan on 2017/12/21.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import "IMXNoPasteTextField.h"

@interface IMXNoPasteTextField()

@end
@implementation IMXNoPasteTextField
- (void)dealloc{
}
#pragma mark ======  public  ======

#pragma mark ======  life cycle  ======
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if(action == @selector(paste:)){
        return NO;
    }
    if(action == @selector(select:)){
        return NO;
    }
    if(action == @selector(selectAll:)){
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}
#pragma mark ======  delegate  ======

#pragma mark ======  event  ======

#pragma mark ======  private  ======

#pragma mark ======  getter & setter  ======



@end
