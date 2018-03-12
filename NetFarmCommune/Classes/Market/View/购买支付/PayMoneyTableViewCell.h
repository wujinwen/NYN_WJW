//
//  PayMoneyTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/10.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^moneyBlock) (NSString *strValue);
@interface PayMoneyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *PayMonyBtn;


@property(nonatomic, copy) moneyBlock moneyBlock;
@end
