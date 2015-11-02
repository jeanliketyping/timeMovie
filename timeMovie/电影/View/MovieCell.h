//
//  MovieCell.h
//  timeMovie
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Movie;
@class StarView;

@interface MovieCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *movieImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleCLabel;

@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;

@property (strong, nonatomic) IBOutlet UILabel *yearLabel;

@property (strong, nonatomic) IBOutlet StarView *starsView;




@property(nonatomic,copy)Movie *movie;

@end
