//
//  NYNEarthZuDiTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MianJiBlock) (NSString *strValue);
typedef void (^ShiChangBlock) (NSString *strValue);


@interface NYNEarthZuDiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mianJiCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *shiChangCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mianjijianIV;
@property (weak, nonatomic) IBOutlet UIImageView *mianjiJiaIV;
@property (weak, nonatomic) IBOutlet UIImageView *shichangjianIV;
@property (weak, nonatomic) IBOutlet UIImageView *shichangjiaIV;
@property (strong, nonatomic) UILabel *priceTotleLabel;

@property(nonatomic, copy) MianJiBlock mianjiBlock;
@property(nonatomic, copy) ShiChangBlock shichangBlock;

@property (nonatomic,assign) int mianJiCount;
@property (nonatomic,assign) int shiChangCount;

@end
