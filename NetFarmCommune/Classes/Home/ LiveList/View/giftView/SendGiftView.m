//
//  SendGiftView.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "SendGiftView.h"
#import "GiftCollectionViewCell.h"
#define celll @"cell"
#import "NYNNetTool.h"
#import "NYNNetTool.h"
#import "Masonry.h"
#import "GiftListModel.h"
#import "ZWPullMenuView.h"

@interface SendGiftView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSString * picString;
    
}

@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSMutableArray * allArray;//礼物数据
@property(nonatomic,strong) NSString * giftID;//礼物ID
@property(nonatomic,strong)NSString * giftName;//礼物名字
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)UIButton * numberBtn;
@property(nonatomic,strong)UIView * baclView;




@end


@implementation SendGiftView

-(instancetype)initWithFrame:(CGRect)frame{
   self =  [super initWithFrame:frame];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}


-(void)initiaInterface{
  

    
    
    UIColor * color = [UIColor blackColor];
    self.backgroundColor = [color colorWithAlphaComponent:0.7];
    
//    _baclView = [[UIView alloc]init];
//    UIColor * color1 = [UIColor blackColor];
//    _baclView.backgroundColor = [color1 colorWithAlphaComponent:0.5];
    //[self addSubview:_baclView];
//    [_baclView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_offset(0);
//        make.height.mas_offset(300);
//
//
//    }];
    
    
    
    
    
    _allArray=[[NSMutableArray alloc]init];
    ;
    
//    _allArray = [NSMutableArray arrayWithObjects:@"占位图",@"占位图",@"占位图",@"占位图",@"占位图",@"占位图",@"占位图",@"占位图",@"占位图",@"占位图",@"占位图", nil];
//    [self addSubview:self.collectionview];
    
    _scrollbuttom = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT/3)];
    _scrollbuttom.contentSize = CGSizeMake(SCREENWIDTH*((self.allArray.count/8)+1), 0);
    _scrollbuttom.pagingEnabled = YES;
    _scrollbuttom.showsHorizontalScrollIndicator = NO;
    _scrollbuttom.delegate = self;
    _scrollbuttom.bounces = NO;
    [_scrollbuttom addSubview:self.collectionview];
    [self addSubview:_scrollbuttom];
    
    
    
    UIView * leftView = [[UIView alloc]init];
    leftView.layer.cornerRadius = 10;
    leftView.clipsToBounds = YES;
    leftView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    leftView.layer.borderWidth =1;
    [self addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.height.mas_offset(30);
        make.width.mas_offset(150);
        make.bottom.mas_offset(-20);
    }];
    
    UILabel * yueLabel = [[UILabel alloc]init];
    yueLabel.textColor = [UIColor whiteColor];
    yueLabel.text = @"余额:0金豆";
    yueLabel.font = [UIFont systemFontOfSize:12];
    [leftView addSubview:yueLabel];
    [yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(80);
        make.height.mas_offset(35);
        make.bottom.mas_offset(-1);
        
    }];
    
    UIButton * chongzhiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chongzhiBtn setTitle:@"充值" forState:UIControlStateNormal];
    [chongzhiBtn setTitleColor:Color90b659 forState:UIControlStateNormal];
    chongzhiBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [chongzhiBtn addTarget:self action:@selector(chongzhiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [leftView addSubview:chongzhiBtn];
    [chongzhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yueLabel.mas_right).offset(10);
        make.width.mas_offset(50);
        make.height.mas_offset(30);
        make.bottom.mas_offset(0);
        
    }];

    UIView * rightView = [[UIView alloc]init];
    rightView.layer.cornerRadius = 15;
    rightView.clipsToBounds = YES;
    rightView.layer.borderWidth =1;
    rightView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(JZWITH(-20));
        make.height.mas_offset(30);
        make.width.mas_offset(110);
        make.bottom.mas_offset(-20);
    }];
    
    
    _numberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_numberBtn setTitle:@"1000 >" forState:UIControlStateNormal];
    _numberBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_numberBtn addTarget:self action:@selector(numberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_numberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightView addSubview:_numberBtn];
    [_numberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rightView.mas_left).offset(10);
        make.width.mas_offset(50);
        make.height.mas_offset(35);
        make.bottom.mas_offset(0);
        
    }];
    
    UIButton * sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [rightView addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_numberBtn.mas_right).offset(1);
        make.width.mas_offset(50);
        make.height.mas_offset(30);
        make.bottom.mas_offset(0);
        
    }];
    //调礼物列表
    [self getLiveList];
    
    
    
    
}
//数量按钮
-(void)numberBtnClick:(UIButton*)sender{
    NSArray * listArr = [NSArray arrayWithObjects: @"  其他数量  ",@"10000 万丈光芒",@"1000 千金买笑",@"100  百花齐放",@"10   十全十美",@"1   百里挑一", nil];
    
    ZWPullMenuView *menuView = [ZWPullMenuView pullMenuAnchorView:sender titleArray:@[
                                                                                      @"  其他数量  ",
                                                                                      @"10000 万丈光芒",
                                                                                      @"1000 千金买笑",
                                                                                      @"100  百花齐放",
                                                                                      @"10   十全十美",
                                                                                      @"1   百里挑一"]];
    menuView.zwPullMenuStyle = PullMenuLightStyle;
    menuView.blockSelectedMenu = ^(NSInteger menuRow) {
        
        
        [_numberBtn setTitle:listArr[(long)menuRow]  forState:UIControlStateNormal];
        

    };
    
}
//发送礼物
-(void)sendBtnClick:(UIButton*)sender{
    
    [self.delegate SendGift:sender giftID:_giftID giftPic:picString giftName:_giftName];
    
    
    
    
   
}
//充值

