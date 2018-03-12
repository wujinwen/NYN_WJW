//
//  FTBuyNeedKnowViewController.m
//  FarmerTreasure
//
//  Created by 123 on 2017/4/25.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTBuyNeedKnowViewController.h"

@interface FTBuyNeedKnowViewController ()

@end

@implementation FTBuyNeedKnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor= [UIColor whiteColor];
    
    NSString *textss = @"dsadasdasdsadas/n dsadasdasdsadasdsadasdasdsadasdsadasdasdsadasdsadasdasdsadasdsadasdasdsadasdsadasdasdsadas";
    
    UILabel *textlb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(202))];
    textlb.text = textss;
    textlb.font = JZFont(12);
    textlb.textColor = RGB104;
    [self.view addSubview:textlb];
    
    textlb.backgroundColor = [UIColor whiteColor];
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
