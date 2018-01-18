//
//  IMXSegContainer.m
//  DHSeller
//
//  Created by zhoupanpan on 2017/11/30.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import "IMXSegContainer.h"
#import <Masonry/Masonry.h>
#import "IMXSegCollectionView.h"
#import "IMXSegBaseCell.h"
#import "IMXSegmentModel.h"
#import "IMXUIKitExtUtil.h"
#import <IMXFuncCpt/IMXObjectExtUtil.h>
#define SEGMENTHEADER_H       60   //segmentHeader的默认高度
@interface IMXSegContainer()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong)UIColor *lineColor;
@property (nonatomic,copy) NSString *cellDes;
@property (nonatomic,copy)IMXRetReuseCellBlock retCellBlock;
@property (nonatomic,copy)IMXRetNumBlock retNumBlock;
@property (nonatomic,copy)IMXRetSizeBlock retSizeBlock;

@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIView *grayLineView;
@property (nonatomic,strong)UIScrollView *containerScrollView;

@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,assign)BOOL isLinked;
@property (nonatomic,assign)BOOL isContainerDraging;

@property (nonatomic,strong)NSArray *dataModels;

@property (nonatomic,assign)CGFloat segmentHeaderH;//segmentHeader的高度
@end

@implementation IMXSegContainer

- (void)dealloc{
}
#pragma mark ======  public  ======
- (instancetype)initWithHighColor:(UIColor *)color registCell:(NSString *)className retNum:(IMXRetNumBlock)numBlock retSize:(IMXRetSizeBlock)sizeBlock retCell:(IMXRetReuseCellBlock)cellBlock{
   return  [self initWithHighColor:color segmentHeaderHeight:SEGMENTHEADER_H registCell:className retNum:numBlock retSize:sizeBlock retCell:cellBlock];
}
- (instancetype)initWithHighColor:(UIColor *)color segmentHeaderHeight:(CGFloat)height registCell:(NSString *)className retNum:(IMXRetNumBlock)numBlock retSize:(IMXRetSizeBlock)sizeBlock retCell:(IMXRetReuseCellBlock)cellBlock{
    self = [super init];
    if(self){
        self.lineColor = color;
        self.cellDes = className;
        self.retNumBlock = numBlock;
        self.retSizeBlock = sizeBlock;
        self.retCellBlock = cellBlock;
        self.segmentHeaderH=height;
        [self initializeView];
    }
    return self;
}
- (void)reloadSegContainer{
    self.dataModels = [self.delegate containerSegModels];
    [self.segListView reloadData];
    self.containerScrollView.contentSize = CGSizeMake(self.dataModels.count*IMX_SCREEN_WIDTH_UIKIT, self.containerScrollView.contentSize.height);
    [self selectedSegment:self.selectedIndex];
}
- (void)selectedSegment:(NSInteger)index{
    [self selectedSegment:index actionLinked:YES];
}
+ (UICollectionViewCell *)dequeueReusableCellWithName:(NSString *)cellDes forIndexPath:(NSIndexPath *)indexPath inCollectView:(UICollectionView *)colView{
    Class cellClz = NSClassFromString(cellDes);
    if(!cellClz){
        cellClz = NSClassFromString(@"UICollectionViewCell");
    }
    NSString *cellId = [NSString stringWithFormat:@"%@ReuseId",[cellClz description]];
    UICollectionViewCell *cell = [colView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    return cell;
}
#pragma mark ======  life cycle  ======
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initializeView];
    }
    return self;
}
//- (void)layoutSubviews{
//    [super layoutSubviews];
//
//    [self refreshUIs];
//}
#pragma mark ======  delegate  ======
#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.retNumBlock){
        return _retNumBlock(section);
    }
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.retSizeBlock){
        return _retSizeBlock(indexPath);
    }
    return CGSizeMake(0, 0);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    IMXSegmentModel *model = [self.dataModels imxObjectAtIndex:indexPath.item];
    IMXSegBaseCell *cell = nil;
    if(self.retCellBlock){
        cell = (IMXSegBaseCell *)self.retCellBlock(collectionView,model,indexPath);
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self cellSelectedAtIndex:indexPath];
}
#pragma mark ======  UIScrollView delegate  ======
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView != self.containerScrollView){
        return;
    }
    if(!_isContainerDraging){
        return;
    }
    [self pageChange:scrollView];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(scrollView != self.containerScrollView){
        return;
    }
    self.isContainerDraging = YES;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView != self.containerScrollView){
        return;
    }
    [self pageChange:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(scrollView != self.containerScrollView){
        return;
    }
    self.isContainerDraging = NO;
}
- (void)pageChange:(UIScrollView *)scrollView{
    if(scrollView != self.containerScrollView){
        return;
    }
    CGFloat pageWidth = IMX_SCREEN_WIDTH_UIKIT;
    BOOL isLeftSlide = scrollView.contentOffset.x < pageWidth*self.selectedIndex;
    NSInteger page = 0;
    if(isLeftSlide){
        page = ceil((scrollView.contentOffset.x-pageWidth/2)/pageWidth);
    }else{
        page = floorf((scrollView.contentOffset.x+pageWidth/2)/pageWidth);
    }
    if (self.selectedIndex != page) {
        
        //self.selectedIndex = page;
        
        [self selectedSegment:page actionLinked:NO];
    }
}

