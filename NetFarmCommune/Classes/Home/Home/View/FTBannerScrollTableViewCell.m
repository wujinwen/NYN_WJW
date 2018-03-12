//
//  FTBannerScrollTableViewCell.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTBannerScrollTableViewCell.h"
#import "LQScrollView.h"

@implementation FTBannerScrollTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
//    v.backgroundColor = [UIColor whiteColor];
//    self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"WechatIMG4",@"WechatIMG5",@"WechatIMG6",@"WechatIMG7",@"WechatIMG8", nil];
    LQScrollView * lq = [[LQScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(190)) imageArray:arr];
    self.lq = lq;
    
    __weak typeof(self) weakSelf = self;
    
    lq.tapBack = ^(NYNFarmCellModel *model) {
        if (weakSelf.back) {
            weakSelf.back(model);
        }
    };
    
    [self addSubview:lq];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setBannerDataArr:(NSMutableArray *)bannerDataArr{
    _bannerDataArr = bannerDataArr;
    self.lq.bannerDataArr = bannerDataArr;    
}



@end
