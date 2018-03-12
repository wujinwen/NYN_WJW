//
//  ZWPullMenuModel.h
//  ZWPullMenuDemo
//
//  Created by 王子武 on 2017/8/28.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ZWPullMenuStyle) {
    PullMenuDarkStyle = 0,  //类微信、黑底白字
    PullMenuLightStyle      //类支付宝、白底黑字
};
@interface ZWPullMenuModel : NSObject
/** 
 * 文字
 */
@property (nonatomic, copy) NSString *title;
/** 
 * 图片
 */
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *id;

@property(nonatomic,strong)NSString * rtmpPull;//拉流地址

@property(nonatomic,strong)NSString * farmTitle;//农场名称

@property(nonatomic,strong)NSString * intro;//直播间介绍

@property(nonatomic,strong)NSString * curentMember;//当前在线人数

@property(nonatomic,strong)NSString * popurlar;//人气
@property(nonatomic,assign)BOOL  isCell;

@property(nonatomic,strong)NSString * pimg;
@property(nonatomic,strong)NSString * farmId;





@end
