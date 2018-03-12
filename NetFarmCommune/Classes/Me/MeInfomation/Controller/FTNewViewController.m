//
//  NewViewController.m
//  通讯录
//
//  Created by Apple on 2017/1/14.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "FTNewViewController.h"
#import "Contact.h"

@interface FTNewViewController ()<UITextFieldDelegate>

@end

@implementation FTNewViewController


- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT , SCREENWIDTH, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑地址";

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick:)];
    
    self.navigationItem.rightBarButtonItem=saveButton;
[self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    self.nameTf.delegate = self;
    self.phoneTf.delegate =self;
    self.detailTf.delegate = self;
    self.nameTf.returnKeyType = UIReturnKeyDone;
    self.phoneTf.returnKeyType = UIReturnKeyDone;
    self.detailTf.returnKeyType = UIReturnKeyDone;
    self.detailTf.clearsOnBeginEditing = YES;
    self.phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.phoneTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
[self.view addSubview:self.pickerView];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneTf) {
        if (textField.text.length > 11) {
            [self showTipsView:@"注意，您输入的手机号码已经超过11位了"];
            textField.text = [textField.text substringToIndex:11];
        }
        
        //        if (textField.text.length < 11) {
        //            [self showBlackBgMessage:@"您输入的手机号码不足11位，请继续输入"];
        //            return;
        //        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return [textField endEditing:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)placeSelect:(id)sender {
    
//    AreaPickview *pickview = [[AreaPickview alloc]init];
//    [self.view addSubview:pickview];
//    pickview.block = ^(NSString *province, NSString *city, NSString *distric, NSString *town){
//        NSString *temp = [NSString stringWithFormat:@"%@%@%@%@",province, city, distric, town];
//        [self.addressButton setTitle:temp forState:UIControlStateNormal];
//        //        [self.click setTitle:[NSString stringWithFormat:@"%@ %@ %@ %@",province, city, distric, town] forState:UIControlStateNormal];
//        
//    };
    
    
[self btnClick:self.addressButton];
   
}

- (void)btnClick:(UIButton *)btn{
    [UIView animateWithDuration:0.5 animations:^{
        
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationDelegate:self];
        //改变它的frame的x,y的值
        if (self.addressButton.selected) {
            _pickerView.frame = CGRectMake(0, SCREENHEIGHT-64, SCREENWIDTH, 215+64);
        }
        else {
            _pickerView.frame=CGRectMake(0,SCREENHEIGHT - 215-64, SCREENWIDTH,215+64);
        }
        [UIView commitAnimations];
        
        self.addressButton.selected = !self.addressButton.selected;
        
    }];

    
}


#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    [self btnClick:self.addressButton];
}
- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area latModel:(NYNMergerModel *)model ProvinceID:(NSString *)ProvinceID CityID:(NSString *)CityID{
    
    [self.addressButton setTitle:[NSString stringWithFormat:@"%@%@%@",province,city,area] forState:UIControlStateNormal];
    [self btnClick:self.addressButton];
    
    JZLog(@"这里有返回");
}




- (void)saveClick:(id)sender {
    
    
    
    
    
    Contact * contact = [[Contact alloc] init];
    contact.name = self.nameTf.text;
    contact.phone = self.phoneTf.text;
    contact.address = [NSString stringWithFormat:@"%@%@",self.addressButton.titleLabel.text,self.detailTf.text];;
    
    self.newsContact = contact;
    
//    //2.添加到数组中:对象
//    [_contactArray addObject:contact];
//    
//    
//    //3.刷新表
//    [_tableView reloadData];
//    
//    //4.添加：数据存储
//    [self saveData];
//
    if (self.selectedRoomBlock != nil) {
        self.selectedRoomBlock(contact.address);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)returnRoomName:(SelectedRoomBlock)block{
    self.selectedRoomBlock = block;
}

@end
