//
//  CinemaCell.h
//  timeMovie
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"

@interface CinemaCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *gradeLabel;
@property (strong, nonatomic) IBOutlet UILabel *lowPriceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *isSeatSupportImageView;
@property (strong, nonatomic) IBOutlet UIImageView *isCouponSupportImageView;
@property (strong, nonatomic) IBOutlet UIImageView *isImaxSupportImageView;
@property (strong, nonatomic) IBOutlet UIImageView *isGroupBuySupportImageView;





@property(nonatomic,copy)Cinema *cinema;

@end
