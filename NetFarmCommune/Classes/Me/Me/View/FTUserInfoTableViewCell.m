//
//  FTUserInfoTableViewCell.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTUserInfoTableViewCell.h"

@implementation FTUserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIImageView *headerimageview = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(16), JZWITH(46), JZHEIGHT(46))];
    headerimageview.image = PlaceImage;
    headerimageview.layer.cornerRadius = JZWITH(23);
    headerimageview.layer.masksToBounds = YES;
    [self.contentView addSubview:headerimageview];
    
    NSString *nameStr = @"幸福的小熊";
    CGFloat nameWith = [nameStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, JZHEIGHT(15)) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Regular" size:SCREENWIDTH/375 * 15]}  context:nil].size.width;
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(headerimageview.right + JZWITH(10), JZHEIGHT(31 - 6), nameWith, JZHEIGHT(15))];
    nameLabel.text = nameStr;
    nameLabel.font = JZFont(15);
    nameLabel.textColor = RGB_COLOR(37, 40, 39);
    nameLabel.userInteractionEnabled = NO;
    [self.contentView addSubview:nameLabel];
    
    UIImageView *sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(nameLabel.right + JZWITH(7), JZHEIGHT(34 - 8), JZWITH(13), JZHEIGHT(13))];
    sexImageView.image= Imaged(@"mine_icon_female");
    sexImageView.userInteractionEnabled = NO;
    [self.contentView addSubview:sexImageView];
    
    UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom + JZHEIGHT(5), JZWITH(31), JZHEIGHT(11))];
    levelLabel.layer.cornerRadius = 3;
    levelLabel.layer.masksToBounds = YES;
    levelLabel.text = @"Level3";
    levelLabel.backgroundColor = [UIColor colorWithHexString:@"fa9b16"];
    levelLabel.font = JZFont(9);
    levelLabel.textAlignment = 1;
    levelLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:levelLabel];
    self.levelLabel = levelLabel;
    
    UIImageView *jiantouImageview = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZHEIGHT(10) - JZHEIGHT(7),  JZHEIGHT(34), JZWITH(7), JZHEIGHT(11))];
    jiantouImageview.image = Imaged(@"mine_icon_more");
    [self.contentView addSubview:jiantouImageview];
    
    
    UILabel *gerenzhuyeLabel = [[UILabel alloc]initWithFrame:CGRectMake(jiantouImageview.left - JZWITH(9) - JZWITH(50), JZHEIGHT(34), JZWITH(50), JZHEIGHT(11))];
    gerenzhuyeLabel.textAlignment = 2;
    gerenzhuyeLabel.text = @"我的主页";
    gerenzhuyeLabel.font = JZFont(11);
    gerenzhuyeLabel.textColor = RGB104;
    [self.contentView addSubview:gerenzhuyeLabel];
    
    self.headerImageView = headerimageview;
    self.nameLabel = nameLabel;
    self.sexImageView = sexImageView;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIButton *goMeInfo = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH / 2, JZHEIGHT(76))];
    goMeInfo.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:goMeInfo];
    
    self.goMeInfo = goMeInfo;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUserModel:(UserInfoModel *)userModel{
    _userModel = userInfoModel;
    
    if (userModel.isLogin) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:PlaceImage];
        
        CGFloat nameWith = [userModel.name boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, JZHEIGHT(15)) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Regular" size:SCREENWIDTH/375 * 15]}  context:nil].size.width;
        self.nameLabel.frame = CGRectMake(self.headerImageView.right + JZWITH(10), JZHEIGHT(31 - 6), nameWith, JZHEIGHT(15));
        self.sexImageView.frame = CGRectMake(self.nameLabel.right + JZWITH(7), JZHEIGHT(34 - 8), JZWITH(13), JZHEIGHT(13));
        
//        if (userModel.name.length < 1) {
//            self.nameLabel.text = userModel.phone;
//
//        }else{
//            self.nameLabel.text = userModel.name;
//        }
        self.nameLabel.text = userModel.name;

        
        if ([userModel.sex isEqualToString:@"1"]) {
        //男
            self.sexImageView.image = Imaged(@"mine_icon_male");
        }else{
        //女
            self.sexImageView.image = Imaged(@"mine_icon_female");
        }
        
        self.levelLabel.text = [NSString stringWithFormat:@"%@",@"1"];
    }else{
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:PlaceImage];
        self.nameLabel.text = @"未登录";
        
        self.sexImageView.hidden = YES;
        self.levelLabel.hidden = YES;
        
//        if ([userModel.sex isEqualToString:@"0"]) {
//            //男
//            self.sexImageView.image = Imaged(@"mine_icon_male");
//        }else{
//            //女
//            self.sexImageView.image = Imaged(@"mine_icon_female");
//        }
        
    }
    
    JZLog(@"");
    
}

@end
