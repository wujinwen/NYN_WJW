//
//  FarmAuctionViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/24.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "FarmAuctionViewController.h"
#import <RongIMLib/RongIMLib.h>
#import <objc/runtime.h>
#import "Masonry.h"
#import "AuctionTableViewCell.h"

#import "NYNAuctionModel.h"
//拍卖界面
@interface FarmAuctionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat rowHeight;
    BOOL isDisplay;//显示
}

@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)NSMutableArray * allArray;

@property(nonatomic,strong)NSString * countString;



@end

@implementation FarmAuctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableview];
    
 
  
}

-(void)getDataFarmIDString:(NSString *)str{
    
    rowHeight = 120;
    
      [self.view addSubview:self.tableview];
    _allArray=[[NSMutableArray alloc]init];
    NSDictionary * dic = @{@"farmId":str,@"pageNo":@"1",@"pageSize":@"10"};

     [NYNNetTool QuerySaleParams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {

            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNAuctionModel *model = [NYNAuctionModel mj_objectWithKeyValues:dic];
                [self.allArray addObject:model];
                
                
            }
            [self.tableview reloadData];


        }else{

        }
    } failure:^(NSError *failure) {
        
    }];
    
}




#pragma mark--UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _allArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AuctionTableViewCell * liveVCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (liveVCell == nil) {
        liveVCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AuctionTableViewCell class]) owner:self options:nil].firstObject;
    }
    liveVCell.index = indexPath.row;
    
    liveVCell.auctionMoedel = _allArray[indexPath.row];
 
    
    liveVCell.offerBlock = ^(NSInteger selectInteger) {
        if (selectInteger < 1) {
            _countString=[NSString stringWithFormat:@"%d",1];
           
        }else{
            _countString=[NSString stringWithFormat:@"%ld",(long)selectInteger];
            
        }
        
    };
     liveVCell.countLabel.text =_countString;
    
    liveVCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return liveVCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    isDisplay = YES;//判断是否显示描述界面
//    //刷新点击cell
//    NSIndexPath * indexpath1 = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
//    rowHeight = 200;
//    [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexpath1,nil] withRowAnimation:UITableViewRowAnimationNone];
//
//    //获取点击cell
////    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       return 300;
   // return rowHeight;
    
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT/2) style:UITableViewStylePlain];
        _tableview.delegate  =self;
        _tableview.dataSource  =self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.rowHeight=JZHEIGHT(304);
        _tableview.separatorStyle =UITableViewCellSeparatorStyleNone;
        

    }
    return _tableview;
    
}


@end
