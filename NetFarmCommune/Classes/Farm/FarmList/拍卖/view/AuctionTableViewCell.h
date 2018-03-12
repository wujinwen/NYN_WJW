//
//  AuctionTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/3.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NYNAuctionModel.h"

typedef void(^offerBlock)(NSInteger selectInteger);

@interface AuctionTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *farmImageView;//农场图片

@property (weak, nonatomic) IBOutlet UILabel *farmName;

@property(nonatomic,strong)NYNAuctionModel* auctionMoedel;
@property (weak, nonatomic) IBOutlet UILabel *jiapaiPrice;//加拍价格
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;//当前价格
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//剩余时间

@property(nonatomic,strong)UITextView * messegetextView;

@property(nonatomic,strong)UIImageView * farmMaeesegView;//农场详情图片

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UILabel *miaosuLabel;
@property (nonatomic,copy) offerBlock offerBlock;

@property(nonatomic,assign)NSInteger index;



@end
