//
//  Movie.m
//  timeMovie
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "Movie.h"

@implementation Movie


-(id)initWithContentsOfDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        //电影中文名
        _titleC = dictionary[@"title"];
        //电影英文名
        _titleE = dictionary[@"original_title"];
        //评分
        NSDictionary *rating = dictionary[@"rating"];
        _rating = [rating[@"average"] floatValue];
        //上映年份
        _year = dictionary[@"year"];
        //图片
        _images = dictionary[@"images"];
        
    }
    
    return self;
    
}


+(id)MovieWithContentsOfDictionary:(NSDictionary *)dictionary
{
    return [[Movie alloc] initWithContentsOfDictionary:dictionary];
}


@end
