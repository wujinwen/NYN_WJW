//
//  PullListTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWPullMenuModel.h"
@interface PullListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *listImageView;
@property (weak, nonatomic) IBOutlet UILabel *farmName;
@property (weak, nonatomic) IBOutlet UILabel *messsegeFarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
/**
 *  pullMenu样式
 */
@property (nonatomic, assign) ZWPullMenuStyle zwPullMenuStyle;

/**
 * 最后一栏cell
 */
@property (nonatomic, assign) BOOL isFinalCell;

/**
 *  model
 */
@property (nonatomic, strong) ZWPullMenuModel *menuModel;
@end
