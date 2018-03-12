//
//  NYNMyPageViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/1.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMyPageViewController.h"
#import "FTMeInfoViewController.h"
#import "NYNMyPageTableViewCell.h"
#import "NYNMeAlbumManagerViewController.h"
#import "NYNPicModel.h"
#import "SDCycleScrollView.h"

@interface NYNMyPageViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic,strong) UITableView *MyPageTable;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *sexImageView;
@property (nonatomic,strong) UILabel *levelLabel;
@property (nonatomic,strong) SDCycleScrollView *bannerImageView;
@property (nonatomic,strong) UIView *addView;
@property (nonatomic,strong) UIView *headerView;
@end

@implementation NYNMyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNav];
    
    [self createMyPageTable];

    ADD_NTF_OBJ(@"login", @selector(changeInfo), nil);
    
    [self reloadHeaderImages];
}

- (void)changeInfo{
    UserInfoModel *userModel = userInfoModel;
    self.nameLabel.text = userModel.name;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:PlaceImage];
    
    if ([userModel.sex isEqualToString:@"1"]) {
        //男
        self.sexImageView.image = Imaged(@"mine_icon_male");
    }else{
        //女
        self.sexImageView.image = Imaged(@"mine_icon_female");
    }
    
    CGFloat nameLabelWith = [MyControl getTextWith:userModel.name andHeight:JZHEIGHT(16) andFontSize:16];
    self.nameLabel.frame = CGRectMake(self.headerImageView.right + JZWITH(11), JZHEIGHT(165), nameLabelWith, JZHEIGHT(16));
    self.levelLabel.frame = CGRectMake(self.nameLabel.right + JZWITH(10), JZHEIGHT(168), JZWITH(30), JZHEIGHT(10));
    
}

- (void)setNav{
    self.title= @"个人主页";
    
    UIButton *bianji = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(30), JZHEIGHT(20))];
    [bianji setTitle:@"编辑" forState:0];
    [bianji setTitleColor:[UIColor whiteColor] forState:0];
    bianji.titleLabel.font = JZFont(13);
    [bianji addTarget:self action:@selector(bianji) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:bianji];
    
}

- (void)bianji{
    FTMeInfoViewController *vc = [FTMeInfoViewController new];
    [self.navigationController pushViewController:vc animated:YES
     ];
}

- (void)createMyPageTable{
    
    UIView *addView = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(112), JZHEIGHT(81), JZWITH(151), JZHEIGHT(29))];
    self.addView = addView;
    addView.layer.cornerRadius = 5;
    addView.layer.masksToBounds = YES;
    addView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
    addView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goAlbum)];
    [addView addGestureRecognizer:tap];
    UIImageView *addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(8), JZHEIGHT(7), JZWITH(15), JZHEIGHT(15))];
    addImageView.image = Imaged(@"meAddImage");
    addImageView.userInteractionEnabled = NO;
    UILabel *addTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(addImageView.right + JZWITH(5), 0, addView.width - addImageView.right - JZWITH(5), addView.height)];
    addTextLabel.text = @"点击上传照片到相册";
    addTextLabel.font = JZFont(13);
    addTextLabel.textColor = [UIColor whiteColor];
    addTextLabel.userInteractionEnabled = NO;
    [addView addSubview:addImageView];
    [addView addSubview:addTextLabel];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(280))];
    headerView.backgroundColor = [UIColor whiteColor];
    self.headerView = headerView;
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(190))];
    backImageView.image = Imaged(@"WechatIMG7");
    [headerView addSubview:backImageView];
    backImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tappp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goAlbum)];
    [backImageView addGestureRecognizer:tappp];
    
