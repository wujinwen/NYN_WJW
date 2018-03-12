//
//  NYNZuDiZhongZhiTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNZuDiZhongZhiTableViewCell.h"

@implementation NYNZuDiZhongZhiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.whoTF.layer.cornerRadius= 5;
    self.whoTF.layer.masksToBounds = YES;
    self.whoTF.layer.borderColor = Color90b659.CGColor;
    self.whoTF.layer.borderWidth = .5;
    self.whoTF.returnKeyType = UIReturnKeyDone;
    
    
    self.ZhiWuTF.layer.cornerRadius= 5;
    self.ZhiWuTF.layer.masksToBounds = YES;
    self.ZhiWuTF.layer.borderColor = Color90b659.CGColor;
    self.ZhiWuTF.layer.borderWidth = .5;
    self.ZhiWuTF.delegate =self;
    self.ZhiWuTF.returnKeyType = UIReturnKeyDone;
    
    self.forWhoTF.layer.cornerRadius= 5;
    self.forWhoTF.layer.masksToBounds = YES;
    self.forWhoTF.layer.borderColor = Color90b659.CGColor;
    self.forWhoTF.layer.borderWidth = .5;
    
    self.forWhoTF.returnKeyType = UIReturnKeyDone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    
    return YES;
}




@end
