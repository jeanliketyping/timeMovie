//
//  BigImageViewController.m
//  timeMovie
//
//  Created by mac on 15/8/25.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BigImageViewController.h"
#import "BigImageCell.h"

@interface BigImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_imageCollectionView;
    BOOL _isHiddenNavigationBar;
}
@end

@implementation BigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片浏览";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createCollectionView];
    
    //根据记录的单元格索引 来显示那个单元格
    [_imageCollectionView scrollToItemAtIndexPath:_indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    //接收一个通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenNavigationBar) name:kHiddenNavigationBar object:nil];
    
}

//隐藏导航栏和状态栏的方法
-(void)hiddenNavigationBar
{
    _isHiddenNavigationBar = !_isHiddenNavigationBar;
    //双击事件 在视图控制器中 隐藏当导航栏的方法
    [self.navigationController setNavigationBarHidden:_isHiddenNavigationBar animated:YES];
    
    //隐藏状态栏
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:_isHiddenNavigationBar withAnimation:UIStatusBarAnimationSlide];
    
    
    
}


-(void)createCollectionView
{
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - 64);
    flowLayout.minimumInteritemSpacing = 10;
    //设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置四周空隙
    flowLayout.sectionInset = UIEdgeInsetsMake(-15, 0, 0, 0);
    
    _imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth+10, kScreenHeight - 64) collectionViewLayout:flowLayout];
    _imageCollectionView.dataSource = self;
    _imageCollectionView.delegate = self;
    _imageCollectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_imageCollectionView];
    //设置分页
    _imageCollectionView.pagingEnabled = YES;
    //隐藏滑动条
    _imageCollectionView.showsHorizontalScrollIndicator = NO;
    //注册一个类
    [_imageCollectionView registerClass:[BigImageCell class] forCellWithReuseIdentifier:@"BigImageCell"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageData.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BigImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BigImageCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    //传入图片
    cell.imageURL = _imageData[indexPath.item];
    return cell;
}

//当即将滑出这个界面时，进行图片还原
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //获取单元格 强制类型转换
    BigImageCell *big = (BigImageCell *)cell;
    //将单元格中的图片缩放还原
    [big backImageZoomingScale];
    
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