//    SDCycleScrollView *bannerImageView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(190)) delegate:self placeholderImage:Imaged(@"WechatIMG7")];
//    self.bannerImageView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//    self.bannerImageView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    [headerView addSubview:backImageView];
    
    [headerView addSubview:addView];

    UserInfoModel *userModel = userInfoModel;
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(15), JZHEIGHT(155), JZWITH(70), JZHEIGHT(70))];
    headerImageView.image = PlaceImage;
    headerImageView.layer.cornerRadius = JZWITH(35);
    headerImageView.layer.masksToBounds = YES;
    self.headerImageView = headerImageView;
    
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:PlaceImage];
    [headerView addSubview:headerImageView];
    
    
    CGFloat nameLabelWith = [MyControl getTextWith:userModel.name andHeight:JZHEIGHT(16) andFontSize:16];
    UILabel *guanjianCiLabel = [[UILabel alloc]initWithFrame:CGRectMake(headerImageView.right + JZWITH(11), JZHEIGHT(165), nameLabelWith, JZHEIGHT(16))];
    guanjianCiLabel.text = userModel.name;
    guanjianCiLabel.textColor = [UIColor whiteColor];
    guanjianCiLabel.font = JZFont(16);
    [headerView addSubview:guanjianCiLabel];
    self.nameLabel = guanjianCiLabel;
    
    UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(guanjianCiLabel.right + JZWITH(10), JZHEIGHT(168), JZWITH(30), JZHEIGHT(10))];
    levelLabel.text = @"LV 1";
    levelLabel.font = JZFont(9);
    levelLabel.textColor = [UIColor whiteColor];
    levelLabel.backgroundColor = [UIColor colorWithHexString:@"fa9b16"];
    levelLabel.layer.cornerRadius = 3;
    levelLabel.layer.masksToBounds = YES;
    levelLabel.textAlignment = 1;
    [headerView addSubview:levelLabel];
    self.levelLabel = levelLabel;
    
    UIImageView *sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(headerImageView.right + JZWITH(11), JZHEIGHT(190) + JZHEIGHT(18), JZWITH(11), JZHEIGHT(11))];
    self.sexImageView = sexImageView;
    if ([userModel.sex isEqualToString:@"1"]) {
        //男
        self.sexImageView.image = Imaged(@"mine_icon_male");
    }else{
        //女
        self.sexImageView.image = Imaged(@"mine_icon_female");
    }
    
    
    [headerView addSubview:sexImageView];
    
    UILabel *userDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(sexImageView.right + JZWITH(5), sexImageView.top, JZWITH(111), sexImageView.height)];
    UserInfoModel *model = userModel;
    //这里把死数据的地址取消掉了
    userDetailLabel.text = [NSString stringWithFormat:@"26岁 成都"];
    userDetailLabel.font = JZFont(13);
    userDetailLabel.textColor = Color252827;
    [headerView addSubview:userDetailLabel];
    
    UIImageView *locationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(userDetailLabel.right + JZWITH(5), userDetailLabel.top, JZWITH(7), JZHEIGHT(9))];
    locationImageView.image = Imaged(@"mine_icon_address2");
    [headerView addSubview:locationImageView];
    
    UILabel *locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(locationImageView.right+JZWITH(6), userDetailLabel.top, JZWITH(40), userDetailLabel.height)];
    locationLabel.textColor = Color686868;
    locationLabel.font = JZFont(11);
    locationLabel.text = @"235km";
    [headerView addSubview:locationLabel];
    
    UIView *shuLien = [[UIView alloc]initWithFrame:CGRectMake(locationLabel.right + JZWITH(20), locationLabel.top, JZWITH(1), locationLabel.height)];
    shuLien.backgroundColor = RGB_COLOR(162, 162, 162);
    [headerView addSubview:shuLien];
    
    UIImageView *zanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(shuLien.right + JZWITH(10), shuLien.top, JZWITH(15), JZHEIGHT(12))];
    zanImageView.image = Imaged(@"mine_icon_follow");
    [headerView addSubview:zanImageView];
    
    UILabel *zanNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(zanImageView.right+JZWITH(5), zanImageView.top, JZWITH(40), shuLien.height)];
    zanNumLabel.text = @"123";
    zanNumLabel.font = JZFont(11);
    zanNumLabel.textColor = Color686868;
    [headerView addSubview:zanNumLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(20), JZHEIGHT(235), SCREENWIDTH - JZWITH(20), JZHEIGHT(0.5))];
    lineView.backgroundColor = Colore3e3e3;
    [headerView addSubview:lineView];
    
    UILabel *signLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(20), lineView.bottom + JZHEIGHT(10), SCREENWIDTH - JZWITH(40), JZHEIGHT(20))];
    signLabel.text = [NSString stringWithFormat:@"个性签名  %@",model.signature];
    signLabel.font = JZFont(13);
    signLabel.textColor = Color252827;
    [headerView addSubview:signLabel];
    
    
    self.MyPageTable.tableHeaderView = headerView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.MyPageTable.delegate = self;
    self.MyPageTable.dataSource = self;
    self.MyPageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.MyPageTable.showsVerticalScrollIndicator = NO;
    self.MyPageTable.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.MyPageTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NYNMyPageTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyPageTableViewCell class]) owner:self options:nil].firstObject;
    }
    
