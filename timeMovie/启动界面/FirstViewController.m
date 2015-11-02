//
//  FirstViewController.m
//  timeMovie
//
//  Created by mac on 15/8/31.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_pagingImageView;
    UIButton *_jumpBtn;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建视图
    [self createView];
    
}

#pragma mark - 创建视图
-(void)createView
{
    //创建一个滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //设置代理
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 5, kScreenHeight);
    
    //循环创建UIImageView
    for (int i = 1; i < 6; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i - 1) * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"guide%d@2x",i]]];
        [_scrollView addSubview:imageView];
    }
    
    //设置分页视图
    _pagingImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 173)/2, kScreenHeight-50, 173, 26)];
    [_pagingImageView setImage:[UIImage imageNamed:@"guideProgress1@2x"]];
    [self.view addSubview:_pagingImageView];
    
    
    //设置分页效果
    _scrollView.pagingEnabled = YES;
    //隐藏水平滑动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    
    //创建一个按钮
    _jumpBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2, kScreenHeight - 90, 100, 20)];
    [_jumpBtn setTitle:@"进入影院" forState:UIControlStateNormal];
    [_jumpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_jumpBtn addTarget:self action:@selector(jumpToMainViewController) forControlEvents:UIControlEventTouchUpInside];
    _jumpBtn.hidden = YES;
    [self.view addSubview:_jumpBtn];

}

//隐藏状态栏
-(void)viewWillAppear:(BOOL)animated
{
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    //获取x的偏移量
    CGFloat xOffSet = _scrollView.contentOffset.x;
    
    //计算当前的页码
    NSInteger index = xOffSet / kScreenWidth;
    
    //改变图片
    NSString *imageName = [NSString stringWithFormat:@"guideProgress%ld",index+1];
    _pagingImageView.image = [UIImage imageNamed:imageName];
    _jumpBtn.hidden = !(index == 4);
}


#pragma mark - 跳转到主界面
-(void)jumpToMainViewController
{
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:NO];
    
    //读取故事版 获取ViewController
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //获取故事版中第一个ViewController
    UIViewController *vc = [storyBoard instantiateInitialViewController];
    //获取当前控制器的_view 所显示在那个窗口上
    self.view.window.rootViewController = vc;
    
    //界面显示动画
    vc.view.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    [UIView animateWithDuration:0.3 animations:^{
        vc.view.transform = CGAffineTransformIdentity;
    }];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:@YES forKey:@"first"];
    
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
