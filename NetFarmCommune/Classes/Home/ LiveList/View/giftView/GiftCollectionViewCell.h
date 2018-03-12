//
//  GiftCollectionViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/17.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftListModel.h"

@interface GiftCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)GiftListModel * giftModel;

@property(nonatomic,strong)UIImageView * giftImage;
@property(nonatomic,strong)UILabel * titleLabel;
@end
