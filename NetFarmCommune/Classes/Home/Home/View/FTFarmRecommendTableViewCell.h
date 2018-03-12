//
//  FTFarmRecommendTableViewCell.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNMarketButton.h"

typedef void(^NYNMarketClick)(NYNMarketButton * sender);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数

@interface FTFarmRecommendTableViewCell : UITableViewCell
//@property (nonatomic,strong) NSMutableArray *picArr;
//@property (nonatomic,strong) NSMutableArray *textArr;
//@property (nonatomic,strong) NSMutableArray *detailArr;

@property (nonatomic,copy) NYNMarketClick buttonAction;

-(void)getpicArr:(NSMutableArray*)picArr textArr:(NSMutableArray*)textArr detailArr:(NSMutableArray*)detailArr;


@property(nonatomic,strong)NSArray * dataArray;

@end
