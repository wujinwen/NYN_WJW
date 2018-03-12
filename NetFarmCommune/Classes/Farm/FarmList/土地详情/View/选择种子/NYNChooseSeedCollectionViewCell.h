//
//  NYNChooseSeedCollectionViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYNChooseSeedCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *contentImageView;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *gouXuanImageView;

@property (nonatomic,assign) BOOL isChoose;
@end
