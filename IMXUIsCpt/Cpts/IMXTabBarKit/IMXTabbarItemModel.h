//
//  IMXTabbarItemModel.h
//  IMXTabbarKit
//
//  Created by zhoupanpan on 2017/11/24.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, IMXTabbarItemType) {
    IMXTabbarItemTypeNormal = 0,
};
@interface IMXTabbarItemModel : NSObject

@property (nonatomic,assign)IMXTabbarItemType itemType;
@property (nonatomic,assign)BOOL selected;
//跳转page:两者互斥
@property (nonatomic,copy)NSString *pageClass;//本地
//@property (nonatomic,copy)NSString *pageURI;//远程

@property (nonatomic,copy)NSString *rootNavi;//可选

@property (nonatomic,strong)UIImage *itemImg;
//@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,strong)UIImage *itemSelectedImg;

@property (nonatomic,copy)NSString *itemTitle;

@property (nonatomic,strong)UIColor *normalColor;
@property (nonatomic,strong)UIColor *highColor;
@end
