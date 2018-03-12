//
//  FTMyDealTableViewCell.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickDealCell)(NSInteger i);
@interface FTMyDealTableViewCell : UITableViewCell
@property (nonatomic,copy) ClickDealCell clickDealCell;
@end
