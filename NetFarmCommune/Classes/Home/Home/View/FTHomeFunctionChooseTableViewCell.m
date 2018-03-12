//
//  FTHomeFunctionChooseTableViewCell.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTHomeFunctionChooseTableViewCell.h"
#import "FTHomeButton.h"
#import "NYNLiveButton.h"

@implementation FTHomeFunctionChooseTableViewCell

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
    

    
}

-(void)getLivePicArray:(NSMutableArray *)picArr textArray:(NSMutableArray *)textArray{
    
    float cellWith = JZWITH(106);
    float cellTopHeight = JZWITH(5);
    
    for (int i = 0 ; i < picArr.count; i ++) {
        _btOne = [[NYNLiveButton alloc]initWithFrame:CGRectMake(JZWITH(12) + (JZWITH(18) + cellWith) * i,cellTopHeight, cellWith, cellWith + JZHEIGHT(30))];
        [_btOne.picImageView sd_setImageWithURL:[NSURL URLWithString:picArr[i]] placeholderImage:[UIImage imageNamed:@"占位图"]];
        _btOne.textLabel.text = textArray[i];
        [self.contentView addSubview:_btOne];
        _btOne.backgroundColor = [UIColor redColor];
        [_btOne addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        _btOne.tag =400+i;
        _btOne.indexFB=i;
    }
}

- (void)click:(NYNLiveButton *)sender{
    
    NSLog(@"ushd.f");
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(sender);
    }
}
-(NSMutableArray *)picArr{
    if (!_picArr) {
        _picArr = [[NSMutableArray alloc]initWithArray: @[@"WechatIMG5",@"WechatIMG6",@"WechatIMG7"]];
    }
    return _picArr;
}

-(NSMutableArray *)textArr{
    if (!_textArr) {
        _textArr = [[NSMutableArray alloc]initWithArray:@[@"大石开心农家乐",@"大石开心农家乐",@"大石开心农家乐",]];
    }
    return _textArr;
}
@end
