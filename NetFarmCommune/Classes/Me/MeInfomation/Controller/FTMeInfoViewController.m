//
//  FTMeInfoViewController.m
//  FarmerTreasure
//
//  Created by 123 on 2017/4/25.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTMeInfoViewController.h"
#import "FTHeaderTableViewCell.h"
#import "FTHeaderDetailTableViewCell.h"

//#import "FTMeNetTool.h"

#import "FTNewViewController.h"
#import "NYNUserInfoModifyModel.h"
#import "ZYInputAlertView.h"
#import "JZDatePickerView.h"
#import "AddressPickerView.h"

@interface FTMeInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,AddressPickerViewDelegate>
@property (nonatomic,strong) UITableView *meInfoTable;

//头像cell
@property (nonatomic,strong) FTHeaderTableViewCell *farmLiveTableViewCell;

@property (nonatomic,strong) NYNUserInfoModifyModel *userInfoModifyModel;

@property (nonatomic,strong) JZDatePickerView *pickerView;

@property (nonatomic,strong) AddressPickerView *addressPickerView;
@end

@implementation FTMeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title= @"编辑个人资料";
    
    [self createmeInfoTable];
    
    [self configMeInfoUI];
}

- (void)createmeInfoTable{
    self.meInfoTable.delegate = self;
    self.meInfoTable.dataSource = self;
    self.meInfoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.meInfoTable.showsVerticalScrollIndicator = NO;
    self.meInfoTable.showsHorizontalScrollIndicator = NO;
    
    self.meInfoTable.scrollEnabled = NO;
    [self.view addSubview:self.meInfoTable];
}

- (void)configMeInfoUI{
    [self.view addSubview:self.pickerView];
    __weak typeof(self) weakSelf = self;
    self.pickerView.MakeClick = ^(NSDate *date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:date];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        
        //设置时区,这个对于时间的处理有时很重要
        
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        
        [formatter setTimeZone:timeZone];
        
//        NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
        
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
        
        [weakSelf showLoadingView:@""];
        [NYNNetTool ModifyUserInfoWithparams:@{@"birthday":timeSp} isTestLogin:YES progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            
            if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                
                NSMutableDictionary *ss = [NSMutableDictionary dictionaryWithDictionary:JZUSERINFO];
                NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:ss[@"user"]];
                [userDic setObject:timeSp forKey:@"birthday"];
                [ss setObject:userDic forKey:@"user"];
                JZSaveMyDefault(SET_USER, ss);
                POST_NTF(@"login", nil);
                [weakSelf.meInfoTable reloadData];

                
                
                
            }else{
                
                [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
            }
            [self hideLoadingView];
        } failure:^(NSError *failure) {
            [self hideLoadingView];
        }];

        
