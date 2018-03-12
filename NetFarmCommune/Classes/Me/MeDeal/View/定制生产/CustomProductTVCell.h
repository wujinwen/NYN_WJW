//
//  CustomProductTVCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomModel.h"

@protocol CustomProductClickDelagate<NSObject>

-(void)planClickIndex:(NSInteger)indexpath  orderId:(NSString*)orderId;
//废纸篓
-(void)garbageClickInteger:(NSInteger)select state:(NSString*)state index:(NSInteger)index;

-(void)payMoneyClick:(NSInteger)idnex model:(CustomModel*)model state:(NSString*)state;


-(void)plantClick:(NSString*)phone;


@end

@interface CustomProductTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *pingjiaButton;//评价

@property (weak, nonatomic) IBOutlet UILabel *yangzhiCountLabel;//养殖数量
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;//种植养殖类型

@property(nonatomic,strong)CustomModel* customModel;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *farmLabel;
@property (weak, nonatomic) IBOutlet UIButton *messegeBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;//电话
@property (weak, nonatomic) IBOutlet UIButton *payBtn;//付款

@property (weak, nonatomic) IBOutlet UIButton *planButton;//养殖计划
@property (weak, nonatomic) IBOutlet UIButton *lajiBtn;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;//状态
@property (weak, nonatomic) IBOutlet UIImageView *messegeImage;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;//产品名

@property(nonatomic,assign)NSInteger  garbageInteger;//订单id
@property(nonatomic,assign)NSInteger  planIndex;

@property(assign,nonatomic)id<CustomProductClickDelagate> delegate;


@property(nonatomic,assign)NSInteger selectInteger;//种植养殖选择的tag值




@end
