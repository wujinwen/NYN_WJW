//
//  FTEarthParameterViewController.m
//  FarmerTreasure
//
//  Created by 123 on 2017/4/25.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTEarthParameterViewController.h"

@interface FTEarthParameterViewController ()

@end

@implementation FTEarthParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor= [UIColor whiteColor];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5, SCREENWIDTH, JZHEIGHT(41))];
    
    
    [self.view addSubview:v];
    
    UILabel *titlelb = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), 0, JZWITH(150), JZHEIGHT(41))];
    titlelb.text= @"土地规格";
    titlelb.font = JZFont(12);
    titlelb.textColor = RGB104;
    [v addSubview:titlelb];
    
    UILabel *titlebn = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(210), 0, JZWITH(200), JZHEIGHT(41))];
    titlebn.text= @"1m*1m";
    titlebn.font = JZFont(12);
    titlebn.textColor = RGB104;
    [v addSubview:titlebn];
    
    
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0,titlelb.bottom +  0.5, SCREENWIDTH, JZHEIGHT(41))];
    
    UILabel *titlelb1 = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), 0, JZWITH(150), JZHEIGHT(41))];
    titlelb1.text= @"土质";
    titlelb1.font = JZFont(12);
    titlelb1.textColor = RGB104;
    [v1 addSubview:titlelb1];
    
    UILabel *titlebn1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(210), 0, JZWITH(200), JZHEIGHT(41))];
    titlebn1.text= @"肥沃";
    titlebn1.font = JZFont(12);
    titlebn1.textColor = RGB104;
    [v1 addSubview:titlebn1];
    
    
    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(0,v1.bottom + 0.5, SCREENWIDTH, JZHEIGHT(41))];
    
    UILabel *titlelb2 = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), 0, JZWITH(150), JZHEIGHT(41))];
    titlelb2.text= @"气候";
    titlelb2.font = JZFont(12);
    titlelb2.textColor = RGB104;
    [v2 addSubview:titlelb2];
    
    UILabel *titlebn2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(210), 0, JZWITH(200), JZHEIGHT(41))];
    titlebn2.text= @"湿润";
    titlebn2.font = JZFont(12);
    titlebn2.textColor = RGB104;
    [v2 addSubview:titlebn2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
