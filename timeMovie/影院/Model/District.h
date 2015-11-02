//
//  District.h
//  timeMovie
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseModel.h"

@interface District : BaseModel

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *districtID;

@property(nonatomic,strong) NSMutableArray *cinemas;
@property(nonatomic,assign) BOOL isTouch;
@end
