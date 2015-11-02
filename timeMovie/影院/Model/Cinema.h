//
//  Cinema.h
//  timeMovie
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "BaseModel.h"

@interface Cinema : BaseModel

/*
 "lowPrice" : "40.00"
 "grade" : "8.8"
 "address" : "北京市海淀区学清路甲8号，圣熙8号购物中心五层西侧。",
 "name" : "嘉华国际影城",
 "isSeatSupport" : "1",
 "isCouponSupport" : "1",
 "isImaxSupport" : "0",
 "isGroupBuySupport" : "0",
 "circleName" : "五道口"
 
 */

@property(nonatomic,copy)NSString *lowPrice;
@property(nonatomic,copy)NSString *grade;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *isSeatSupport;
@property(nonatomic,copy)NSString *isCouponSupport;
@property(nonatomic,copy)NSString *isImaxSupport;
@property(nonatomic,copy)NSString *isGroupBuySupport;
@property(nonatomic,copy)NSString *districtId;


@end
