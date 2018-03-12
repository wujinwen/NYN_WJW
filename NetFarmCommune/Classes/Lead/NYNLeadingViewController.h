//
//  NYNLeadingViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^Go)(NSString *s);
@interface NYNLeadingViewController : BaseViewController
@property (nonatomic,copy) Go Go;
@end
