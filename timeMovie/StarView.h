//
//  StarView.h
//  timeMovie
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
{
    UIView *_grayView;
    UIView *_yellowView;
}

@property(nonatomic, assign)CGFloat rating;

@end
