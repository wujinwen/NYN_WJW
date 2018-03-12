//
//  NewFrendTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NewFrendTableViewCell.h"

@implementation NewFrendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrinedModel:(NewFriendModel *)frinedModel{
    _frinedModel = frinedModel;

    
    self.nameLabel.text = [frinedModel.fromUser valueForKey:@"name"];
    
    

    
//    if ([frinedModel.fromUser valueForKey:@"age"] !=nil) {
//          self.agelabel.text =[frinedModel.fromUser valueForKey:@"age"];
//    }
    
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[frinedModel.fromUser valueForKey:@"avatar"]] placeholderImage:PlaceImage];
    if ([frinedModel.status isEqualToString:@"pendingHandle"]) {
        //待处理
        _stateBtn.hidden=YES;
        if ([frinedModel.fromUserId isEqual:[frinedModel.fromUser valueForKey:@"id" ]]) {
            _refusedBtn.hidden = YES;
            _agereeBtn.hidden = YES;
            
            
        }else{
            _refusedBtn.hidden = NO;
            _agereeBtn.hidden = NO;
        }
        
        
    }else if ([frinedModel.status isEqualToString:@"agree"]){
        //已同意
        [_stateBtn setTitle:@"已同意" forState:UIControlStateNormal];
        
        
    }else if ([frinedModel.status isEqualToString:@"refused"]){
        //已拒绝
         [_stateBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
        
    }else{
        //已忽略
         [_stateBtn setTitle:@"已忽略" forState:UIControlStateNormal];
    }
}
//拒绝
- (IBAction)refusedBtn:(UIButton *)sender {
  //  [self.delegate friendAgreeRequse:sender userId: _frinedModel.toUserId];
}
//同意
- (IBAction)agreeBtn:(UIButton *)sender {
  //  [self.delegate friendAgreeRequse:sender userId: _frinedModel.toUserId];
}

@end
