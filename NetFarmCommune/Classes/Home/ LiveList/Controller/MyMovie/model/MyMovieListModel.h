//
//  MyMovieListModel.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/1.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMovieListModel : NSObject


@property(nonatomic,assign)int ID;
@property(nonatomic,assign)int sex;
@property(nonatomic,assign)int fans;
@property(nonatomic,strong)NSString* nickName;

@property(nonatomic,strong)NSString* String;
@property(nonatomic,strong)NSString* age;
@property(nonatomic,strong)NSString* level;
@property(nonatomic,strong)NSString* birthday;
@property(nonatomic,strong)NSArray* liveHistory;
@property(nonatomic,strong)NSString* avatar;

@end
