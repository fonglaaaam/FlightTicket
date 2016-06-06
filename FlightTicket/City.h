//
//  City.h
//  ticketCheck
//
//  Created by 林峰 on 16/6/5.
//  Copyright © 2016年 林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityGroup : NSObject
@property NSString *key;
@property NSMutableArray *list;
@end

@interface City : NSObject
@property NSString *name;
@property NSString *code;
@end
