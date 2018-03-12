//
//  SendGiftView.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendGiftClickDelagate<NSObject>

-(void)SendGift:(UIButton*)btn giftID:(NSString*)giftID giftPic:(NSString*)giftPic giftName:(NSString*)giftName;


-(void)chongzhiBtnClick:(UIButton*)sender;

@end



@interface SendGiftView : UIView

@property(nonatomic,strong)UIScrollView * scrollbuttom;

@property(nonatomic,strong)NSString * liveId;
@property(assign,nonatomic)id<SendGiftClickDelagate> delegate;


@end
