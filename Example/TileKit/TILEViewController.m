//
//  TILEViewController.m
//  TileKit
//
//  Created by lugeek on 01/26/2021.
//  Copyright (c) 2021 lugeek. All rights reserved.
//

#import "TILEViewController.h"
#import "TILEHostingVIewTextController.h"
#import "TILECollectionViewTestController.h"
#import "TILEBigCollectionViewTestController.h"

@interface TILEViewController ()
@property(nonatomic, strong)UIButton *button1;
@property(nonatomic, strong)UIButton *button2;
@property(nonatomic, strong)UIButton *button3;
@end

@implementation TILEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(12, 100, 200, 44)];
    [self.button1 setTitle:@"非列表使用" forState:UIControlStateNormal];
    self.button1.backgroundColor = [UIColor blueColor];
    [self.button1 addTarget:self action:@selector(goToHostingView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button1];
    
    self.button2 = [[UIButton alloc] initWithFrame:CGRectMake(12, 150, 200, 44)];
    [self.button2 setTitle:@"CollectionView使用" forState:UIControlStateNormal];
    self.button2.backgroundColor = [UIColor blueColor];
    [self.button2 addTarget:self action:@selector(goToCollectionView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button2];
    
    self.button3 = [[UIButton alloc] initWithFrame:CGRectMake(12, 200, 200, 44)];
    [self.button3 setTitle:@"复杂列表使用" forState:UIControlStateNormal];
    self.button3.backgroundColor = [UIColor blueColor];
    [self.button3 addTarget:self action:@selector(goToBigCollectionView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button3];
    
}

- (void)goToHostingView
{
    [self.navigationController pushViewController:[TILEHostingVIewTextController new] animated:YES];
}

- (void)goToCollectionView
{
    [self.navigationController pushViewController:[TILECollectionViewTestController new] animated:YES];
}

- (void)goToBigCollectionView
{
    [self.navigationController pushViewController:[TILEBigCollectionViewTestController new] animated:YES];
}

@end
