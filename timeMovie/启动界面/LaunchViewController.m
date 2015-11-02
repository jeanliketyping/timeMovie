//
//  LaunchViewController.m
//  timeMovie
//
//  Created by mac on 15/8/31.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //使用定时器 每0.2s显示一张
    [NSTimer scheduledTimerWithTimeInterval:0.2
                                     target:self
                                   selector:@selector(showImageView:)
                                   userInfo:nil
                                    repeats:YES];
    
    

}

//隐藏状态栏
-(void)viewWillAppear:(BOOL)animated
{
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:YES];
}

//显示状态栏
-(void)viewDidDisappear:(BOOL)animated
{
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:NO];
}

#pragma mark - 定时器方式 显示图片
-(void)showImageView:(NSTimer *)timer
{
    static NSInteger i = 1;
    UIImageView *imageView = (UIImageView  *)[self.view viewWithTag:i];
    //显示这个imageView
    imageView.hidden = NO;
    i++;
    if (i == 25) {
        //停止计时器
        [timer invalidate];
        //延迟0.5s 跳转动主界面
        [self performSelector:@selector(jumpToMainViewController) withObject:nil afterDelay:0.5];
    }
}


#pragma mark - 跳转到主界面
-(void)jumpToMainViewController
{
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
