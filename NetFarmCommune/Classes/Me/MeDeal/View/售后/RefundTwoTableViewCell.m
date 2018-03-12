//
//  RefundTwoTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/2/5.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "RefundTwoTableViewCell.h"

@implementation RefundTwoTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiaInterce];
        
    }
    return self;
    
}
-(void)initiaInterce{
      [self.contentView addSubview:self.headLabel];
    [self.contentView addSubview:self.textView];
    [self addObserver];
    

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

/**
 *  加通知
 */
-(void)addObserver
{
    //开始编辑
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginediting:) name:UITextViewTextDidBeginEditingNotification object:self];
    //停止编辑
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endediting:) name:UITextViewTextDidEndEditingNotification object:self];
}
-(void)beginediting:(NSNotification *)notification
{
    _textView.text = nil;
    
}
-(void)endediting:(NSNotification *)notification
{
    NSLog(@"停止编辑");
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return false;
    }
    return true;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    self.refuseBlock(textView.text);
    
    
}



//开始编辑

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView

{
    
      _textView.text = nil;
  
    
    return YES;
    
}
//记得释放通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(UITextView *)textView{
    if (!_textView) {
        _textView =  [[UITextView alloc]initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 100)];
        _textView.textColor = Color686868;
        _textView.text=@"输入你的退货原因，200个字以内";
        _textView.keyboardType = UIReturnKeyDefault;
        _textView.delegate=self;
        
        
    }
    return _textView;
    
}

@end
