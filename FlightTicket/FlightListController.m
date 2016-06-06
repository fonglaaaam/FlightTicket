//
//  FlightListController.m
//  ticketCheck
//
//  Created by 林峰 on 16/6/5.
//  Copyright © 2016年 林峰. All rights reserved.
//

#import "FlightListController.h"
#import "FlightListCell.h"
#import "Masonry.h"
#import "TFHpple.h"
#import "FlightInfo.h"

@interface FlightListController ()
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation FlightListController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray array];
    
    [self.tableView registerClass:[FlightListCell class] forCellReuseIdentifier:@"FlightListCell"];
    
    _data = [NSData dataWithContentsOfURL:_url];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:_data];
    NSArray *dataArray = [xpathParser searchWithXPathQuery:@"//li [@class='list-row item']"];
    
    for (TFHppleElement *hppleElement in dataArray) {
        FlightInfo *info = [[FlightInfo alloc]init];
        
        NSArray *fromtimeArray = [hppleElement searchWithXPathQuery:@"//p [@class='from-time time-font']"];
        TFHppleElement *e1 = fromtimeArray.firstObject;
        NSLog(@"%@",e1.content);
        info.fromTime = e1.content;
        
        NSArray *FromPlaceArray = [hppleElement searchWithXPathQuery:@"//p [@class='from-place ellipsis']"];
        TFHppleElement *e2 = FromPlaceArray.firstObject;
        NSLog(@"%@",e2.content);
        info.fromPlace = e2.content;
        
        NSArray *toTimeArray = [hppleElement searchWithXPathQuery:@"//p [@class='to-time time-font']"];
        TFHppleElement *e3 = toTimeArray.firstObject;
        NSLog(@"%@",e3.content);
        info.toTime = e3.content;
        
        NSArray *toPlaceArray = [hppleElement searchWithXPathQuery:@"//p [@class='to-place ellipsis']"];
        TFHppleElement *e4 = toPlaceArray.firstObject;
        NSLog(@"%@",e4.content);
        info.toPlace = e4.content;
        
        NSArray *planeArray = [hppleElement searchWithXPathQuery:@"//span [@class='company2 ellipsis']"];
        TFHppleElement *e5 = planeArray.firstObject;
        NSLog(@"%@",e5.content);
        info.plane = e5.content;
        
        NSArray *flightArray = [hppleElement searchWithXPathQuery:@"//span [@class='company1 ellipsis']"];
        TFHppleElement *e6 = flightArray.firstObject;
        NSLog(@"%@",e6.content);
        info.flight = e6.content;
        
        NSArray *price1Array = [hppleElement searchWithXPathQuery:@"//p [@class='price-info']"];
        TFHppleElement *e7 = price1Array.firstObject;
        NSLog(@"%@",e7.content);
        info.price1 = e7.content;
        
        NSArray *price2Array = [hppleElement searchWithXPathQuery:@"//p [@class='price-info2']"];
        TFHppleElement *e8 = price2Array.firstObject;
        NSLog(@"%@",e8.content);
        info.price2 = e8.content;
        
        [_dataSource addObject:info];
    }
    NSLog(@"%@",_dataSource);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlightListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlightListCell"
                                                           forIndexPath:indexPath];
    if (!cell){
        cell = [[FlightListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FlightListCell"];
        
    }
    FlightInfo *info = [_dataSource objectAtIndex:indexPath.row];
    [cell setModel:info];
    return cell;
}

@end
