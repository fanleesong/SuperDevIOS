//
//  QYUserRegistViewController.h
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-14.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYBaseViewController.h"

@interface QYUserRegistViewController : QYBaseViewController<UITextFieldDelegate>

@property(nonatomic,retain)UITextField *nickNameTextField;
@property(nonatomic,retain)UITextField *confirmPasswordField;
@property(nonatomic,retain)UITextField *userNameTextField;
@property(nonatomic,retain)UITextField *userPasswordTextField;
@property(nonatomic,retain)UILabel *userNameLabel;
@property(nonatomic,retain)UILabel *userPasswordLabel;
@property(nonatomic,retain)UILabel *nickNameLabel;
@property(nonatomic,retain)UILabel *confirmPasswordLabel;



@end
