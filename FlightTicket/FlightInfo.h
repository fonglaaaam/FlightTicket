//
//  FlightInfo.h
//  ticketCheck
//
//  Created by 林峰 on 16/6/5.
//  Copyright © 2016年 林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightInfo : NSObject
@property(nonatomic,strong)NSString *fromTime;
@property(nonatomic,strong)NSString *fromPlace;
@property(nonatomic,strong)NSString *toTime;
@property(nonatomic,strong)NSString *toPlace;
@property(nonatomic,strong)NSString *price1;
@property(nonatomic,strong)NSString *priceInfo1;
@property(nonatomic,strong)NSString *price2;
@property(nonatomic,strong)NSString *priceInfo2;
@property(nonatomic,strong)NSString *plane;
@property(nonatomic,strong)NSString *flight;
@end
