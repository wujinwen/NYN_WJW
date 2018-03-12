//
//  NYNJiShiHeaderView.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNJiShiHeaderView.h"
#import "NYNMarketHeaderChooseButton.h"
#import "NYNMarketUnitCollectionViewCell.h"
#import "NYNPaiXuTitleModel.h"


@implementation NYNJiShiHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.upIndex = -1;

    }
    return self;
}

- (void)gogo{
    //初始化collection的展示数据  第一个分类的数据
    self.selectLeiModel = [self.marketModel.titleArr firstObject];
    
    self.selectPinZhongModel = [self.selectLeiModel.productCategories firstObject];
    
    
    //设置背景颜色
    self.backgroundColor = Colore3e3e3;
    
    CGFloat titleButtonWith = SCREENWIDTH / self.marketModel.titleArr.count;
    
    for (int i = 0; i < self.marketModel.titleArr.count; i++) {
        NYNMarketCagoryModel *leiModel = self.marketModel.titleArr[i];
        NYNMarketHeaderChooseButton *titleButton = [[NYNMarketHeaderChooseButton alloc]initWithFrame:CGRectMake(0 + titleButtonWith*i, 0, titleButtonWith, JZHEIGHT(41))];
        [titleButton setTitle:leiModel.name forState:0];
        [titleButton setTitleColor:Color383938 forState:0];
        titleButton.titleLabel.font = JZFont(14);
        titleButton.sanJiaoImageView.hidden = YES;
        [self addSubview:titleButton];
        [self.titleButtonArr addObject:titleButton];
        titleButton.senderTag = i;
        
        
        if (i == 0) {
            NYNMarketCagoryModel *ssubModel = [leiModel.productCategories firstObject];
            ssubModel.isChoose = YES;
        }
        if ([leiModel isEqual:self.marketModel.titleArr.firstObject]) {
            //                [titleButton setTitle:leiModel.LeiName forState:0];
            [titleButton setTitleColor:Color90b659 forState:0];
            titleButton.sanJiaoImageView.hidden = NO;
        }
        
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    //划线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(41), SCREENWIDTH, JZHEIGHT(1))];
    lineView.backgroundColor = Color90b659;
    [self addSubview:lineView];
    
    //分类部分
    self.moreView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(42), SCREENWIDTH , JZHEIGHT(130))];
    self.moreView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.moreView];
    
    [self.moreView addSubview:self.HfenLeiCollection];
    
    UIButton *bbButton = [[UIButton alloc]initWithFrame:CGRectMake(0, JZHEIGHT(100), SCREENWIDTH, JZHEIGHT(30))];
    //        bbButton.backgroundColor = [UIColor redColor];
    [bbButton addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    [self.moreView addSubview:bbButton];
    
    UILabel *bottomMoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(171), 0, JZWITH(30), bbButton.height)];
    bottomMoreLabel.text = @"收起";
    bottomMoreLabel.font = JZFont(12);
    bottomMoreLabel.textColor = Color888888;
    bottomMoreLabel.userInteractionEnabled = NO;
    bottomMoreLabel.textAlignment = 2;
    //        moreLabel.backgroundColor = [UIColor yellowColor];
    [bbButton addSubview:bottomMoreLabel];
    
    UIImageView *bottomMoreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(bottomMoreLabel.right + JZWITH(3), (bbButton.height - JZHEIGHT(6)) / 2, JZWITH(10), JZHEIGHT(6))];
    bottomMoreImageView.image = Imaged(@"market_icon_select");
    [bbButton addSubview:bottomMoreImageView];
    
    [self addSubview:self.VfenLeiCollection];
    
    
    
    self.moreView.hidden = YES;
    
    UIButton *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(self.VfenLeiCollection.right, JZHEIGHT(42), JZWITH(50), JZHEIGHT(41))];
    moreButton.backgroundColor = [UIColor whiteColor];
    [self.viewForLastBaselineLayout addSubview:moreButton];
    [moreButton addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    //        [moreButton setTitle:@"qwe" forState:0];
    UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, JZWITH(30), moreButton.height)];
    moreLabel.text = @"更多";
    moreLabel.font = JZFont(12);
    moreLabel.textColor = Color888888;
    moreLabel.userInteractionEnabled = NO;
    moreLabel.textAlignment = 2;
    //        moreLabel.backgroundColor = [UIColor yellowColor];
    [moreButton addSubview:moreLabel];
    
    UIImageView *moreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(moreLabel.right + JZWITH(3), JZHEIGHT(18), JZWITH(10), JZHEIGHT(6))];
    moreImageView.image = Imaged(@"farm_icon_more3");
    [moreButton addSubview:moreImageView];
    
    self.moreButton = moreButton;
    //灰线
    
    //排序条件Button
    NSArray *zongHePaiXuArr = @[@"综合排序",@"销量最高",@"距离最近",@"价格高低 ↑",@"预售产品"];
    NSArray *orderTypeArr = @[@"normal",@"sale",@"position",@"price",@"yushou"];

    
    for (int i = 0; i < zongHePaiXuArr.count; i++) {
        NYNPaiXuTitleModel *model = [[NYNPaiXuTitleModel alloc]init];
        model.orderType = orderTypeArr[i];
        model.name = zongHePaiXuArr[i];
        model.isUp = YES;
        if (i == 0) {
            model.isChoose = YES;
        }
        [self.titleModelArr addObject:model];
    }
    
    CGFloat buttonWith = SCREENWIDTH / zongHePaiXuArr.count;
    UIView *shaiXuanTiaoJianView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(89), SCREENWIDTH, JZHEIGHT(41))];
    shaiXuanTiaoJianView.backgroundColor = [UIColor whiteColor];
    [self addSubview:shaiXuanTiaoJianView];
    self.bottomView = shaiXuanTiaoJianView;
    
    UIView *shaiXuanTiaoJianBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(41) - .5, SCREENWIDTH, .5)];
    shaiXuanTiaoJianBottomView.backgroundColor = Colore3e3e3;
    [shaiXuanTiaoJianView addSubview:shaiXuanTiaoJianBottomView];
    
    for (int i = 0; i < zongHePaiXuArr.count; i++) {
        UIButton *tiaojianButton = [[UIButton alloc]initWithFrame:CGRectMake(0 + buttonWith * i, 0, buttonWith, JZHEIGHT(41))];
        [tiaojianButton setTitle:zongHePaiXuArr[i] forState:0];
        [tiaojianButton setTitleColor:Color686868 forState:0];
        tiaojianButton.titleLabel.font = JZFont(12);
        [shaiXuanTiaoJianView addSubview:tiaojianButton];
        [self.shaiXuanButtonArr addObject:tiaojianButton];
        //下面排序选择
        [tiaojianButton addTarget:self action:@selector(clickBottomItem:) forControlEvents:UIControlEventTouchUpInside];
        tiaojianButton.tag = 5656 + i;
        if (i == 0) {
            [tiaojianButton setTitleColor:Color90b659 forState:0];
            
        }
    }
    
    UIView *shuLine = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(303), JZHEIGHT(14), JZWITH(1), JZHEIGHT(13))];
    shuLine.backgroundColor = Colore3e3e3;
    [shaiXuanTiaoJianView addSubview:shuLine];
}

