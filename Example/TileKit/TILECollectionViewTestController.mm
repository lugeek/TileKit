//
//  TILECollectionViewTestController.m
//  TileKit_Example
//
//  Created by lugeek on 2021/2/2.
//  Copyright © 2021 lugeek. All rights reserved.
//

#import "TILECollectionViewTestController.h"
#import "ComponentKit.h"
#import "ComponentTextKit.h"

@interface TILECollectionViewTestController () <UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)CKComponentFlexibleSizeRangeProvider *rangeProvider;
@property(nonatomic, strong)CKCollectionViewDataSource *dataSource;
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation TILECollectionViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:0];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    self.rangeProvider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibleHeight];
    const CKSizeRange sizeRange = [self.rangeProvider sizeRangeForBoundingSize:self.collectionView.bounds.size];
    
    CKDataSourceConfiguration *configuration = [[CKDataSourceConfiguration<NSDictionary*,id<NSObject>> alloc] initWithComponentProviderFunc:ComponentProvider context:nil sizeRange:sizeRange];
    
    self.dataSource = [[CKCollectionViewDataSource alloc] initWithCollectionView:self.collectionView supplementaryViewDataSource:nil configuration:configuration];
    
    self.dataArray = [NSMutableArray new];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CKDataSourceChangeset *initialChangeset = [[[CKDataSourceChangesetBuilder dataSourceChangeset] withInsertedSections:[NSIndexSet indexSetWithIndex:0]] build];
    [self.dataSource applyChangeset:initialChangeset mode:CKUpdateModeAsynchronous userInfo:nil];
    [self nextPage];
}

static CKComponent *ComponentProvider(NSDictionary *data, id<NSObject> context)
{
  return [CKLabelComponent newWithLabelAttributes:{
      .string = data[@"key"],
      .font = [UIFont systemFontOfSize:20],
      .color = [UIColor redColor],
  } viewAttributes:{
      
  } size:{}];
}

- (void)nextPage
{
    NSInteger startIndex = [self.dataArray count];
    NSMutableDictionary *items = [NSMutableDictionary new];
    for (int i = 0; i < 50; i++) {
        [self.dataArray addObject:@(startIndex + i)];
        [items setObject:@{@"key": [NSString stringWithFormat:@"第%@个", @(startIndex + i)]} forKey:[NSIndexPath indexPathForRow:startIndex + i inSection:0]];
    }
    CKDataSourceChangeset *changeset = [[[CKDataSourceChangesetBuilder dataSourceChangeset] withInsertedItems:items] build];
    [self.dataSource applyChangeset:changeset mode:CKUpdateModeAsynchronous userInfo:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return [_dataSource sizeForItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
  [_dataSource announceWillDisplayCell:cell];
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
  [_dataSource announceDidEndDisplayingCell:cell];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  if (scrollView.contentSize.height == 0) {
    return;
  }
  if (scrolledToBottomWithBuffer(scrollView.contentOffset, scrollView.contentSize, scrollView.contentInset, scrollView.bounds)) {
      [self nextPage];
  }
}

static BOOL scrolledToBottomWithBuffer(CGPoint contentOffset, CGSize contentSize, UIEdgeInsets contentInset, CGRect bounds)
{
  CGFloat buffer = CGRectGetHeight(bounds) - contentInset.top - contentInset.bottom;
  const CGFloat maxVisibleY = (contentOffset.y + bounds.size.height);
  const CGFloat actualMaxY = (contentSize.height + contentInset.bottom);
  return ((maxVisibleY + buffer) >= actualMaxY);
}

@end
