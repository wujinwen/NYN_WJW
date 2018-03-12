//
//  NYNNongJiaLeTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/2.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTHomeButton.h"

typedef void(^farmClick)(FTHomeButton * sender);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数

@interface NYNNongJiaLeTableViewCell : UITableViewCell
@property (nonatomic,strong) NSMutableArray *picArr;
@property (nonatomic,strong) NSMutableArray *textArr;
@property (nonatomic,strong) NSMutableArray *detailArr;

@property (nonatomic,copy) farmClick buttonAction;

@property(nonatomic,strong)NSMutableArray * totalArray;



@end
