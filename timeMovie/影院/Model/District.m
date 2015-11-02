//
//  District.m
//  timeMovie
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "District.h"

@implementation District

-(id)initContentWithDic:(NSDictionary *)jsonDic
{
    self = [super initContentWithDic:jsonDic];
    if (self) {
        self.districtID = jsonDic[@"id"];
        
        _cinemas = [[NSMutableArray alloc] init];
        
    }
    return self;
}

@end
