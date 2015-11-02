//
//  PictureModalVC.m
//  timeMovie
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "PictureModalVC.h"
#import "BigImageViewController.h"

@interface PictureModalVC ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_picData;
}

@end

@implementation PictureModalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新闻图片";
    //加载数据
    [self loadData];

    //创建UICollectionView
    [self createCollection];
    
    

}

//加载数据
-(void)loadData
{
    NSArray *array = [MovieJSON readJSONFile:@"image_list"];
    _picData = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array) {
        NSString *urlString = dic[@"image"];
        NSURL *url = [NSURL URLWithString:urlString];
        [_picData addObject:url];
    }
    
}



#pragma mark - 创建UICollectionView
-(void)createCollection
{
    //collection
    //创建一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局规则
    //水平最小间隙
//    flowLayout.minimumInteritemSpacing = 10;
    //竖直最小间隙
//    flowLayout.minimumLineSpacing = 10;
    //单元格大小
    CGFloat itemWidth = (kScreenWidth - 10 * 5) / 4;
    flowLayout.itemSize = CGSizeMake(itemWidth,itemWidth);
    //滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置四周间隙
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //使用布局对象 来创建UICollectionView
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.view addSubview:collection];
    
    //数据源对象设置
    collection.dataSource = self;
    collection.delegate = self;
    
    //使用一个类来注册单元格
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _picData.count ;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //读取网络图片
    UIImageView *imageView = [[UIImageView alloc] init];    
    [imageView sd_setImageWithURL:_picData[indexPath.item]];
    cell.backgroundView = imageView;
    
    
    
    //设置边框
    //边框颜色
    cell.layer.borderColor = [UIColor purpleColor].CGColor;
    //边框宽度
    cell.layer.borderWidth = 3;
    //边框圆角
    cell.layer.cornerRadius = 10;
    //遮盖边框没有包住的部分
    cell.layer.masksToBounds = YES;
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

{
    
    BigImageViewController *bigImage = [[BigImageViewController alloc] init];
    //将图片数据传输给下一个控制器
    bigImage.imageData = _picData;
    
    //记录本次点击选中的单元格的索引
    bigImage.indexPath = indexPath;
    
    bigImage.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bigImage animated:YES];
    
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
