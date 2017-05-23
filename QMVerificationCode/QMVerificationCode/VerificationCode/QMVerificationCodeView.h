//
//  QMVerificationCodeView.h
//  QMVerificationCode
//
//  Created by zyx on 17/5/23.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMVerificationCodeView : UIView

/// 验证码，必须设置
@property (nonatomic, copy) NSString *verificationCode;

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame checkCode:(BOOL(^)(NSString *))checkCode success:(void(^)(NSString *))success fail:(dispatch_block_t)fail;

/// 开始验证
- (void)startCheck;

@end
