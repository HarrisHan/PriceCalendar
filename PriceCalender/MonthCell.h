//
//  MonthCell.h
//  PriceCalender
//
//  Created by Harris on 16/4/27.
//  Copyright © 2016年 HarrisHan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalenderView.h"

@interface MonthCell : UITableViewCell

@property (nonatomic, strong) NSDate *today;
@property (nonatomic, assign) NSDate *date;
@property (nonatomic, copy) void(^selectedBlock)(YLDate date);

@end
