//
//  NYNAddAddressViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNAddAddressViewController.h"
#import "NYNChooseMorenTableViewCell.h"
#import "NYNTextFieldsTableViewCell.h"
#import "NYNSuoYouDiQuTableViewCell.h"
#import "NYNShouHuoRenTableViewCell.h"
#import "NYNMeAddressModel.h"
//种植添加地址
@interface NYNAddAddressViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *addAddressTable;
@end

@implementation NYNAddAddressViewController

- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT , SCREENWIDTH, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShow = NO;
    
    self.title = @"添加收货地址";
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick:)];
    
    self.navigationItem.rightBarButtonItem=saveButton;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                                                                                                        forBarMetrics:UIBarMetricsDefault];
//    self.nameTf.delegate = self;
//    self.phoneTf.delegate =self;
//    self.detailTf.delegate = self;
//    self.nameTf.returnKeyType = UIReturnKeyDone;
//    self.phoneTf.returnKeyType = UIReturnKeyDone;
//    self.detailTf.returnKeyType = UIReturnKeyDone;
//    self.detailTf.clearsOnBeginEditing = YES;
//    self.phoneTf.keyboardType = UIKeyboardTypeNumberPad;
//    
    
    [self.view addSubview:self.addAddressTable];
    self.addAddressTable.delegate = self;
    self.addAddressTable.dataSource = self;
    self.addAddressTable.showsVerticalScrollIndicator = NO;
    self.addAddressTable.showsHorizontalScrollIndicator = NO;
    self.addAddressTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:self.pickerView];
}

- (void)textFieldDidChange:(UITextField *)textField
{
//    if (textField == self.phoneTf) {
//        if (textField.text.length > 11) {
//            [self showTipsView:@"注意，您输入的手机号码已经超过11位了"];
//            textField.text = [textField.text substringToIndex:11];
//        }
//    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return [textField endEditing:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)placeSelect:(id)sender {
//    
//    //    AreaPickview *pickview = [[AreaPickview alloc]init];
//    //    [self.view addSubview:pickview];
//    //    pickview.block = ^(NSString *province, NSString *city, NSString *distric, NSString *town){
//    //        NSString *temp = [NSString stringWithFormat:@"%@%@%@%@",province, city, distric, town];
//    //        [self.addressButton setTitle:temp forState:UIControlStateNormal];
//    //        //        [self.click setTitle:[NSString stringWithFormat:@"%@ %@ %@ %@",province, city, distric, town] forState:UIControlStateNormal];
//    //
//    //    };
//    
//    [self btnClick:self.addressButton];
//    
//}

- (void)btnClick{
    [UIView animateWithDuration:0.5 animations:^{
        
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationDelegate:self];
        //改变它的frame的x,y的值
        if (self.isShow) {
            _pickerView.frame = CGRectMake(0, SCREENHEIGHT-64, SCREENWIDTH, 215+64);
        }else {
            _pickerView.frame=CGRectMake(0,SCREENHEIGHT - 215-64, SCREENWIDTH,215+64);
        }
        [UIView commitAnimations];
        
        self.isShow = !self.isShow;
        
    }];
    
    
}


#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    [self btnClick];
}
- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area latModel:(NYNMergerModel *)model ProvinceID:(NSString *)ProvinceID CityID:(NSString *)CityID{
    
//    [self.addressButton setTitle:[NSString stringWithFormat:@"%@%@%@",province,city,area] forState:UIControlStateNormal];
    
    self.model.diqutr = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.addAddressTable reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationNone];
    self.model.areaAddressModel = model;
    self.provinceID = ProvinceID;
    self.cityID = CityID;
    
    [self btnClick];
}




