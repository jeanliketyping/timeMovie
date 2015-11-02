//
//  MovieCell.m
//  timeMovie
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MovieCell.h"
#import "Movie.h"
#import "StarView.h"



@implementation MovieCell

//覆写setMovie
-(void)setMovie:(Movie *)movie
{
    _movie = movie;
    //将电影model对象中存储的数据，取出来显示到label imageView
    _titleCLabel.text = _movie.titleC;
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",_movie.rating];
    _yearLabel.text = [NSString stringWithFormat:@"上映年份：%@",_movie.year];
    
    //从网络读取图片
    //创建url
    NSString *urlString = _movie.images[@"small"];
    NSURL *url = [NSURL URLWithString:urlString];
    [_movieImageView sd_setImageWithURL:url];

    //创建星星视图
    _starsView.rating = _movie.rating;
    
    
    
    
}










- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
