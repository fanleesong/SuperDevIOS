//
//  QYUserLoginViewController.h
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-14.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYBaseViewController.h"

@interface QYUserLoginViewController : QYBaseViewController<UITextFieldDelegate>

@property(nonatomic,retain)UITextField *userNameTextField;
@property(nonatomic,retain)UITextField *userPasswordTextField;
@property(nonatomic,retain)UILabel *userNameLabel;
@property(nonatomic,retain)UILabel *userPasswordLabel;
@property(nonatomic,retain)UIButton *loginButton;
@property(nonatomic,retain)UIButton *registerButton;

@end
