//
//  GoumaiOneTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/10.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNMarketListModel.h"

#import "ShopCartModel.h"

#import "FreightModel.h"
typedef void (^FrieghtBlock) (float  strValue,float totalPrice);


@interface GoumaiOneTableViewCell : UITableViewCell


@property(nonatomic, copy) FrieghtBlock frieghtBlock;
@property (weak, nonatomic) IBOutlet UILabel *farmLabel;//农场

@property (weak, nonatomic) IBOutlet UITextView *messegeTextView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;//数量
@property (weak, nonatomic) IBOutlet UILabel *totallabel;//总数

@property (weak, nonatomic) IBOutlet UILabel *yunfeiLabel;//运费
@property (weak, nonatomic) IBOutlet UIImageView *farmImage;//农场图片
@property (weak, nonatomic) IBOutlet UIImageView *productImage;//产品图片

@property (weak, nonatomic) IBOutlet UILabel *productLabel;//产品label
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property(nonatomic,strong)NYNMarketListModel * lictModel;
@property(nonatomic,strong)ShopCartModel * shopModel;
@property(nonatomic,strong)FreightModel * freightModel;




@end
