//
//  Top250Cell.m
//  timeMovie
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "Top250Cell.h"
#import "StarView.h"
#import "Movie.h"

@implementation Top250Cell

-(void)setMovie:(Movie *)movie
{
    _movie = movie;
    //设置海报
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_movie.images[@"small"]]];
    //评分
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",_movie.rating];
    //电影名
    _titleLabel.text = _movie.titleC;
    //星星
    _starView.rating = _movie.rating;
}

@end
