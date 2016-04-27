//
//  DateViewController.h
// 简书：http://www.jianshu.com/users/c1bb6aa0e422/latest_articles
//
//  Created by Harris on 16/4/27.
//  Copyright © 2016年 HarrisHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateViewController : UIViewController


@property (nonatomic, copy) void (^finishBlock)(NSUInteger start_year,NSUInteger start_month, NSUInteger start_day, NSUInteger end_year,NSUInteger end_month,NSUInteger end_day);

- (void)show;

- (void)hiden;


@end
