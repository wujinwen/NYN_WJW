//
//  AgritmntViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "AgritmntViewController.h"

#import "NYNFarmChooseButton.h"
#import "NYNSrollSelectButton.h"
#import "FTFarmListTableViewCell.h"

@interface AgritmntViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *uppics;
//选择view
@property (nonatomic,strong) UIView *selecteBackView;
//选择bt的数组
@property (nonatomic,strong) NSMutableArray *btArr;

//低级选项的button数组   全部 种植  养殖 这些
@property (nonatomic,strong) NSMutableArray *ziCellButtonArr;

@property(nonatomic,strong)UITableView * agritTableView;//农家乐

//下部滑动scollView
@property (nonatomic,strong) UIScrollView *scrollViewBack;

//高级里面的数据数组
@property (nonatomic,strong) NSMutableArray *bannerSelectDataArr;
@property (nonatomic,strong) NSArray *selectUppics;
@property (nonatomic,strong) NSArray *selectDownpics;

@end

@implementation AgritmntViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title =@"农家乐";
    [self configData];
    [self creatHeadTitle];
    [self.view addSubview:self.agritTableView];
    
    
 
}

-(void)configData{
    self.titles = @[@"综合排序",@"人气",@"距离",@"高级筛选"];
    self.uppics = @[@"",@"farm_icon_screen1",@"farm_icon_screen1",@"farm_icon_screen2"];
    self.selectUppics = @[@"",@"farm_icon_screen3",@"farm_icon_screen3",@"farm_icon_scree6"];
    self.selectDownpics = @[@"",@"farm_icon_screen4",@"farm_icon_screen4",@"farm_icon_scree6"];

}

-(void)creatHeadTitle{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(62))];
    backView.backgroundColor = Colore3e3e3;
    [self.view addSubview:backView];
    UIView *selecteBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(41 ))];
    selecteBackView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:selecteBackView];
    selecteBackView.clipsToBounds = NO;
    
    CGFloat btWith = SCREENWIDTH / 4;
    for (int i = 0; i < 4; i ++) {
        NYNFarmChooseButton *bt =[[NYNFarmChooseButton alloc]initWithFrame:CGRectMake(0 + btWith * i, 0, btWith, selecteBackView.height)];
        bt.textLabel.text = self.titles[i];
        bt.picImageView.image = Imaged(self.uppics[i]);
        bt.indexFB = i;
        [bt addTarget:self action:@selector(clickBT:) forControlEvents:UIControlEventTouchUpInside];
        [selecteBackView addSubview:bt];
        
        if (i == 0) {
            bt.textLabel.textColor = Color90b659;
        }
        
        [self.btArr addObject:bt];
    }
    
    UIScrollView *scrollViewBack = [[UIScrollView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(41.5), SCREENHEIGHT, JZHEIGHT(41))];
    scrollViewBack.backgroundColor = [UIColor whiteColor];
    [backView addSubview:scrollViewBack];
    //    (JZWITH(50) + JZWITH(13)) * 7 + 65
    scrollViewBack.contentSize = CGSizeMake((JZWITH(50) + JZWITH(13)) + JZWITH(120) * self.bannerSelectDataArr.count, 0);
    scrollViewBack.hidden = YES;
    scrollViewBack.scrollEnabled = YES;
    self.scrollViewBack = scrollViewBack;
    scrollViewBack.userInteractionEnabled = YES;
    scrollViewBack.showsVerticalScrollIndicator = NO;
    scrollViewBack.showsHorizontalScrollIndicator = NO;
    
    UILabel *zhuYingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, (scrollViewBack.height - 12) / 2, 40, 12)];
    zhuYingLabel.text = @"主营:";
    zhuYingLabel.font = JZFont(13);
    zhuYingLabel.textColor = Color686868;
    [scrollViewBack addSubview:zhuYingLabel];
    
}

- (void)clickBT:(NYNFarmChooseButton *)sender{
    if (sender.indexFB == 3) {
        
    }else{
        for (int i = 0; i < self.btArr.count; i++) {
            if (i == 3) {
                continue;
            }
            
            NYNFarmChooseButton *bt = self.btArr[i];
            
            bt.textLabel.textColor = Color686868;
            
            bt.picImageView.image = Imaged(self.uppics[i]);
        }
        sender.textLabel.textColor = Color90b659;
        
    }
    
    //清空数据
    switch (sender.indexFB) {
        case 0:
           break;
        case 1:
            break;
            
        case 2:
        {
            sender.isAsc = !sender.isAsc;
            if (sender.isAsc) {
                sender.picImageView.image = Imaged(self.selectUppics[2]);
                
//                [self.postDic setObject:@"position" forKey:@"sort"];
//                [self.postDic setObject:@"asc" forKey:@"orderBy"];
            }else{
                sender.picImageView.image = Imaged(self.selectDownpics[2]);
                
//                [self.postDic setObject:@"position" forKey:@"sort"];
//                [self.postDic setObject:@"desc" forKey:@"orderBy"];
            }
        }
            break;
        case 3:
        {
            sender.isAsc = !sender.isAsc;
            
            if (sender.isAsc) {
                sender.textLabel.textColor = RGB_COLOR(56, 57, 56);
                for (NYNSrollSelectButton *bt in self.ziCellButtonArr) {
                    bt.textLabel.textColor = Color686868;
                }
                
            }else{
                sender.textLabel.textColor = Color90b659;
                
            }
            
            if (!sender.isAsc) {
                [UIView animateWithDuration:.5 animations:^{
                    self.agritTableView.frame = CGRectMake(0, 64+JZHEIGHT(41)+JZHEIGHT(5)+JZHEIGHT(41), SCREENWIDTH, SCREENHEIGHT - (64 + JZHEIGHT(41) + JZHEIGHT(5) + 50) - JZHEIGHT(41));
                }];
                
                self.scrollViewBack.hidden = NO;
            }else{
                [UIView animateWithDuration:.5 animations:^{
                    self.agritTableView.frame = CGRectMake(0, 64+JZHEIGHT(41)+JZHEIGHT(5), SCREENWIDTH, SCREENHEIGHT - (64 + JZHEIGHT(41) + JZHEIGHT(5) + 50));
                }];
                
                self.scrollViewBack.hidden = YES;
            }
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark--UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FTFarmListTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTFarmListTableViewCell class]) owner:self options:nil].firstObject;
    }
    return farmLiveTableViewCell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(100);
}

#pragma mark---懒加载
-(NSMutableArray *)btArr{
    if (!_btArr) {
        _btArr = [[NSMutableArray alloc]init];
    }
    return _btArr;
}

-(UITableView *)agritTableView{
    if (!_agritTableView) {
        _agritTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(41)+JZHEIGHT(5), SCREENWIDTH, SCREENHEIGHT - (64 + JZHEIGHT(41) + JZHEIGHT(5) + 50)) style:UITableViewStylePlain];
        _agritTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _agritTableView.delegate = self;
        _agritTableView.dataSource = self;
        _agritTableView.showsVerticalScrollIndicator = NO;
        _agritTableView.showsHorizontalScrollIndicator = NO;
    }
    return _agritTableView;
    
}
@end
