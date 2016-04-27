//
//  ViewController.m
//  PriceCalender
//
//  Created by Harris on 16/4/27.
//  Copyright © 2016年 HarrisHan. All rights reserved.
//

#import "ViewController.h"
#import "CalenderView.h"
#import "DateViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    DateViewController *vc = [[DateViewController alloc] init];

    [vc setFinishBlock:^(NSUInteger start_year,NSUInteger start_month, NSUInteger start_day, NSUInteger end_year,NSUInteger end_month,NSUInteger end_day) {
        NSLog(@"开始日期:%ld-%ld-%ld;结束日期:%ld-%ld-%ld",start_year,start_month,start_day,end_year,end_month,end_day);
    }];
    [vc show];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
