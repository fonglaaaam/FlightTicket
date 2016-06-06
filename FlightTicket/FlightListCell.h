//
//  FlightListCell.h
//  ticketCheck
//
//  Created by 林峰 on 16/6/5.
//  Copyright © 2016年 林峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightInfo.h"

@interface FlightListCell : UITableViewCell
@property(nonatomic,strong)UILabel *fromTime;
@property(nonatomic,strong)UILabel *fromPlace;
@property(nonatomic,strong)UILabel *toTime;
@property(nonatomic,strong)UILabel *toPlace;
@property(nonatomic,strong)UILabel *price1;
@property(nonatomic,strong)UILabel *priceInfo1;
@property(nonatomic,strong)UILabel *price2;
@property(nonatomic,strong)UILabel *priceInfo2;
@property(nonatomic,strong)UILabel *plane;
@property(nonatomic,strong)UILabel *flight;

- (void)setModel:(FlightInfo *)model;
@end

@interface UILabel(ext)
+ (UILabel *)autoLayoutView:(UIFont *)font textColor:(UIColor *)tColor;
@end