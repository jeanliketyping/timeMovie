//
//  Cinema.m
//  timeMovie
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "Cinema.h"

@implementation Cinema


- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic {
    
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    
    for (id key in jsonDic) {
        [mapDic setObject:key forKey:key];
    }
    //添加 key 和 model中属性名的映射关系
    
    return mapDic;
}


@end
