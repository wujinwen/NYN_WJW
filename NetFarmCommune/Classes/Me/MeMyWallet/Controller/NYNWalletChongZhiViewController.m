//
//  NYNWalletChongZhiViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNWalletChongZhiViewController.h"
#import "NYNMeChongZhiTableViewCell.h"
#import "NYNWalletChooseModel.h"
#import "FTHomeBottomButton.h"
#import "NYNGouMaiView.h"

@interface NYNWalletChongZhiViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *walletChongZhitable;
@property (nonatomic,strong) NSMutableArray *modelArr;
@end

@implementation NYNWalletChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    for (int i = 0; i < 3; i++) {
        NYNWalletChooseModel *model = [[NYNWalletChooseModel alloc]init];
        if (i == 0) {
            model.iconName = @"mine_icon_panment";
            model.contentStr = @"支付方式";
            model.isChoose = NO;
        }
        if (i == 1) {
            model.iconName = @"mine_icon_zhifubao";
            model.contentStr = @"支付宝支付";
            model.isChoose = NO;
        }
        if (i == 2) {
            model.iconName = @"mine_icon_wxpanment";
            model.contentStr = @"微信支付";
            model.isChoose = NO;
        }
        [self.modelArr addObject:model];
    }
    
    self.title = @"充值";
    
    [self createTable];
    
    NYNGouMaiView *bottomView = [[NYNGouMaiView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(46) - 64, SCREENWIDTH, JZHEIGHT(46))];
    [bottomView ConfigDataWithIndex:1 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) - 64, SCREENWIDTH, JZHEIGHT(45))];
    [bottomView.goumaiBT setTitle:@"确认付款" forState:0];
    bottomView.gouwucheBlock = ^(NSString *strValue) {
        
    };
    
    bottomView.goumaiBlock = ^(NSString *strValue) {
        
    };
    [self.view addSubview:bottomView];
}

- (void)createTable{
    [self.view addSubview:self.walletChongZhitable];
    self.walletChongZhitable.showsHorizontalScrollIndicator = NO;
    self.walletChongZhitable.showsVerticalScrollIndicator = NO;
    self.walletChongZhitable.delegate = self;
    self.walletChongZhitable.dataSource = self;
    self.walletChongZhitable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.walletChongZhitable.backgroundColor = Colore3e3e3;
    self.walletChongZhitable.scrollEnabled = NO;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(46 + 11))];
    headerView.backgroundColor = Colore3e3e3;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(46))];
    topView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:topView];
    
    UILabel *jineLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), 0, JZWITH(40), topView.height)];
    jineLabel.text = @"金额";
    jineLabel.font = JZFont(13);
    jineLabel.textColor = [UIColor blackColor];
    [topView addSubview:jineLabel];
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(jineLabel.right + JZWITH(30), 0, JZWITH(150), topView.height)];
    tf.placeholder = @"请输入充值金额";
    tf.font = JZFont(13);
    tf.delegate=self;
    
    tf.keyboardType = UIReturnKeyDefault;
    [topView addSubview:tf];
    
    self.walletChongZhitable.tableHeaderView  = headerView;
}


//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    
    return YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNMeChongZhiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeChongZhiTableViewCell class]) owner:self options:nil].firstObject;
    }
    NYNWalletChooseModel *model = self.modelArr[indexPath.row];
    
    if (indexPath.row == 0) {
        farmLiveTableViewCell.iconImageView.image = Imaged(model.iconName);
        farmLiveTableViewCell.contentLabel.text = model.contentStr;
        farmLiveTableViewCell.chooseImageView.hidden= YES;
        
    }else{
        farmLiveTableViewCell.iconImageView.image = Imaged(model.iconName);
        farmLiveTableViewCell.contentLabel.text = model.contentStr;
    }
    if (model.isChoose) {
        farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_selected2");
        
    }else{
        farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_unchecked");

    }
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(46);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (NYNWalletChooseModel *md in self.modelArr) {
        md.isChoose = NO;
    }
    
    NYNWalletChooseModel *model = self.modelArr[indexPath.row];
    model.isChoose = !model.isChoose;
    [self.walletChongZhitable reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)walletChongZhitable{
    if (!_walletChongZhitable) {
        _walletChongZhitable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - 46) style:UITableViewStylePlain];
    }
    return _walletChongZhitable;
}

-(NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [[NSMutableArray alloc]init];
    }
    return _modelArr;
}
@end
