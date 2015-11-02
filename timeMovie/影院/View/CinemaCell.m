//
//  CinemaCell.m
//  timeMovie
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "CinemaCell.h"
#import "Cinema.h"

@implementation CinemaCell

//重写setCinema方法
-(void)setCinema:(Cinema *)cinema
{
    _cinema = cinema;
    _nameLabel.text = _cinema.name;
    _addressLabel.text = _cinema.address;
    _gradeLabel.text = _cinema.grade;
    if (_cinema.lowPrice.length == 0) {
        _lowPriceLabel.text = @"暂无报价";
    }
    else
    {
        _lowPriceLabel.text = [NSString stringWithFormat:@"¥%@",_cinema.lowPrice];
    }

    _isSeatSupportImageView.hidden = ![_cinema.isSeatSupport intValue];

    _isCouponSupportImageView.hidden = ![_cinema.isCouponSupport intValue];
    
    _isImaxSupportImageView.hidden = ![_cinema.isImaxSupport intValue];


    _isGroupBuySupportImageView.hidden = ![_cinema.isGroupBuySupport intValue];

    
    
    
    
    
    
    
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
