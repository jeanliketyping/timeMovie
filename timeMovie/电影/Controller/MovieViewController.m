//
//  MovieViewController.m
//  timeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MovieViewController.h"
#import "Movie.h"
#import "MovieCell.h"
#import "PostCollectionView.h"
#import "PostHeadCollectionView.h"

@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //右侧翻转按钮
    UIButton *_rightButton;
    //表视图
    UITableView *_tableView;
    //海报视图
    UIView *_view;
    
    NSMutableArray *_movieData;
    //头部视图
    UIView *_headView;
    //创建下拉按钮
    UIButton *_upDownBtn;
    //遮罩视图
    UIView *_maskView;
    
    UIImageView *_leftLightImageView;
    UIImageView *_rightLightImageView;
    
    //创建中间海报的collectionView
    PostCollectionView *_postCollectionView;
    
    //创建头部视图的collectionView
    PostHeadCollectionView *_postHeadCollectionView;
}

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"电影";
    
    //加载数据
    [self _loadData];
    //创建中间视图
    [self _createView];
    //创建右边按钮
    [self _createRightButton];
    
    //创建翻页头部视图
    [self _createHeadView];
    
    //添加观察者
    [self addObserver];
    

}

-(void)_loadData
{
    NSDictionary *dic = [MovieJSON readJSONFile:@"us_box"];
    
    //4.数据的读取和储存
    NSArray *subjects = dic[@"subjects"];
    _movieData = [[NSMutableArray alloc] initWithCapacity:subjects.count];
    for (NSDictionary *dictionary in subjects) {
        Movie *movie = [[Movie alloc] initWithContentsOfDictionary:dictionary[@"subject"]];
        
        [_movieData addObject:movie];
    }
    
}

#pragma mark - create

//创建中间视图
-(void)_createView
{
    //创建表视图
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //创建海报视图
    _view = [[UIView alloc] initWithFrame:self.view.bounds];
    _view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_view];
    _view.hidden = YES;
    
    //创建中间海报的collectionView
    _postCollectionView = [[PostCollectionView alloc] initWithFrame:_view.bounds];
    _postCollectionView.movieData = _movieData;
    [_view addSubview:_postCollectionView];
    
    
    
    
}

//创建右侧按钮
-(void)_createRightButton
{
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(0, 0, 49, 25);
    //设置背景和图片
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateSelected];
    //按钮方法
    [_rightButton addTarget:self
                     action:@selector(rightBtn:)
           forControlEvents:UIControlEventTouchUpInside];
    //打包按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//创建头部视图
-(void)_createHeadView
{
    //创建遮罩视图
    _maskView = [[UIView alloc] initWithFrame:_view.bounds];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _maskView.hidden = YES;
    [_view addSubview:_maskView];
    
    //给遮罩视图添加单击手势
    UITapGestureRecognizer *onetap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewMoveUp)];
    [_maskView addGestureRecognizer:onetap];
    
    //给遮罩视图添加滑动手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(headViewMoveDown)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_view addGestureRecognizer:swipe];
    
    
    //创建头部视图
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64-100, kScreenWidth, 130)];
    _headView.backgroundColor = [UIColor clearColor];
    [_view addSubview:_headView];
    
    //读取图片并拉伸
    UIImage *bgImage = [UIImage imageNamed:@"indexBG_home"];
    bgImage = [bgImage stretchableImageWithLeftCapWidth:0 topCapHeight:5];
    //创建图片视图
    UIImageView *bg = [[UIImageView alloc] initWithFrame:_headView.bounds];
    bg.image = bgImage;
    [_headView addSubview:bg];
    
    //创建下拉按钮
    _upDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _upDownBtn.frame = CGRectMake(0, 0, 26, 20);
    _upDownBtn.center = CGPointMake(kScreenWidth / 2 + 3, 120);
    [_upDownBtn setImage: [UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [_upDownBtn setImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateSelected];
    [_upDownBtn addTarget:self action:@selector(upDownBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview: _upDownBtn];
    
    
    
    //创建头部的collectionView
    _postHeadCollectionView = [[PostHeadCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    _postHeadCollectionView.movieData = _movieData;
    [_headView addSubview:_postHeadCollectionView];
    
    //创建左侧闪光灯视图
    _leftLightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 100)];
    _leftLightImageView.center = CGPointMake((kScreenWidth - 70) / 2, 50);
    _leftLightImageView.image = [UIImage imageNamed:@"light"];
    [_headView addSubview:_leftLightImageView];
    
    _rightLightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 100)];
    _rightLightImageView.center = CGPointMake((kScreenWidth + 70) / 2, 50);
    _rightLightImageView.image = [UIImage imageNamed:@"light"];
    [_headView addSubview:_rightLightImageView];

}



