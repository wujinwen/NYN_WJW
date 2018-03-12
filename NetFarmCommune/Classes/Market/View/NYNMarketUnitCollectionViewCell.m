//
//  NYNMarketUnitCollectionViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMarketUnitCollectionViewCell.h"

@implementation NYNMarketUnitCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    
//    UILabel *ctLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, JZHEIGHT(50), JZHEIGHT(20))];
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        JZLog(@"");
        UILabel *ctLabel = [[UILabel alloc]init];
        self.ctLabel = ctLabel;
        ctLabel.font = JZFont(12);
        ctLabel.layer.cornerRadius = 5;
        ctLabel.layer.masksToBounds = YES;
        ctLabel.layer.borderWidth = .5;
        ctLabel.layer.borderColor = Color888888.CGColor;
        ctLabel.textAlignment = 1;
        ctLabel.textColor = Color888888;
        [self addSubview:ctLabel];
        }
    return self;
}

- (void)layoutSubviews {
    // 一定要调用super的方法
    [super layoutSubviews];
    
    // 确定子控件的frame（这里得到的self的frame/bounds才是准确的）
    self.ctLabel.frame = CGRectMake(0, 0, self.width, self.height);
}
@end
