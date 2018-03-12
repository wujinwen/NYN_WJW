//
//  NYNLeadingViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNLeadingViewController.h"
#import "FTTabarViewController.h"
#import "AppDelegate.h"

@interface NYNLeadingViewController ()
@property (nonatomic,strong) NSArray *arr;
@end

@implementation NYNLeadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //这个接口有版本号和版本更新地址
    [NYNNetTool GetYinDaoTuWithparams:nil isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            self.arr = [NSArray arrayWithArray:success[@"data"][@"imgs"]];
            
            UIScrollView *scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
            [self.view addSubview:scro];
            scro.contentSize = CGSizeMake(SCREENWIDTH * self.arr.count, 0);
            scro.showsVerticalScrollIndicator = NO;
            scro.showsHorizontalScrollIndicator = NO;
            scro.scrollEnabled = YES;
            scro.bounces = NO;
            scro.pagingEnabled = YES;
            for (int i = 0 ; i < self.arr.count; i++) {
                UIImageView *yinDaoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT)];
                NSDictionary *dic = self.arr[i];
                [yinDaoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"imgUrl"]]] placeholderImage:nil];
                
                if (i == (self.arr.count - 1)) {
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gogo)];
                    [yinDaoImageView addGestureRecognizer:tap];
                    yinDaoImageView.userInteractionEnabled = YES;
                }
                [scro addSubview:yinDaoImageView];
            }
        }else{
            if (self.Go) {
                self.Go(@"");
            }
            
        }
        
    } failure:^(NSError *failure) {
        if (self.Go) {
            self.Go(@"");
        }
    }];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 
}

- (void)gogo{
    if (self.Go) {
        self.Go(@"");
    }
}
//FTTabarViewController *tabar = [[FTTabarViewController alloc]init];
//tabar.delegate = self;

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-(NSArray *)arr{
//    if (!_arr) {
//        _arr = [[NSArray alloc]init];
//    }
//    return  _arr;
//}
@end
