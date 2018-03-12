//
//  CarBuyViewController.m
//  NetFarmCommune
//
//  Created by manager on 2018/2/6.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "CarBuyViewController.h"
#import "GoumaiOneTableViewCell.h"
#import "GoumaiTwoTableViewCell.h"
#import "NYNMeAdressViewController.h"
#import "PayTotalTableViewCell.h"
#import "NYNMeAddressModel.h"
#import <Masonry/Masonry.h>
#import "NYNPayViewController.h"
#import "FreightModel.h"
@interface CarBuyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSString * addresID;

@property(nonatomic,strong)NYNMeAddressModel *model;

@property(nonatomic,strong)UIButton * dealButton;

@property(nonatomic,strong)NSMutableArray * freightArray;

@property(nonatomic,assign)float  freightString;
@property(nonatomic,assign)float  totalPrice;
@end

@implementation CarBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _freightArray = [[NSMutableArray alloc]init];
    
    [self.view addSubview:self.tableView];
    [self getDefaultAddress];
    [self.view addSubview:self.dealButton];
   
    
    
    [self.dealButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(45);
        
        
    }];
    
    
}
//获取用户默认地址
-(void)getDefaultAddress{
    
    NSDictionary * dic = @{};
    
    [NYNNetTool DefaultqueryWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
           _model = [NYNMeAddressModel mj_objectWithKeyValues:success[@"data"]];
            
            
//            _addresID= success[@"data"][@"id"];
    
            [self.tableView reloadData];
             [self shippingmethodData];
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}
//产品运费计算方式
-(void)shippingmethodData{

    //这里拼接订单的数据
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    
    for (int i =0; i<_dataArray.count; i++) {
        NSArray * arr = _dataArray[i];
        if (![arr isKindOfClass:[NSArray class]]) continue;
        for (int j = 0; j < [arr count]; j ++) {
            [dic setObject:_model.ID?:@"" forKey:[arr[j] productId]];
        }
//        [dic setObject:_model.ID forKey:[_dataArray[i] productId]];
    }
      NSDictionary *cc = @{@"data":[MyControl dictionaryToJson:dic]};
    [NYNNetTool ShippingmethodWithparams:cc isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
                if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
           
                    for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                        FreightModel *model = [FreightModel mj_objectWithKeyValues:dic];
                        [self.freightArray addObject:model];
                    }
            [self.tableView reloadData];
            
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}



//提交订单

-(void)dealButtonClick:(UIButton*)sender{
    if (_model.ID==nil) {
        return;
        
    }
    //这里拼接订单的数据
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
      NSMutableArray *itemModels = [[NSMutableArray alloc]init];
        for (int i =0; i<_dataArray.count; i++) {
     
            NSMutableDictionary *productDic = @{@"productId":[_dataArray[i] productId],@"quantity":[_dataArray[i] quantity]}.mutableCopy;
             [dic setObject:[_dataArray[i] productType] forKey:@"type"];
            [dic setObject:_model.ID forKey:@"userAddressId"];
             [dic setObject:[_dataArray[i] farmId] forKey:@"farmId"];
            [itemModels addObject:productDic];
        }
    
      [dic setObject:itemModels forKey:@"itemModels"];
    
    NSDictionary *cc = @{@"data":[MyControl dictionaryToJson:dic]};
    
    
    [NYNNetTool AddMarketSaveWithparams:cc isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            //                       NYNDealModel *model = [NYNDealModel mj_objectWithKeyValues:success[@"data"]];
            
            _dataArray =success[@"data"];
            //                        [self weixinPay];
            NYNPayViewController * payvc =[[NYNPayViewController alloc]init];
            
            payvc.typeStr=@"4";
            
            
            NYNDealModel *model = [NYNDealModel mj_objectWithKeyValues:_dataArray];
            payvc.model =model;
            [self.navigationController pushViewController:payvc animated:YES];
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
    
    
}

#pragma mark--UITableViewDelegate,UITableViewDataSource;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_dataArray.count>0) {
            return _dataArray.count+2;
    }else{
        return 0;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArray.count > 0 && section < _dataArray.count) {
        return [(NSArray *)_dataArray[section] count];
    }else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
 if (indexPath.section == _dataArray.count+1){
        //收货地址
        GoumaiTwoTableViewCell  * Cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (Cell == nil) {
            Cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GoumaiTwoTableViewCell class]) owner:self options:nil].firstObject;
        }
        NYNMeAdressViewController * addressVC = [[NYNMeAdressViewController alloc]init];
     __weak typeof(self)weakSelf = self;
       addressVC.addressClickBlock = ^(NYNMeAddressModel *model) {
           _model.ID = model.ID;
           _model.address= model.address;
            _model.contactName= model.contactName;
            NSIndexPath *idp = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[idp] withRowAnimation:UITableViewRowAnimationNone];
       };
     
        //地址管理跳转
        Cell.guanliBlock= ^(NSString *strValue){
            [weakSelf.navigationController pushViewController:addressVC animated:YES];

     };
     
     Cell.addressLabel.text =_model.address;
     Cell.phoneLabel.text =_model.phone;
     Cell.nameLabel.text  =[NSString stringWithFormat:@"收货人:%@",_model.contactName];
     
     
        
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return Cell;
        
    }else if (indexPath.section==_dataArray.count){
        //合计
     PayTotalTableViewCell  * Cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (Cell == nil) {
            Cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PayTotalTableViewCell class]) owner:self options:nil].firstObject;
        }

        
        Cell.freighLabel.text =[NSString stringWithFormat:@"含运费:%.2f元",_freightString];
        Cell.totalPriceLabel.text =[NSString stringWithFormat:@"%.2f元",_totalPrice+_freightString];

        
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return Cell;
    }else{
        GoumaiOneTableViewCell  * goumaiCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (goumaiCell == nil) {
            goumaiCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GoumaiOneTableViewCell class]) owner:self options:nil].firstObject;
        }
        
        if (_dataArray.count>0) {
            goumaiCell.shopModel  =_dataArray[indexPath.section][indexPath.row];
            
        }
  
        
        goumaiCell.frieghtBlock = ^(float strValue,float totalPrice) {
            //计算运费和总价
            _freightString +=strValue;
            _totalPrice+=totalPrice;
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:_dataArray.count];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
        };
        if (_freightArray.count>0) {
            goumaiCell.freightModel  =_freightArray[indexPath.section];
        }
        
        goumaiCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return goumaiCell;
        
    }
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == _dataArray.count) {
        return 45;
        
        
    }else if (indexPath.section==_dataArray.count+1){
        return 93;
        
    }else{
        return 180;
        
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
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-66) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
    
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    return _dataArray;
    
}

-(UIButton *)dealButton{
    if (!_dealButton) {
        _dealButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_dealButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_dealButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _dealButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_dealButton addTarget:self action:@selector(dealButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _dealButton.backgroundColor = Color9ecc5b;
        
        
    }
    return _dealButton;
    
}
@end
