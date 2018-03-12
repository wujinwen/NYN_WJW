//
//  ShopCartHeadTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/2/7.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartModel.h"

typedef void(^FarmTitleClickBlcok) (BOOL choose,NSInteger section);

@interface ShopCartHeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *farImage;
@property (weak, nonatomic) IBOutlet UILabel *farmLabel;
@property (weak, nonatomic) IBOutlet UIButton *garbgeLabel;

@property(nonatomic,strong)ShopCartModel * model;

@property(nonatomic,assign)BOOL Selected;
@property(nonatomic,assign)NSInteger section;

@property(nonatomic,copy)FarmTitleClickBlcok  FarmTitleBlock;
-(void)setCellSelect:(BOOL)select ;
@end
