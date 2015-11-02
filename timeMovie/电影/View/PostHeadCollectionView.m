//
//  PostHeadCollectionView.m
//  timeMovie
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "PostHeadCollectionView.h"
#import "Movie.h"


@implementation PostHeadCollectionView


-(instancetype)initWithFrame:(CGRect)frame
{
    //创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    //单元格大小
    layout.itemSize = CGSizeMake(frame.size.width * 0.2, frame.size.height * 0.8);
    //四周空隙
    layout.sectionInset = UIEdgeInsetsMake(0, kScreenWidth * 0.4, 0, kScreenWidth * 0.4);
    //滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        //注册一个单元格
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    }
    return self;
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _movieData.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    //背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    cell.backgroundView = imageView;
    //读取图片
    Movie *movie = _movieData[indexPath.row];
    NSURL *url = [NSURL URLWithString:movie.images[@"small"]];
    //加载图片
    [imageView sd_setImageWithURL:url];
    
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    /*
     实现自定义的分页效果
     1. 获取视图停止之后的偏移量 x
     2. 根据偏移量 计算停止之后 所在的页码
     3. 计算此页 显示在正中间时 滑动视图的偏移量
     4. 将计算所得的偏移量 设置给滑动视图
     */
    
    //1.
    CGFloat xOffSet = targetContentOffset->x;
    
    //2.
    /*
     -0.5-10  ~ 0.5+0     0
     0.5 ~ 1.5+10         1
     1.5+10 ~ 2.5+20      2
     
     0 ~ 1+10            0
     1+10 ~ 2+20          1
     2+20 ~ 3+30          2
 
     */
    xOffSet += scrollView.width * 0.1 + 10;
    NSInteger index = xOffSet / (scrollView.width * 0.2 + 10);
    
    //3.
    xOffSet = index * (scrollView.width * 0.2 + 10);
    
    //4.
    targetContentOffset->x = xOffSet;
    
    //KVO监控的是这个属性的SET方法
    self.index = index;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    self.index = indexPath.item;
}









@end
