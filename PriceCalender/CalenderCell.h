//
//  CalenderCell.h
//  PriceCalender
//
//  Created by Harris on 16/4/27.
//  Copyright © 2016年 HarrisHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderCell : UICollectionViewCell

@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign,getter=isPasted) BOOL pasted;
@property (nonatomic, assign,getter=isChoosed) BOOL choosed;

@end
