//
//  RefundtProductThreeCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/2/5.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectPricBlock) (NSIndexPath * indexpath);



@interface RefundtProductThreeCell : UITableViewCell



@property(nonatomic,strong)UILabel * headLabel;

@property(nonatomic, copy) SelectPricBlock selectBlock;

@property (nonatomic,strong) NSMutableArray *picsArr;

@property (nonatomic,strong) UICollectionView *albumCollectionView;

@end
