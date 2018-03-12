//
//  NYNChooseAndPayViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/17.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNChooseAndPayViewController.h"
#import "NYNMeChongZhiTableViewCell.h"
#import "NYNWalletHistoryTableViewCell.h"
#import "NYNChooseTitleTableViewCell.h"

@interface NYNChooseAndPayViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *choosePayTable;
@property (nonatomic,strong) UITextField *costNumTextField;
@end

@implementation NYNChooseAndPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.chooseMethodStr = @"选择支付宝";
    self.title = self.chooseMethodStr;
    
    [self addTable];
    
    UIButton *bottomButton = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - 49 - 64, SCREENWIDTH, 49)];
    bottomButton.backgroundColor = Color90b659;
    [bottomButton setTitle:@"提交" forState:0];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:0];
    bottomButton.titleLabel.font = JZFont(14);
    [self.view addSubview:bottomButton];
}

- (void)addTable{
    self.choosePayTable.delegate = self;
    self.choosePayTable.dataSource = self;
    self.choosePayTable.showsHorizontalScrollIndicator = NO;
    self.choosePayTable.showsVerticalScrollIndicator = NO;
    self.choosePayTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.choosePayTable];
    
    UIView *tiXianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(46))];
    tiXianView.backgroundColor = [UIColor whiteColor];
    UILabel *tixianLabel = [[UILabel alloc]init];
    tixianLabel.text = @"提现金额";
    tixianLabel.font = JZFont(13);
    [tixianLabel sizeToFit];
    tixianLabel.frame = CGRectMake(JZWITH(10), (tiXianView.height - tixianLabel.height) / 2, tixianLabel.width, tixianLabel.height);
    [tiXianView addSubview:tixianLabel];
    
    UITextField *tixianTF = [[UITextField alloc]initWithFrame:CGRectMake(tixianLabel.right + JZWITH(30), JZHEIGHT(13), SCREENWIDTH - (tixianLabel.right + JZWITH(30) + JZWITH(10)), JZHEIGHT(20))];
    tixianTF.placeholder= @"请输入充值金额";
//    [tixianTF setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [tixianTF setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    tixianTF.font = JZFont(13);

    self.costNumTextField = tixianTF;
    [tiXianView addSubview:tixianTF];
    self.choosePayTable.tableHeaderView = tiXianView;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 4;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NYNChooseTitleTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChooseTitleTableViewCell class]) owner:self options:nil].firstObject;
        }
        if (indexPath.row == 0) {
            farmLiveTableViewCell.titleLabel.text = @"支付宝账户";
        }else{
            farmLiveTableViewCell.titleLabel.text = @"支付宝名称";

        }
        return farmLiveTableViewCell;
    }else{
        if (indexPath.row == 0) {
            
            NYNChooseTitleTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChooseTitleTableViewCell class]) owner:self options:nil].firstObject;
            }
            return farmLiveTableViewCell;
        }else{
            NYNWalletHistoryTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNWalletHistoryTableViewCell class]) owner:self options:nil].firstObject;
            }
            return farmLiveTableViewCell;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *yueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(37))];
        yueView.backgroundColor = Colorededed;
        UILabel *yueLabel = [[UILabel alloc]init];
        yueLabel.text = @"我的余额:";
        yueLabel.font = JZFont(12);
        yueLabel.textColor = Color888888;
        [yueLabel sizeToFit];
        yueLabel.frame = CGRectMake(JZWITH(10), (yueView.height - yueLabel.height) / 2, yueLabel.width, yueLabel.height);
        [yueView addSubview:yueLabel];
        
        UILabel *costLabel = [[UILabel alloc]initWithFrame:CGRectMake(yueLabel.right + JZWITH(5), 0, JZWITH(150), yueView.height)];
        costLabel.textColor = [UIColor redColor];
        costLabel.text = @"3562.00元";
        costLabel.font = JZFont(12);
        costLabel.textAlignment = 0;
        [yueView addSubview:costLabel];
        return yueView;
    }else{
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(11))];
        v.backgroundColor = Colorededed;
        return v;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return JZHEIGHT(37);
    }else{
        return JZHEIGHT(11);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)choosePayTable{
    if (!_choosePayTable) {
        _choosePayTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - 49) style:UITableViewStyleGrouped];
    }
    return  _choosePayTable;
}

@end
