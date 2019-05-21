//
//  ViewController.m
//  FlutterHybridiOS
//
//  Created by 张亚飞 on 2019/5/21.
//  Copyright © 2019 张亚飞. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = UIColor.redColor;
    [self.view addSubview:view];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"切换");
    FlutterViewController *flutterViewController = [FlutterViewController new];
    [flutterViewController setInitialRoute:@"rout1"];
    [self presentViewController:flutterViewController animated:NO completion:nil];
}
    


@end
