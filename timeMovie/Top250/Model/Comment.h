//
//  Comment.h
//  timeMovie
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseModel.h"

@interface Comment : BaseModel

/*
 "userImage" : "http://img2.mtime.com/images/default/head.gif",
 "nickname" : "yangna988",
 "rating" : "9.0",
 "content" : "儿子很喜欢 一直期盼上映"
 */
@property (nonatomic,copy) NSString *userImage;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *rating;
@property (nonatomic,copy) NSString *content;

@property(nonatomic,assign)BOOL isShow;
@end
