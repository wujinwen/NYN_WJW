//
//  NYNPushSrteamViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/9/25.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNPushSrteamViewController.h"
#import "NYNPushStreamModel.h"
#import "SetLiveView.h"


@interface NYNPushSrteamViewController ()

@property(nonatomic,strong)SetLiveView * setliveV;//预览设置view

/**
 *  返回按钮
 */
@property (nonatomic, strong) UIButton *backBtn;



@end

@implementation NYNPushSrteamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatRoom];
    [self initSetLiveView];
    
}
-(void)initSetLiveView{
//    _setliveV = [[SetLiveView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT/2, SCREENWIDTH, SCREENHEIGHT/2)];
    [self.view addSubview:_setliveV];
    
    
}

-(void)initializeSubViews{
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(10, 35, 72, 25);
    UIImageView *backImg = [[UIImageView alloc]
                            initWithImage:[UIImage imageNamed:@"navi_back.png"]];
    backImg.frame = CGRectMake(0, 0, 25, 25);
    [_backBtn addSubview:backImg];
    [_backBtn addTarget:self
                 action:@selector(leftBarButtonItemPressed:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
}
/**
 *  点击返回的时候消耗播放器和退出聊天室
 *
 *  @param sender sender description
 */
- (void)leftBarButtonItemPressed:(id)sender {
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"退出聊天室？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertview show];
}




-(void)creatRoom{
    //创建直播间http://192.168.9.200/l//live/create
    NSDictionary *ns = @{@"title":@"爸爸的直播间",@"pimg":@"https://baike.baidu.com/pic/苍井空/9776304/0/ac4bd11373f08202e9cc9e3949fbfbedab641b5d?fr=lemma&ct=single#aid=0&pic=ac4bd11373f08202e9cc9e3949fbfbedab641b5d",@"intro":@"爸爸的直播间",@"type":@"live"};
    [NYNNetTool CreateLivePushWithparams:ns isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
   
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            NSDictionary *dic = @{@"status":@"ONLINE",@"fansCount":@"0"};
            //切换直播状态到成功
            [NYNNetTool SwitchStatusWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                NSLog(@"开启成功");
            } failure:^(NSError *failure) {
                NSLog(@"");
                
            }];
            
            
        }else{
            
        }
        NSLog(@"");
    } failure:^(NSError *failure) {
        NSLog(@"");
    }];
}

//调整美颜程度0~1

- (void)alivcLiveVideoChangeSkinValue:(CGFloat)value{
    
}










@end
