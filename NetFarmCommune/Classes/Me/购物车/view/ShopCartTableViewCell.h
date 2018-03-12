//
//  ShopCartTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopCartModel.h"


@protocol ShopCartTableViewDelegate<NSObject>

//删除订单
-(void)garbageProductId:(NSString*)productId productType:(NSString*)productType;

@end

typedef void(^ShopCartBlcok) (BOOL choose,NSInteger section,NSInteger row);

@interface ShopCartTableViewCell : UITableViewCell

@property(nonatomic,strong)ShopCartModel * model;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *productImage;

@property (weak, nonatomic) IBOutlet UITextView *messegeTextV;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *farmLaebl;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *bigSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *smallButton;
@property(nonatomic,assign)BOOL Selected;

@property (weak, nonatomic) IBOutlet UIImageView *productLogoImage;


@property(nonatomic,assign)BOOL smallSelected;

@property(nonatomic,weak)id<ShopCartTableViewDelegate>delaget;

@property(nonatomic,assign)NSInteger section;
@property(nonatomic,assign)NSInteger row;

@property(nonatomic,copy)ShopCartBlcok  block;

//
-(void)setCellSelect:(BOOL)select;

@end
