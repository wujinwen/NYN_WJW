//
//  NYNInfoView.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNInfoView.h"
#import <Masonry/Masonry.h>

@interface NYNInfoView()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;//头像

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//姓名

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;//年龄

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;//地区

@property (weak, nonatomic) IBOutlet UIButton *addFriendBtn;//加为好友

@property (weak, nonatomic) IBOutlet UIButton *stopSpeakBtn;//禁言


@end

@implementation NYNInfoView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initiaInterface];
        self.layer.cornerRadius = 15;
        self.clipsToBounds=YES;
        
        
    }
    return self;
    
}


-(void)awakeFromNib{
    [super awakeFromNib];
    UIColor * color = [UIColor blackColor];
    self.backgroundColor = [color colorWithAlphaComponent:0.5];
    _userArray = [[NSArray alloc]init];
    
    
}


//主页
- (IBAction)homePageClick:(UIButton *)sender {
}
//禁言
- (IBAction)stopSpeakClick:(UIButton *)sender {
    
    NSDictionary * ns = @{@"chatroomId":_liveID,@"userId":@"200",@"minute":@"60"};
    [NYNNetTool GetgagInfoWithparams: ns isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
         
            
        }else if ([NSString stringWithFormat:@"%@",success[@"401"]]){
            
        }
    } failure:^(NSError *failure){
        
        
    }];
    
    
}

//连麦
- (IBAction)lianmaiBtn:(UIButton *)sender {
}
//加好友
- (IBAction)addFriendClick:(UIButton *)sender {
    
}

-(void)initiaInterface{
    self.backgroundColor = [UIColor whiteColor];
    

    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
    
}

@end
