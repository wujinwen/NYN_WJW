//
//  NYNFarmChooseButton.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/5.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYNFarmChooseButton : UIButton
@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,assign) int indexFB;
@property (nonatomic,assign) BOOL isAsc;
@end
