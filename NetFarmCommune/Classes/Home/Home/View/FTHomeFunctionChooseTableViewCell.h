//
//  FTHomeFunctionChooseTableViewCell.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTHomeFunctionChooseTableViewCell : UITableViewCell
@property (nonatomic,strong) NSMutableArray *picArr;
@property (nonatomic,strong) NSMutableArray *textArr;


-(void)getLivePicArray:(NSMutableArray*)picArr textArray:(NSMutableArray*)textArray;

@end
