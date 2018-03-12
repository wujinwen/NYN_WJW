//
//  MyMovieViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "MyMovieViewController.h"
#import "MyLiveOneTVCell.h"

#import "MyLiveTwoTVCell.h"

#import "NYNNetTool.h"
#import "MyMovieListModel.h"
#import "MyLiveTwoTabCell.h"

@interface MyMovieViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    MyMovieListModel *_model;
}

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * allArray;
@property(nonatomic,strong)NSMutableArray * giftArray;



@end

@implementation MyMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _allArray =[NSMutableArray array];
    _giftArray = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    
    
    NSDictionary *dic = @{@"pageNo":@"1",@"pageSize":@"10"};
    
    [NYNNetTool GetMyLiveInfoWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            NSDictionary *dic = success[@"data"];
               _model = [MyMovieListModel mj_objectWithKeyValues:dic];
//                [_allArray addObject:model];
//               [_giftArray addObject:model.liveHistory];
            
            
            [self.tableView reloadData];
        }else{
            
        }
        
    } failure:^(NSError *failure) {
        NSLog(@"");
    }];
    
}



#pragma mark--UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
             return 1;

    }else{
            return _model.liveHistory.count;
    }
    return 0;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MyLiveOneTVCell *liveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (liveTableViewCell == nil) {
            liveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MyLiveOneTVCell class]) owner:self options:nil].firstObject;
        }
        if (_model) {
            liveTableViewCell.movieModel = _model;

        }
        
        return liveTableViewCell;
        
        
    }else{
        MyLiveTwoTabCell *twoTVCell = [tableView dequeueReusableCellWithIdentifier:@"MyLiveTwoTabCell"];
        if (twoTVCell == nil) {
            twoTVCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MyLiveTwoTabCell class]) owner:self options:nil].firstObject;
        }
        
        twoTVCell.dic = _model.liveHistory[indexPath.row];

        return twoTVCell;
    }
    return nil;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 250;
        
    }
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-60) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        
        
    }
    return _tableView;
    
}

@end
