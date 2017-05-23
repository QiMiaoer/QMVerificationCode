//
//  QMVerificationCodeView.m
//  QMVerificationCode
//
//  Created by zyx on 17/5/23.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "QMVerificationCodeView.h"

#define Random_Color [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]
#define Random_Font_Size arc4random_uniform(8) + 15
#define Line_Count 6

@implementation QMVerificationCodeView {
    NSArray *_codes;
    BOOL(^_checkCode)(NSString *);
    void(^_success)(NSString *);
    dispatch_block_t _fail;
}

- (instancetype)initWithFrame:(CGRect)frame checkCode:(BOOL (^)(NSString *))checkCode success:(void (^)(NSString *))success fail:(dispatch_block_t)fail {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = Random_Color;
        _checkCode = checkCode;
        _success = success;
        _fail = fail;
    }
    return self;
}

- (void)setVerificationCode:(NSString *)verificationCode {
    _verificationCode = verificationCode;
    
    NSMutableArray *characters = [NSMutableArray array];
    for (int i = 0; i < verificationCode.length; i++) {
        [characters addObject:[verificationCode substringWithRange:NSMakeRange(i, 1)]];
    }
    _codes = [characters copy];
    
    [self setNeedsDisplay];
}

- (void)startCheck {
    if (_checkCode) {
        BOOL success = _checkCode(_verificationCode);
        if (success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"success" message:[NSString stringWithFormat:@"check success! code is %@", _verificationCode] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            if (_success) {
                _success(_verificationCode);
            }
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"fail" message:@"check fail! code error!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            if (_fail) {
                _fail();
            }
        }
    }
}

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = Random_Color;
    
    CGFloat margin = 2;
    CGFloat maxWidth = (self.frame.size.width - (_codes.count + 1) * margin) / _codes.count;
    CGFloat maxHeight = self.frame.size.height;
    CGSize size = [@"一" boundingRectWithSize:CGSizeMake(maxWidth, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:Random_Font_Size]} context:nil].size;
    
    for (int i = 0; i < _codes.count; i++) {
        CGRect charRect = CGRectMake((maxWidth + margin) * i + margin + arc4random_uniform(maxWidth - size.width), arc4random_uniform(maxHeight - size.height), size.width, size.height);
        [_codes[i] drawInRect:charRect withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:Random_Font_Size], NSForegroundColorAttributeName: Random_Color}];
    }
    
    for (int i = 0; i < Line_Count; i++) {
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint:CGPointMake(arc4random_uniform(rect.size.width), arc4random_uniform(rect.size.height))];
        [path addLineToPoint:CGPointMake(arc4random_uniform(rect.size.width), arc4random_uniform(rect.size.height))];
        [Random_Color setStroke];
        path.lineWidth = 1;
        [path stroke];
    }
}

@end
