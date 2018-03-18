//
//  NYNEarthDetailHeaderTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNEarthDetailHeaderTableViewCell.h"

@implementation NYNEarthDetailHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    SDCycleScrollView *bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(171)) delegate:self placeholderImage:PlaceImage];
    bannerScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    bannerScrollView.hidesForSinglePage = YES;

    [self.contentView addSubview:bannerScrollView];
    self.bannerScrollView = bannerScrollView;

    UIView *starBackView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(106), JZHEIGHT(10), JZWITH(140), JZHEIGHT(25))];
    starBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];
    starBackView.layer.cornerRadius = JZWITH(12.5);
    starBackView.layer.masksToBounds = YES;
    [self.contentView addSubview:starBackView];
    starBackView.userInteractionEnabled = YES;
    starBackView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [starBackView addGestureRecognizer:tap];
    
    UIImageView *starLabel = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(12.5), (starBackView.height - JZHEIGHT(11)) / 2, JZWITH(18), JZHEIGHT(11))];
    starLabel.image = Imaged(@"farm_icon_live");
    [starBackView addSubview:starLabel];
    starLabel.userInteractionEnabled = NO;

    UILabel *jkLB = [[UILabel alloc]initWithFrame:CGRectMake(starLabel.right + JZWITH(5), 0, JZWITH(50), starBackView.height)];
    jkLB.textColor = [UIColor whiteColor];
    jkLB.font = JZFont(11);
    jkLB.text = @"查看监控";
    [starBackView addSubview:jkLB];
    jkLB.userInteractionEnabled = NO;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)tap{
    JZLog(@"点击了查看监控");
}

-(void)setUrlImages:(NSMutableArray *)urlImages{
    _urlImages = urlImages;
    
//    NSArray *array = [urlImages componentsSeparatedByString:@","];
//    NSMutableArray *muArr = [[NSMutableArray alloc]init];
//    for (int i = 0; i < array.count; i++) {
//        NSString *str = array[i];
//        str = [[[str stringByReplacingOccurrencesOfString:@"[" withString:@""]stringByReplacingOccurrencesOfString:@"\"" withString:@""]stringByReplacingOccurrencesOfString:@"]" withString:@""];
//        
//        [muArr addObject:str];
//        JZLog(@"");
//    }
    
    NSMutableArray *rr = [[NSMutableArray alloc]init];
    for (NSString *imgurl in urlImages) {
        [rr addObject:imgurl];
    }
    
    
    self.bannerScrollView.imageURLStringsGroup = [NSArray arrayWithArray:rr];
//    self.bannerScrollView.localizationImageNamesGroup = @[@"WechatIMG4",@"WechatIMG5",@"WechatIMG6",@"WechatIMG7",@"WechatIMG8"];
}
@end
