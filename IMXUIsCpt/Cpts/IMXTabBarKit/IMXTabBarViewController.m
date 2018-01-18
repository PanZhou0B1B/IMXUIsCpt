//
//  IMXTabBarViewController.m
//  IMXTabbarKit
//
//  Created by zhoupanpan on 2017/11/27.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import "IMXTabBarViewController.h"
#import "IMXTabbarItemModel.h"
#import "IMXTabBarItem.h"
#import "IMXTabBar.h"
#import <Masonry/Masonry.h>

NSString *const imx_tabbar_showreddot_notificationname = @"imx_tabbar_showreddot_notificationname";
NSString *const imx_tabbar_hidereddot_notificationname = @"imx_tabbar_hidereddot_notificationname";

NSString *const imx_tabbar_show_notificationname = @"imx_tabbar_show_notificationname";
NSString *const imx_tabbar_hide_notificationname = @"imx_tabbar_hide_notificationname";

NSString *const imx_show_tabbar_notificationname = @"imx_show_tabbar_notificationname";
@interface IMXTabBarViewController ()
@property (nonatomic,strong)NSMutableArray *itemModels;
@property (nonatomic,strong)NSMutableArray *items;
@property (nonatomic,strong)IMXTabBar *imxTabbar;
@property (nonatomic,assign)CGFloat tabbarBottomOffset;
@end

@implementation IMXTabBarViewController


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark ======  public  ======
- (void)refreshTabBar:(NSArray *)itemModels{
    if(itemModels && itemModels.count>0){
        [self.itemModels removeAllObjects];
        [self.itemModels addObjectsFromArray:itemModels];
        [self refreshCtrls];
        [self refreshTabbarItems];
        [self refreshUIs];
    }
}
+ (void)postShowReddotAtIndex:(NSUInteger)index{
    [[NSNotificationCenter defaultCenter] postNotificationName:imx_tabbar_showreddot_notificationname object:nil userInfo:@{imx_tabbar_index:@(index)}];
}
+ (void)posthHideReddotAtIndex:(NSUInteger)index{
    [[NSNotificationCenter defaultCenter] postNotificationName:imx_tabbar_hidereddot_notificationname object:nil userInfo:@{imx_tabbar_index:@(index)}];
}
+ (void)postShowTabbar{
    [[NSNotificationCenter defaultCenter] postNotificationName:imx_tabbar_show_notificationname object:nil userInfo:nil];
}
+ (void)posthHideTabbar{
    [[NSNotificationCenter defaultCenter] postNotificationName:imx_tabbar_hide_notificationname object:nil userInfo:nil];
}
- (void)showReddotAtIndex:(NSUInteger)index{
    index = MIN(index, self.items.count-1);
    IMXTabBarItem *item = [self.items objectAtIndex:index];
    item.showReddot = YES;
}
- (void)hideReddotAtIndex:(NSUInteger)index{
    index = MIN(index, self.items.count-1);
    IMXTabBarItem *item = [self.items objectAtIndex:index];
    item.showReddot = NO;
}
+ (void)postShowTabbarAtIndex:(NSInteger)index{
    [[NSNotificationCenter defaultCenter] postNotificationName:imx_show_tabbar_notificationname object:nil userInfo:@{imx_tabbar_index:@(index)}];
}
#pragma mark ======  life cycle  ======
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [self initialData];
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialData];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initialData];
    }
    return self;
}
- (void)initialData{
    self.tabBar.hidden = YES;
    _imxSelectedIndex = 0;
    self.tabbarBottomOffset = .0f;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the voiview.
    self.view.backgroundColor = [UIColor whiteColor];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showReddot:) name:imx_tabbar_showreddot_notificationname object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideReddot:) name:imx_tabbar_hidereddot_notificationname object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show:) name:imx_tabbar_show_notificationname object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide:) name:imx_tabbar_hide_notificationname object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabbarAtIndex:) name:imx_show_tabbar_notificationname object:nil];
    
    self.imxSelectedIndex = 0;
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //约束、frame布局设置
    [self refreshUIs];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ======  delegate  ======

#pragma mark ======  event  ======

