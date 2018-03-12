//
//  NYNMyFarmTuDiZengSongViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/17.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMyFarmTuDiZengSongViewController.h"
#import "NYNMyFarmTuDiZengSongTableViewCell.h"
#import "NYNTuDiZengSongModel.h"
@interface NYNMyFarmTuDiZengSongViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tuDiZengSongTable;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation NYNMyFarmTuDiZengSongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"土地赠送";
    
    for (int i = 0; i < 10 ; i++) {
        NYNTuDiZengSongModel *model = [[NYNTuDiZengSongModel alloc]init];
        if (i == 0) {
            model.isChoose = YES;
        }else{
            model.isChoose = NO;
        }
        [self.dataArr addObject:model];
        
    }
    
    [self setTable];
    
    UIButton *zengSong = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(46) - 64, SCREENWIDTH, JZHEIGHT(46))];
    [zengSong setTitle:@"赠送" forState:0];
    zengSong.backgroundColor = Color90b659;
    [zengSong setTitleColor:[UIColor whiteColor] forState:0];
    zengSong.titleLabel.font = JZFont(14);
    [zengSong addTarget:self action:@selector(zengsong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zengSong];
}

- (void)setTable{
    [self.view addSubview:self.tuDiZengSongTable];
    self.tuDiZengSongTable.delegate = self;
    self.tuDiZengSongTable.dataSource = self;
    self.tuDiZengSongTable.showsVerticalScrollIndicator = NO;
    self.tuDiZengSongTable.showsHorizontalScrollIndicator = NO;
    self.tuDiZengSongTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(156))];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *zengSongLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(16), SCREENWIDTH - JZWITH(20), JZHEIGHT(14))];
    zengSongLabel.text = @"将土地赠送给TA";
    zengSongLabel.font = JZFont(14);
    [headerView addSubview:zengSongLabel];
    
    UILabel *phoneNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(11), zengSongLabel.bottom + JZHEIGHT(26), JZWITH(70), JZHEIGHT(13))];
    phoneNumLabel.text = @"电话号码";
    phoneNumLabel.font = JZFont(13);
    phoneNumLabel.textColor = Color686868;
    
    [headerView addSubview:phoneNumLabel];
    
    UITextField *phoneTf = [[UITextField alloc]initWithFrame:CGRectMake(phoneNumLabel.right + JZWITH(10), zengSongLabel.bottom + JZHEIGHT(20), JZWITH(201), JZHEIGHT(26))];
    phoneTf.layer.cornerRadius = 5;
    phoneTf.layer.masksToBounds = YES;
    [headerView addSubview:phoneTf];
    phoneTf.placeholder = @"   输入搜索的电话号码";
    [phoneTf setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    phoneTf.backgroundColor = Colorededed;
    
    UIButton *guanJianCiButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(25) - JZWITH(40), phoneTf.top, JZWITH(40)  , phoneTf.height)];
    [guanJianCiButton setTitle:@"关键词" forState:0];
    [guanJianCiButton setTitleColor:Color90b659 forState:0];
    guanJianCiButton.titleLabel.font = JZFont(13);
    guanJianCiButton.titleLabel.textAlignment = 1;
    [headerView addSubview:guanJianCiButton];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, headerView.height - JZHEIGHT(65), SCREENWIDTH, JZHEIGHT(65))];
    bottomView.backgroundColor = Colorededed;
    [headerView addSubview:bottomView];
    
    UILabel *shuoMingLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(10), SCREENWIDTH - JZWITH(20), bottomView.height - JZHEIGHT(20))];
    [bottomView addSubview:shuoMingLabel];
    shuoMingLabel.textColor = Color888888;
    shuoMingLabel.font= JZFont(12);
    shuoMingLabel.text = @"提示：土地赠送给他人后，对方将获得该土地的对应权限，同事该 土地将会从您的土地列表中消失";
    shuoMingLabel.numberOfLines = 0;
    [headerView addSubview:bottomView];
    
    self.tuDiZengSongTable.tableHeaderView = headerView;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArr.count;
    return self.dataArr.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NYNMyFarmTuDiZengSongTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmTuDiZengSongTableViewCell class]) owner:self options:nil].firstObject;
    }
    
    farmLiveTableViewCell.iconImageView.image = PlaceImage;
    
    NYNTuDiZengSongModel *model = self.dataArr[indexPath.row];
    if (model.isChoose) {
        farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_selected2");
    }else{
        farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_unchecked");

    }
    
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(56);
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(46))];
    v.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), 0, JZWITH(200), JZHEIGHT(46))];
    titleLabel.font = JZFont(14);
    titleLabel.text = @"好友列表";
    titleLabel.textColor = Color252827;
    [v addSubview:titleLabel];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(46) - 0.5, SCREENWIDTH, 0.5)];
    bottomView.backgroundColor = Colorededed;
    [v addSubview:bottomView];
    
    return v;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.00001)];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return JZHEIGHT(46);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (NYNTuDiZengSongModel *model in self.dataArr) {
        model.isChoose = NO;
    }
    
    NYNTuDiZengSongModel *nowModel = self.dataArr[indexPath.row];
    nowModel.isChoose = YES;
    
    [self.tuDiZengSongTable reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tuDiZengSongTable{
    if (!_tuDiZengSongTable) {
        _tuDiZengSongTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(46)) style:UITableViewStyleGrouped];
    }
    return _tuDiZengSongTable;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}


- (void)zengsong{
    [self showTipsView:@"研发当中"];
}
@end
