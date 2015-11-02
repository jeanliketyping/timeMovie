//
//  TabBarButton.m
//  timeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

-(id)initWithTitle:(NSString *)title
         imageName:(NSString *)imageName
             frame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        //创建图片视图
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 19)/2, 8, 19, 20)];
        imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:imageView];
        //设置图片的拉伸模式
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //创建文本
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 15)];
        label.text = title;
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}

@end
