//
//  ReceiveGiftView.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackClickBlck)();

@interface ReceiveGiftView : UIView
@property (nonatomic,copy) BackClickBlck backClick;

@property(nonatomic,strong)NSString * liveIdString;

-(instancetype)initWithFrame:(CGRect)frame liveId:(NSString*)liveId;

@end