#pragma mark - buttonAction


//翻转按钮方法
-(void)rightBtn:(UIButton *)sender
{
    
    UIViewAnimationOptions option = sender.selected ?
    UIViewAnimationOptionTransitionFlipFromLeft :UIViewAnimationOptionTransitionFlipFromRight;
    
    [self _flipViewWithView:sender option:option];
    [self _flipViewWithView:self.view option:option];
    
    sender.selected = ! sender.selected;
    _tableView.hidden = !_tableView.hidden;
    _view.hidden = !_view.hidden;
    
    
    
    [UIView transitionWithView:sender
                      duration:.1
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        sender.selected = !sender.selected;
                    } completion:nil];
}


//下拉按钮方法
-(void)upDownBtnAction:(UIButton *)sender
{
    if (sender.selected) {
        [self headViewMoveUp];
    }
    else
    {
        [self headViewMoveDown];
    }

}


//单击头部视图上移方法
-(void)headViewMoveUp
{
    [UIView animateWithDuration:0.4 animations:^{
        _headView.top = -36;
        _upDownBtn.selected = NO;
        _maskView.hidden = YES;
    }];
 
}

//滑动头部视图下移方法
-(void)headViewMoveDown
{
    [UIView animateWithDuration:0.4 animations:^{
        _headView.top = 64;
        _upDownBtn.selected = YES;
        _maskView.hidden = NO;
    }];
    
}


//翻转视图
-(void)_flipViewWithView:(UIView *)view option:(UIViewAnimationOptions)option
{
    [UIView transitionWithView:view
                      duration:.35
                       options:option
                    animations:^{
                        
                    } completion:nil];
}






#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _movieData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //从闲置池中获取cell
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieCell" owner:self
                                            options:nil]lastObject];
    }
    //将这个单元格索读经的电影对象，设置给单元格
    //将一个电影对象 交给单元格去显示
    cell.movie = _movieData[indexPath.row];

    return cell;
}
//设置单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


//添加一个观察者
-(void)addObserver
{
    //KVO
    //给collection 添加一个观察者
    [_postCollectionView addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:nil];
    [_postHeadCollectionView addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)dealloc
{
    [_postCollectionView removeObserver:self forKeyPath:@"index"];
    [_postHeadCollectionView removeObserver:self forKeyPath:@"index"];
}

//观察者 发现 被观察者的属性发生变化时调用的方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSNumber *itemNumber = change[@"new"];
    NSInteger itemIndex = [itemNumber integerValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];
    if (object == _postCollectionView &&   indexPath.item != _postHeadCollectionView.index
        ) {
        //改变小的
        [_postHeadCollectionView scrollToItemAtIndexPath:indexPath
                                        atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                animated:YES];
        _postHeadCollectionView.index = indexPath.item;
    }
    else if (object == _postHeadCollectionView && indexPath.item != _postCollectionView.index)
    {
        //改变大的
        [_postCollectionView scrollToItemAtIndexPath:indexPath
                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                            animated:YES];
        _postCollectionView.index = indexPath.item;
    }
        



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
