//
//  MoreTableViewController.m
//  timeMovie
//
//  Created by mac on 15/8/29.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MoreTableViewController.h"

@interface MoreTableViewController ()<UIAlertViewDelegate>
{
    UILabel *_titleLabel;
    UIAlertView *_alertView;
}
@end

@implementation MoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.text = @"title";
    
    self.navigationItem.titleView = _titleLabel;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    
    
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                            message:@"确定清楚所有缓存"
                                           delegate:self
                                  cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    _alertView.delegate = self;
    [self.view addSubview:_alertView];
    
    
    
 
}


-(void)viewWillAppear:(BOOL)animated
{
    //将计算完成的结果 显示到界面上去
    _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
}



#pragma mark - 计算当前缓存文件的大小
//计算当前应用程序缓存文件的大小之和
-(CGFloat)countCacheFileSize
{
    //1. 获取缓存文件的路径
    //函数 用于获取当前程序的沙盒路径
    NSString *homePath = NSHomeDirectory();
    
    /*
     子文件夹1  /tmp/MediaCache/
     子文件夹2  /Library/Caches/com.hackemist.SDWebImageCache.default/
     子文件夹3  /Library/Caches/com.jean.timeMovie/
     */
    
    //2.使用-(CGFloat)getFileSize:(NSString *)filePath来计算这些文件夹中的文件大小
    NSArray *pathArray = @[@"/tmp/MediaCache/",
                           @"/Library/Caches/com.hackemist.SDWebImageCache.default/",
                           @"/Library/Caches/com.jean.timeMovie/"];
    
    CGFloat fileSize = 0;
    for (NSString *string in pathArray) {
        //拼接字符串
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        fileSize += [self getFileSize:filePath];
        NSLog(@"%.2f",[self getFileSize:filePath]);
    }
    
    //3.对上一步计算的结果进行求和，并返回
    
    
    return fileSize;
    
    
}

-(CGFloat)getFileSize:(NSString *)filePath
{
    //文件管理器对象 单例
    NSFileManager *manager = [NSFileManager defaultManager];
    //数组 存储文件夹中所有的子文件夹以及文件的名字
    NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
    
    long long size = 0;
    
    //遍历文件夹
    for (NSString *fileName in fileNames) {
        //拼接获取文件的路径
        NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
        //获取文件信息
        NSDictionary *dic = [manager attributesOfItemAtPath:subFilePath error:nil];
        //获得单个文件大小
        NSNumber *sizeNumber = dic[NSFileSize];
        //使用一long long 类型来存储文件大小
        long long subFileSize = [sizeNumber longLongValue];
        
        //文件大小求和
        size += subFileSize;
    }
    
    
    
    return size / 1024.0 /1024;
    
}


#pragma mark - 删除缓存
-(void)clearCacheFile
{
    _cacheLabel.text = @"清理中...";
    //获取缓存文件的路径
    
    //1. 获取缓存文件的路径
    //函数 用于获取当前程序的沙盒路径
    NSString *homePath = NSHomeDirectory();
    
    /*
     子文件夹1  /tmp/MediaCache/
     子文件夹2  /Library/Caches/com.hackemist.SDWebImageCache.default/
     子文件夹3  /Library/Caches/com.jean.timeMovie/
     */
    
    //2.删除文件
    NSArray *pathArray = @[@"/tmp/MediaCache/",
                           @"/Library/Caches/com.hackemist.SDWebImageCache.default/",
                           @"/Library/Caches/com.jean.timeMovie/"];
    
    for (NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        //文件管理器对象 单例
        NSFileManager *manager = [NSFileManager defaultManager];
        //数组 存储文件夹中所有的子文件夹以及文件的名字
        NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
        //遍历文件夹 删除文件
        for (NSString *fileName in fileNames)
        {
            //拼接子文件路径
            NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
            //删除文件
            [manager removeItemAtPath:subFilePath error:nil];
        }
    }
    
    //重新计算缓存文件大小
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //将计算完成的结果 显示到界面上去
        _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    });
    
    
}












- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [_alertView show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    NSLog(@"%ld",buttonIndex);
    if (buttonIndex == 0) {
        [self clearCacheFile];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
