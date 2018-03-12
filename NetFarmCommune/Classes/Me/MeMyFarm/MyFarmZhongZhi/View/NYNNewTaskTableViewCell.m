//
//  NYNNewTaskTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/23.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNNewTaskTableViewCell.h"

@implementation NYNNewTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(NYNMyFarmTaskHistoryModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    
    
    NSString *str1 = model.artProductName;
    NSString *str2 = [NSString stringWithFormat:@"¥%@元",model.artProductPrice];
    NSString *str3 = @"/㎡";
    
    NSMutableAttributedString *monstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@%@",str1,str2,str3]];
    
    [monstr addAttribute:NSForegroundColorAttributeName value:Color7b7b7b range:NSMakeRange(0, str1.length)];
    [monstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, str1.length)];
    
    [monstr addAttribute:NSForegroundColorAttributeName value:Colorf8491a range:NSMakeRange(str1.length, str2.length)];
    [monstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(str1.length, str2.length)];
    
    [monstr addAttribute:NSForegroundColorAttributeName value:Color888888 range:NSMakeRange(str1.length + str2.length, str3.length)];
    [monstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(str1.length + str2.length, str3.length)];
    
    self.priceLabel.attributedText = monstr;
    
    self.fabuLabel.text = [NSString stringWithFormat:@"发布日期:%@",[MyControl timeWithTimeIntervalString:model.completeExecuteDate]];
    
    self.shifeiLabel.text = [NSString stringWithFormat:@"施肥日期:%@",[MyControl timeWithTimeIntervalString:model.createDate]];
}
@end
