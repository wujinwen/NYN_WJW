//
//  NYNMeDealDaiFuKuanTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDealModel.h"
typedef void(^CCBlock) (NSInteger i,GoodsDealModel * model);
@interface NYNMeDealDaiFuKuanTableViewCell : UITableViewCell
@property (nonatomic,copy) CCBlock ccblock;

@property(nonatomic,strong)GoodsDealModel * model;




@end
