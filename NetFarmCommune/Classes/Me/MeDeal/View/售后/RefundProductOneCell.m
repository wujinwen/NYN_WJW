//
//  RefundProductOneCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/2/5.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "RefundProductOneCell.h"
#import "DMDropDownMenu.h"
@interface RefundProductOneCell()<DMDropDownMenuDelegate,UITextFieldDelegate>

@end

@implementation RefundProductOneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}

//-(void)beginediting:(NSNotification *)notification
//{
//   _nameTextF
//}

//记得释放通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)initiaInterface{
    
    [self.contentView addSubview:self.nameTextF];
    [self.contentView addSubview:self.headLabel];
//    _dmArray2 = [NSArray arrayWithObjects:@"今晚与你记住蒲公英今晚与你记住蒲公英今晚与你记住蒲公英",@"今晚偏偏想起风的清劲",@"今晚偏偏想起风的清劲",@"回忆不在受制于我 我承认",@"回忆也许是你的", nil];
   
}


-(void)setDmArray2:(NSArray *)dmArray2{
    _dmArray2 = dmArray2;
    _dm2 = [[DMDropDownMenu alloc] initWithFrame:CGRectMake(0, 40,  SCREENWIDTH, 40)];
    _dm2.delegate = self;
    [_dm2 setListArray:_dmArray2];
    [self.contentView addSubview:_dm2];
}

-(UITextField *)nameTextF{
    if (!_nameTextF) {
        _nameTextF = [[UITextField alloc]initWithFrame:CGRectMake(0, 40, SCREENWIDTH-50, 40)];
        _nameTextF.font = [UIFont systemFontOfSize:14.0f];
        _nameTextF.textColor = [UIColor blackColor];
        _nameTextF.placeholder = @"退款金额";
        _nameTextF.keyboardType = UIReturnKeyDefault;
        _nameTextF.delegate=self;
        
        [_nameTextF addTarget:self action:@selector(nameTextFClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _nameTextF;
    
}
-(UILabel *)headLabel{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
        _headLabel.textColor = [UIColor blackColor];
        _headLabel.backgroundColor =  Colorededed;
        _headLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _headLabel;
    
}

-(void)nameTextFClick:(UIButton*)sender{
    
    [self.delaget selectIndexpath:_indexPath];

    
    
}
- (void)selectIndex:(NSInteger)index AtDMDropDownMenu:(DMDropDownMenu *)dmDropDownMenu
{
    NSLog(@"dropDownMenu:%@ index:%ld",dmDropDownMenu,(long)index);
    if (self.selectBlock) {
        self.selectBlock(index,_indexPath);
        
    }
    
}

-(void)menuWillChange:(BOOL)isopen height:(CGFloat)height {
    if ([_delaget respondsToSelector:@selector(cellWillChange:height:index:)]) {
        [_delaget cellWillChange:isopen height:height index:self.indexPath];
    }
}
//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.moneyBlock) {
        self.moneyBlock(textField.text);
        
    }
    
}
@end

