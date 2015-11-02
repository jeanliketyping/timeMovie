//
//  BaseViewController.m
//  timeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTabBarController.h"

@interface BaseViewController ()
{
    UILabel *_titleLabel;
    BOOL _isHiddenTabBar;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.text = @"title";

    self.navigationItem.titleView = _titleLabel;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    _titleLabel.text = title;
}

#pragma mark - 隐藏／显示标签栏

-(void)viewWillAppear:(BOOL)animated
{
    if (_isHiddenTabBar) {
        //隐藏标签栏
        BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
        [tab setTabBarHidden: YES];
    }
    else
    {
        //显示标签栏
        BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
        [tab setTabBarHidden: NO];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    //显示标签栏
    BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
    [tab setTabBarHidden: NO];
}

-(void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    _isHiddenTabBar = hidesBottomBarWhenPushed;
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
