//
//  ViewController.m
//  ticketCheck
//
//  Created by 林峰 on 16/6/2.
//  Copyright © 2016年 林峰. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ASIHTTPRequest.h"
#import "City.h"
#import "FlightListController.h"

@interface ViewController ()<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *cityArray;
    NSMutableData *recvData;
    NSMutableData * urlData;
    NSURLConnection *submitConnection;
    
    NSMutableDictionary *params;
    
    UIButton *startCityBtn;
    UIButton *endCityBtn;
    UIButton *oneWayBtn;
    UIButton *roundWayBtn;
    UIButton *startDateBtn;
    UIButton *endDateBtn;
    UIButton *submitBtn;
    UITableView *_tableView;
    UIDatePicker *picker;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    recvData = [NSMutableData data];
    urlData = [NSMutableData data];
    
    cityArray = [NSMutableArray array];
    params = [NSMutableDictionary dictionary];
    [params setValue:@"" forKey:@"startCity"];
    [params setValue:@"" forKey:@"destCity"];
    [params setValue:@"" forKey:@"startDate"];
    [params setValue:@"" forKey:@"backDate"];
    [params setValue:@"oneWay" forKey:@"flightType"];
    //city 录入
    NSURL *url = [NSURL URLWithString:@"http://touch.qunar.com/h5/flight/citylist?type=11"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    oneWayBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    oneWayBtn.backgroundColor = [UIColor redColor];
    [oneWayBtn setTitle:@"单程" forState:UIControlStateNormal];
    [oneWayBtn addTarget:self action:@selector(oneWayFlightClick)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oneWayBtn];
    
    roundWayBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    roundWayBtn.backgroundColor = [UIColor lightGrayColor];
    [roundWayBtn setTitle:@"往返" forState:UIControlStateNormal];
    [roundWayBtn addTarget:self action:@selector(roundWayClick)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:roundWayBtn];
    
    startCityBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    startCityBtn.backgroundColor = [UIColor lightGrayColor];
    startCityBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    startCityBtn.tag = 20;
    [startCityBtn setTitle:@"出发城市" forState:UIControlStateNormal];
    [startCityBtn addTarget:self action:@selector(cityShow:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startCityBtn];
    
    endCityBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    endCityBtn.backgroundColor = [UIColor lightGrayColor];
    [endCityBtn setTitle:@"目的城市" forState:UIControlStateNormal];
    endCityBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    endCityBtn.tag = 21;
    [endCityBtn addTarget:self action:@selector(cityShow:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endCityBtn];
    
    startDateBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    startDateBtn.backgroundColor = [UIColor lightGrayColor];
    [startDateBtn setTitle:@"出发日期" forState:UIControlStateNormal];
    [startDateBtn addTarget:self action:@selector(dateShow:)
           forControlEvents:UIControlEventTouchUpInside];
    startDateBtn.tag = 22;
    [self.view addSubview:startDateBtn];
    
    endDateBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    endDateBtn.backgroundColor = [UIColor lightGrayColor];
    [endDateBtn setTitle:@"返程日期" forState:UIControlStateNormal];
    endDateBtn.tag = 23;
    [endDateBtn addTarget:self action:@selector(dateShow:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endDateBtn];
    
    submitBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor brownColor];
    [submitBtn addTarget:self action:@selector(subMit)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    UIView *superView = self.view;
    [oneWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView.mas_centerX).offset(-40);
        make.top.equalTo(superView.mas_top).offset(80);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    [roundWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_centerX).offset(40);
        make.top.equalTo(superView.mas_top).offset(80);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    [startCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneWayBtn.mas_bottom).offset(20);
        make.right.equalTo(superView.mas_centerX).offset(-30);
        make.left.equalTo(superView);
        make.height.equalTo(@30);
    }];
    
    [endCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_centerX).offset(30);
        make.top.equalTo(oneWayBtn.mas_bottom).offset(20);
        make.right.equalTo(superView);
        make.height.equalTo(@30);
    }];
    
    [startDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startCityBtn.mas_bottom).offset(20);
        make.right.equalTo(superView.mas_centerX).offset(-30);
        make.left.equalTo(superView);
        make.height.equalTo(@30);
    }];
    
    [endDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startCityBtn.mas_bottom).offset(20);
        make.left.equalTo(superView.mas_centerX).offset(30);
        make.right.equalTo(superView);
        make.height.equalTo(@30);
    }];
    
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startDateBtn.mas_bottom).offset(30);
        make.centerX.equalTo(superView);
        make.width.equalTo(@150);
        make.height.equalTo(@40);
    }];
    
    [self oneWayFlightClick];
}

- (void)oneWayFlightClick {
    [params setValue:@"oneWay" forKey:@"flightType"];
    roundWayBtn.backgroundColor = [UIColor lightGrayColor];
    endDateBtn.userInteractionEnabled = NO;
    endDateBtn.hidden = YES;
}

- (void)roundWayClick {
    [params setValue:@"roundWay" forKey:@"flightType"];
    roundWayBtn.backgroundColor = [UIColor redColor];
    oneWayBtn.backgroundColor = [UIColor redColor];
    endDateBtn.userInteractionEnabled = YES;
    endDateBtn.hidden = NO;
}

