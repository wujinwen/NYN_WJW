//
//  SelectView.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/10.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YYBlock) (NSInteger i);

@interface SelectView : UIView

@property (weak, nonatomic) IBOutlet UIButton *addFriendBtn;
@property (weak, nonatomic) IBOutlet UIButton *findButton;
@property (weak, nonatomic) IBOutlet UIButton *creatButton;
@property (nonatomic,copy) YYBlock yyblock;


@end
