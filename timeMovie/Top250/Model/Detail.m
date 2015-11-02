//
//  Detail.m
//  timeMovie
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "Detail.h"

@implementation Detail

/*
 属性名与json字典中key的映射关系
 key:  json字典的key名
 value: model对象的属性名
 */
- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic {
    
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    
    for (id key in jsonDic) {
        [mapDic setObject:key forKey:key];
    }
    //添加 key 和 model中属性名的映射关系
    
    return mapDic;
}

@end
