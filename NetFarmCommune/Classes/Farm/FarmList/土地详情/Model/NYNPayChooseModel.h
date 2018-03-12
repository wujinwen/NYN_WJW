//
//  NYNPayChooseModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNPayChooseModel : NSObject
@property (nonatomic,copy) NSString *chooseImageView;
@property (nonatomic,copy) NSString *iconStr;
@property (nonatomic,copy) NSString *aliPayStr;
@property (nonatomic,copy) NSString *detailContentStr;
@property (nonatomic,copy) NSString *timeContentStr;

@property (nonatomic,assign) BOOL isChoose;


@end
