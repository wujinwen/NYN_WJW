//
//  LocationViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationOneTableViewCell.h"
#import "LocationTwoTableViewCell.h"
#import "LocationThreeTableViewCell.h"
#import "AddressPickerView.h"
#import <Masonry/Masonry.h>

@interface LocationViewController ()<UITableViewDelegate,UITableViewDataSource,AddressPickerViewDelegate>

@property(nonatomic,strong)UITableView * locationTV;//定位

@property(nonatomic,strong)UIButton * sureButton;//确认

@property (nonatomic ,strong) AddressPickerView * pickerView;

@property (nonatomic,assign)  BOOL isShow;

@property(nonatomic,strong)NSString *provinceString;//省份



@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.locationTV];
    self.title = @"城市定位";
    
    [self.view addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(60);
        
    }];
    
    [self.view addSubview:self.pickerView];
    

}
//确定按钮
-(void)sureButtonClick:(UIButton*)sender{
    [self.delagate SureBtnClickDelagate:_provinceString];
    
    [self.navigationController popViewControllerAnimated:YES];
    
  
 
}
//城市选择
-(void)citySelectBtnClick{
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
    [self citySelectBtnClick];
    
}
- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area latModel:(NYNMergerModel *)model ProvinceID:(NSString *)ProvinceID CityID:(NSString *)CityID{
    NSString * str  = [province stringByAppendingString:city];
    _provinceString = [str stringByAppendingString:area];
    
    NSIndexPath *indexPathA = [NSIndexPath indexPathForRow:2 inSection:0]; //刷新第0段第2行
    
    [_locationTV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathA,nil] withRowAnimation:UITableViewRowAnimationNone];
    
     [self citySelectBtnClick];

}

#pragma mark---UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        LocationOneTableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell ==nil) {
            cell=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LocationOneTableViewCell class]) owner:self options:nil].firstObject;
        }
       
        NSDictionary * locDic =JZFetchMyDefault(SET_Location);

     
        NSString *city = locDic[@"city"] ?: @"";
         cell.cityLabel.text =city;
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.row ==1){
        LocationTwoTableViewCell* cellTwo =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cellTwo ==nil) {
            cellTwo=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LocationTwoTableViewCell class]) owner:self options:nil].firstObject;
        }
         cellTwo.selectionStyle= UITableViewCellSelectionStyleNone;
        return cellTwo;
    }else{
        
        LocationThreeTableViewCell* cellThree =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cellThree ==nil) {
            cellThree=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LocationThreeTableViewCell class]) owner:self options:nil].firstObject;
        }
        [cellThree.citySelectBtn addTarget:self action:@selector(citySelectBtnClick) forControlEvents:UIControlEventTouchUpInside];
        if ( _provinceString == nil) {
            cellThree.cityLabel.text = @"北京";
        }else{
            cellThree.cityLabel.text = _provinceString;
            
        }
           cellThree.selectionStyle= UITableViewCellSelectionStyleNone;
        return cellThree;
    }

}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0 ) {
        return 60;
        
    }else if (indexPath.row ==1){
        return 90;
    }else{
        return 100;
        
    }
}




-(UITableView *)locationTV{
    if (!_locationTV) {
        _locationTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-90) style:UITableViewStylePlain];
        _locationTV.dataSource = self;
        _locationTV.delegate=self;
        _locationTV.tableFooterView = [[UIView alloc]init];
        _locationTV.separatorStyle = UITableViewCellSelectionStyleNone;
//        _locationTV.backgroundColor=[UIColor lightGrayColor];
//        _locationTV.alpha=0.5;
//
    }
    return _locationTV;
    
    
}

-(UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sureButton.titleLabel.font=[UIFont systemFontOfSize:16];
        [_sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _sureButton.backgroundColor =Color90b659;
        
        
    }
    return _sureButton;
    
}
- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT , SCREENWIDTH, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}
@end
