//
//  MainVC.m
//  FlutterHybridiOS
//
//  Created by 张亚飞 on 2019/5/22.
//  Copyright © 2019 张亚飞. All rights reserved.
//

#import "MainVC.h"
#import "HybridVC.h"

@interface MainVC ()

@property (nonatomic, strong) UITextField *flutterInitParamsTF;
    
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"混合开发";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UITextField *flutterInitParamsTF = [[UITextField alloc] initWithFrame:CGRectMake(10,150, UIScreen.mainScreen.bounds.size.width - 20, 23)];
    _flutterInitParamsTF = flutterInitParamsTF;
    flutterInitParamsTF.layer.cornerRadius = 3;
    flutterInitParamsTF.layer.borderColor = UIColor.blueColor.CGColor;
    flutterInitParamsTF.layer.borderWidth = 2;
    [self.view addSubview:flutterInitParamsTF];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"初始化" forState:UIControlStateNormal];
    btn.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width  - 100) / 2, CGRectGetMaxY(flutterInitParamsTF.frame) + 30, 100, 30);
    btn.backgroundColor = UIColor.blueColor;
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoInit) forControlEvents:UIControlEventTouchUpInside];
    
}

    
- (void)gotoInit {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isMethod"];
    
    HybridVC *hybirdVC = [[HybridVC alloc] init];
    hybirdVC.InitParams = _flutterInitParamsTF.text;
    [self.navigationController pushViewController:hybirdVC animated:YES];
    
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
