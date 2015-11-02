//
//  NewsViewController.m
//  timeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "NewsViewController.h"
#import "News.h"
#import "NewsCell.h"
#import "PictureModalVC.h"
#import "WebNewsViewController.h"


@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_newsData;
    UIImageView *_topImageView;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
    [self _loadData];
}
//加载数据
-(void)_loadData
{
    NSArray *array = [MovieJSON readJSONFile:@"news_list"];
    _newsData = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *dic in array)
    {
        News *news = [[News alloc] initContentWithDic:dic];
        [_newsData addObject:news];
    }

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _newsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News *news = _newsData[indexPath.row];
    
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopNewsCell"];
        _topImageView = (UIImageView *)[cell.contentView viewWithTag:100];
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
        label.text = news.title;
        [_topImageView sd_setImageWithURL:[NSURL URLWithString:news.image]];
        return cell;
    }
    else
    {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
        cell.titleLabel.text = news.title;
        [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:news.image]];
        cell.summaryLabel.text = news.summary;
        NSInteger type = [news.type intValue];
        if (type == 1) {
            [cell.typeImageView setImage:[UIImage imageNamed:@"sctpxw"]];

        }
        else if (type == 2)
        {
            [cell.typeImageView setImage:[UIImage imageNamed:@"scspxw"]];

        }
        
        return cell;
    }

}
//设置单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
    }
    else
    {
        return 60;
    }
    
}


//当单元格被选中时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News *news = _newsData[indexPath.row];
    if ([news.type isEqualToNumber:@1])
    {
        PictureModalVC *picture = [[PictureModalVC alloc] init];
        picture.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:picture animated:YES];

    }
    else if ([news.type isEqualToNumber:@0])
    {
        WebNewsViewController *web = [[WebNewsViewController alloc] init];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }
}


//滑动 下拉顶部图片实现图片填充
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取下拉的y方向偏移
    CGFloat yOff = scrollView.contentOffset.y + 64;
    
    //获取图片的原始高度
    CGFloat oldHeight = 150;
    //设置下拉后图片的高度
    CGFloat newHeight = 150 - yOff;
    //获取放大的倍数
    CGFloat scale = newHeight / oldHeight;
    //对图片进行放大
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    _topImageView.transform = transform;
    
    //顶部对齐
    _topImageView.top = yOff;
    
    
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
