//
//  ShopCartViewController.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "ShopCartViewController.h"
#import "ShopCartTableViewCell.h"

#import "LiveMessegeBoomVIew.h"
#import "ShopCartModel.h"
#import "NYNGouMaiView.h"
#import "CarBuyViewController.h"
#import "NYNMeAdressViewController.h"
#import "ShopCartHeadTableViewCell.h"
@interface ShopCartViewController ()<UITableViewDelegate,UITableViewDataSource,ShopCartTableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;
//专装选中的数组
@property(nonatomic,strong)NSMutableArray *selectArray;

@property(nonatomic,strong)NYNGouMaiView *bottomView;

@property(nonatomic,strong)NSMutableArray *dealArray;//存放选择的model






@end

@implementation ShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];

    _dealArray = [[NSMutableArray alloc]init];
    
    self.title = @"购物车";
    [self.view addSubview:self.tableView];
    [self chaxunShopCart];
    [self.view addSubview:self.bottomView];

    
    
 
        __weak typeof(self)weakSelf = self;
    self.bottomView.goumaiBlock = ^(NSString *strValue) {
        //购物车下单
        CarBuyViewController * carbuyVc = [[CarBuyViewController alloc]init];
        carbuyVc.dataArray  =weakSelf.selectArray;
        
        [weakSelf.navigationController pushViewController:carbuyVc animated:YES];
        };
    
}


#pragma mark--ShopCartTableViewDelegate

//删除订单
-(void)garbageProductId:(NSString*)productId productType:(NSString*)productType{
    

    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"确定删除吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //TODO:
    }];
    [sheet addAction:cancelAction];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self showLoadingView:@""];

        NSDictionary * dic = @{@"productId":productId,@"productType":productType};
        [NYNNetTool DeleteCartParams:dic isTestLogin:YES progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            
            if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
//                [self.dataArray removeObject:model];
                //
                //                //                    NSIndexPath *ip = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                //                //                    [self.meZhongZhiTable deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationFade];
         //   [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
                
                
            }else{
                [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
            }
            [self hideLoadingView];
        } failure:^(NSError *failure) {
            [self hideLoadingView];
            
            
        }];
    }];
    [sheet addAction:confirmAction];
    
    [self presentViewController:sheet animated:YES completion:^{
 
    }];

}


//查询购物车
-(void)chaxunShopCart{

    NSDictionary * dic = @{};
    [NYNNetTool CartQueryWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
        
            _dataArray = [ShopCartModel mj_objectArrayWithKeyValuesArray:success[@"data"]];
            NSMutableArray * allArr = [NSMutableArray array];
            NSMutableArray * idArr = [NSMutableArray array];
            
            for (int i = 0; i < _dataArray.count; i ++) {
                NSString * farmId = [_dataArray[i] farmId];
                if ([idArr containsObject:farmId]) {
                    NSMutableArray * temp = allArr[[idArr indexOfObject:farmId]];
                    [temp addObject:_dataArray[i]];
                }else {
                    NSMutableArray * newArr = [NSMutableArray array];
                    [newArr addObject:_dataArray[i]];
                    [allArr addObject:newArr];
                    [idArr addObject:farmId];
                }
            }
            _dataArray = allArr;
            [self.tableView reloadData];
            
            _selectArray = [NSMutableArray array];
            for (int i = 0 ; i < _dataArray.count; i ++) {
                [_selectArray addObject:[NSMutableArray array]];
            }
            
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
        
        
    }];
}



#pragma mark--UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArray[section]count]+1;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==0) {
        ShopCartHeadTableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell ==nil) {
            cell=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShopCartHeadTableViewCell class]) owner:self options:nil].firstObject;
            
            
        }
        
        cell.section = indexPath.section;
           cell.model=_dataArray[indexPath.section][indexPath.row];
        
        if ([_selectArray[indexPath.section] isEqualToArray:_dataArray[indexPath.section]]) {
            [cell setCellSelect:YES];
        }else {
            [cell setCellSelect:NO];
        }
        
        cell.FarmTitleBlock = ^(BOOL choose, NSInteger section) {
            if (choose) {
                if (![_selectArray[section] isEqualToArray:_dataArray[section]]) {
                    [_selectArray[section] removeAllObjects];
                    [_selectArray[section] addObjectsFromArray:_dataArray[section]];
                    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
                }
            }else {
                [_selectArray[section] removeAllObjects];
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
            }
        };
        
        return cell;
    }else{
        ShopCartTableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell ==nil) {
            cell=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShopCartTableViewCell class]) owner:self options:nil].firstObject;
            
            
        }
        cell.section = indexPath.section;
        cell.row = indexPath.row-1;
        cell.model=_dataArray[indexPath.section][indexPath.row-1];
        if ([_selectArray[indexPath.section] containsObject:_dataArray[indexPath.section][indexPath.row-1]]) {
            [cell setCellSelect:YES];
        }else {
            [cell setCellSelect:NO];
        }
        cell.block = ^(BOOL choose, NSInteger section, NSInteger row) {
            if (choose) {
                if (![_selectArray[section] containsObject:_dataArray[section][row]]) {
                    [_selectArray[section] addObject:_dataArray[section][row]];
                    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
                }
            }else {
                if ([_selectArray[section] containsObject:_dataArray[section][row]]) {
                    [_selectArray[section] removeObject:_dataArray[section][row]];
                    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
                }
            }
        };
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
    
   
    
}
//删除cell某一行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle)
    {
//        [self.dataArray removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }else{
        return 120;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 8)];
    view.backgroundColor = Colorededed;
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
    
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-JZHEIGHT(45)) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView =[[UIView alloc]init];
        _tableView.rowHeight=175;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;

    }
    return _tableView;
}
-(NYNGouMaiView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NYNGouMaiView alloc]init];
        [_bottomView ConfigDataWithIndex:1 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45)-62, SCREENWIDTH, JZHEIGHT(45))];
        [_bottomView.goumaiBT setTitle:@"付款" forState:UIControlStateNormal];
        
        
    }
    return _bottomView;
    
    
}

@end