#pragma mark ======  event  ======

#pragma mark ======  private  ======
- (void)initializeView{
    self.selectedIndex = -1;
    self.isLinked = YES;
    Class cellClz = NSClassFromString(self.cellDes);
    if(!cellClz){
        cellClz = NSClassFromString(@"UICollectionViewCell");
    }
    NSString *cellId = [NSString stringWithFormat:@"%@ReuseId",[cellClz description]];
    [self.segListView registerClass:cellClz forCellWithReuseIdentifier:cellId];
    [self configUIs];
    [self refreshUIs];
}
- (void)selectedSegment:(NSInteger)index actionLinked:(BOOL)isLinked{
    if(index<0 || index >=self.dataModels.count){
        return;
    }
    self.isLinked = isLinked;
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.segListView selectItemAtIndexPath:selectIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    [self cellSelectedAtIndex:selectIndexPath];
}
- (void)configUIs{
    [self.backView addSubview:self.segListView];
    [self.backView addSubview:self.grayLineView];
    [self.backView addSubview:self.lineView];
    [self addSubview:self.backView];
    [self addSubview:self.containerScrollView];
}
- (void)refreshUIs{
    [self.segListView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(0);
        make.right.equalTo(self.backView).offset(0);
        make.top.equalTo(self.backView).offset(0);
        make.bottom.equalTo(self.backView).offset(-1);
    }];
    [self.grayLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(0);
        make.right.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.backView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(-10);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.backView);
        make.width.mas_equalTo(10);
    }];
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.mas_equalTo(self.segmentHeaderH);
    }];
    [self.containerScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self.backView.mas_bottom).offset(0);
        make.bottom.equalTo(self).offset(0);
    }];
}
- (void)cellSelectedAtIndex:(NSIndexPath *)indexPath{
    if(indexPath.item == _selectedIndex){
        return;
    }
    if(_selectedIndex >= 0){
        NSIndexPath *preIndexPath = [NSIndexPath indexPathForItem:_selectedIndex inSection:0];
        [self.segListView deselectItemAtIndexPath:preIndexPath animated:NO];
        [self oldChildRemoveAtIndex:_selectedIndex];
    }
    self.selectedIndex = indexPath.item;
    [self.segListView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    [self newChildMoveAtIndex:_selectedIndex];
    if(self.isLinked)
    {
        [self.containerScrollView setContentOffset:CGPointMake(_selectedIndex*IMX_SCREEN_WIDTH_UIKIT, 0)];
        
        if(self.selectBlock){
            _selectBlock(_selectedIndex);
        }
    }
    self.isLinked = YES;
     [self updataLineView];
}

/**
 动态更新底部选中态横线
 */
- (void)updataLineView{
    if(_selectedIndex < 0){
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_selectedIndex inSection:0];
    IMXSegBaseCell *cell = (IMXSegBaseCell *)[self.segListView cellForItemAtIndexPath:indexPath];
    CGRect frame = [self.segListView convertRect:cell.frame toView:self.backView];
    [UIView animateWithDuration:0.2 animations:^{
        [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.backView).offset(frame.origin.x);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self.backView);
            make.width.mas_equalTo(frame.size.width);
        }];
        [self.backView layoutIfNeeded];
    }];
}
/**
 旧的的child Ctrl自container上移除，需要设置部分：
 View 不再重复移除；
 周期方法响应
 
 @param index <#index description#>
 */
