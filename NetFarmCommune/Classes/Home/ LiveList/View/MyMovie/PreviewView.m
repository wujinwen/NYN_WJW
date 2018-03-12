//
//  PreviewView.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "PreviewView.h"


#import <UShareUI/UShareUI.h>

@interface PreviewView()

@property(nonatomic,strong)UIButton * beautyBtn;
@property(nonatomic,strong)UIButton * modelBtn;

@property(nonatomic,strong)UILabel * lineLabel;




@end

@implementation PreviewView


-(instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}


-(void)initiaInterface{
    UIColor * coclor = [UIColor blackColor];
    self.backgroundColor = [coclor colorWithAlphaComponent:0.2];
    
    
    UILabel * shareLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 90, 30)];
    shareLabel.text = @"开播分享到:";
    shareLabel.textColor = [UIColor whiteColor];
    shareLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:shareLabel];
    
    
    NSArray * arr= [NSArray arrayWithObjects:@"QQ",@"weibo",@"-friends",@"WeChat", nil];
    for (int i = 0; i<4; i++) {
        CGFloat x = CGRectGetMaxX(shareLabel.frame);
        CGFloat w  =35;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(x+10+(i*w)+5*i, 10, w, 35);
        btn.tag = 300+i;
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    
    UILabel *  protocolLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(shareLabel.frame)+15, 80, 30)];
    protocolLabel.font = [UIFont systemFontOfSize:10];
    protocolLabel.textColor = [UIColor whiteColor];
    protocolLabel.text = @"开播即默认同意";
    [self addSubview:protocolLabel];
    
    
    UIButton * protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    protocolBtn.frame = CGRectMake(CGRectGetMaxX(protocolLabel.frame), CGRectGetMaxY(shareLabel.frame)+15, 120, 30);
    [protocolBtn setTitle:@"《网农公社管理条例》" forState:UIControlStateNormal];
    protocolBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [protocolBtn setTitleColor:[UIColor colorWithRed:156 green:199 blue:93 alpha:1] forState:UIControlStateNormal];
    [self addSubview:protocolBtn];
    
    
    UIButton * startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame =CGRectMake(SCREENWIDTH-120, 50, 100, 50);
    startButton.backgroundColor = Color90b659;
     [startButton setTitle:@"开始直播" forState:UIControlStateNormal];
    startButton.layer.cornerRadius =15;
    startButton.clipsToBounds= YES;
    [startButton addTarget:self action:@selector(startButton:) forControlEvents:UIControlEventTouchUpInside];
     [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:startButton];
    
}

-(void)shareBtnClick:(UIButton*)sender{
    
    for (int i = 0; i<4; i++) {
        UIButton * btn = (UIButton*)[self viewWithTag:i+300];
        if (btn.tag ==sender.tag) {
     
            
//            switch (btn.tag) {
//                case 300:{
//                    [btn setImage:[UIImage imageNamed:@"login_icon_qq"] forState:UIControlStateNormal];
//                }
//                    break;
//                case 301:{
//                     [btn setImage:[UIImage imageNamed:@"login_icon_weibo"] forState:UIControlStateNormal];
//                }
//                case 303:{
//                     [btn setImage:[UIImage imageNamed:@"login_icon_weixin"] forState:UIControlStateNormal];
//                }
//                case 302:{
//                    [btn setImage:[UIImage imageNamed:@"login_icon_weixin"] forState:UIControlStateNormal];
//                }
//
//                default:
//                    break;
//            }
            
        }else{
            
        }
    }

    

 
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    //设置缩略图的图片链接
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        UMSocialLogInfo(@"error is %@",error);

//        [self alertWithError:error];
    }];
}

-(void)startButton:(UIButton*)sender{
    if (self.startClick) {
        self.startClick(sender);
    }
}

@end
