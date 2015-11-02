//
//  PostCollectionView.m
//  timeMovie
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "PostCollectionView.h"
#import "PostCell.h"
#import "PostHeadCollectionView.h"



@implementation PostCollectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    //创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //单元格大小
    layout.itemSize = CGSizeMake(frame.size.width * 0.6, frame.size.height * 0.6);
    layout.minimumInteritemSpacing = 10;
    //四周空隙
    layout.sectionInset = UIEdgeInsetsMake(0, kScreenWidth * 0.2, 0, kScreenWidth * 0.2);
    //滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        //注册一个单元格
        UINib *nib = [UINib nibWithNibName:@"PostCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellWithReuseIdentifier:@"postCell"];
        
        
        
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
    PostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"postCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    cell.movie = _movieData[indexPath.item];
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
     -0.5 - 10 ~ 0.5 + 0      0
     0.5 + 0 ~ 1.5 + 10       1
     1.5 + 10 ~ 2.5 + 20      2
     
     -->
     
     0 ~ 1 + 10     0
     1 + 10  ~ 2 + 20    1
     2 + 20 ~ 3 + 30    2
     
     */
    
    xOffSet += scrollView.width * 0.3 + 10;
    NSInteger index = xOffSet / (scrollView.width * 0.6 + 10);
    
    //3.
    xOffSet = index * (scrollView.width * 0.6 +10);
    
    //4.
    targetContentOffset->x = xOffSet;
    
    //KVO监控的是这个属性的SET方法
    self.index = index;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //根据偏移量 计算正中间单元格的索引
    NSInteger index = collectionView.contentOffset.x / ((collectionView.width * 0.6 +10));
    //判断选中的单元格 是不是正中间单元格
    if (indexPath.item == index) {
        //1.YES 翻转这个单元格
        
        //获取单元格
        PostCell *cell = (PostCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //翻转单元格
        [cell flipCell];
    }
    else
    {
        //2.NO 将这个单元格居中
        
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        //将前一个单元格 翻转回来
        //获取单元格
        PostCell *cell = (PostCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        //翻转单元格
        [cell backCell];
        
        self.index = indexPath.item;
        
        
    }
    

    
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *postCell = (PostCell *)cell;
    [postCell backCell];
}










@end
