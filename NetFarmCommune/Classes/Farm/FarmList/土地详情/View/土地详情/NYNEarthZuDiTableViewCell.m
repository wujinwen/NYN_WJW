//
//  NYNEarthZuDiTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNEarthZuDiTableViewCell.h"

@implementation NYNEarthZuDiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    self.mianjiJiaIV.userInteractionEnabled = YES;
    self.mianjijianIV.userInteractionEnabled = YES;
    self.shichangjiaIV.userInteractionEnabled = YES;
    self.shichangjianIV.userInteractionEnabled= YES;
    
//    self.mianJiCount = 0;
//    self.shiChangCount = 0;
    
    self.mianJiCountLabel.text = [NSString stringWithFormat:@"%d",self.mianJiCount];
    self.shiChangCountLabel.text = [NSString stringWithFormat:@"%d",self.shiChangCount];
    
    self.priceTotleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10 + 150), JZHEIGHT(10), JZWITH(150), JZHEIGHT(15))];
    self.priceTotleLabel.textAlignment = 2;
    [self.contentView addSubview:self.priceTotleLabel];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)mianjijian:(id)sender {
    self.mianJiCount--;
    if (self.mianJiCount < 0) {
        self.mianJiCount = 0;
    }
    self.mianJiCountLabel.text = [NSString stringWithFormat:@"%d",self.mianJiCount];
    JZLog(@"面积-");
    if (self.mianjiBlock) {
        //将自己的值传出去，完成传值
        self.mianjiBlock(@"-");
    }
    


}

- (IBAction)mianjijia:(id)sender {
    self.mianJiCount++;
    self.mianJiCountLabel.text = [NSString stringWithFormat:@"%d",self.mianJiCount];
    if (self.mianjiBlock) {
        //将自己的值传出去，完成传值
        self.mianjiBlock(@"+");
    }
    


}

- (IBAction)shichangjian:(id)sender {
    

    
    self.shiChangCount--;
    if (self.shiChangCount < 0) {
        self.shiChangCount = 0;
    }
 self.shiChangCountLabel.text = [NSString stringWithFormat:@"%d",self.shiChangCount];
    if (self.shichangBlock) {
        //将自己的值传出去，完成传值
        self.shichangBlock(@"-");
    }
}

- (IBAction)shichangjia:(id)sender {
    JZLog(@"时长+");
 
    
    self.shiChangCount++;
    self.shiChangCountLabel.text = [NSString stringWithFormat:@"%d",self.shiChangCount];
    if (self.shichangBlock) {
        //将自己的值传出去，完成传值
        self.shichangBlock(@"+");
    }
}

-(void)setMianJiCount:(int)mianJiCount{
    _mianJiCount = mianJiCount;
    self.mianJiCountLabel.text = [NSString stringWithFormat:@"%d",self.mianJiCount];
}

-(void)setShiChangCount:(int)shiChangCount{
    _shiChangCount = shiChangCount;
    self.shiChangCountLabel.text = [NSString stringWithFormat:@"%d",self.shiChangCount];
}

@end
