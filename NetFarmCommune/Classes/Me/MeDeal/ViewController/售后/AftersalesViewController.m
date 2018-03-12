//
//  AftersalesViewController.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/31.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "AftersalesViewController.h"
#import "RefundProductOneCell.h"
#import "RefundTwoTableViewCell.h"
#import "DMDropDownMenu.h"
#import "RefundtProductThreeCell.h"
#import "CImagePicker.h"
#import <Masonry/Masonry.h>
@interface AftersalesViewController ()<UITableViewDelegate,UITableViewDataSource,RefundProductOneCellDelagate>

{
    BOOL updateCell;//是否更新cell高度过程中
    CGFloat changeHeight;//更新cell高的改变量
    NSInteger updateCellIndex;//要更新的cell
    
    CGFloat cellHeight0;//更新cell高的改变量
    CGFloat cellHeight1;//更新cell高的改变量
    CGFloat cellHeight2;//更新cell高的改变量
    NSString * _moneyString;
    NSString * _productStr;
    NSString * _refundString;//退货说明
    
    NSString * _selectResonStr;
    
    
    
    
}

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)UIButton * tijiaoButton;

@property(nonatomic,strong)NSArray * resonArray;
@property(nonatomic,strong)NSArray * productArray;

@property(nonatomic,strong)NSMutableArray * picArray;






@end

@implementation AftersalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"售后退换";
    
    cellHeight0 = JZHEIGHT(80);
    cellHeight1 = JZHEIGHT(80);
    cellHeight2 = JZHEIGHT(80);
    
    [self.view addSubview:self.tableView];
    
    _resonArray=[NSArray arrayWithObjects:@"空包裹",@"未按约定时间发货",@"快递/物流一直未送到",@"商品与描述不符",@"质量问题",@"少发/漏发",@"包装/商品破损",@"未按约定时间发货",@"卖家发错货",nil];
        _productArray = [NSArray arrayWithObjects: _goodsDealModel.farm[@"name"], nil];
     _productStr = _productArray[0];
    
    [self.view addSubview:self.tijiaoButton];
    
    [self.tijiaoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.left.right.mas_offset(0);
        make.height.mas_offset(45);
        
    }];
    
}



- (void)cellWillChange:(BOOL)isopen height:(CGFloat)height index:(NSInteger)index{
    updateCell = YES;
    changeHeight = height;
    updateCellIndex = index;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    updateCell = NO;
}


