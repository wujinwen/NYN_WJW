//
//  FTSearchViewController.m
//  FarmerTreasure
//
//  Created by 123 on 2017/4/27.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTSearchViewController.h"
#import "OJLLabelLayout.h"
#import "OJLCollectionViewCell.h"
#import "SXPoperTableView.h"
#import "DXPopover.h"

@interface FTSearchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,OJLLabelLayoutDelegate,SXPoperTableViewDelegate>
@property (nonatomic,strong) UIView *navView;
@property (nonatomic, strong) NSMutableArray* titles;
@property (nonatomic, weak) UICollectionView* collectionView;
@property (nonatomic, weak) UITextField* textField;
@property (nonatomic,strong) DXPopover *popover;

@end

@implementation FTSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    
    [self configUI];
    
    
    [self createMarkCollection];
}

- (void)setNav{
    UIView *nav = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREENWIDTH,64)];
    nav.backgroundColor = KNaviBarTintColor;
    [self.view addSubview:nav];
    self.navView = nav;
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, nav.width, nav.height)];
    backImageView.image = Imaged(@"public_title bar");
    [nav addSubview:backImageView];
    
    UIImageView *backV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 32, 10, 17)];
    backV.image = Imaged(@"public_icon_return");
    [nav addSubview:backV];
    
    UIButton *backBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 64)];
    [nav addSubview:backBt];
    [backBt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *searchMiddleView = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(65), 28, JZWITH(231), JZHEIGHT(30))];
    searchMiddleView.backgroundColor = [UIColor whiteColor];
    searchMiddleView.layer.cornerRadius = 5;
    searchMiddleView.layer.masksToBounds = YES;
    [nav addSubview:searchMiddleView];
    
    UIButton *chooseButton = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(10), 0, JZWITH(35), searchMiddleView.height)];
    [searchMiddleView addSubview:chooseButton];
    UILabel *chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, JZHEIGHT(8), JZWITH(40), JZHEIGHT(12))];
    chooseLabel.text = @"农场";
    chooseLabel.font = JZFont(13);
    chooseLabel.textColor = RGB104;
    chooseLabel.userInteractionEnabled = NO;
    [chooseButton addSubview:chooseLabel];
    UIImageView *chooseImageView = [[UIImageView alloc]initWithFrame:CGRectMake( JZWITH(35), JZHEIGHT(12), JZWITH(5), JZHEIGHT(5))];
    chooseImageView.image = PlaceImage;
    chooseImageView.userInteractionEnabled = NO;
    [chooseButton addSubview:chooseImageView];
    [chooseButton addTarget:self action:@selector(chooseFarm) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *searchTF = [[UITextField alloc]initWithFrame:CGRectMake(chooseButton.right + JZWITH(11), JZHEIGHT(8), JZWITH(200 - 15), searchMiddleView.height - JZHEIGHT(10))];
    searchTF.placeholder = @"输入你要搜索的内容";
    [searchTF setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    searchTF.font = JZFont(14);
    searchTF.textColor = RGB136;
    [searchMiddleView addSubview:searchTF];
    self.textField = searchTF;
    
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 10 - JZWITH(40), searchMiddleView.top, JZWITH(40), JZHEIGHT(29))];
    [searchButton setTitle:@"搜索" forState:0];
    [searchButton setTitleColor:[UIColor whiteColor] forState:0];
    searchButton.titleLabel.font = JZFont(13);
    [nav addSubview:searchButton];
    [searchButton addTarget:self action:@selector(searchGo) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configUI{
    UILabel *historySearchResultLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(16) + 64, JZWITH(100), JZHEIGHT(13))];
    historySearchResultLabel.text = @"历史搜索";
    historySearchResultLabel.font = JZFont(13);
    historySearchResultLabel.textColor = RGB40;
    [self.view addSubview:historySearchResultLabel];
    
    
    UIButton *detelBt = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(11 + 16), JZHEIGHT(16) + 64, JZWITH(11), JZHEIGHT(12))];
    UIImageView *detelImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, detelBt.width, detelBt.height)];
    detelImageView.userInteractionEnabled = NO;
    detelImageView.image = PlaceImage;
    [detelBt addSubview:detelImageView];
    [self.view addSubview:detelBt];
    [detelBt addTarget:self action:@selector(detel) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma action
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooseFarm{
    JZLog(@"选择农场");
    
    CGPoint starPoint = CGPointMake(75, 58);
    SXPoperTableView *poptableView = [[SXPoperTableView alloc]initWithFrame:CGRectMake(0, 0, 104, 40 * 3)];
    poptableView.arrayData = @[@"农场",@"农产品",@"水产品"];
    poptableView.delegate = self;
    [self.popover showAtPoint:starPoint popoverPostion:DXPopoverPositionDown withContentView:poptableView inView:self.view];
    [poptableView reloadTableView];
}

- (void)searchGo{
    JZLog(@"点击了搜索");
    if (self.textField.text.length) {
        [self.titles addObject:self.textField.text];
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.titles.count - 1 inSection:0]]];
    }
}

- (void)detel{
    JZLog(@"点击了删除");
    
    [self.titles removeAllObjects];
    [self.collectionView  reloadData];
//    [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:0]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark
static NSString* identifier = @"cell";
- (NSArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray arrayWithArray:@[@"这是第1条标签",@"这是第2条标签用来测试很长的长度的",@"这个第3条比较短",@"测试的第4个",@"测试的第5个af",@"第6个",@"7",@"8随便插"]];
        
    }
    return _titles;
}

-(DXPopover *)popover{
    if (!_popover) {
        _popover = [DXPopover popover];
    }
    return _popover;
}


- (void)createMarkCollection{
    OJLLabelLayout* layout = [[OJLLabelLayout alloc] init];
    layout.panding = JZHEIGHT(10);
    layout.rowPanding = JZWITH(15);
    layout.delegate = self;
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 29+64, SCREENWIDTH - 20, SCREENHEIGHT - 64 - 29 - 10) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerNib:[UINib nibWithNibName:@"OJLCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:collectionView];
}


#pragma mark OJLLabelLayoutDelegate
-(NSArray *)OJLLabelLayoutTitlesForLabel{
    return self.titles;
}
#pragma mark UICollectionViewDataSource,UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OJLCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [cell setTitle:self.titles[indexPath.item]];
//    [cell setTitle:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.titles[indexPath.item]);
    [self.titles removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];

}


#pragma popViewDelegate
- (void)clickItemAtIndex:(NSInteger)index withValue:(NSString *) value{
    JZLog(@"选择农产品:%ld",(long)index);
    [self.popover dismiss];

}
@end
