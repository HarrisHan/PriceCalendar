//
//  MonthCell.m
//  PriceCalender
//
//  Created by Harris on 16/4/27.
//  Copyright © 2016年 HarrisHan. All rights reserved.
//

#import "MonthCell.h"

@interface MonthCell ()

@property (nonatomic, weak) CalenderView *calendar;

@end

@implementation MonthCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initView{
    
    CalenderView *calendar = [[CalenderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-100, 300)];
    self.calendar = calendar;
    __weak MonthCell *weakSelf = self;
    [calendar setCalendarBlock:^(YLDate date) {
        if (weakSelf.selectedBlock) {
            weakSelf.selectedBlock(date);
            
        }
    }];
    [self.contentView addSubview:calendar];
}

- (void)setDate:(NSDate *)date{
    
    _date = date;
    self.calendar.date = date;
}

- (void)setToday:(NSDate *)today{
    
    _today = today;
    self.calendar.today = today;
}

@end