//提交退货申请
-(void)tijiaoButtonClick:(UIButton*)sender{
    
    double moneyS =[_moneyString doubleValue];
    double money1 = [_goodsDealModel.amount doubleValue] - [_goodsDealModel.freight intValue] ;
    
    
    if (moneyS>money1 ) {
         [self showTextProgressView:@"退款金额大于实际金额"];
        [self hideLoadingView];
        return;
        
    }
    
    NSDictionary * dic = @{@"orderId":_goodsDealModel.ID,@"orderItemId":_goodsDealModel.orderItems[0][@"id"],@"productName":_productStr,@"refundAmount":_moneyString,@"returnInfo":_refundString,@"returnReason":_selectResonStr,@"returnImg":[MyControl toJSONData:_picArray]};
    [NYNNetTool AccountfundParams:dic isTestLogin:YES progress:^(NSProgress *progress ) {
        
        
    } success:^(id success) {
        NSLog(@"--------%@",success);
        
         [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        
        [self.navigationController popViewControllerAnimated:YES];
        
         [self hideLoadingView];
    } failure:^(NSError *failure) {
        
    }];
    
    
    
    
}


-(void)addPicUImage:(UIImage*)image{

    //这里上传图片
    
    NSData *dd = UIImageJPEGRepresentation(image, 1);
    
    
    [NYNNetTool PostImageWithparams:@{@"folder":@"avatar"} andFile:dd isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            NSString * str = [NSString stringWithFormat:@"%@",success[@"data"]];
            [self.picArray  addObject:str];


            
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
    return 5;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0 ||indexPath.section ==1||indexPath.section ==2 ) {
        RefundProductOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[RefundProductOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.section == 0) {
            cell.headLabel.text = @"  退款商品";
            //            cell.nameTextF.titleLabel.text = @"优质大白菜";
            cell.indexPath = indexPath.section;
             cell.dmArray2 =_productArray;
            cell.nameTextF.hidden= YES;
            
            cell.selectBlock = ^(NSInteger selectIndex,NSInteger indexpath) {
                if (indexpath == 0) {
                    _productStr = _productArray[indexpath];
                    
                }
                
            };
            
            
        }else if (indexPath.section == 1){
            cell.headLabel.text = @"  退货原因";
            //             cell.nameTextF.titleLabel.text  = @"请选择退款原因";
            cell.dmArray2 =_resonArray;
            
         
            
            cell.indexPath = indexPath.section;
            cell.nameTextF.hidden= YES;
     
            cell.selectBlock = ^(NSInteger selectIndex,NSInteger indexpath) {
                if (indexpath==1) {
                    _selectResonStr = _resonArray[indexpath];
                    
                }
                
            };
            
            
        }else if (indexPath.section==2){
            cell.headLabel.text = @"  退款金额";
            cell.nameTextF.placeholder = @"请输入退款金额";
            cell.nameTextF.hidden= NO;
            cell.dm2.hidden = YES;
            _moneyString=@"0";
            cell.moneyBlock = ^(NSString *textfieldText) {
                   _moneyString = textfieldText;
                
            };
            
            
            cell.indexPath = indexPath.section;
        }
        cell.delaget = self;
        
        
        return cell;
        
        
    }else if (indexPath.section ==3){
        
        RefundTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[RefundTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.headLabel.text = @" 退货说明";
        _refundString = @" ";
        cell.refuseBlock = ^(NSString *text) {
            _refundString = text;
            
        };
        
        return cell;
        
    }else{
        RefundtProductThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[RefundtProductThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
                cell.headLabel.text = @" 上传图片凭证";
          __weak typeof(self)weakSelf = self;
        __weak typeof(RefundtProductThreeCell)*weakSelf1 = cell;
        cell.selectBlock = ^(NSIndexPath *indexpath) {
            CImagePicker * imgpicker = [CImagePicker imagePicker];
            
            [imgpicker openGallery:^(UIAlertController *alertController) {
                //alertController是选择提示器,传出来给controller加载
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            } didChoose:^{
                //这个回调是选择了照片或者拍照后调用的,imgpicker.imagePickerController就是照片选择器,传出来给controller加载
                [weakSelf presentViewController:imgpicker.imagePickerController animated:YES completion:nil];
            } didFinish:^(UIImage *img) {
                //选择图片结束
                if (img) {
                     JZLog (@"qqqqq选取图片成功");
                    [weakSelf1.picsArr addObject:img];
                    [weakSelf addPicUImage:img];
                    
                    [weakSelf1.albumCollectionView reloadData];
                    
                    
                }else {
                    JZLog(@"qqqqq选取照片失败");
                }
            } didCancel:^{
                //点击取消
                JZLog(@"qqqqq选取照片点击取消");
            }];
            
        };
       
    
        
        return cell;
    }
    return nil;
    
    
}








-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (updateCell) {
        if (indexPath.section == updateCellIndex) {
            if (indexPath.section==0) {
                cellHeight0 = JZHEIGHT(80)+changeHeight;
                return  cellHeight0;
            }else if (indexPath.section ==1) {
                cellHeight1 = JZHEIGHT(80)+changeHeight;
                return  cellHeight1;
            }else if (indexPath.section ==2) {
                cellHeight2 = JZHEIGHT(80)+changeHeight;
                return  cellHeight2;
            }
            return  JZHEIGHT(80)+changeHeight;
        }
    }
    
    if (indexPath.section==0) {
        return  cellHeight0;
    }else if (indexPath.section ==1) {
        return  cellHeight1;
    }else if (indexPath.section ==2) {
        return  cellHeight2;
    }
    else{
        
        return JZHEIGHT(240);
        
        
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
    }
    
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-40) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[[UIView alloc]init];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
    
}

-(UIButton *)tijiaoButton{
    if (!_tijiaoButton) {
        _tijiaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tijiaoButton setTitle:@"提交申请" forState:UIControlStateNormal];
        _tijiaoButton.titleLabel.textColor=[UIColor whiteColor];
        _tijiaoButton.backgroundColor = Color90b659;
        
        _tijiaoButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_tijiaoButton addTarget:self action:@selector(tijiaoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _tijiaoButton;
    
}
-(NSMutableArray *)picArray{
    if (!_picArray) {
        _picArray = [[NSMutableArray alloc]init];
        
    }
    return _picArray;
    
}
@end

