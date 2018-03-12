//
//  NYNBaoXianGouMaiViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^BaoXianBackData)(NSString *s);
@interface NYNBaoXianGouMaiViewController : BaseViewController
@property (nonatomic,copy) BaoXianBackData baoXianDataBack;
@end
