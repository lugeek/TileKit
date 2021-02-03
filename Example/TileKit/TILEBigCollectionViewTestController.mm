//
//  TILEBigCollectionViewTestController.m
//  TileKit_Example
//
//  Created by lugeek on 2021/2/2.
//  Copyright © 2021 lugeek. All rights reserved.
//

#import "TILEBigCollectionViewTestController.h"
#import "ComponentKit.h"
#import "ComponentTextKit.h"

@interface TILEBigComponentProvider : NSObject<CKComponentProvider>

@end

@implementation TILEBigComponentProvider

+ (CKComponent *)componentForModel:(NSDictionary *)data context:(id<NSObject>)context
{
    CKComponent *imageComponent = [[CKImageComponent alloc]
                                   initWithImage:[UIImage imageNamed:@"ic_error"]
                                   attributes:{}
                                   size:{.width=90,.height=90}];
    CKComponent *titleComponent = [CKLabelComponent
                                   newWithLabelAttributes:{
                                        .string=@"这是一个很长的标题1234567890这是一个很长的标题1234567890",
                                        .maximumNumberOfLines=2,
                                        .truncationString=@"…",
//                                        .lineBreakMode=NSLineBreakByCharWrapping,
                                        .maximumLineHeight=20,
                                        .minimumLineHeight=20,
                                        .font=[UIFont systemFontOfSize:14],
                                        .color=[UIColor blackColor]}
                                   viewAttributes:{}
                                   size:{}];
    CKComponent *skuComponent = [CKLabelComponent
                                 newWithLabelAttributes:{
                                        .string=@"这是一个很长的sku1234567890这是一个很长的sku1234567890这是一个很长的sku1234567890",
                                        .maximumNumberOfLines=2,
                                        .truncationString=@"…",
//                                        .lineBreakMode=NSLineBreakByCharWrapping,
                                        .font=[UIFont systemFontOfSize:14],
                                        .color=[UIColor grayColor]}
                                 viewAttributes:{}
                                 size:{}];
    CKComponent *priceComponent = [CKLabelComponent
                                   newWithLabelAttributes:{
                                        .string=@"¥198.00",
                                        .font=[UIFont systemFontOfSize:14],
                                        .color=[UIColor blackColor]}
                                   viewAttributes:{}
                                   size:{}];
    CKComponent *saveComponent = [CKLabelComponent
                                   newWithLabelAttributes:{
                                        .string=@"省¥18.00",
                                        .font=[UIFont systemFontOfSize:14],
                                        .color=[UIColor orangeColor]}
                                   viewAttributes:{}
                                   size:{}];
    CKComponent *priceAndSaveComponent = CK::FlexboxComponentBuilder()
                                        .direction(CKFlexboxDirectionColumn)
                                        .alignItems(CKFlexboxAlignItemsEnd)
                                        .spacing(4)
                                        .child(priceComponent)
                                        .child(saveComponent)
                                        .build();
    CGSize priceAndSaveSize = [priceAndSaveComponent layoutThatFits:CKSizeRange(CGSizeMake(0, 0), CGSizeMake(200, 200)) parentSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].size;
    CKComponent *numComponent = [CKLabelComponent
                                 newWithLabelAttributes:{
                                        .string=@"x2",
                                        .font=[UIFont systemFontOfSize:14],
                                        .color=[UIColor blackColor],
                                        .alignment=NSTextAlignmentRight}
                                 viewAttributes:{}
                                 size:{.width=priceAndSaveSize.width}];
    CKComponent *refundComponent = [CKLabelComponent
                                    newWithLabelAttributes:{}
                                    viewAttributes:{}
                                    size:{}];
    CKComponent *preComponent = [CKLabelComponent
                                 newWithLabelAttributes:{
                                    .string=@"预售",
                                    .font=[UIFont systemFontOfSize:14],
                                    .color=[UIColor redColor]}
                                 viewAttributes:{}
                                 size:{}];
    
    
    return CK::InsetComponentBuilder().insets(UIEdgeInsetsMake(12, 16, 12, 16))
    .component(
       CK::FlexboxComponentBuilder()
       .direction(CKFlexboxDirectionRow)
       .justifyContent(CKFlexboxJustifyContentStart)
       .alignItems(CKFlexboxAlignItemsStart)
       .child({.component = imageComponent})
       .child({
        .flexGrow = 1.f,
        .flexShrink = 1.f,
        .component = CK::FlexboxComponentBuilder()
                        .direction(CKFlexboxDirectionColumn)
                        .spacing(6)
                        .child(CK::FlexboxComponentBuilder()
                               .direction(CKFlexboxDirectionRow)
                               .spacing(16)
                               .child(CK::FlexboxChildComponentBuilder()
                                      .flexGrow(1)
                                      .flexShrink(1)
                                      .component(titleComponent)
                                      .build())
                               .child(priceAndSaveComponent)
                               .build())
                        .child(CK::FlexboxComponentBuilder()
                               .direction(CKFlexboxDirectionRow)
                               .spacing(16)
                               .child(CK::FlexboxChildComponentBuilder()
                                      .flexGrow(1)
                                      .flexShrink(1)
                                      .component(skuComponent)
                                      .build())
                               .child(numComponent)
                               .build())
                        .child(CK::FlexboxComponentBuilder()
                               .direction(CKFlexboxDirectionRow)
                               .build())
                        .child(preComponent)
                        .build()})
       .build())
    .build();
}

@end

@interface TILEBigCollectionViewTestController ()<UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)CKComponentFlexibleSizeRangeProvider *rangeProvider;
@property(nonatomic, strong)CKCollectionViewDataSource *dataSource;
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation TILEBigCollectionViewTestController

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
    
    CKDataSourceConfiguration *configuration = [[CKDataSourceConfiguration<NSDictionary*,id<NSObject>> alloc] initWithComponentProvider:[TILEBigComponentProvider class] context:nil sizeRange:sizeRange];
    
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
