//
//  HybridVC.m
//  FlutterHybridiOS
//
//  Created by 张亚飞 on 2019/5/22.
//  Copyright © 2019 张亚飞. All rights reserved.
//

#import "HybridVC.h"

#import "NativeVC.h"
#import "FlutterVC.h"

#define  Statur_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define  NAVIBAR_HEIGHT  (self.navigationController.navigationBar.frame.size.height) //导航栏高度

#define Top_HEIGHT (Statur_HEIGHT + NAVIBAR_HEIGHT)

@interface HybridVC ()

@end

@implementation HybridVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"交互";
    self.view.backgroundColor = UIColor.grayColor;
    [self initUI];
}
    
    
- (void)initUI {
    
    NativeVC *native = [[NativeVC alloc] init];
    [self addChildViewController:native];
    native.view.frame = CGRectMake(0, Top_HEIGHT, UIScreen.mainScreen.bounds.size.width, 200);
    [self.view addSubview:native.view];
    
    FlutterVC *flutter = [[FlutterVC alloc] init];
    [self addChildViewController:flutter];
    flutter.InitParams = self.InitParams;
    flutter.view.frame = CGRectMake(0, CGRectGetMaxY(native.view.frame), UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height -CGRectGetMaxY(native.view.frame));
    [self.view addSubview:flutter.view];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
