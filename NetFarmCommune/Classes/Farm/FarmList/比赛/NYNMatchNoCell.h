//
//  NYNMatchNoCell.h
//  NetFarmCommune
//
//  Created by ff on 2018/3/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYNMatchNoCell : UITableViewCell

@property (nonatomic, strong)  UILabel *leftLab;
@property (nonatomic, strong)  UILabel *rightLab;

- (void)letfTitle:(NSString *)title rightTitle:(NSString *)rightT;


@end
