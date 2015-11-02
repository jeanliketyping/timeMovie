//
//  CinemaViewController.m
//  timeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "CinemaViewController.h"
#import "District.h"
#import "Cinema.h"
#import "CinemaCell.h"



@interface CinemaViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    
    
    NSMutableArray *_districtData;
    NSMutableArray *_cinemaData;
    UITableView *_tableView;

}

@end

@implementation CinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"影院";
    //读取数据
    [self _loadData];
    //创建视图
    [self _createView];
    
}

#pragma mark - 读取数据
-(void)_loadData
{
    //读取地区信息
    NSDictionary *dicDistrict = [MovieJSON readJSONFile:@"district_list"];
    NSArray *arrayDistrict = dicDistrict[@"districtList"];
    _districtData = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arrayDistrict) {
        District *distrct = [[District alloc] initContentWithDic:dic];
        [_districtData addObject:distrct];
    }
    

    
    
    
    //读取影院信息
    NSDictionary *dicCinema = [MovieJSON readJSONFile:@"cinema_list"];
    NSArray *arrayCinema = dicCinema[@"cinemaList"];
    _cinemaData = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arrayCinema) {
        Cinema *cinema = [[Cinema alloc] initContentWithDic:dic];
        for (District *dis in _districtData) {
            if ([dis.districtID isEqualToString:cinema.districtId]) {
                [dis.cinemas addObject: cinema];
                break;
            }
        }
    }

    
}

#pragma mark - 创建视图
-(void)_createView
{
    //创建表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _districtData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    District *dis = _districtData[section];
    if (dis.isTouch) {
        return dis.cinemas.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CinemaCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CinemaCell" owner:self options:nil]lastObject];
    }
    
    District *dis = _districtData[indexPath.section];
    cell.cinema = dis.cinemas[indexPath.row];
    return cell;
    
}

#pragma mark - 组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, tableView.bounds.size.width, 40);
    
    UIImage *image = [UIImage imageNamed:@"hotMovieBottomImage"];
    image = [image stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [btn setBackgroundImage:image forState:UIControlStateNormal];

    District *dis = _districtData[section];
    [btn setTitle:dis.name forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = section+100;
    return btn;
}

#pragma mark - 设置头部视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - 设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}



#pragma mark - 头视图按钮的方法，将表视图收起展开
-(void)btnAction:(UIButton *)sender{
    
    
    NSInteger section = sender.tag - 100;
    District *dis = _districtData[section];
    dis.isTouch = !dis.isTouch;
    NSIndexSet  *set = [NSIndexSet indexSetWithIndex:section];
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
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