#pragma mark ======  private  ======
- (void)refreshCtrls{
    NSMutableArray *rootCtrls = [[NSMutableArray alloc] init];
    NSInteger count = self.itemModels.count;
    for (NSInteger index = 0;index<count;index++){
        IMXTabbarItemModel *model = self.itemModels[index];
        if(![model isKindOfClass:[IMXTabbarItemModel class]]){
            break;
        }
        Class clz = NSClassFromString(model.pageClass);
        if(!clz){
            break;
        }
        UIViewController *rootCtrl = [[clz alloc] init];
        
        Class rootNaviClz = NSClassFromString(model.rootNavi);
        if(rootNaviClz){
            UINavigationController *rootNavi = [[rootNaviClz alloc] initWithRootViewController:rootCtrl];
            [rootCtrls addObject:rootNavi];
        }else{
            [rootCtrls addObject:rootCtrl];
        }
    }
    self.viewControllers = rootCtrls;
}
- (void)refreshTabbarItems{
    [self.imxTabbar removeAllTabbarItemViews];
    [self.items removeAllObjects];
    if(![self.imxTabbar superview]){
        [self.view addSubview:self.imxTabbar];
    }
    NSInteger count = self.itemModels.count;
    count = MIN(count, 5);
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width/count;
    __weak __typeof(self)weakSelf = self;
    for (NSInteger index = 0;index<count;index++){
        IMXTabbarItemModel *model = self.itemModels[index];
        IMXTabBarItem *item = [[IMXTabBarItem alloc] init];
        item.itemImg = model.itemImg;
        item.itemSelectedImg = model.itemSelectedImg;
        item.itemTitle = model.itemTitle;
        item.normalColor = model.normalColor;
        item.selectColor = model.highColor;
        item.selectblock = ^(IMXTabBarItem *item) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.imxSelectedIndex = [strongSelf.items indexOfObject:item];
        };
        [self.imxTabbar addSubview:item];
        [item mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imxTabbar).offset(index*itemWidth);
            make.top.equalTo(self.imxTabbar).offset(4);
            make.bottom.equalTo(self.imxTabbar);
            make.width.mas_equalTo(itemWidth);
        }];
        [self.items addObject:item];
    }
}
- (void)refreshUIs{
    [self.imxTabbar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        if(@available(iOS 11.0, *)){
            make.bottom.equalTo(self.view).offset(-self.view.safeAreaInsets.bottom+self.tabbarBottomOffset);
        }else{
            make.bottom.equalTo(self.view).offset(self.tabbarBottomOffset);
        }
        make.height.mas_equalTo(49);
    }];
}
- (void)showReddot:(NSNotification *)noti{
    NSDictionary *userinfo = noti.userInfo;
    NSInteger index = [[userinfo objectForKey:imx_tabbar_index] integerValue];
    [self showReddotAtIndex:index];
}
- (void)hideReddot:(NSNotification *)noti{
    NSDictionary *userinfo = noti.userInfo;
    NSInteger index = [[userinfo objectForKey:imx_tabbar_index] integerValue];
    [self hideReddotAtIndex:index];
}
- (void)show:(NSNotification *)noti{
    [self hideTabBar:NO];
}
- (void)hide:(NSNotification *)noti{
    [self hideTabBar:YES];
}
- (void)hideTabBar:(BOOL)isHidden{
    if(isHidden){
        if(@available(iOS 11.0, *)){
            self.tabbarBottomOffset = self.view.safeAreaInsets.bottom+49;
        }else{
            self.tabbarBottomOffset = 49;
        }
    }else{
        self.tabbarBottomOffset = 0;
    }
    [self refreshUIs];
    [UIView animateWithDuration:.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)showTabbarAtIndex:(NSNotification *)noti{
    NSDictionary *userinfo = noti.userInfo;
    NSInteger index = [[userinfo objectForKey:imx_tabbar_index] integerValue];
    index = MIN(index, self.items.count-1);
    index = MAX(0, index);
    self.selectedIndex = index;
    self.imxSelectedIndex = index;
}
#pragma mark ======  getter & setter  ======
- (NSMutableArray *)itemModels{
    if(!_itemModels){
        _itemModels = [[NSMutableArray alloc] init];
    }
    return _itemModels;
}
- (NSMutableArray *)items{
    if(!_items){
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}
- (IMXTabBar *)imxTabbar{
    if(!_imxTabbar){
        _imxTabbar = [[IMXTabBar alloc] init];
        [_imxTabbar configShadow];
        _imxTabbar.backgroundColor = [UIColor whiteColor];
    }
    return _imxTabbar;
}
- (void)setImxSelectedIndex:(NSUInteger)imxSelectedIndex{
    if(self.itemModels.count<=0){
        return;
    }
    if((_imxSelectedIndex == imxSelectedIndex) && (imxSelectedIndex != 0)){
        return;
    }
    _imxSelectedIndex = imxSelectedIndex;
    for(IMXTabbarItemModel *sModel in self.itemModels){
        sModel.selected = NO;
    }
    for(IMXTabBarItem *item in self.items){
        item.selected = NO;
    }
    self.selectedIndex = _imxSelectedIndex;
    IMXTabbarItemModel *model = [self.itemModels objectAtIndex:_imxSelectedIndex];
    model.selected = YES;
    IMXTabBarItem *item = [self.items objectAtIndex:_imxSelectedIndex];
    item.selected = YES;
}
@end
