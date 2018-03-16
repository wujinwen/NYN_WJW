//
//  NYNPlayDeController.m
//  NetFarmCommune
//
//  Created by manager on 2018/3/15.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNPlayDeController.h"

@interface NYNPlayDeController ()

@end

@implementation NYNPlayDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    NSDictionary * locDic = JZFetchMyDefault(SET_Location);
    NSString *lat = locDic[@"lat"] ?: @"";
    NSString *lon =locDic[@"lon"] ?: @"";
    
    [NYNNetTool MatchDeId:self.ID Params:@{@"longitude":lon,@"latitude":lat} isTestLogin:NO progress:^(NSProgress *Progress) {
        
    } success:^(id success) {
        JZLog(@"%@", success);
    } failure:^(NSError *failure) {
        
    }];
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