- (void)oldChildRemoveAtIndex:(NSInteger)index{
    UIViewController *old = [self.delegate childViewControllerAtIndex:index];
    //[old.view removeFromSuperview];
    [old beginAppearanceTransition:NO animated:YES];
    [old endAppearanceTransition];
    [old willMoveToParentViewController:nil];
    [old removeFromParentViewController];
}

/**
 新的child Ctrl添加至container上，需要设置部分：
 View 添加；
 周期方法响应
 
 @param index <#index description#>
 */
- (void)newChildMoveAtIndex:(NSInteger)index{
    UIViewController *new = [self.delegate childViewControllerAtIndex:index];
    [[self.delegate containerViewController] addChildViewController:new];
    if(!new.view.superview){
        [self addChildViewtoContainerAtIndex:index];
    }else{
        [new beginAppearanceTransition:YES animated:YES];
        [new endAppearanceTransition];
    }
    [new didMoveToParentViewController:[self.delegate containerViewController]];
}

/**
 chilid Ctrl对应的View添加至Container容器上
 
 @param index 位置
 */
- (void)addChildViewtoContainerAtIndex:(NSInteger )index {
    UIViewController *ctrl = [self.delegate childViewControllerAtIndex:index];
    if(ctrl.view.superview){
        return;
    }
    [self.containerScrollView addSubview:ctrl.view];
    [ctrl.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerScrollView).offset(IMX_SCREEN_WIDTH_UIKIT*index);
        make.top.equalTo(self.containerScrollView);
        make.width.mas_equalTo(IMX_SCREEN_WIDTH_UIKIT);
        make.height.equalTo(self.containerScrollView);
    }];
}

/**
 segment底部黑色横线
 */
- (void)grayLineConfig{
    [self.backView addSubview:self.grayLineView];
    [_grayLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.backView);
    }];
}
#pragma mark ======  getter & setter  ======
- (UIView *)backView{
    if(!_backView){
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
- (IMXSegCollectionView *)segListView{
    if(!_segListView){
        _segListView = [[IMXSegCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _segListView.delegate = self;
        _segListView.dataSource = self;
        _segListView.backgroundColor = [UIColor whiteColor];
        _segListView.showsHorizontalScrollIndicator = NO;
        _segListView.alwaysBounceHorizontal = YES;
    }
    return _segListView;
}
- (UICollectionViewFlowLayout *)layout{
    if(!_layout){
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 0.1f;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}
- (UIScrollView *)containerScrollView{
    if(!_containerScrollView){
        _containerScrollView = [[UIScrollView alloc] init];
        _containerScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _containerScrollView.delegate = self;
        _containerScrollView.showsVerticalScrollIndicator = NO;
        _containerScrollView.showsHorizontalScrollIndicator = NO;
        _containerScrollView.pagingEnabled = YES;
    }
    return _containerScrollView;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [UIView new];
        _lineView.backgroundColor = self.lineColor;
    }
    return _lineView;
}
- (UIColor *)lineColor{
    if(!_lineColor){
        _lineColor = [UIColor blueColor];
    }
    return _lineColor;
}
- (UIView *)grayLineView{
    if(!_grayLineView){
        _grayLineView = [UIView new];
        _grayLineView.backgroundColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1.0f];
    }
    return _grayLineView;
}

@end
