//
//  FTCategoryTableViewCell.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTCategoryTableViewCell.h"

@implementation FTCategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
  
    
    
    
//    CGFloat jiangeWith = JZWITH(32);
////    jiangeWith = 100;
//    for (int i = 0 ; i < self.picArr.count; i ++) {
//        CGFloat x = JZWITH(22) + (jiangeWith + JZWITH(40)) * i ;
//        FTHomeButton *btOne = [[FTHomeButton alloc]initWithFrame:CGRectMake(x, JZHEIGHT(17), JZWITH(40), JZHEIGHT(61))];
//        btOne.picImageView.image = Imaged(self.picArr[i]);
//        btOne.textLabel.text = self.textArr[i];
//        [self.contentView addSubview:btOne];
//
//        btOne.indexFB = i;
//        [btOne addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
    
    
//    self.contentView.backgroundColor = [UIColor colorWithHexString:@"eef4e5"];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

-(void)getDataListArr:(NSArray*)picArr textArray:(NSArray *)textArray{
    
    
    float cellWith = JZWITH(106);
    float cellTopHeight = JZWITH(5);
    CGFloat x = JZWITH(18) + cellWith;
    CGFloat h =cellWith + JZHEIGHT(30);
    for (int i = 0 ; i < picArr.count; i ++) {
        
        _btOne = [[FTHomeButton alloc]initWithFrame:CGRectMake(x*(i%3)+10,cellTopHeight+(h*(i/3)), cellWith,h )];
//        _btOne.picImageView.image =  Imaged(picArr[i]);
         [ _btOne.picImageView sd_setImageWithURL:[NSURL URLWithString:picArr[i]] placeholderImage:nil];
        
        _btOne.picImageView.contentMode = UIViewContentModeScaleToFill;
        _btOne.textLabel.text = textArray[i];
        [_btOne addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btOne];
        _btOne.tag =400+i;
        _btOne.indexFB=i;
        
        
    }
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(NSMutableArray *)picArr{
//    if (!_picArr) {
//        _picArr = [[NSMutableArray alloc]initWithArray: @[@"WechatIMG5",@"WechatIMG5",@"WechatIMG5",@"WechatIMG5",@"WechatIMG5",@"WechatIMG5"]];
//    }
//    return _picArr;
//}

-(NSMutableArray *)textArr{
    if (!_textArr) {
        _textArr = [[NSMutableArray alloc]initWithArray:@[@"活动",@"直播",@"农家乐",@"阳光厨房",@"专属农场",@"专属农场"]];
    }
    return _textArr;
}

//- (void)actionCotrolPage:(id)sender
//{
//    [self.scrollView setContentOffset:CGPointMake(self.pageController.currentPage * 320, 0) animated:YES];
//    //}


//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if ([scrollView isEqual:self.scrollView]) {
//        int index = self.scrollView.contentOffset.x / SCREENWIDTH;
//        self.pageController.currentPage = index ;
//    }
//}

- (void)buttonClick:(FTHomeButton *)button{

    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(button);
    }
}

-(void)setBannerDataArr:(NSMutableArray *)bannerDataArr{
    _bannerDataArr = bannerDataArr;
    
    
    
}
@end
