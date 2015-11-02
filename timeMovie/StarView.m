//
//  StarView.m
//  timeMovie
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "StarView.h"
#import "UIViewExt.h"

@implementation StarView

//覆写init方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _createStarView];
    }
    return self;
}

-(void)awakeFromNib
{
    
    [self _createStarView];
}



-(void)_createStarView
{
    
    //创建灰色星星视图
    _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17.5 * 5, 17)];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray"]];
    //放大到原视图大小
    CGAffineTransform transform = CGAffineTransformMakeScale(self.frame.size.width / 17.5 / 5, self.frame.size.height / 17);
    _grayView.transform = transform;
    [self addSubview:_grayView];
    
    //创建黄色星星视图
    _yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17.5 * 5, 17)];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow"]];
    _yellowView.transform = transform;
    [self addSubview:_yellowView];
    
    //放大变换之后，视图的位置会发生变化，所以需要重新设置视图的中心点
    CGPoint selfCenterPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _grayView.center = selfCenterPoint;
    _yellowView.center = selfCenterPoint;
    
    
}

-(void)setRating:(CGFloat)rating
{
    if (rating >= 0 && rating <= 10) {
        _rating = rating;
        _yellowView.width = _grayView.width * rating / 10 ;
    }
}



@end
