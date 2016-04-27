//
//  CalenderView.h
// 简书：http://www.jianshu.com/users/c1bb6aa0e422/latest_articles
//
//  Created by Harris on 16/4/27.
//  Copyright © 2016年 HarrisHan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct
{
    NSUInteger day;
    NSUInteger month;
    NSUInteger year;
} YLDate;

@interface CalenderView : UIView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *today;
@property (nonatomic, copy) void(^calendarBlock)(YLDate date);

@end
