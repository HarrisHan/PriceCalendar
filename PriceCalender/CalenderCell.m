//
//  CalenderCell.m
//  PriceCalender
//
//  Created by Harris on 16/4/27.
//  Copyright © 2016年 HarrisHan. All rights reserved.
//

#import "CalenderCell.h"



@interface CalenderCell ();

@property (nonatomic, weak) UILabel *lable;
@property (nonatomic, weak) UIView *statusView;

@end

@implementation CalenderCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, self.bounds.size.width-4, self.bounds.size.height-4)];
        statusView.backgroundColor = [UIColor redColor];
        statusView.alpha = 0.0f;
        self.statusView = statusView;
        [self.contentView addSubview:statusView];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.lable = lable;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.adjustsFontSizeToFitWidth = YES;
        lable.textColor = [UIColor blackColor];
        [self.contentView addSubview:lable];
    }
    return self;
}

- (void)setDay:(NSString *)day{
    
    self.lable.text = day;
}

- (void)setTextColor:(UIColor *)textColor{
    
    _textColor = textColor;
    self.lable.textColor = textColor;
}

- (void)setChoosed:(BOOL)choosed{
    
    _choosed = choosed;
    if (choosed) {
        self.statusView.alpha = 1.0f;
    }else{
        self.statusView.alpha = 0.0f;
    }
}

@end
