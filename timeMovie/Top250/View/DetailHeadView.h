//
//  DetailHeadView.h
//  timeMovie
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Detail.h"



@interface DetailHeadView : UITableView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleCnLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *imagesScrollView;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@property (weak,nonatomic) Detail *detail;
@property(weak,nonatomic) UINavigationController *navigationController;
@end
