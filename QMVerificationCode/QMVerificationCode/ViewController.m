//
//  ViewController.m
//  QMVerificationCode
//
//  Created by zyx on 17/5/23.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "ViewController.h"
#import "QMVerificationCodeView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *aView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController {
    QMVerificationCodeView *_codeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QMVerificationCodeView *codeView = [[QMVerificationCodeView alloc] initWithFrame:self.aView.bounds checkCode:^BOOL(NSString *code) {
        return [self.textField.text isEqualToString:code];
    } success:^(NSString *code) {
        NSLog(@"success code is %@", code);
    } fail:^{
        NSLog(@"fail");
    }];
    [self.aView addSubview:codeView];
    _codeView = codeView;
    
    codeView.verificationCode = @"a3b5";
}

- (IBAction)check:(id)sender {
    [_codeView startCheck];
}

- (IBAction)exchange:(id)sender {
    _codeView.verificationCode = @"8d6cdb";
}

@end
