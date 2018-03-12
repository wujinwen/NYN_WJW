//
//  StopSpeakTVCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNInfoView.h"
// 定义选择代理
@protocol StopSpeakTVCellDelagate < NSObject>

//头像点击事件
-(void)headImageGesture:(UITapGestureRecognizer*)tap;




@end

@interface StopSpeakTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;//头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//姓名
@property (weak, nonatomic) IBOutlet UIButton *jinyanButton;//禁言

@property(nonatomic,strong)NYNInfoView * infoView;


@end
