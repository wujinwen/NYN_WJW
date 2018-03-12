//
//  NYNChanPinJiaGongViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "NYNChanPinJiaGongModel.h"

//NYNChanPinJiaGongModel *model
typedef void(^ReturnBlock) (NYNChanPinJiaGongModel *model);

@interface NYNChanPinJiaGongViewController : BaseViewController
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) ReturnBlock returnBlock;


-(void)setProductId:(NSString*)productId type:(NSString*)type;

@end
