//
//  Top250ViewController.m
//  timeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "Top250ViewController.h"
#import "Movie.h"
#import "Top250Cell.h"
#import "MovieDetailViewController.h"


@interface Top250ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_top250Data;
}
@end

@implementation Top250ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Top250";
    [self _loadData];
    
}

//读取文件
-(void)_loadData
{
    NSDictionary *dic = [MovieJSON readJSONFile:@"top250"];
    NSArray *array = dic[@"subjects"];
    _top250Data = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in array)
    {
        Movie *movie = [[Movie alloc] initWithContentsOfDictionary:dictionary];
        [_top250Data addObject:movie];
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    return _top250Data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    Top250Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
    cell.movie = _top250Data[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWidth = (kScreenWidth - 10 * 4) / 3;
    CGFloat cellHeight = cellWidth * 1.3;
    return CGSizeMake(cellWidth, cellHeight);
}

//单元格选中事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获取故事版对象
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //2.从故事版中读取视图控制器
    MovieDetailViewController *detail = [storyBoard instantiateViewControllerWithIdentifier:@"detail"];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    
    
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
