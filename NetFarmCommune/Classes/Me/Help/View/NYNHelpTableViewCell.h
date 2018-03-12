//
//  NYNHelpTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/5.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNHelpModel.h"

@interface NYNHelpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *anserLabelHeight;


@property (nonatomic,strong) NYNHelpModel* model;
@end
