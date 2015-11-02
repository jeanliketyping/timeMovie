//
//  BaseTabBarController.m
//  timeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseTabBarController.h"
#import "TabBarButton.h"




@interface BaseTabBarController ()
{
    UIView *_newTabBar;
    CGFloat _btnWidth;
    UIImageView *_selectedView;
}
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建标签栏
    [self createTabBar];
    
}


-(void)createTabBar
{
    //隐藏自带的标签栏
    self.tabBar.hidden = YES;
    //创建新的标签栏
    _newTabBar = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenHeight - 49, kScreenWidth,49)];
    [_newTabBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg_all"]]];
    [self.view addSubview:_newTabBar];
    
    NSArray *titles = @[@"电影",
                        @"新闻",
                        @"TOP250",
                        @"影院",
                        @"更多"];
    NSArray *imageNames = @[@"movie_home",
                            @"msg_new",
                            @"yellow",
                            @"icon_cinema",
                            @"more_setting"];
    _btnWidth = kScreenWidth / self.viewControllers.count;
    //创建滑动视图
    _selectedView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _btnWidth, 49)];
    _selectedView.image = [UIImage imageNamed:@"selectTabbar_bg_all1"];
    [_newTabBar addSubview:_selectedView];
    for (int i = 0; i < self.viewControllers.count; i++) {
        TabBarButton *button = [[TabBarButton alloc] initWithTitle:titles[i] imageName:imageNames[i] frame:CGRectMake(i * _btnWidth, 0, _btnWidth, 49)];
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [_newTabBar addSubview:button];
        
    }
}

-(void)btnAction:(UIButton *)sender
{
    NSInteger index = sender.tag - 100;
    self.selectedIndex = index;
    [UIView animateWithDuration:.2 animations:^{
//        _selectedView.frame = CGRectMake(index * _btnWidth, 0, _btnWidth, 49);
        _selectedView.center = sender.center;
    }];

}


-(void)setTabBarHidden:(BOOL)isHidden
{
    _newTabBar.hidden = isHidden;
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