- (void)saveClick:(id)sender {

    if (self.model.diqutr.length < 1 || self.cityID.length < 1 || self.provinceID.length < 1) {
        [self showTextProgressView:@"请先选择地区"];
        [self hideLoadingView];
    }
//    ,@"zipCode":[NSString stringWithFormat:@"%@",self.codeTf.text]
    NSDictionary *dic = @{@"contactName":[NSString stringWithFormat:@"%@",self.nameTf.text],@"areaId":[NSString stringWithFormat:@"%@",self.model.areaAddressModel.ID],@"provinceId":[NSString stringWithFormat:@"%@",self.provinceID],@"phone":[NSString stringWithFormat:@"%@",self.phoneTf.text],@"address":[NSString stringWithFormat:@"%@",self.detailTf.text],@"isDefault":self.model.isChoose ? @"1" : @"0"};
    
    [self showLoadingView:@""];
    [NYNNetTool SearchAllAddressWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];

    }];
    
    
    
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)returnRoomName:(SelectedRoomBlock)block{
    self.selectedRoomBlock = block;
}

//tableDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            NYNSuoYouDiQuTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNSuoYouDiQuTableViewCell class]) owner:self options:nil].firstObject;
            }
            self.addressLabel = farmLiveTableViewCell.addressLabel;
            self.addressLabel.text = self.model.diqutr;
            return farmLiveTableViewCell;
        }else if (indexPath.row == 4){
            NYNTextFieldsTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNTextFieldsTableViewCell class]) owner:self options:nil].firstObject;
            }
            self.detailTf = farmLiveTableViewCell.detailTextView;
            farmLiveTableViewCell.detailTextView.placehoder = @"请填写详细地址，不少于5个字";
            return farmLiveTableViewCell;
        }else{
            NYNShouHuoRenTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShouHuoRenTableViewCell class]) owner:self options:nil].firstObject;
            }
            if (indexPath.row == 0) {
                self.nameTf = farmLiveTableViewCell.textFields;
                farmLiveTableViewCell.titleLabel.text = @"收货人";
                farmLiveTableViewCell.textFields.placeholder = @"收货人";
            }
            if (indexPath.row == 1) {
                self.phoneTf = farmLiveTableViewCell.textFields;
                [self.phoneTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                farmLiveTableViewCell.titleLabel.text = @"联系电话";
                farmLiveTableViewCell.textFields.placeholder = @"收货人电话";

            }
            if (indexPath.row == 2) {
                self.codeTf = farmLiveTableViewCell.textFields;
                farmLiveTableViewCell.titleLabel.text = @"邮政编码";
                farmLiveTableViewCell.textFields.placeholder = @"收货地址邮政编码";
                farmLiveTableViewCell.textFields.returnKeyType = UIReturnKeyDone;
                   farmLiveTableViewCell.textFields.delegate = self;
            }
            
            return farmLiveTableViewCell;
        }
    }else{
        NYNChooseMorenTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChooseMorenTableViewCell class]) owner:self options:nil].firstObject;
        }
        
        if (self.model.isChoose) {
            farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_selected");
        }else{
            farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_unchecked");
        }
        return farmLiveTableViewCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            [self btnClick];
        }
    }
    if (indexPath.section == 1) {
        self.model.isChoose = !self.model.isChoose;
        NSIndexSet *ss = [NSIndexSet indexSetWithIndex:1];
        [self.addAddressTable reloadSections:ss withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 4) {
            return JZHEIGHT(81);
        }else{
            return JZHEIGHT(47);
        }
    }else{
        return JZHEIGHT(47);

    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
        return v;
    }else{
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(11))];
        v.backgroundColor = Colore3e3e3;
        return v;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }else{
        return JZHEIGHT(11);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(UITableView *)addAddressTable{
    if (!_addAddressTable) {
        _addAddressTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStyleGrouped];
    }
    return _addAddressTable;
}


-(NYNMeAddressModel *)model{
    if (!_model) {
        _model = [[NYNMeAddressModel alloc]init];
        _model.shouHuoRenStr = @"";
        _model.dianhuaStr = @"";
        _model.youbianStr = @"";
        _model.diqutr = @"请选择";
        _model.diquDetailStr = @"";
        _model.isChoose = NO;
    }
    return _model;
}
@end
