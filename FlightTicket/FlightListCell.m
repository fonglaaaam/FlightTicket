//
//  FlightListCell.m
//  ticketCheck
//
//  Created by 林峰 on 16/6/5.
//  Copyright © 2016年 林峰. All rights reserved.
//

#import "FlightListCell.h"
#import "Masonry.h"
#import "FlightInfo.h"

#define APP_FONT(f)                 [UIFont systemFontOfSize:f]

@implementation FlightListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _fromTime = [UILabel autoLayoutView:APP_FONT(18)textColor:[UIColor blackColor]];
        _fromTime.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_fromTime];
        
        _fromPlace = [UILabel autoLayoutView:APP_FONT(14)textColor:[UIColor blackColor]];
        _fromPlace.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_fromPlace];
        
        _toTime = [UILabel autoLayoutView:APP_FONT(18)textColor:[UIColor blackColor]];
        _toTime.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_toTime];
        
        _toPlace = [UILabel autoLayoutView:APP_FONT(14)textColor:[UIColor blackColor]];
        _toPlace.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_toPlace];
        
        _price1 = [UILabel autoLayoutView:APP_FONT(14)textColor:[UIColor blackColor]];
        _price1.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_price1];
        
        _priceInfo1 = [UILabel autoLayoutView:APP_FONT(14)textColor:[UIColor blackColor]];
        _priceInfo1.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_priceInfo1];
        
        _price2 = [UILabel autoLayoutView:APP_FONT(14)textColor:[UIColor blackColor]];
        _price2.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_price2];
        
        _priceInfo2 = [UILabel autoLayoutView:APP_FONT(14)textColor:[UIColor blackColor]];
        _priceInfo2.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_priceInfo2];
        
        _plane = [UILabel autoLayoutView:APP_FONT(13)textColor:[UIColor blackColor]];
        _plane.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_plane];
        
        _flight = [UILabel autoLayoutView:APP_FONT(13)textColor:[UIColor blackColor]];
        _flight.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_flight];
        
        UIView *superView = self.contentView;
        
        [_fromTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(superView).offset(15);
            make.height.equalTo(@16);
            make.width.equalTo(@100);
        }];
        
        [_toTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.mas_top).offset(15);
            make.left.equalTo(_fromTime.mas_right).offset(80);
            make.height.equalTo(@16);
            make.width.equalTo(@100);
        }];
        
        [_fromPlace mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(15);
            make.top.equalTo(_fromTime.mas_bottom).offset(5);
            make.height.equalTo(@16);
            make.width.equalTo(@100);
        }];
        
        [_toPlace mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_toTime.mas_bottom).offset(5);
            make.left.equalTo(_fromPlace.mas_right).offset(80);
            make.height.equalTo(@16);
            make.width.equalTo(@100);
        }];
        
        [_flight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(15);
            make.bottom.equalTo(superView.mas_bottom).offset(-20);
            make.height.equalTo(@14);
            make.width.equalTo(@100);
            make.right.equalTo(_plane.mas_left).offset(-3);
        }];
        
        [_plane mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_flight.mas_right).offset(3);
            make.bottom.equalTo(superView.mas_bottom).offset(-20);
            make.height.equalTo(@14);
            make.width.equalTo(@100);
        }];
        
        [_price1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView).offset(7);
            make.right.equalTo(superView.mas_right).offset(-15);
            make.height.equalTo(@16);
            make.width.equalTo(@100);
        }];
        
        [_priceInfo1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_price1.mas_bottom).offset(5);
            make.right.equalTo(superView.mas_right).offset(-15);
            make.height.equalTo(@16);
            make.width.equalTo(@100);
        }];
        
        [_price2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_priceInfo1.mas_bottom).offset(5);
            make.right.equalTo(superView.mas_right).offset(-15);
            make.height.equalTo(@16);
            make.width.equalTo(@100);
        }];
        
        [_priceInfo2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_price2.mas_bottom).offset(5);
            make.right.equalTo(superView.mas_right).offset(-15);
            make.height.equalTo(@16);
            make.width.equalTo(@100);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor grayColor];
        [superView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.left.right.bottom.equalTo(superView);
        }];
        
        
        _priceInfo1.text = @"经济舱";
        _priceInfo2.text = @"头等超值舱";
    }
    return self;
}

- (void)setModel:(FlightInfo *)model{
    _flight.text = model.flight;
    _plane.text = model.plane;
    _fromTime.text = model.fromTime;
    _toTime.text = model.toTime;
    _fromPlace.text = model.fromPlace;
    _toPlace.text = model.toPlace;
    _price1.text = model.price1;
    //    _priceInfo1.text = model.priceInfo1;
    _price2.text = model.price2;
    //    _priceInfo2.text = model.priceInfo2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end

@implementation UILabel(ext)
+ (UILabel *)autoLayoutView:(UIFont *)font textColor:(UIColor *)tColor{
    UILabel *lable = [[self class] new];
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = tColor;
    lable.font = font;
    return lable;
}
@end
