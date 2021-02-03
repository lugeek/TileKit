//
//  TILEHostingVIewTextController.m
//  TileKit_Example
//
//  Created by lugeek on 2021/2/2.
//  Copyright © 2021 lugeek. All rights reserved.
//

#import "TILEHostingVIewTextController.h"
#import "ComponentKit.h"
#import "ComponentTextKit.h"

@interface TILEHostingVIewTextController ()
@property(nonatomic, strong)CKComponentHostingView *hostingView;
@end

@implementation TILEHostingVIewTextController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CKComponentFlexibleSizeRangeProvider *rangeProvider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibleWidthAndHeight];
    self.hostingView = [[CKComponentHostingView alloc] initWithComponentProviderFunc:componentProvider sizeRangeProvider:rangeProvider];
    [self.view addSubview:self.hostingView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGSize hostingViewSize = [self.hostingView sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGFloat bottom = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    self.hostingView.frame = CGRectMake(100, bottom + 100, hostingViewSize.width, hostingViewSize.height);
}

// componentProvider 方法实现方式
static CKComponent *componentProvider(id<NSObject> model, id<NSObject> context)
{
  CKComponentScope scope([CKComponent class]);
    return CK::FlexboxComponentBuilder()
    .child([CKLabelComponent newWithLabelAttributes:{
        .string = @"hello world",
        .font = [UIFont systemFontOfSize:12],
    } viewAttributes:{
        {@selector(setBackgroundColor:), [UIColor redColor]},
        {@selector(setUserInteractionEnabled:), @NO},
    } size:{}])
    .build();
}

@end
