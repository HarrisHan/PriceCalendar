//
//  CalenderCell.h
// 简书：http://www.jianshu.com/users/c1bb6aa0e422/latest_articles
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
