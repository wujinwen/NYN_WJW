//
//  PinJiaViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "PinJiaViewController.h"
#import "StartView.h"

@interface PinJiaViewController ()

@property(nonatomic,strong)UITextView * textView;




@end

@implementation PinJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    
    StartView * startView= [[StartView alloc]initWithFrame:CGRectMake(40, 20, 200, 50) EmptyImage:@"farm_icon_grade2" StarImage:@"farm_icon_grade1"];
    [self.view addSubview:startView];
    
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 70, SCREENWIDTH, JZHEIGHT(150))];
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.text = @"请输入你的看法";
    [self.view addSubview:self.textView];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
