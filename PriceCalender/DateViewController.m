//
//  DateViewController.m
//  PriceCalender
//
//  Created by Harris on 16/4/27.
//  Copyright © 2016年 HarrisHan. All rights reserved.
//

#import "DateViewController.h"
#import "MonthCell.h"
#import "AppDelegate.h"

YLDate endDate;
YLDate startDate;

@interface DateViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initView];
    
}

- (void)initView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 20, self.view.bounds.size.width-100, self.view.bounds.size.height-20) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.sectionHeaderHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[MonthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    NSDate *today = [NSDate date];
    cell.today = today;
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +indexPath.row;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:today options:0];
    cell.date = newDate;
    __weak DateViewController *weakSelf = self;
    [cell setSelectedBlock:^(YLDate date) {
        
        if (date.year == startDate.year && date.month == startDate.month && date.day == startDate.day) {
            [weakSelf clear];
            
        }else if (startDate.day>0 && endDate.day>0) {
            [self clear];
            startDate = date;
        }else{
            if (startDate.day) {
                endDate = date;
                [weakSelf.tableView reloadData];
            }else{
                startDate = date;
                [weakSelf.tableView reloadData];
            }
        }
        
    }];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(10, 0, 40, 40);
    [clearBtn setTitle:@"清除" forState:UIControlStateNormal];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [clearBtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:clearBtn];
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame = CGRectMake(tableView.bounds.size.width-60, 0, 40, 40);
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    finishBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [finishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:finishBtn];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(clearBtn.frame)+10, 0, self.tableView.bounds.size.width-120, 40)];
    titleLable.text = @"请选择入住日期";
    titleLable.textColor = [UIColor blackColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.adjustsFontSizeToFitWidth = YES;
    [headerView addSubview:titleLable];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 300;
}

- (void)clear{
    
    startDate.day = 0;
    startDate.month = 0;
    startDate.year = 0;
    endDate.day = 0;
    endDate.month = 0;
    endDate.year = 0;
    [self.tableView reloadData];
}

- (void)finish{
    
    if (startDate.day != 0 && endDate.day != 0) {
        if (self.finishBlock) {
            self.finishBlock(startDate.year,startDate.month,startDate.day,endDate.year,endDate.month,endDate.day);
        }
    }
    [self clear];
    [self hiden];
}

- (void)show{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 ) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [delegate.window.rootViewController presentViewController:self animated:YES completion:^{
            [UIView animateWithDuration:0.25 animations:^{
                self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            }];
            
        }];
    }else{
        self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [delegate.window.rootViewController presentViewController:self animated:YES completion:^{
            [UIView animateWithDuration:0.25 animations:^{
                self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            }];
        }];
        self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
}

- (void)hiden{
    
    [UIView animateWithDuration:0.1 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
