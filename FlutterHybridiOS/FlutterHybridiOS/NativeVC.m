//
//  NativeVC.m
//  FlutterHybridiOS
//
//  Created by 张亚飞 on 2019/5/22.
//  Copyright © 2019 张亚飞. All rights reserved.
//

#import "NativeVC.h"

@interface NativeVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *useChannel;

@property (nonatomic, strong) UILabel *receiverLbl;

@property (nonatomic, strong) UITextField *sendTextF;

@end

@implementation NativeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.lightGrayColor;
    
    [self initUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMessage:) name:@"showMessage" object:nil];
}

- (void)showMessage:(NSNotification*)notification{
    id params = notification.object;
    self.receiverLbl.text = [NSString stringWithFormat:@"来自Dart：%@",params];
}

    
- (void)initUI {
    
    UISwitch *sendSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(10, 10, 55, 32)];
    [self.view addSubview:sendSwitch];
    BOOL isMethod = [[NSUserDefaults standardUserDefaults] valueForKey:@"isMethod"];
    
    sendSwitch.on = isMethod;
    
    [sendSwitch addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventValueChanged];
    
    
    UILabel *useChannel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sendSwitch.frame) + 30, 10, 1000, 20)];
    [self.view addSubview:useChannel];
    _useChannel = useChannel;
    _useChannel.text = sendSwitch.isOn ? @"_methodChannel" :  @"_basicMessageChannel";
    
    
    UILabel *receiverLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sendSwitch.frame) + 4, UIScreen.mainScreen.bounds.size.width, 70)];
    receiverLbl.numberOfLines = 0;
    _receiverLbl = receiverLbl;
    _receiverLbl.text = @"noData";
    [self.view addSubview:receiverLbl];
    
    UITextField *sendTF = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(receiverLbl.frame) + 5, UIScreen.mainScreen.bounds.size.width - 20, 50)];
    [self.view addSubview:sendTF];
    _sendTextF = sendTF;
//    _sendTextF.delegate = self;
    sendTF.layer.cornerRadius = 3;
    sendTF.layer.borderColor = UIColor.blueColor.CGColor;
    sendTF.layer.borderWidth = 1;
    [sendTF addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    
}
    
    
- (void)changeState:(UISwitch *)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:@"isMethod"];
    _useChannel.text = sender.isOn ? @"_methodChannel" :  @"_basicMessageChannel";
}


- (void)textDidChange:(UITextField *)textField{
    NSString * text = textField.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendMessage" object:@{@"message": text,@"useEventChannel":[[NSUserDefaults standardUserDefaults] valueForKey:@"isMethod"]}];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
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
