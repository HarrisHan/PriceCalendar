//
//  WeekView.m
//  PriceCalender
//
//  Created by Harris on 16/4/27.
//  Copyright © 2016年 HarrisHan. All rights reserved.
//

#import "weekView.h"

@interface weekView ()

@property (nonatomic, strong) UILabel *monthLable;

@end

@implementation weekView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.monthLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-100, self.bounds.size.height/2)];
    self.monthLable.textColor = [UIColor blackColor];
    self.monthLable.adjustsFontSizeToFitWidth = YES;
    self.monthLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.monthLable];
    
    NSArray *weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat width = self.bounds.size.width/weekArray.count;
    for (int i = 0; i < weekArray.count; i++) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(width*i, self.bounds.size.height/2, width, self.bounds.size.height/2)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.adjustsFontSizeToFitWidth = YES;
        lable.textColor = [UIColor blackColor];
        lable.text = weekArray[i];
        [self addSubview:lable];
    }
}

- (void)setMonth:(NSString *)month{
    
    _month = month;
    self.monthLable.text = month;
}

@end
