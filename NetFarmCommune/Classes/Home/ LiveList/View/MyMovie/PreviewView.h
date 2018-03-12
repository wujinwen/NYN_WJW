//
//  PreviewView.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StartClickBlck)();

@interface PreviewView : UIView

@property (nonatomic,copy) StartClickBlck startClick;

@end
