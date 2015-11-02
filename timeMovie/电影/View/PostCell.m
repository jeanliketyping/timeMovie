//
//  PostCell.m
//  timeMovie
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "PostCell.h"
#import "StarView.h"
#import "Movie.h"


@interface PostCell()
@property (strong, nonatomic) IBOutlet UIImageView *bigImageView;
@property (strong, nonatomic) IBOutlet UIImageView *smallImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleCLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleELabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet StarView *starView;



@end

@implementation PostCell



-(void)setMovie:(Movie *)movie
{
    _movie = movie;
    NSURL *url = [NSURL URLWithString:_movie.images[@"large"]];
    [_bigImageView sd_setImageWithURL:url];
    [_smallImageView sd_setImageWithURL:url];
    _titleCLabel.text = _movie.titleC;
    _titleELabel.text = _movie.titleE;
    _yearLabel.text = _movie.year;
    _starView.rating = _movie.rating;
    
}






//翻转单元格
-(void)flipCell
{
    [UIView transitionWithView:self
                      duration:0.3
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        _bigImageView.hidden = !_bigImageView.hidden;
                    }
                    completion:nil];
}

//取消翻转
-(void)backCell
{
    if (_bigImageView.hidden) {
        [UIView transitionWithView:self
                          duration:.3
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            _bigImageView.hidden = NO;
                        } completion:nil];
    }
    
}




- (void)awakeFromNib {
    // Initialization code
}

@end