//    cell.textLabel.text = @"It is awesome";
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(274);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  JZHEIGHT(38) + 5 : 5)];
    
    if (section == 0) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, SCREENWIDTH, JZHEIGHT(38))];
        headView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:headView];
        
        UILabel *dongTaiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, JZWITH(150), JZHEIGHT(38))];
        dongTaiLabel.text = @"动态";
        dongTaiLabel.font = JZFont(14);
        dongTaiLabel.textColor = Color252827;
        [headView addSubview:dongTaiLabel];
        
        UIButton *jiabutton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 10 - JZWITH(19), (JZHEIGHT(38) - JZHEIGHT(19)) / 2, JZWITH(19), JZHEIGHT(19))];
        [jiabutton addTarget:self action:@selector(headerJia) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *jiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, jiabutton.width, jiabutton.height)];
        jiaImageView.image = Imaged(@"mine_icon_add-to");
        jiaImageView.userInteractionEnabled = NO;
        [jiabutton addSubview:jiaImageView];
        
        [headView addSubview:jiabutton];
        
    }
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ?  JZHEIGHT(38) + 5 : 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return footerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma 懒加载
-(UITableView *)MyPageTable
{
    if (!_MyPageTable) {
        _MyPageTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 ) style:UITableViewStyleGrouped];
    }
    return _MyPageTable;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
        
    }
    return _dataArr;
}

#pragma 触发事件
- (void)headerJia{
    JZLog(@"触发事件");
}

- (void)goAlbum{
    JZLog(@"进入相册");
    
    NYNMeAlbumManagerViewController *vc = [[NYNMeAlbumManagerViewController alloc]init];
    __weak typeof(self)weakSelf = self;
    vc.picBack = ^{
        [weakSelf reloadHeaderImages];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)reloadHeaderImages{
    [self showLoadingView:@""];
    [NYNNetTool GetPicsWithparams:@{} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            JZLog(@"");
            NSMutableArray *urlImages = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in success[@"data"]) {
                [urlImages addObject:[NSString stringWithFormat:@"%@",dic[@"url"]]];
                
            }
            
            [self.bannerImageView removeFromSuperview];

            if (urlImages.count > 0 ) {
                self.addView.hidden = YES;
//                [self.bannerImageView removeFromSuperview];
//                [self.bannerImageView.superview addSubview:self.bannerImageView];
                
                
                SDCycleScrollView *bannerImageView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(190)) delegate:self placeholderImage:Imaged(@"WechatIMG7")];
                self.bannerImageView = bannerImageView;
                self.bannerImageView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
                self.bannerImageView.imageURLStringsGroup = urlImages;
                self.bannerImageView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
//                [self.headerView addSubview:bannerImageView];
                [self.headerView insertSubview:self.bannerImageView belowSubview:self.headerImageView];
                
                
            }else{
                self.addView.hidden = NO;
            }
            
//            NYNPicModel *model = [[NYNPicModel alloc]init];
//            [self.picsArr addObject:model];
//            
//            [self.albumCollectionView reloadData];
            //           +号图片的名字 mePicJIia
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self goAlbum];
}
@end
