//
//  WebNewsViewController.m
//  timeMovie
//
//  Created by mac on 15/8/31.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WebNewsViewController.h"

@interface WebNewsViewController ()

@end

@implementation WebNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网页新闻";
    
    //------------------UIWebView-------------------
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    
    //1.读取文件
    //读取HTML文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"html"];
    
    //读取文件数据
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    //读取新闻数据的json文件
    NSDictionary *dic = [MovieJSON readJSONFile:@"news_detail"];
    
    //2.拼接HTML字符串
    //读取网页需要使用的相关数据
    NSString *title = dic[@"title"];
    NSString *content = dic[@"content"];
    NSString *time = dic[@"time"];
    NSString *source = dic[@"source"];
    
    htmlString = [NSString stringWithFormat:htmlString,title,content,time,source];
    
    //3.加载页面
    [web loadHTMLString:htmlString baseURL:nil];
    
    web.scalesPageToFit = YES;
    
    
    
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
