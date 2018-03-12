//
//  ChooseLandViewController.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNXuanZeZhongZiModel.h"

typedef void(^SelectBlock)(NYNXuanZeZhongZiModel * model);

@interface ChooseLandViewController : BaseViewController

@property (nonatomic,strong) NYNXuanZeZhongZiModel *selectModel;



@property(nonatomic,strong)NSString * farmID;

/**
 *  click
 */
@property (nonatomic, copy) SelectBlock selectBlock;


@property(nonatomic,strong)NSString * titleStr;


-(void)getTitle:(NSString*)titleStr type:(NSString*)type;




@end
