//
//  PostHeadCollectionView.h
//  timeMovie
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PostHeadCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSArray *movieData;
@property(nonatomic,assign)NSInteger index;


@end
