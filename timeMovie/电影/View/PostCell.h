//
//  PostCell.h
//  timeMovie
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface PostCell : UICollectionViewCell

@property (nonatomic,strong)Movie *movie;

-(void)flipCell;

-(void)backCell;

@end