-(void)chongzhiBtnClick:(UIButton*)sender{
//    NYNGouMaiWangNongBiViewController *
    [self.delegate chongzhiBtnClick:sender];
    
}

//获取礼物列表
-(void)getLiveList{
    [NYNNetTool GetSendGiftListWithparams:nil isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
//            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
//
////                GiftListModel *model = [GiftListModel mj_objectWithKeyValues:dic];
//                [self.allArray addObject:dic];
//            }
            self.allArray = [success[@"data"]mutableCopy];
            
            [self.collectionview reloadData];
        
        }else{
            
        }
    } failure:^(NSError *failure) {
        
    }];
}

#pragma mark--UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allArray.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GiftCollectionViewCell *cell = (GiftCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:celll forIndexPath:indexPath];
    if (![[_allArray[indexPath.row] valueForKey:@"img"] isKindOfClass:[NSNull class]]) {
        [cell.giftImage sd_setImageWithURL:[NSURL URLWithString:[_allArray[indexPath.row] valueForKey:@"img" ]] placeholderImage:[UIImage imageNamed:@"占位图"]];

    }
    if ([_allArray[indexPath.row]valueForKey:@"name"] !=nil) {
//          cell.titleLabel.text  =[_allArray[indexPath.row] valueForKey:@"name"];
        cell.titleLabel.text  =[NSString stringWithFormat:@"%@金豆",[_allArray[indexPath.row] valueForKey:@"score"]];

    }
    if (_giftID) {
        if ([_allArray[indexPath.row]valueForKey:@"id"]==_giftID) {
            cell.layer.borderColor = Color90b659.CGColor;
            cell.layer.cornerRadius =5;
            cell.clipsToBounds=YES;
            
            cell.layer.borderWidth = 2;
        }else{
            cell.layer.borderWidth = 0;

        }
    }
    
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//     GiftCollectionViewCell *cell = (GiftCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    _giftID =[_allArray[indexPath.row] valueForKey:@"id"];
    _giftName = [_allArray[indexPath.row] valueForKey:@"name"];
    [self.collectionview reloadData];
    
    picString =[_allArray[indexPath.row] valueForKey:@"img" ];

    
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
 //   GiftCollectionViewCell *cell = (GiftCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

}

//每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int cellWidth = SCREENWIDTH/4;
    int cellHeight = ( SCREENHEIGHT/3- SCREENHEIGHT/18)/2;
    return CGSizeMake(cellWidth ,cellHeight);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionview.backgroundColor =  [UIColor redColor];
        
//        [flowLayout setItemSize:CGSizeMake(JZWITH(172), JZWITH(172))];//设置cell的尺寸
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];//设置其布局方向
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//设置其边界
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT/3-SCREENWIDTH/18)collectionViewLayout:flowLayout];
        flowLayout.itemSize = CGSizeMake(SCREENWIDTH/4, ( SCREENHEIGHT/3- SCREENHEIGHT/18)/2);
        _collectionview.dataSource = self;
        _collectionview.pagingEnabled = YES ;
        _collectionview.delegate = self;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.scrollEnabled =YES;
        _collectionview.backgroundColor = [UIColor clearColor];
        [_collectionview registerClass:[GiftCollectionViewCell class] forCellWithReuseIdentifier:celll];

    }
    return _collectionview;
    
}

@end
