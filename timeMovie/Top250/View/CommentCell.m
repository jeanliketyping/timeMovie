//
//  CommentCell.m
//  timeMovie
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    _bgView.layer.cornerRadius = 3;
    _bgView.layer.borderColor = [UIColor redColor].CGColor;
    _bgView.layer.borderWidth = 2;
    _bgView.layer.masksToBounds = YES;
    
}


-(void)setComment:(Comment *)comment
{
    _comment = comment;
    NSURL *url = [NSURL URLWithString:_comment.userImage];
    [_userImageView sd_setImageWithURL:url];
    _nickNameLabel.text = _comment.nickname;
    _ratingLabel.text = _comment.rating;
    _contentLabel.text = _comment.content;
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
