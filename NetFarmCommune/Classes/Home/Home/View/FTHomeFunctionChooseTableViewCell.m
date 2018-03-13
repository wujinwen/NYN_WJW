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
}

-(void)getLivePicArray:(NSMutableArray *)picArr textArray:(NSMutableArray *)textArray{
    float cellWith = JZWITH(106);
    float cellTopHeight = JZWITH(5);
    for (int i = 0 ; i < picArr.count; i ++) {
        _btOne = [[NYNLiveButton alloc]initWithFrame:CGRectMake(JZWITH(12) + (JZWITH(18) + cellWith) * i,cellTopHeight, cellWith, cellWith + JZHEIGHT(30))];
        [_btOne.picImageView sd_setImageWithURL:[NSURL URLWithString:picArr[i]] placeholderImage:[UIImage imageNamed:@"占位图"]];
        _btOne.textLabel.text = textArray[i];
        [self.contentView addSubview:_btOne];
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
