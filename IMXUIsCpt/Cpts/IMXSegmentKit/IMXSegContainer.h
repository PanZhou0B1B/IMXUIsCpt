//
//  IMXSegContainer.h
//  DHSeller
//
//  Created by zhoupanpan on 2017/11/30.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UICollectionViewCell* (^IMXRetReuseCellBlock)(UICollectionView *collectionView,id model, NSIndexPath * indexPath);
typedef NSInteger (^IMXRetNumBlock)(NSInteger section);
typedef CGSize (^IMXRetSizeBlock)(NSIndexPath *indexPath);
typedef void (^IMXSegSelectBlock)(NSInteger index);

@class IMXSegmentModel;
@protocol IMXSegContainerProtocol<NSObject>
@required
- (UIViewController *)containerViewController;
- (NSArray<IMXSegmentModel *> *)containerSegModels;
- (UIViewController *)childViewControllerAtIndex:(NSInteger)index;
@end
@class IMXSegCollectionView;
@interface IMXSegContainer : UIView
@property (nonatomic,strong)IMXSegCollectionView *segListView;
@property (nonatomic,strong)UICollectionViewFlowLayout *layout;
@property (nonatomic,weak)id<IMXSegContainerProtocol> delegate;
@property (nonatomic,copy)IMXSegSelectBlock selectBlock;

- (instancetype)initWithHighColor:(UIColor *)color registCell:(NSString *)className retNum:(IMXRetNumBlock)numBlock retSize:(IMXRetSizeBlock)sizeBlock retCell:(IMXRetReuseCellBlock)cellBlock;
- (instancetype)initWithHighColor:(UIColor *)color segmentHeaderHeight:(CGFloat)height registCell:(NSString *)className retNum:(IMXRetNumBlock)numBlock retSize:(IMXRetSizeBlock)sizeBlock retCell:(IMXRetReuseCellBlock)cellBlock;
+ (UICollectionViewCell *)dequeueReusableCellWithName:(NSString *)cellDes forIndexPath:(NSIndexPath *)indexPath inCollectView:(UICollectionView *)colView;

- (void)selectedSegment:(NSInteger)index;
- (void)reloadSegContainer;
@end
