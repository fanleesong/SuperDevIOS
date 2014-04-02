//
//  QYHomePageCell.h
//  QYMovieScanner
//
//  Created by BB on 14-3-13.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYVideoModule;
//创建工厂协议
@protocol CellDelegate <NSObject>

- (void)imageWithVideoModule:(QYVideoModule *)video didClick:(id)sender;

@end

@interface QYHomePageCell : UITableViewCell


@property (nonatomic ,retain) NSMutableArray * dataForCellArray;//文件单元格数组
@property (nonatomic ,assign) id<CellDelegate> delegate;//协议

//设置单元格数据的工厂
- (void)setCellForDataArray;

@end