//        weakSelf.userInfoModifyModel.bornDate = strDate;
//        [weakSelf.meInfoTable reloadData];
    };
    
    
    [self.view addSubview:self.addressPickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 5;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        default:
        {
            return 1;
        }
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UserInfoModel *userModel = userInfoModel;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            FTHeaderTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTHeaderTableViewCell class]) owner:self options:nil].firstObject;
            }
            self.farmLiveTableViewCell = farmLiveTableViewCell;
            [self.farmLiveTableViewCell.headerImageV sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:PlaceImage];
            
            
            return farmLiveTableViewCell;
        }else if(indexPath.row == 1){
            FTHeaderDetailTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTHeaderDetailTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.namelb.text = @"昵称";
            farmLiveTableViewCell.detaillb.text = userModel.name;
            return farmLiveTableViewCell;
        }else if(indexPath.row == 2){
            FTHeaderDetailTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTHeaderDetailTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.namelb.text = @"性别";
            if ([userModel.sex isEqualToString:@"1"]) {
                farmLiveTableViewCell.detaillb.text = @"男";
            }else{
                farmLiveTableViewCell.detaillb.text = @"女";

            }
            return farmLiveTableViewCell;
        }else if(indexPath.row == 3){
            FTHeaderDetailTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTHeaderDetailTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.namelb.text = @"我的生日";
            farmLiveTableViewCell.detaillb.text = [MyControl timeWithTimeIntervalString:userModel.birthday];

            
            
            return farmLiveTableViewCell;
        }else{
            FTHeaderDetailTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTHeaderDetailTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.namelb.text = @"所在城市";
            farmLiveTableViewCell.detaillb.text = userModel.city;

            return farmLiveTableViewCell;
        }
    }else{
        FTHeaderDetailTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTHeaderDetailTableViewCell class]) owner:self options:nil].firstObject;
        }
        farmLiveTableViewCell.namelb.text = @"个性签名";
        farmLiveTableViewCell.detaillb.text = userModel.signature;

        return farmLiveTableViewCell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return JZHEIGHT(61);
        }else{
            return JZHEIGHT(41);

        }
    }else{
        return JZHEIGHT(41);

    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : 5)];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ?  0.0001 : 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //#import "WFactivityViewController.h"
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 ) {
            UIActionSheet *sheet;
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
                
            }else{
                
                sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择" , nil] ;
                
            }
            
            [sheet showInView:self.view];
        }
        
        if (indexPath.row == 1) {
            __weak typeof(self) weakSelf = self;

            ZYInputAlertView *alertView = [ZYInputAlertView alertView];
            alertView.confirmBgColor = Color90b659;
            alertView.placeholder = @"请输入你的昵称···";
            [alertView confirmBtnClickBlock:^(NSString *inputString) {
                weakSelf.userInfoModifyModel.nameStr = inputString;
                
                [self showLoadingView:@""];
                [NYNNetTool ModifyUserInfoWithparams:@{@"name":inputString} isTestLogin:YES progress:^(NSProgress *progress) {
                    
                } success:^(id success) {
                    
                    if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                        NSMutableDictionary *ss = [NSMutableDictionary dictionaryWithDictionary:JZUSERINFO];
                        
                        NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:ss[@"user"]];
                        [userDic setObject:inputString forKey:@"name"];
                        
                        [ss setObject:userDic forKey:@"user"];
                        
                        JZSaveMyDefault(SET_USER, ss);
                        POST_NTF(@"login", nil);
     
                        [self.meInfoTable reloadData];
                        
                        
                    }else{
                        
                        [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                    }
                    [self hideLoadingView];
                } failure:^(NSError *failure) {
                    [self hideLoadingView];
                }];

                
            }];
            [alertView show];
        }
        
        if (indexPath.row == 2) {
            UIActionSheet *sheet;
            
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
            sheet.tag = indexPath.row;
            [sheet showInView:self.view];
        }
        if (indexPath.row == 3) {
            [self.pickerView showPickerView];
        }
        if (indexPath.row == 4) {
            [self showAddressPic];
        }
    }else{
        
//        FTNewViewController *vc = [FTNewViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//        __weak FTMeInfoViewController *weakSelf = self;
//        
//        [vc returnRoomName:^(NSString *roomName) {
//            weakSelf.addressStr = roomName;
//            [weakSelf.meInfoTable reloadData];
//        }];
        __weak typeof(self) weakSelf = self;
        
        ZYInputAlertView *alertView = [ZYInputAlertView alertView];
        alertView.confirmBgColor = Color90b659;
        alertView.placeholder = @"请输入个性签名···";
        [alertView confirmBtnClickBlock:^(NSString *inputString) {
            weakSelf.userInfoModifyModel.mySign = inputString;
//            [weakSelf.meInfoTable reloadData];
            
            
            [self showLoadingView:@""];
            [NYNNetTool ModifyUserInfoWithparams:@{@"signature":inputString} isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                
                if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                    
                    NSMutableDictionary *ss = [NSMutableDictionary dictionaryWithDictionary:JZUSERINFO];
                    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:ss[@"user"]];
                    [userDic setObject:inputString forKey:@"signature"];
                    [ss setObject:userDic forKey:@"user"];
                    JZSaveMyDefault(SET_USER, ss);
                    POST_NTF(@"login", nil);
                    [self hideAddressPic];
                    
                    [self.meInfoTable reloadData];
                    
                }else{
                    
                    [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                }
                [self hideLoadingView];
            } failure:^(NSError *failure) {
                [self hideLoadingView];
            }];
            
        }];
        [alertView show];
    }
    
}
#pragma 懒加载
-(UITableView *)meInfoTable
{
    if (!_meInfoTable) {
        _meInfoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStyleGrouped];
    }
    return _meInfoTable;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        
        return;
        
    }
    
    if (actionSheet.tag == 2) {
        
        if (buttonIndex == 0) {
            self.userInfoModifyModel.sexStr = @"男";
            
            [self showLoadingView:@""];
            [NYNNetTool ModifyUserInfoWithparams:@{@"sex":@0} isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                
                if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                    
                    NSMutableDictionary *ss = [NSMutableDictionary dictionaryWithDictionary:JZUSERINFO];
                    
                    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:ss[@"user"]];
                    [userDic setObject:@"1" forKey:@"sex"];
                    
                    [ss setObject:userDic forKey:@"user"];
                    
                    JZSaveMyDefault(SET_USER, ss);
                    
                    
                    POST_NTF(@"login", nil);
                    [self.meInfoTable reloadData];

                    
                }else{
                    
                    [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                }
                [self hideLoadingView];
            } failure:^(NSError *failure) {
                [self hideLoadingView];
            }];
            

            
        }
        if (buttonIndex == 1){
            self.userInfoModifyModel.sexStr = @"女";
            
            [self showLoadingView:@""];
            [NYNNetTool ModifyUserInfoWithparams:@{@"sex":@1} isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                
                if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                    
                    NSMutableDictionary *ss = [NSMutableDictionary dictionaryWithDictionary:JZUSERINFO];
                    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:ss[@"user"]];
                    [userDic setObject:@"2" forKey:@"sex"];
                    [ss setObject:userDic forKey:@"user"];
                    JZSaveMyDefault(SET_USER, ss);
                    POST_NTF(@"login", nil);
                    
                    [self.meInfoTable reloadData];

                }else{
                    
                    [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                }
                [self hideLoadingView];
            } failure:^(NSError *failure) {
                [self hideLoadingView];
            }];
        }
        [self.meInfoTable reloadData];

    }else{
    
    
    NSInteger sourceType = 0;
    
    if (buttonIndex == 0) {
        
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }else if (buttonIndex == 1){
        
        sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    
    pickerController.sourceType= sourceType;
    
    pickerController.delegate = self;
    
    pickerController.allowsEditing = YES;
    
    [self presentViewController:pickerController animated:YES completion:nil];
    
        
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary*)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSData *dd = UIImageJPEGRepresentation(image, 1);
    [self showLoadingView:@""];
    
    [NYNNetTool PostImageWithparams:@{@"folder":@"avatar"} andFile:dd isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            JZLog(@"");
            NSString *url = [NSString stringWithFormat:@"%@",success[@"data"]];

            [NYNNetTool SavePicsWithparams:@{@"url":url} isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                
                if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                    
                    [NYNNetTool ModifyUserInfoWithparams:@{@"avatar":url} isTestLogin:YES progress:^(NSProgress *progress) {
                        
                    } success:^(id success) {
                        
                        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                            
                            NSMutableDictionary *ss = [NSMutableDictionary dictionaryWithDictionary:JZUSERINFO];
                            
                            NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:ss[@"user"]];
                            [userDic setObject:url forKey:@"avatar"];
                            
                            [ss setObject:userDic forKey:@"user"];
                            
                            JZSaveMyDefault(SET_USER, ss);
                            
                            self.farmLiveTableViewCell.headerImageV.image = image;
                            
                            POST_NTF(@"login", nil);
                            
                        }else{
                            
                            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                        }
                        [self hideLoadingView];
                    } failure:^(NSError *failure) {
                        [self hideLoadingView];
                    }];
                    
                    
                }else{
                    
                    [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                }
                
            } failure:^(NSError *failure) {
                [self hideLoadingView];

            }];
            
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}


