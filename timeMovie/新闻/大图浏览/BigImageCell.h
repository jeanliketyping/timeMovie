//
//  BigImageCell.h
//  timeMovie
//
//  Created by mac on 15/8/25.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigImageCell : UICollectionViewCell

@property(nonatomic,strong)NSURL *imageURL;

-(void)backImageZoomingScale;

@end
