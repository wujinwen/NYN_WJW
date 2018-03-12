//
//  NYNChooseSeedTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/16.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNXuanZeZhongZiModel.h"
#import "NYNMaiBaiCaiView.h"

@interface NYNChooseSeedTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *chooseSeedDataArr;


@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *zhouqiLabel;
@property (nonatomic,assign) int nowCount;
//@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) NYNXuanZeZhongZiModel *selectModel;

@property (nonatomic,strong) NYNMaiBaiCaiView *chooseV;
@end
