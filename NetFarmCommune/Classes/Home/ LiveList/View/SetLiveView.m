//
//  SetLiveView.m
//  NetFarmCommune
//
//  Created by manager on 2017/9/30.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "SetLiveView.h"

@interface SetLiveView()

@property (weak, nonatomic) IBOutlet UIButton *qqButton;

@property (weak, nonatomic) IBOutlet UIButton *startLiveBtn;

@end


@implementation SetLiveView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
}

//美颜
- (IBAction)meiyanButton:(UIButton *)sender {
    
    
}
//直播模式
- (IBAction)liveModel:(UIButton *)sender {
}
//开始直播
- (IBAction)startlive:(UIButton *)sender {
}

@end