BOOL isStart;
- (void)cityShow:(UIButton *)sender {
    if(sender.tag == 20){
        isStart = YES;
    }else{
        isStart = NO;
    }
    
    [self.view addSubview:_tableView];
    
    UIView *superView = self.view;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_centerY);
        make.bottom.left.right.equalTo(superView);
    }];
    [self.view layoutSubviews];
}

- (void)dateShow:(UIButton *)sender {
    if(picker){
        [picker removeFromSuperview];
        [[self.view viewWithTag:40]removeFromSuperview];
    }
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *currentDataString = [formatter stringFromDate:date];
    NSLog(@"当前时间字符串：%@",currentDataString);
    
    picker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    picker.tag = sender.tag + 10;
    picker.datePickerMode = UIDatePickerModeDate;
    NSDate *currentDate = [NSDate date];
    picker.minimumDate = currentDate;
    [picker addTarget:self action:@selector(didSelectedData:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:picker];
    
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    doneBtn.tag = 40;
    doneBtn.backgroundColor = [UIColor redColor];
    [doneBtn setTitle:@"完成日期选择" forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(done:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    
    UIView *superView = self.view;
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(superView);
        make.height.equalTo(@250);
    }];
    
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(picker);
        make.height.equalTo(@30);
    }];
    
    [self.view layoutSubviews];
}

- (void)didSelectedData:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *currentDataString = [formatter stringFromDate:datePicker.date];
    NSLog(@"选择了：%@",currentDataString);
    if(datePicker.tag == 32){
        [params setValue:currentDataString forKey:@"startDate"];
        [startDateBtn setTitle:currentDataString forState:UIControlStateNormal];
    }else{
        [params setValue:currentDataString forKey:@"backDate"];
        [endDateBtn setTitle:currentDataString forState:UIControlStateNormal];
    }
}

- (void)done:(UIButton *)sender {
    [picker removeFromSuperview];
    [sender removeFromSuperview];
}

- (void)subMit {
    //     NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://touch.qunar.com/h5/flight/flightlist?startCity=%E5%8C%97%E4%BA%AC&startCode=PEK&destCity=%E4%B8%8A%E6%B5%B7&destCode=SHA&startDate=2016-06-02&backDate=&flightType=oneWay"]];
    
    NSMutableString *url = [NSMutableString stringWithFormat:@"http://touch.qunar.com/h5/flight/flightlist"];
    ;
    
    FlightListController *flightListVC = [[FlightListController alloc]init];
    flightListVC.url = [NSURL URLWithString:[self requestJoinToString:url]];
    [self.navigationController pushViewController:flightListVC animated:YES];
}

- (NSString *)requestJoinToString:(NSString *)url{
    NSMutableArray *_params = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *key in params.allKeys) {
        NSString *value = [params valueForKey:key];
        NSString * encodingString = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [_params addObject:[NSString stringWithFormat:@"%@=%@",key,encodingString]];
    }
    NSString *paramString = [_params componentsJoinedByString:@"&"];
    NSLog(@"请求链接: %@?%@",url,paramString);
    return [NSString stringWithFormat:@"%@?%@",url,paramString];
}

#pragma mark -NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    if (connection == submitConnection) {
        urlData.length = 0;
        NSLog(@"请求长度%lld   文件名 %@",[response expectedContentLength],[response suggestedFilename]);
    }else{
        recvData.length = 0;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if (connection == submitConnection) {
        [urlData appendData:data];
    }else{
        [recvData appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if (connection == submitConnection) {
        
    }else{
        NSArray *array = [NSJSONSerialization JSONObjectWithData:recvData
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
        for (NSDictionary *group in array) {
            CityGroup *cityGroup = [[CityGroup alloc]init];
            cityGroup.key = group[@"k"];
            cityGroup.list = [NSMutableArray array];
            for (NSDictionary *dictionary in group[@"n"]) {
                City *city = [[City alloc]init];
                city.name = dictionary[@"n"];
                city.code = dictionary[@"c"];
                [cityGroup.list addObject:city];
            }
            [cityArray addObject:cityGroup];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
}

#pragma mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return cityArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CityGroup *group = [cityArray objectAtIndex:section];
    return group.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    CityGroup *group = [cityArray objectAtIndex:indexPath.section];
    City *city = [group.list objectAtIndex:indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CityGroup *group = [cityArray objectAtIndex:section];
    return group.key;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityGroup *group = [cityArray objectAtIndex:indexPath.section];
    City *city = [group.list objectAtIndex:indexPath.row];
    if(isStart){
        [params setValue:city.name forKey:@"startCity"];
        [params setValue:city.code forKey:@"startCode"];
        [startCityBtn setTitle:city.name forState:UIControlStateNormal];
    }else{
        [params setValue:city.name forKey:@"destCity"];
        [params setValue:city.code forKey:@"destCode"];
        [endCityBtn setTitle:city.name forState:UIControlStateNormal];
    }
    [_tableView removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

