//
//  FTFarmRecommendTableViewCell.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTFarmRecommendTableViewCell : UITableViewCell
//@property (nonatomic,strong) NSMutableArray *picArr;
//@property (nonatomic,strong) NSMutableArray *textArr;
//@property (nonatomic,strong) NSMutableArray *detailArr;



-(void)getpicArr:(NSMutableArray*)picArr textArr:(NSMutableArray*)textArr detailArr:(NSMutableArray*)detailArr;


@property(nonatomic,strong)NSArray * dataArray;

@end
