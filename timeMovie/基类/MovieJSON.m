//
//  MovieJSON.m
//  timeMovie
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MovieJSON.h"

@implementation MovieJSON

+(id)readJSONFile:(NSString *)fileName
{
    //1.获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    //2.读取文件
    //NSData 数据类 里面的数据是以二进制的形式储存 字符串、字典、数组、UIImage
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //3.文件解析
    //NSJON 苹果公司自己开发的解析器 稳定 高效 不需要添加第三方框架
    id json = [NSJSONSerialization
                         JSONObjectWithData:data
                         options:NSJSONReadingMutableLeaves
                         error:nil];
    return json;
}

@end
