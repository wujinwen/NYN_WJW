//
//  NYNEarthLocationViewTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBlock) (NSString *ss);

@interface NYNEarthLocationViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UILabel *juliLabel;

@property (nonatomic,copy) CallBlock callBlock;
@end