-(NYNUserInfoModifyModel *)userInfoModifyModel{
    if (!_userInfoModifyModel) {
        _userInfoModifyModel = [[NYNUserInfoModifyModel alloc]init];
        

    }
    UserInfoModel *userModel = userInfoModel;
    
    _userInfoModifyModel.imageData = PlaceImage;
    _userInfoModifyModel.nameStr = @"未命名";
    _userInfoModifyModel.sexStr = @"男";
    _userInfoModifyModel.bornDate = @"1997-7-8";
    _userInfoModifyModel.address = @"成都";
    _userInfoModifyModel.mySign = @"这个人很懒，什么都没有留下";
    
    return _userInfoModifyModel;
}

- (JZDatePickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[JZDatePickerView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, JZHEIGHT(200))];
        _pickerView.backgroundColor = [UIColor whiteColor];
        [_pickerView.datePickerView setMinimumDate:[NSDate dateWithTimeIntervalSince1970:0]];
    }
    
    return _pickerView;
}

- (AddressPickerView *)addressPickerView{
    if (!_addressPickerView) {
        _addressPickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT , SCREENWIDTH, 300)];
        _addressPickerView.delegate = self;
    }
    return _addressPickerView;
}

- (void)showAddressPic{
    [UIView animateWithDuration:0.2 animations:^{
        self.addressPickerView.frame = CGRectMake(0, SCREENHEIGHT - 300, SCREENWIDTH, 300);
    }];
}

- (void)hideAddressPic{
    [UIView animateWithDuration:0.2 animations:^{
        self.addressPickerView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 300);
    }];
}

-(void)cancelBtnClick{
    [self hideAddressPic];
}

-(void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area latModel:(NYNMergerModel *)model ProvinceID:(NSString *)ProvinceID CityID:(NSString *)CityID{
    JZLog(@"%@%@%@",province,city,area);
//    self.userInfoModifyModel.address = city;
//    [self.meInfoTable reloadData];
    
    JZLog(@"这里有返回地址的模型");
    
    
    [self showLoadingView:@""];
    [NYNNetTool ModifyUserInfoWithparams:@{@"city":city} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            NSMutableDictionary *ss = [NSMutableDictionary dictionaryWithDictionary:JZUSERINFO];
            NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:ss[@"user"]];
            [userDic setObject:city forKey:@"city"];
            [ss setObject:userDic forKey:@"user"];
            JZSaveMyDefault(SET_USER, ss);
            POST_NTF(@"login", nil);
            [self hideAddressPic];

            [self.meInfoTable reloadData];
            
        }else{
            
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
    
    
    
    
    
    
}
@end
