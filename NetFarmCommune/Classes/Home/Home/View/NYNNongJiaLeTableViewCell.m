//
//  NYNNongJiaLeTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/2.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNNongJiaLeTableViewCell.h"
#import "FTHomeButton.h"
#import "NYNMarketButton.h"
@implementation NYNNongJiaLeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, JZHEIGHT(15), SCREENWIDTH, JZHEIGHT(13))];
    //    titleLabel.textColor = RGB_COLOR(86, 77, 90);
    //    titleLabel.font = JZFontHeaderSemibold(13);
    //    titleLabel.textAlignment = 1;
    //    titleLabel.text = @"人气推荐";
    //    [self.contentView addSubview:titleLabel];
    //
    //    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.bottom + JZHEIGHT(7), SCREENWIDTH, JZHEIGHT(10))];
    //    detailLabel.textAlignment = 1;
    //    detailLabel.font = JZFont(10);
    //    detailLabel.textColor = RGB_COLOR(136, 136, 136);
    //    detailLabel.text = @"直播互动 给你好玩";
    //    [self.contentView addSubview:detailLabel];
    //
    //    float cellWith = (SCREENWIDTH - (self.picArr.count + 1) * 10) / self.picArr.count;
    //
    //    float cellTopHeight  = 0;
    //    UIButton *moreButton = nil;
    //    if (self.picArr.count == 3) {
    //        cellTopHeight = JZHEIGHT(62);
    //
    //    }else{
    //
    //        cellTopHeight = JZHEIGHT(55);
    //
    //        moreButton = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(346), JZHEIGHT(16), JZWITH(20), JZHEIGHT(10))];
    //        [moreButton setTitle:@"更多" forState:0];
    //        moreButton.titleLabel.font = JZFont(10);
    //        [moreButton setTitleColor:RGB_COLOR(136, 136, 136) forState:0];
    //        [self.contentView addSubview:moreButton];
    //    }
    

//    self.contentView.backgroundColor = [UIColor colorWithHexString:@"eef4e5"];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
}


-(void)setTotalArray:(NSMutableArray *)totalArray{
    _totalArray = totalArray;
    
    CGFloat cellWith = JZWITH(81);
    CGFloat jiangeWith = (SCREENWIDTH - 4 * JZWITH(81)) / 5;
    
    for (int i = 0 ; i < self.totalArray.count; i ++) {
        FTHomeButton *btOne = [[FTHomeButton alloc]initWithFrame:CGRectMake(jiangeWith+ (jiangeWith + cellWith) * i,JZHEIGHT(5), cellWith, cellWith + JZHEIGHT(28))];
        [ btOne.picImageView sd_setImageWithURL:[NSURL URLWithString:self.totalArray[i][@"pImg"]] placeholderImage:nil];
        btOne.textLabel.text = self.totalArray[i][@"farmName"];
        //        NSString *str = self.detailArr[i];
        //        btOne.zhongLiangLabel.attributedText = [MyControl CreateNSAttributedString:str thePartOneIndex:NSMakeRange(0, str.length - 3) withColor:[UIColor colorWithHexString:@"fa9b16"] withFont:[UIFont systemFontOfSize:12] andPartTwoIndex:NSMakeRange(str.length - 3, 3) withColor:[UIColor colorWithHexString:@"686868"] withFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:btOne];
        
        UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(jiangeWith+ (jiangeWith + cellWith) * i,btOne.bottom, cellWith,  JZHEIGHT(20))];
        priceLabel.text=[NSString stringWithFormat:@"%@/%@",self.totalArray[i][@"newPrice"],self.totalArray[i][@"unitName"]];
        priceLabel.textColor = JZRGBColor(250,155,22);
        priceLabel.font =[UIFont systemFontOfSize:11];
        priceLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.contentView addSubview:priceLabel];
        
        
    }
}


-(NSMutableArray *)picArr{
    if (!_picArr) {
        _picArr = [[NSMutableArray alloc]initWithArray: @[@"WechatIMG5",@"WechatIMG6",@"WechatIMG4",@"WechatIMG7"]];
    }
    return _picArr;
}

-(NSMutableArray *)textArr{
    if (!_textArr) {
        _textArr = [[NSMutableArray alloc]initWithArray:@[@"红皮萝卜",@"西红柿",@"西兰花",@"土豆"]];
    }
    return _textArr;
}

-(NSMutableArray *)detailArr{
    if (!_detailArr) {
        _detailArr = [[NSMutableArray alloc]initWithArray:@[@"¥1.5/kg",@"¥1.5/kg",@"¥1.5/kg",@"¥1.5/kg"]];
    }
    return _detailArr;
}

@end
