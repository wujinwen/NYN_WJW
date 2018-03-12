//
//  ForgetPasswordView.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/12.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ForgetPasswordViewDelagate<NSObject>



-(void)GetyanzhengmaClick:(NSString*)phoneStr;
//提交
-(void)GetphoneNumber:(NSString*)phoneStr yanzhengmaStr:(NSString*)yanzhengmaStr;


//删除按钮
-(void)deletButton:(UIButton*)sender;



@end



@interface ForgetPasswordView : UIView


@property(assign,nonatomic)id<ForgetPasswordViewDelagate> delegate;

@property(nonatomic,strong)UILabel * titleLabel;

@property(nonatomic,strong)UITextField * phonetextField;

@property(nonatomic,strong)UITextField * yantextField;

@property(nonatomic,strong)UIButton * yanzhengBtn;

@property(nonatomic,strong)UIButton * tijiaoBtn;

@end
