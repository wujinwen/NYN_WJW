//
//  ShopSelectView.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ShopSelectViewDelagate<NSObject>

-(void)selectCellClick:(NSString * )str selectID:(NSString*)selectID selectIndex:(NSString*)selectIndex;

@end

@interface ShopSelectView : UIView

-(void)getData:(NSArray*)array;


@property(nonatomic,weak)id<ShopSelectViewDelagate>delagate;

@end