- (void)layoutSubviews {
    // 一定要调用super的方法
    [super layoutSubviews];
    
    // 确定子控件的frame（这里得到的self的frame/bounds才是准确的）

}

- (void)clickBottomItem:(UIButton *)sender{
    NSInteger nowIndex = sender.tag - 5656;
    
    
    JZLog(@"选择了第%ld个排序类",(long)nowIndex);
    NYNPaiXuTitleModel *nowModel = self.titleModelArr[nowIndex];

    
    if (nowIndex < 4) {

        for (int i = 0; i < 4; i++) {
            NYNPaiXuTitleModel *model = self.titleModelArr[i];
            model.isChoose = NO;
            
        }
        
        nowModel.isChoose = YES;
        
        if (nowIndex == self.upIndex) {
            nowModel.isUp = !nowModel.isUp;
            
            if (nowIndex == 3) {
                if (nowModel.isUp) {
                    nowModel.name = @"价格高低 ↑";
                }else{
                    nowModel.name = @"价格高低 ↓";
                }
            }else{
    
                
            }
            
        }else{
            nowModel.isUp = YES;
        }
        
        
        
    }else{
        
        nowModel.isChoose = !nowModel.isChoose;
    
    }
    
    if (nowIndex < 3) {
        NYNPaiXuTitleModel *nowModelPriceUpAndDown = self.titleModelArr[3];
        nowModelPriceUpAndDown.name = @"价格高低 ↑";
    }
    
    //这里如果是预售   就不设置两次点击改变顺序  不设置前选位
    if (nowIndex == 4) {
        
    }else{
        self.upIndex = (int)nowIndex;
    }
    
    

    for (int k = 0; k < self.shaiXuanButtonArr.count; k++) {
        UIButton *bt = self.shaiXuanButtonArr[k];
        NYNPaiXuTitleModel *model = self.titleModelArr[k];
        
        if (model.isChoose) {
            [bt setTitleColor:Color90b659 forState:0];
        }else{
            [bt setTitleColor:Color686868 forState:0];
        }
        
        [bt setTitle:model.name forState:0];
        
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    if (nowIndex == 4) {
        //如果这里的nowindex==4  这里的上下排序就不动
    }else{
        if (nowModel.isUp) {
            [dic setObject:@"asc" forKey:@"orderBy"];
        }else{
            [dic setObject:@"desc" forKey:@"orderBy"];
        }
    }
    

    
    [dic setObject:nowModel.orderType forKey:@"orderType"];
    
    NYNPaiXuTitleModel *lastModel = [self.titleModelArr lastObject];

    
    if (lastModel.isChoose) {
        [dic setObject:@1 forKey:@"onlyPreSale"];

    }else{
        [dic setObject:@0 forKey:@"onlyPreSale"];

    }
    
    if (self.paiXuClick) {
        self.paiXuClick(dic);
    }
    

}

- (void)titleClick:(NYNMarketHeaderChooseButton *)sender{
    JZLog(@"点击了大组%ld",(long)sender.senderTag);
    

    
    for (NYNMarketHeaderChooseButton *bt in self.titleButtonArr) {
        [bt setTitleColor:Color383938 forState:0];
        bt.sanJiaoImageView.hidden = YES;
    }
    [sender setTitleColor:Color90b659 forState:0];
    sender.sanJiaoImageView.hidden = NO;
    
    for (NYNMarketCagoryModel *md in self.marketModel.titleArr) {
        md.isChoose = NO;
    }
    for (NYNMarketCagoryModel *model in self.selectLeiModel.children) {
        model.isChoose = NO;
    }
    self.selectLeiModel = self.marketModel.titleArr[sender.senderTag];
    self.selectLeiModel.isChoose = YES;

    NYNMarketCagoryModel *firModel = [self.selectLeiModel.productCategories firstObject];;
    
    if (self.categoryClick) {
        self.categoryClick(firModel);
    }
    
    
    
    self.selectPinZhongModel = [self.selectLeiModel.productCategories firstObject];
    self.selectPinZhongModel.isChoose = YES;
    

    [self.HfenLeiCollection reloadData];
    [self.VfenLeiCollection reloadData];
    self.VfenLeiCollection.contentOffset=CGPointMake(0, 0);
    self.HfenLeiCollection.contentOffset=CGPointMake(0, 0);




}

- (void)moreClick{
    self.isMore = !self.isMore;
    
    if (self.isMore) {
        self.moreView.hidden = NO;
        self.VfenLeiCollection.hidden = YES;
        self.moreButton.hidden = YES;
        self.bottomView.hidden = YES;
    }else{
        self.moreView.hidden = YES;
        self.VfenLeiCollection.hidden = NO;
        self.moreButton.hidden = NO;
        self.bottomView.hidden = NO;
    }
    
    if (self.didMoreClick) {
        self.didMoreClick(self.isMore);
    }
}

-(NYNJiShiDataModel *)marketModel{
    if (!_marketModel) {
        _marketModel = [[NYNJiShiDataModel alloc]init];
    }
    return _marketModel;
}


-(NSMutableArray *)titleButtonArr{
    if (!_titleButtonArr) {
        _titleButtonArr = [[NSMutableArray alloc]init];
    }
    return _titleButtonArr;
}

-(NSMutableArray *)shaiXuanButtonArr{
    if (!_shaiXuanButtonArr) {
        _shaiXuanButtonArr = [[NSMutableArray alloc]init];
    }
    return _shaiXuanButtonArr;
}

-(UICollectionView *)VfenLeiCollection{
    if (!_VfenLeiCollection) {
//        _VfenLeiCollection = [UICollectionView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(42), SCREENWIDTH - JZWITH(50), JZHEIGHT(41)) collectionViewLayout:<#(nonnull UICollectionViewLayout *)#>;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
         layout.minimumInteritemSpacing = 10;// 垂直方向的间距
         layout.minimumLineSpacing = 10; // 水平方向的间距
        _VfenLeiCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, JZHEIGHT(42), SCREENWIDTH - JZWITH(50), JZHEIGHT(41)) collectionViewLayout:layout];
        _VfenLeiCollection.backgroundColor = [UIColor whiteColor];
        _VfenLeiCollection.dataSource = self;
        _VfenLeiCollection.delegate = self;
        
        // 注册collectionViewcell:WWCollectionViewCell是我自定义的cell的类型
        [_VfenLeiCollection registerClass:[NYNMarketUnitCollectionViewCell class] forCellWithReuseIdentifier:@"Vcell"];
//        [_VfenLeiCollection registerNib:[UINib nibWithNibName:@"NYNMarketUnitCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Hcell"];
        
        [_VfenLeiCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Noheader"];
        [_VfenLeiCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Nofooter"];


    }
    return _VfenLeiCollection;
}

-(UICollectionView *)HfenLeiCollection{
    if (!_HfenLeiCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumInteritemSpacing = 10;// 垂直方向的间距
        layout.minimumLineSpacing = 10; // 水平方向的间距
        _HfenLeiCollection= [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH , JZHEIGHT(100)) collectionViewLayout:layout];
        _HfenLeiCollection.backgroundColor = [UIColor whiteColor];
        _HfenLeiCollection.dataSource = self;
        _HfenLeiCollection.delegate = self;
        
        [_HfenLeiCollection registerClass:[NYNMarketUnitCollectionViewCell class] forCellWithReuseIdentifier:@"Hcell"];
//        [_HfenLeiCollection registerNib:[UINib nibWithNibName:@"NYNMarketUnitCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Hcell"];
        [_VfenLeiCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_VfenLeiCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _HfenLeiCollection;
}

//-(NYNMarketCagoryModel *)selectLeiModel{
//    if (!_selectLeiModel) {
//        _selectLeiModel = [[NYNMarketCagoryModel alloc]init];
//    }
//    return _selectLeiModel;
//}
//
//-(NYNMarketCagoryModel *)selectPinZhongModel{
//    if (!_selectPinZhongModel) {
//        _selectPinZhongModel = [[NYNMarketCagoryModel alloc]init];
//    }
//    return _selectPinZhongModel;
//}

-(void)setIsMore:(BOOL)isMore{
    _isMore = isMore;

}



#pragma mark -- UICollectionViewDataSource
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.selectLeiModel.productCategories.count;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NYNMarketCagoryModel *model = self.selectLeiModel.productCategories[indexPath.row];

    if ([collectionView isEqual:self.VfenLeiCollection]) {
        
        NYNMarketUnitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Vcell" forIndexPath:indexPath];
//        cell.zhanWeiLabel.text = model.pinName;
        cell.ctLabel.text = model.name;

     
        
        if (model.isChoose) {
            cell.ctLabel.layer.borderColor = Color90b659.CGColor;
            cell.ctLabel.textColor = Color90b659;
        }else{
            cell.ctLabel.layer.borderColor = Color888888.CGColor;
            cell.ctLabel.textColor = Color888888;
        }
        
        return cell;

    }else{
        NYNMarketUnitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Hcell" forIndexPath:indexPath];
//        cell.zhanWeiLabel.text = model.pinName;
        cell.ctLabel.text =  model.name;

      
        if (model.isChoose) {
            cell.ctLabel.layer.borderColor = Color90b659.CGColor;
            cell.ctLabel.textColor = Color90b659;
        }else{
            cell.ctLabel.layer.borderColor = Color888888.CGColor;
            cell.ctLabel.textColor = Color888888;
        }
        return cell;
    }
    

}

/** 总共多少组*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NYNMarketCagoryModel *model = self.selectLeiModel.productCategories[indexPath.row];
    CGFloat cellWith = [MyControl getTextWith:model.name andHeight:JZHEIGHT(20) andFontSize:12];
    
    return CGSizeMake(cellWith + JZWITH(30), JZHEIGHT(20));
}


/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([collectionView isEqual:self.VfenLeiCollection]) {
        return UIEdgeInsetsMake(5, 5, 5, 5);

    }else{
        return UIEdgeInsetsMake(10, 5, 5, 5);

    }
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);

    if ([collectionView isEqual:self.VfenLeiCollection]) {
        self.selectPinZhongModel.isChoose = NO;
        self.selectPinZhongModel = self.selectLeiModel.productCategories[indexPath.row];
        self.selectPinZhongModel.isChoose = YES;
        [self.VfenLeiCollection reloadData];
        [self.HfenLeiCollection reloadData];
   
        
    }else{
        self.selectPinZhongModel.isChoose = NO;
        self.selectPinZhongModel = self.selectLeiModel.productCategories[indexPath.row];
        self.selectPinZhongModel.isChoose = YES;
        [self.VfenLeiCollection reloadData];
        [self.HfenLeiCollection reloadData];
        
        self.moreView.hidden = YES;
        self.VfenLeiCollection.hidden = NO;
        self.moreButton.hidden = NO;
        self.bottomView.hidden = NO;
        
    }
    
    self.isMore = NO;

    
    if (self.didMoreClick) {
        self.didMoreClick(self.isMore);
    }
    
    
    NYNMarketCagoryModel *model = self.selectLeiModel.productCategories[indexPath.row];
    
    if (self.backModelClick) {
        self.backModelClick(model,indexPath.row);
    }
}

-(NSMutableArray *)titleModelArr{
    if (!_titleModelArr) {
        _titleModelArr = [[NSMutableArray alloc]init];
    }
    return _titleModelArr;
}
@end
