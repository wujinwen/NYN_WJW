//
//  NYNMeDealShouHouTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CCBlock) (NSInteger i);
@interface NYNMeDealShouHouTableViewCell : UITableViewCell
@property (nonatomic,copy) CCBlock ccblock;

@end
