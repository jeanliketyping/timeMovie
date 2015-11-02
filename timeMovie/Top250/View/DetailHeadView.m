//
//  DetailHeadView.m
//  timeMovie
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "DetailHeadView.h"
#import <MediaPlayer/MediaPlayer.h>


@implementation DetailHeadView


- (IBAction)imageButtonAction:(UIButton *)sender
{
    
        MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4"]];
        [self.navigationController pushViewController:moviePlayer animated:YES];
        
    
}








@end
