//
//  NYNSetLiveView.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNSetLiveView.h"
#import "Masonry.h"
#import "clarityView.h"
#import <UShareUI/UShareUI.h>

#import "BeautyView.h"
@interface NYNSetLiveView()<clarityViewDelagate>

@property(nonatomic,strong)UIButton * beautyBtn;
@property(nonatomic,strong)UIButton * imageBtn;

@property(nonatomic,strong)UISlider * beautySlider;

@property(nonatomic,strong)UIButton * styleButton;//横竖屏

@property(nonatomic,strong)UIButton * stopButton;//禁言列表
@property(nonatomic,strong)UIButton * shareButton;//分享





@end


@implementation NYNSetLiveView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}

-(void)initiaInterface{  UIColor * coclor = [UIColor blackColor];
    self.backgroundColor = [coclor colorWithAlphaComponent:0.5];
    
    CGFloat wight = 70;
    CGFloat height =90;
    //改了UI不想改属性名
//    _beautyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _beautyBtn.frame=CGRectMake(20, 40, wight, height);
//    [_beautyBtn setImage:[UIImage imageNamed:@"transverse"] forState:UIControlStateNormal];
//    _beautyBtn.imageEdgeInsets = UIEdgeInsetsMake(0,13,21,_beautyBtn.titleLabel.bounds.size.width);
//    [_beautyBtn setTitle:@"横竖屏" forState:UIControlStateNormal];
//    _beautyBtn.titleLabel.font=[UIFont systemFontOfSize:15];
//    _beautyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [_beautyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _beautyBtn.titleEdgeInsets = UIEdgeInsetsMake(71, -_beautyBtn.titleLabel.bounds.size.width-50, 0, 0);
//    [_beautyBtn addTarget:self action:@selector(beautyBtn :) forControlEvents:UIControlEventTouchUpInside];
    
//    [self addSubview:_beautyBtn];
    _beautyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _beautyBtn.frame=CGRectMake(20, 40, wight, height);
    [_beautyBtn setImage:[UIImage imageNamed:@"Beauty"] forState:UIControlStateNormal];
    _beautyBtn.imageEdgeInsets = UIEdgeInsetsMake(0,13,21,_beautyBtn.titleLabel.bounds.size.width);
    [_beautyBtn setTitle:@"美颜" forState:UIControlStateNormal];
    _beautyBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _beautyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_beautyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _beautyBtn.titleEdgeInsets = UIEdgeInsetsMake(71, -_beautyBtn.titleLabel.bounds.size.width-50, 0, 0);
    [_beautyBtn addTarget:self action:@selector(beautyBtn :) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_beautyBtn];
    
    
    
    
    
    
    _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageBtn.frame=CGRectMake(CGRectGetMaxX(_beautyBtn.frame), 40, wight, height);
    [_imageBtn setImage:[UIImage imageNamed:@"HD"] forState:UIControlStateNormal];
    _imageBtn.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,_imageBtn.titleLabel.bounds.size.width);
    [_imageBtn setTitle:@"清晰度" forState:UIControlStateNormal];
    _imageBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _imageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_imageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _imageBtn.titleEdgeInsets = UIEdgeInsetsMake(71, -_imageBtn.titleLabel.bounds.size.width-50, 0, 0);
    [_imageBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_imageBtn];
    
//    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _shareButton.frame=CGRectMake(CGRectGetMaxX(_imageBtn.frame), 40, wight, height);
//    [_shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//    _shareButton.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,_shareButton.titleLabel.bounds.size.width);
//    [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
//    _shareButton.titleLabel.font=[UIFont systemFontOfSize:15];
//    _shareButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _shareButton.titleEdgeInsets = UIEdgeInsetsMake(71, -_shareButton.titleLabel.bounds.size.width-50, 0, 0);
//    [_shareButton addTarget:self action:@selector(shareButtonclick:) forControlEvents:UIControlEventTouchUpInside];
//
//    [self addSubview:_shareButton];
    
//    _stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _stopButton.frame=CGRectMake(CGRectGetMaxX(_shareButton.frame), 40, wight, height);
//    [_stopButton setImage:[UIImage imageNamed:@"Microphone2"] forState:UIControlStateNormal];
//    _stopButton.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,_stopButton.titleLabel.bounds.size.width);
//    [_stopButton setTitle:@"禁言列表" forState:UIControlStateNormal];
//    _stopButton.titleLabel.font=[UIFont systemFontOfSize:15];
//    _stopButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [_stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _stopButton.titleEdgeInsets = UIEdgeInsetsMake(71, -_stopButton.titleLabel.bounds.size.width-50, 0, 0);
//    [_stopButton addTarget:self action:@selector(stopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_stopButton];
//
    
    
    
    
    
    UIButton * backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbtn setImage:[UIImage imageNamed:@"fork-@2x.png"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backBtn:)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backbtn];
    [backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.top.mas_offset(10);
        make.width.height.mas_offset(30);
        
    }];
    
    
    
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2, 10, 80, 40)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text =@"设置";
    titleLabel.font=[UIFont systemFontOfSize:18];
    [self addSubview:titleLabel];
    
  
    
    
    
}
//分享
-(void)shareButtonclick:(UIButton*)sender{
    //显示分享面板
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Qzone)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        messageObject.title = @"快来下载网农公社吧，哈哈哈哈";
        messageObject.text = @"快来下载网农公社吧，哈哈哈哈";
        
  
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];
        
    }];
    
}
//清晰度
-(void)imageBtnClick:(UIButton*)sender{
    self.hidden=YES;

    [self.delagate BDBtnClick:sender];

}
//标清
-(void)BDBtnClick:(UIButton *)sender{
    
    [self.delagate BDBtnClick:sender];
    
    
}

//禁言列表
-(void)stopButtonClick:(UIButton*)sender{
    
    [self.delagate stopSpeakBtnClick:sender];
}

//横竖屏转换
-(void)beautyBtn:(UIButton*)sender{
//    _beautyBtn.hidden=YES;
//    _imageBtn.hidden=YES;
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 80, 30)];
//    label.text = @"美颜";
//    label.textColor= [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:15];
//    [self addSubview:label];
//
//
//    _beautySlider = [[UISlider alloc]initWithFrame:CGRectMake(50, 50, 110, 20)];
//    [self addSubview:_beautySlider];
         self.hidden=YES;
    [self.delagate screenSwitch:sender];
    
//    BeautyView * beautyV = [[BeautyView alloc]init];
//    beautyV.delegate = self;
//    
//    //滤镜
//    //    self.yfSession.videoCamera =
//    [self addSubview:beautyV];
//    [beautyV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.mas_offset(0);
//        make.height.mas_offset(JZHEIGHT(300));
//    }];


   

    
}
//返回
-(void)backBtn:(UIButton*)sender{
    if (self.backClick) {
        self.backClick(sender);
    }
  
}






@end
