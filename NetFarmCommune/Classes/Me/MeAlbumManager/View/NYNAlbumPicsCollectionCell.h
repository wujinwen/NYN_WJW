//
//  NYNAlbumPicsCollectionCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/8/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DetelTapBlock)(NSIndexPath *indexPath);

@interface NYNAlbumPicsCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImgeView;
@property (weak, nonatomic) IBOutlet UIImageView *detelImageView;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,copy) DetelTapBlock detelBlock;
@property (strong, nonatomic)  UIImageView *detelImageViewW;
@property (strong, nonatomic)  UIImageView *picImgeViewW;

@end
