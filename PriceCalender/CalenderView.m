//
//  CalenderView.m
//  PriceCalender
//
//  Created by Harris on 16/4/27.
//  Copyright © 2016年 HarrisHan. All rights reserved.
//

#import "CalenderView.h"
#import "WeekView.h"
#import "CalenderCell.h"

#define CELLID @"calenderCellID"
#define HEADERID @"weekViewID"

@interface CalenderView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CalenderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        _today = [NSDate date];
        [self initView];
    }
    return self;
}

- (NSInteger)firstWeekDayInThisMonth:(NSDate *)date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [components setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:components];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

- (NSInteger)today:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

- (void)setDate:(NSDate *)date{
    
    _date = date;
    [self.collectionView reloadData];
}

- (void)initView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(self.bounds.size.width/7, (self.bounds.size.height-80)/6);
    flowLayout.headerReferenceSize = CGSizeMake(self.bounds.size.width, 80);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CalenderCell class] forCellWithReuseIdentifier:CELLID];
    [self.collectionView registerClass:[weekView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADERID];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSUInteger number = [self totaldaysInMonth:self.date] + [self firstWeekDayInThisMonth:self.date];
    return number;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
    cell.pasted = NO;
    BOOL canSelected = YES;
    cell.choosed = NO;
    NSUInteger firstWeekDay = [self firstWeekDayInThisMonth:self.date];
    if (indexPath.row < firstWeekDay) { //1号之前置空，并不可点击
        cell.day = @"";
        cell.pasted = YES;
        canSelected = NO;
    }else{
        NSUInteger day = indexPath.row - firstWeekDay + 1;
        cell.day = [NSString stringWithFormat:@"%ld",day];
        cell.textColor = [UIColor blackColor];
        
        if ([self.today isEqualToDate:self.date]) {//当月
            if ([self today:self.date] == day) { //当天
                cell.day = @"今天";
            }
            if (day < [self today:self.date]) { //本月过去的日期
                cell.textColor = [UIColor lightGrayColor];
                canSelected = NO;
                cell.pasted = YES;
            }else{
                cell.textColor = [UIColor blackColor];
            }
        }
    }
    
    extern YLDate startDate;
    extern YLDate endDate;
    
    if (startDate.day > 0 && endDate.day == 0) { //只选择了开始
        NSUInteger year = [self year:self.date];
        NSUInteger month = [self month:self.date];
        NSUInteger day = indexPath.row - firstWeekDay + 1;
        double cellDate = year*10000+month*100+day;
        double start = startDate.year*10000+startDate.month*100+startDate.day;
        if (cellDate < start) { //开始之前的日期变灰并不可点击
            cell.pasted = YES;
            cell.textColor = [UIColor grayColor];
        }else if(cellDate == start){ //开始日期
            cell.day = @"开始";
            cell.choosed = YES;
        }else{                      //其他
            cell.textColor = [UIColor blackColor];
        }
    }
    
    if (startDate.day && endDate.day) { //选择结束
        double start = startDate.year*10000+startDate.month*100+startDate.day;
        double end = endDate.year*10000+endDate.month*100+endDate.day;
        NSUInteger year = [self year:self.date];
        NSUInteger month = [self month:self.date];
        NSUInteger day = indexPath.row - firstWeekDay + 1;
        double cellDate = year*10000+month*100+day;
        if (start <= cellDate && cellDate <= end && canSelected) { //开始和结束中间的日期的cell
            cell.choosed = YES; //设置选中状态
            
            if (start == cellDate) { //开始日期的cell
                cell.day = @"开始";
            }else if (end == cellDate){ //结束日期的cell
                cell.day = @"结束";
            }
            
        }else{ // 其余未选中cell
            cell.choosed = NO;
        }
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    weekView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADERID forIndexPath:indexPath];
    headerView.month = [NSString stringWithFormat:@"%ld-%ld",[self year:self.date],[self month:self.date]];
    return headerView;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CalenderCell *cell = (CalenderCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.isPasted) {
        return;
    }
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger firstWeekday = [self firstWeekDayInThisMonth:self.date];
    
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    day = i - firstWeekday + 1;
    if (self.calendarBlock) {
        YLDate date;
        date.day = day;
        date.month = [comp month];
        date.year = [comp year];
        self.calendarBlock(date);
    }
}



@end

