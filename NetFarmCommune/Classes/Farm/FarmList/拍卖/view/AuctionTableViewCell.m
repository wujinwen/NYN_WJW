//
//  AuctionTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/3.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "AuctionTableViewCell.h"
#import <Masonry/Masonry.h>
#import "PicCollectionViewCell.h"

static NSString * CellIdentifier = @"cell";

@interface AuctionTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic,assign) int count;
@end


@implementation AuctionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.countLabel.text=@"0";
    

}

//加号
- (IBAction)addBtn:(UIButton *)sender {
    
    if (sender.tag ==300) {
        self.count--;
        if (self.count < 1) {
            self.count = 1;
        }
    }else if (sender.tag==301){
            self.count++;
    }
    
    if (self.offerBlock) {
        self.offerBlock(self.count);
    }
    
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.count];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         [self initiaInterface];
    }
    return self;
    
}

-(void)initiaInterface{


    
    

}

#pragma mark---UICollectionViewDelegate,UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
    
    
}


- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PicCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
//    [cell.imageView sd_setImageWithURL:_picArr[indexPath.row] placeholderImage:[UIImage imageNamed:@"占位图"]];
//    cell.imageView.image =[UIImage imageNamed:@"占位图"];

    NSData *jsonData = [_auctionMoedel.images dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[0]] placeholderImage:PlaceImage];
    
    return cell;
    
    
}



-(void)setAuctionMoedel:(NYNAuctionModel *)auctionMoedel{
    _auctionMoedel  =auctionMoedel;

    
    [self.farmImageView sd_setImageWithURL:[NSURL URLWithString:auctionMoedel.pImg]];
    self.farmName.text = auctionMoedel.unitName;
    self.jiapaiPrice.text = [NSString stringWithFormat:@"加价单位：%dd",auctionMoedel.addPrice];
    
    [self.contentView addSubview:self.messegetextView];
    [self.messegetextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.width.mas_offset(SCREENWIDTH-40);
        make.top.equalTo(_miaosuLabel.mas_bottom).offset(4);
        make.height.mas_offset(60);
        
        
    }];
    
    _messegetextView.text = auctionMoedel.intro;
    
   
    

    
//    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(_messegetextView.frame), 900, 70);
       [self.contentView addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.width.mas_offset(SCREENWIDTH);
        make.top.equalTo(_messegetextView.mas_bottom).offset(4);
        make.height.mas_offset(60);
        
        
    }];
    
}
//出价
- (IBAction)chujiaBtn:(UIButton *)sender {
    self.offerBlock(_index);
}


-(UITextView *)messegetextView{
    if (!_messegetextView) {
        _messegetextView= [[UITextView alloc]init];
        _messegetextView.textAlignment = NSTextAlignmentLeft;
        _messegetextView.textColor = [UIColor blackColor];
        _messegetextView.hidden = NO;
        [_messegetextView setEditable:NO];
    }
    return _messegetextView;
    
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake(JZWITH(100/2), JZWITH(64/2))];//设置cell的尺寸
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);//设置其边界
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_messegetextView.frame), SCREENWIDTH, 70)collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
          [_collectionView registerClass:[PicCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    }
    return _collectionView;
    
}
@end
