//
//  NYNMaiWangNongOneTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/17.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DoClick) (int i,NSString * str );

typedef void(^CountSelectClick) (int i,NSString* type);

@interface NYNMaiWangNongOneTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic,strong) NSMutableArray *btArr;
@property (nonatomic,copy) DoClick click;

@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong) UILabel *contentLabel;


@property (nonatomic,copy) CountSelectClick countClick;

@property (nonatomic,assign) int count;
@end
