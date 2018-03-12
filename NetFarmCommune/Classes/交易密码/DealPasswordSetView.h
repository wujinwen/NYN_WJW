//
//  DealPasswordSetView.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/12.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DealPasswordSetViewDelagate<NSObject>

-(void)SetTextFieldString:(NSString*)textField;


-(void)setGetPassword:(UIButton*)sender;


//删除按钮
-(void)deleteBtnClick:(UIButton*)sender;

//修改交易密码
-(void)amendBtnClick:(UIButton*)sender;



@end




@interface DealPasswordSetView : UIView

-(void)setTitleNameStr:(NSString *)nameLabel isBool:(int)isBool;
/**
 清除并重置输入框
 */
- (void)clear;

@property(assign,nonatomic)id<DealPasswordSetViewDelagate> delegate;

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UITextField * textField;


@property(nonatomic,strong) UIButton*forgetBtn;
@property(nonatomic,strong) UIButton * amendBtn;

@end
