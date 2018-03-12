//
//  NYNGouMaiTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GouMaiBlock) (NSString *strValue);

@interface NYNGouMaiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *jianImageView;
@property (weak, nonatomic) IBOutlet UIImageView *jiaImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic, copy) GouMaiBlock shichangBlock;
@property (weak, nonatomic) IBOutlet UILabel *biaoTiLabel;


@property (nonatomic,assign) int count;
@end
