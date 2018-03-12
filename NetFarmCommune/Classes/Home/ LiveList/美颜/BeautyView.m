//
//  BeautyView.m
//  NetFarmCommune
//
//  Created by manager on 2017/9/30.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BeautyView.h"
#import <Masonry/Masonry.h>

@interface BeautyView()

@property(nonatomic,strong)UISlider * beautySlider;



@end



@implementation BeautyView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initiaUI];
        UIColor * color = [UIColor blackColor];
        self.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        
    }
    return self;
    
}

-(void)initiaUI{
    
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 80, 30)];
        label.text = @"美颜";
        label.textColor= [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
    
    _beautySlider = [[UISlider alloc]initWithFrame:CGRectMake(20, 90, SCREENWIDTH-60, 40)];
    [_beautySlider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_beautySlider];
    
    
        UIButton * backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backbtn setImage:[UIImage imageNamed:@"fork-@2x.png"] forState:UIControlStateNormal];
        [backbtn addTarget:self action:@selector(backBtn:)forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backbtn];
        [backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.top.mas_offset(10);
            make.width.height.mas_offset(30);
    
        }];
    
    UIScrollView * scrollerView = [[UIScrollView alloc]init];
    scrollerView.frame = CGRectMake(0,  CGRectGetMaxY(_beautySlider.frame), SCREENWIDTH, 100);
    
    
   
//    NSArray * arr = [NSArray arrayWithObjects:@"哈哈镜",@"漩涡 ",@"漫画效果",@"鱼 眼 ",@"浮雕 ",@"晕影",@"水晶球", nil];
//    for (int i = 0; i< 7; i++) {
//        UIButton * beautyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        beautyBtn.frame = CGRectMake(10+(i*80)+(i*10), CGRectGetMaxY(_beautySlider.frame)+10, 80, 80);
//
//        beautyBtn.layer.cornerRadius=80/2;
//        beautyBtn.clipsToBounds=YES;
//        beautyBtn.tag =300+i;
//        [beautyBtn setTitle:arr[i] forState:UIControlStateNormal];
//
////        [beautyBtn setImage:[UIImage imageNamed:@"占位图"] forState:UIControlStateNormal];
//        [beautyBtn addTarget:self action:@selector(beautyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//
//
//        [self addSubview:beautyBtn];
//    }
  
    
}
-(void)sliderChange:(UISlider*)slider{
    
}

-(void)beautyBtnClick:(UIButton*)sender{
    [self.delegate beautyButtonClick:sender.tag];
    
}

-(void)backBtn:(UIButton*)sender{
    self.hidden = YES;
    
}

/*
 
 typedef enum {
 YFINSTCamera_NORMAL_FILTER = 0,
 //原图
 YFINSTCamera_AMARO_FILTER,
 //经典
 YFINSTCamera_RISE_FILTER,
 //彩虹瀑
 YFINSTCamera_HUDSON_FILTER,
 //云端
 YFINSTCamera_XPROII_FILTER,
 //淡雅
 YFINSTCamera_SIERRA_FILTER,
 //古铜色
 YFINSTCamera_LOMOFI_FILTER,
 //黑白
 YFINSTCamera_EARLYBIRD_FILTER,
 //哥特风
 YFINSTCamera_SUTRO_FILTER,
 //移轴
 YFINSTCamera_TOASTER_FILTER,
 //TEST1
 YFINSTCamera_BRANNAN_FILTER,
 //TEST2
 YFINSTCamera_INKWELL_FILTER,
 //一九OO
 YFINSTCamera_WALDEN_FILTER,
 //候鸟
 YFINSTCamera_HEFE_FILTER,
 //TEST3
 YFINSTCamera_VALENCIA_FILTER,
 //复古
 YFINSTCamera_NASHVILLE_FILTER,
 //碧波
 YFINSTCamera_1977_FILTER,
 //粉红佳人
 YFINSTCamera_LORDKELVIN_FILTER,
 //上野
 
 
 */
@end
