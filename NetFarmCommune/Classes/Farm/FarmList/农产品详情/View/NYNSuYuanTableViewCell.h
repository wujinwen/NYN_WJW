//
//  NYNSuYuanTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SuYuanBlock) (NSString *strValue);

@interface NYNSuYuanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *suYuanButton;

@property(nonatomic, copy) SuYuanBlock SuYuanBlock;

@end
