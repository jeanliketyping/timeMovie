//
//  Top250Cell.h
//  timeMovie
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StarView;
@class Movie;


@interface Top250Cell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet StarView *starView;
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property(nonatomic,copy)Movie *movie;

@end
