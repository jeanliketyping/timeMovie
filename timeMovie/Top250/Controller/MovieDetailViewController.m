//
//  MovieDetailViewController.m
//  timeMovie
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "DetailHeadView.h"
#import "Comment.h"
#import "CommentCell.h"
#import "Detail.h"
#import <MediaPlayer/MediaPlayer.h>



@interface MovieDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_commentData;
    NSMutableArray *_DetailData;
}


@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电影详情";
    //读取数据
    [self loadData];
    
    

}

#pragma mark - 读取数据
-(void)loadData
{
    //读取评论数据
    NSDictionary *dicComment = [MovieJSON readJSONFile:@"movie_comment"];
    NSArray *arrayComment = dicComment[@"list"];
    _commentData = [[NSMutableArray alloc] initWithCapacity:arrayComment.count];
    for (NSDictionary *dictionary in arrayComment) {
        Comment *comment  =[[Comment alloc] initContentWithDic:dictionary];
        [_commentData addObject:comment];
    }
    
    //获取电影详情信息
    NSDictionary *dicDetail = [MovieJSON readJSONFile:@"movie_detail"];
    _DetailData = [[NSMutableArray alloc] init];
    Detail *detail = [[Detail alloc] initContentWithDic:dicDetail];
    [_DetailData addObject:detail];
    
}





#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return _commentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    cell.comment = _commentData[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment *comment = _commentData[indexPath.row];
    if (comment.isShow)
    {
        //评论的内容
        NSString *string = comment.content;
        //根据字符串的长度 计算label的大小
        CGSize maxSize = CGSizeMake(kScreenWidth - 80, CGFLOAT_MAX);
        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
        CGRect rect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.height + 50;
    }
    else
    {
        return 60;
    }

}

//单元格的选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment *comment = _commentData[indexPath.row];
    comment.isShow = !comment.isShow;
    //刷新单元格
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //读取xib
    DetailHeadView *head = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeadView" owner:nil options:nil]lastObject];
    head.navigationController = self.navigationController;
    Detail *detail = _DetailData[section];
    [head.imageView sd_setImageWithURL:[NSURL URLWithString:detail.image]];
    head.titleCnLabel.text = detail.titleCn;
    head.directorsLabel.text = [detail.directors componentsJoinedByString:@","];
    head.actorsLabel.text = [detail.actors componentsJoinedByString:@","];
    head.typeLabel.text = [detail.type componentsJoinedByString:@","];
    head.yearLabel.text = [NSString stringWithFormat:@"上映时间：%@",detail.year];
    
    head.imagesScrollView.backgroundColor = [UIColor blackColor];
    head.imagesScrollView.layer.cornerRadius = 5;
    head.imagesScrollView.layer.borderColor = [UIColor purpleColor].CGColor;
    head.imagesScrollView.layer.borderWidth = 2;
    
    
    CGFloat width = head.imagesScrollView.height - 10;
    //创建子视图
    for (int i = 0;i < detail.images.count;i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * (width + 5) + 5, 5, width, width)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:detail.images[i]]];
        [head.imagesScrollView addSubview:imageView];
    }
    //隐藏水平滑动条
    head.imagesScrollView.showsHorizontalScrollIndicator = NO;
    head.imagesScrollView.contentSize = CGSizeMake(6 * (width + 5) + 5, 0);
    
    return  head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
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
