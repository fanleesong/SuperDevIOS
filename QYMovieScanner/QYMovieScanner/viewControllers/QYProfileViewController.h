//
//  QYProfileViewController.h
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYBaseViewController.h"

//个人设置
@interface QYProfileViewController : QYBaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIImageView *avatarImages;
@property (nonatomic,retain)NSArray *textArray;
@property (nonatomic,retain)UIButton *loginButton;
@property (nonatomic,retain)UIButton *registButton;
@property (nonatomic,retain)UILabel *nickNameAndDate;
@end
