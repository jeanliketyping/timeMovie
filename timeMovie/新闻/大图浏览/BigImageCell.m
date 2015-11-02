//
//  BigImageCell.m
//  timeMovie
//
//  Created by mac on 15/8/25.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BigImageCell.h"

@interface BigImageCell ()<UICollectionViewDelegate>

{
    UIScrollView *_scrollView;
    UIImageView *_imageView;
    NSTimer *_timer;
}

@end


@implementation BigImageCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createScrollView];
    }
    return self;
}



-(void)_createScrollView
{
    //创建滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.contentSize = self.frame.size;
    //设置缩放倍数
    _scrollView.maximumZoomScale = 3;
    _scrollView.minimumZoomScale = 0.3;

    _scrollView.delegate = self;
    
    
    [self.contentView addSubview:_scrollView];
    
    //创建图片视图
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.image = [UIImage imageNamed:@"11@2x"];
    [_scrollView addSubview:_imageView];
    
    //图片拉伸
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //添加单击手势
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneAction)];
    //点击次数
    oneTap.numberOfTapsRequired = 1;
    //手指数
    oneTap.numberOfTouchesRequired = 1;
    
    [_imageView addGestureRecognizer:oneTap];
    //给图片视图开启点击事件
    _imageView.userInteractionEnabled = YES;
    
    
    //添加双击时间
    UITapGestureRecognizer *twoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoTapAction)];
    //点击次数
    twoTap.numberOfTapsRequired = 2;
    //手指数
    twoTap.numberOfTouchesRequired = 1;
    
    [_imageView addGestureRecognizer:twoTap];
    
}

//调用定时器，判断单击还是双击
-(void)oneAction
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                              target:self
                                            selector:@selector(oneTapAction)
                                            userInfo:nil
                                             repeats:NO];
}
//单击方法
-(void)oneTapAction
{
    NSLog(@"单击一次");
    //发送一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kHiddenNavigationBar object:nil];
}
//双击方法
-(void)twoTapAction
{
    [_timer invalidate];
    if (_scrollView.zoomScale >= 2) {
        [_scrollView setZoomScale:1 animated:YES];
    }
    else
    {
        [_scrollView setZoomScale:3 animated:YES];
    }
}



//设置捏合手势的方法
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [_imageView sd_setImageWithURL:_imageURL];
}

//还原
-(void)backImageZoomingScale
{
    [_scrollView setZoomScale:1];
}





@end
