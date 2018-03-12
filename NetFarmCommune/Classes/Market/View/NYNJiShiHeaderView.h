//
//  NYNJiShiHeaderView.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNJiShiDataModel.h"
#import "NYNLeiDataModel.h"
#import "NYNPinZhongDataModel.h"
#import "NYNMarketCagoryModel.h"

typedef void(^MoreClickBlock)(BOOL isMore);
typedef void(^BackModelClick)(NYNMarketCagoryModel *model ,NSInteger indexPath);
typedef void(^PaiXuClickBlock)(NSMutableDictionary *dic);
typedef void(^CategoryClickBlck)(NYNMarketCagoryModel *model);


@interface NYNJiShiHeaderView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
//这里出发titleArr给数据  在setMarket里面开始界面创建  保证数据进来d
@property (nonatomic,strong) NSMutableArray *marketTitleArr;
@property (nonatomic,strong) NYNJiShiDataModel *marketModel;

//上面的
@property (nonatomic,strong) NSMutableArray *titleButtonArr;
//下面的
@property (nonatomic,strong) NSMutableArray *shaiXuanButtonArr;

//横向
@property (nonatomic,strong) UICollectionView *VfenLeiCollection;
//竖向
@property (nonatomic,strong) UICollectionView *HfenLeiCollection;

@property (nonatomic,assign) BOOL isMore;

@property (nonatomic,strong) UIButton *moreButton;
@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) NYNMarketCagoryModel *selectLeiModel;
@property (nonatomic,strong) NYNMarketCagoryModel *selectPinZhongModel;

@property (nonatomic,copy) PaiXuClickBlock paiXuClick;

@property (nonatomic,copy) MoreClickBlock didMoreClick;

@property (nonatomic,copy) CategoryClickBlck categoryClick;

@property (nonatomic,copy) BackModelClick backModelClick;

@property (nonatomic,strong) UIView *moreView;

@property (nonatomic,strong) NSMutableArray *titleModelArr;

@property (nonatomic,assign) int upIndex;
- (void)gogo;
@end
