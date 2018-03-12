    //
    //  LQScrollView.m
    //  LQScrollView3D
    //
    //  Created by zhengliqiang on 16/12/7.
    //  Copyright © 2016年 zhengliqiang. All rights reserved.
    //

#import "LQScrollView.h"
#define WIDTH [UIScreen mainScreen ].bounds.size.width
#define HEIGHT 470

@implementation LQScrollView
{
    
    UIView *      leftTouchView;//左边的点击view
    UIView *      rightTouchView;//右边的点击view
    UIImageView * imgV1;//图片从左向右 以此为 imgV1,..2,..3,..4,..5
    UIImageView * imgV2;
    UIImageView * imgV3;
    UIImageView * imgV4;
    UIImageView * imgV5;
    NSArray *     array;
    NSArray *     scoreArr;//分数数据源
    NSArray *     titleArr;//标题数据
    int iii;
    CGRect        rectmid;//imageView的rect
    CGRect        rectmidL1;
    CGRect        rectmidL2;
    CGRect        rectmidR1;
    CGRect        rectmidR2;
    
    float         zPoint0;//层级 z轴的坐标
    float         zPoint1;
    float         zPoint2;
    float         zPoint3;
}
-(instancetype)initWithFrame:(CGRect)frame imageArray:(NSMutableArray *)Array;{
    if (self = [super initWithFrame:frame]) {
        iii=5;
        zPoint0 = 1;
        zPoint1 = -1;
        zPoint2 = -2;
        zPoint3 = -3;
        [self addViews:Array];//加载控件
    }
    return self;
}

- (void)addViews:(NSMutableArray *)arr{
    
    array = arr;
    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(12), JZHEIGHT(11), JZWITH(14), JZHEIGHT(12))];
//    imageView.image = Imaged(@"home_button_farm");
//    [self addSubview:imageView];
//    
//    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + JZWITH(5), JZHEIGHT(9), JZWITH(200), JZHEIGHT(18))];
//    titleLab.textColor = Color90b659;
//    titleLab.font = [UIFont boldSystemFontOfSize:14];
//    titleLab.text  = @"农场";
//    titleLab.textAlignment = NSTextAlignmentLeft;
//    [self addSubview:titleLab];
//    
//    UIButton *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-45, 3, 40, 30)];
//    [moreButton setTitleColor:Color90b659 forState:0];
//    moreButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//    [moreButton setTitle:@"..." forState:0];
//    [self addSubview:moreButton];
//    
//    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(12), titleLab.bottom + JZHEIGHT(7), JZWITH(150), JZHEIGHT(30))];
//    detailLabel.text = @"本月热门农场推荐";
//    detailLabel.font = JZFont(10);
//    detailLabel.textAlignment = 0;
//    detailLabel.textColor = Color888888;
//    [self addSubview:detailLabel];
//    
//        //热门更多按钮
//    self.enterButton = [[UIButton alloc]init];
//    self.enterButton.frame = CGRectMake(WIDTH-45, 10, 40, 30);
//    [self.enterButton setImage:[UIImage imageNamed:@"more"] forState:0];
//    self.enterButton.adjustsImageWhenHighlighted = NO;
//    self.enterButton.backgroundColor = [UIColor redColor];
//    [self addSubview:self.enterButton];
    
//    UIView * bgview = [[UIView alloc]init];
//    bgview.frame = CGRectMake(0, 50, WIDTH,HEIGHT*0.55-50-40);
//    [self addSubview:bgview];
    
        //数据初始化
    scoreArr = @[@"",@"",@"",@"",@""];
    titleArr = @[@"",@"",@"",@"",@""];
    
    
    float offSetW = JZWITH(15);
    float offSetH = JZHEIGHT(60);
    
        //设置五个位置的rect
    float midWidth = JZWITH(151);
    float midheigh = JZWITH(151);
    float midpointX = WIDTH/2-midWidth/2;
    float midpointY = 5;
    rectmid = CGRectMake(midpointX, midpointY, midWidth, midheigh);
    
    
    float midL1Width = WIDTH/3-offSetW;
    float midL1heigh = JZHEIGHT(131);
    float midL1pointX = WIDTH/2 - midWidth/2-midL1Width/2;
    float midL1pointY = offSetW;
    rectmidL1 = CGRectMake(midL1pointX, midL1pointY, midL1Width, midL1heigh);
    
    float midL2Width = WIDTH/3-offSetW-20;
    float midL2heigh = JZHEIGHT(106);
    float midL2pointX = WIDTH/2 - midWidth/2-midL1Width/2-midL2Width/2;
    float midL2pointY = offSetW+JZHEIGHT(13);
    rectmidL2 = CGRectMake(midL2pointX, midL2pointY, midL2Width, midL2heigh);
    
    float midR1Width = WIDTH/3-offSetW;
    float midR1heigh = JZHEIGHT(131);
    float midR1pointX = WIDTH/2 + midWidth/2-midL1Width/2;
    float midR1pointY = offSetW;
    rectmidR1 = CGRectMake(midR1pointX, midR1pointY, midR1Width, midR1heigh);
    
    float midR2Width = WIDTH/3-offSetW-20;
    float midR2heigh = JZHEIGHT(106);
    float midR2pointX = WIDTH/2 + midWidth/2+midL1Width/2-midL2Width/2;
    float midR2pointY = offSetW+JZHEIGHT(13);
    rectmidR2 = CGRectMake(midR2pointX, midR2pointY, midR2Width, midR2heigh);
    
    
    //初始化数据
    imgV1 = [[UIImageView alloc]init];
    imgV1.frame = rectmidL2;
    imgV1.image = [UIImage imageNamed:array[0]];
    
    
    imgV2 = [[UIImageView alloc]init];
    imgV2.frame = rectmidL1;
    imgV2.image = [UIImage imageNamed:array[1]];
    
    
    imgV3 = [[UIImageView alloc]init];
    imgV3.frame = rectmid;
    imgV3.image = [UIImage imageNamed:array[2]];
    
    
    imgV4 = [[UIImageView alloc]init];
    imgV4.frame = rectmidR1;
    imgV4.image = [UIImage imageNamed:array[3]];
    
    
    imgV5 = [[UIImageView alloc]init];
    imgV5.frame = rectmidR2;
    imgV5.image = [UIImage imageNamed:array[4]];
    
    
    imgV1.alpha = 0.5;
    imgV2.alpha = 0.9;
    imgV3.alpha = 1.0;
    imgV4.alpha = 0.9;
    imgV5.alpha = 0.5;
    
    
    imgV1.layer.zPosition = zPoint2;
    imgV2.layer.zPosition = zPoint1;
    imgV3.layer.zPosition = zPoint0;
    imgV4.layer.zPosition = zPoint1;
    imgV5.layer.zPosition = zPoint2;
    
        //设置image的layer层
    [self setImageLayerToImage:imgV1 FLX:0 FLY:0 Opacity:0.4 CornerRadius:5];
    [self setImageLayerToImage:imgV2 FLX:0 FLY:0 Opacity:0.4 CornerRadius:5];
    [self setImageLayerToImage:imgV3 FLX:0 FLY:0 Opacity:0.4 CornerRadius:5];
    [self setImageLayerToImage:imgV4 FLX:0 FLY:0 Opacity:0.4 CornerRadius:5];
    [self setImageLayerToImage:imgV5 FLX:0 FLY:0 Opacity:0.4 CornerRadius:5];
    
//    imgV1.backgroundColor = [UIColor blueColor];
//    imgV2.backgroundColor = [UIColor redColor];
//    imgV3.backgroundColor = [UIColor greenColor];
//    imgV4.backgroundColor = [UIColor cyanColor];
//    imgV5.backgroundColor = [UIColor greenColor];
    
    [self addSubview:imgV1];
    [self addSubview:imgV2];
    [self addSubview:imgV3];
    [self addSubview:imgV4];
    [self addSubview:imgV5];
    
    [self.bannerButtonArr addObject:imgV1];
    [self.bannerButtonArr addObject:imgV2];
    [self.bannerButtonArr addObject:imgV3];
    [self.bannerButtonArr addObject:imgV4];
    [self.bannerButtonArr addObject:imgV5];

    
    leftTouchView = [[UIView alloc]init];
    leftTouchView.frame = CGRectMake(0, 5, (WIDTH-midWidth)/2, midheigh);
    [self addSubview:leftTouchView];
    [self bringSubviewToFront:leftTouchView];
    
    rightTouchView = [[UIView alloc]init];
    rightTouchView.frame = CGRectMake(WIDTH-midpointX, 5, (WIDTH-midWidth)/2, midheigh);
    [self addSubview:rightTouchView];
    [self bringSubviewToFront:rightTouchView];
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2Action:)];
    [leftTouchView addGestureRecognizer:tap2];
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap3Action:)];
    [imgV3 addGestureRecognizer:tap3];
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap4Action:)];
    [rightTouchView addGestureRecognizer:tap4];
    
    self.midTouchView = [[UIView alloc]initWithFrame:rectmid];
    self.midTouchView.userInteractionEnabled = YES;
    self.midTouchView.layer.zPosition = 2;
    [self addSubview:self.midTouchView];
    [self bringSubviewToFront:self.midTouchView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap3Action:)];
    [self.midTouchView addGestureRecognizer:tap];
    
    self.swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    self.swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.midTouchView addGestureRecognizer:self.swipeGesture];
    self.swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.midTouchView addGestureRecognizer:self.swipeGestureLeft];
    
    
    self.scoreLab = [[UILabel alloc]init];
    self.scoreLab.frame = CGRectMake(midWidth-23,0, 23, 26);
//    self.scoreLab.backgroundColor = [UIColor redColor];
    self.scoreLab.attributedText = [self scoreLable:3];
    self.scoreLab.textAlignment = NSTextAlignmentCenter;
        //    self.scoreLab.layer.zPosition = 2;
//    [self.midTouchView addSubview:self.scoreLab];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.frame = CGRectMake(midpointX, CGRectGetMaxY(self.midTouchView.frame) + 5, midWidth, 20);
    self.titleLab.text = titleArr[3];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:self.titleLab];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(tap2Action:) userInfo:nil repeats:YES];
    self.timer = timer;
}

#pragma mark --- 这是image的layer层
- (void)setImageLayerToImage:(UIImageView *)image FLX:(float)flX FLY:(float)flY Opacity:(float)fl0pacity CornerRadius:(float)flCR{
    image.layer.shadowColor = [UIColor blackColor].CGColor;
    image.layer.shadowOffset = CGSizeMake(flX, flY);
    [[image layer] setShadowRadius:10];
    image.layer.shadowOpacity = fl0pacity;
    image.layer.shadowRadius = flCR;
    image.layer.cornerRadius = 2;
        //    image.layer.masksToBounds = YES;
    image.layer.borderColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00].CGColor;
    image.layer.borderWidth = 0.1f;
}
    //这个是点击左边 图片滑动的手势
- (void)tap2Action:(UITapGestureRecognizer *)tap{
    NSLog(@"向右滑");
    if (iii>=10) {
        iii = 10;
    }
    iii++;
    
    if (iii+1>10) {
        iii=5;
    }
    
    [self moveView:NO];
    
//    [self chooseNowModel];

}

-(void)tap3Action:(UITapGestureRecognizer *)tap{
        NSLog(@"点击了中间");
    
    if (self.tapBack) {
        self.tapBack(self.nowModel);
    }
    
}
    //这边是点击右边 图片滑动的手势
-(void)tap4Action:(UITapGestureRecognizer *)tap{
        NSLog(@"向左滑");
    if (iii <= 0) {
        iii = 0;
    }
    iii--;
    if (iii-1 < 0) {
        iii = 5;
    }
    
    [self moveView:YES];
    
    
//    [self chooseNowModel];

    
    
}

    //轻扫手势触发方法
-(void)swipeGesture:(UISwipeGestureRecognizer *)sender
{
    
    UISwipeGestureRecognizer *swipe = sender;
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft){
            NSLog(@"向左滑");
        if (iii <= 0) {
            iii = 0;
        }
        iii--;
        if (iii-1 < 0) {
            iii = 5;
        }
        [self moveView:YES];
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
            NSLog(@"向右滑");
        if (iii>=10) {
            iii = 10;
        }
        iii++;
        
        if (iii+1>10) {
            iii=5;
        }
        [self moveView:NO];
        
    }
    
//    [self chooseNowModel];
    
}




#pragma mark --- 这个是分数的富文本设置
- (NSAttributedString *)scoreLable:(int)Num{
    NSString * string = scoreArr[Num-1];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
//    [attrString addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"STHeitiTC-Medium" size:15.f] range:NSMakeRange(0, 2)];
//    [attrString addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"STHeitiTC-Medium" size:12.0f] range:NSMakeRange(2, 1)];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor whiteColor]
                       range:NSMakeRange(0, string.length)];
    
    return attrString;
}

#pragma mark --- 动画的处理
- (void)setImageOfzPpsition:(BOOL)isLOrR Z1:(float)z1 Z2:(float)z2 Z3:(float)z3 Z4:(float)z4 Z5:(float)z5 IMG1:(UIImageView *)img1 IMG2:(UIImageView *)img2 R1:(CGRect)R1 R2:(CGRect)R2 R3:(CGRect)R3 R4:(CGRect)R4 R5:(CGRect)R5 AlphaArray:(NSArray *)alphaArray{
    
    imgV1.layer.zPosition = z1;
    imgV2.layer.zPosition = z2;
    imgV3.layer.zPosition = z3;
    imgV4.layer.zPosition = z4;
    imgV5.layer.zPosition = z5;
    
    if (isLOrR == YES) {
        img1.layer.zPosition = zPoint2;
        img2.layer.zPosition = zPoint3;
    }else{
        img2.layer.zPosition = zPoint2;
        img1.layer.zPosition = zPoint3;
    }
    
    
    imgV1.frame = R1;
    imgV2.frame = R2;
    imgV3.frame = R3;
    imgV4.frame = R4;
    imgV5.frame = R5;
    
    imgV1.alpha = [alphaArray[0] floatValue];
    imgV2.alpha = [alphaArray[1] floatValue];
    imgV3.alpha = [alphaArray[2] floatValue];
    imgV4.alpha = [alphaArray[3] floatValue];
    imgV5.alpha = [alphaArray[4] floatValue];
    
    [self chooseNowModel];
    
}

#pragma mark --- 视图移动的事件
-(void)moveView:(BOOL)isLOrR{
    
    [UIView animateWithDuration:0.4 delay:0  usingSpringWithDamping:1 initialSpringVelocity:1 options:(UIViewAnimationOptionTransitionNone) animations:^{
        NSArray * alphaArray;
        switch (iii) {
            case 0:
                alphaArray  = @[@"0.5",@"0.9",@"1",@"0.9",@"0.5"];
                [self setImageOfzPpsition:isLOrR Z1:zPoint2 Z2:zPoint1 Z3:zPoint0 Z4:zPoint1 Z5:zPoint2 IMG1:imgV5 IMG2:imgV1 R1:rectmidL2 R2:rectmidL1 R3:rectmid R4:rectmidR1 R5:rectmidR2 AlphaArray:alphaArray];
                self.scoreLab.attributedText = [self scoreLable:3];
                self.titleLab.text = titleArr[2];
                
                break;
            case 1:
                alphaArray  = @[@"0.9",@"1",@"0.9",@"0.5",@"0.5"];
                [self setImageOfzPpsition:isLOrR Z1:zPoint1 Z2:zPoint0 Z3:zPoint1 Z4:zPoint2 Z5:zPoint2 IMG1:imgV5 IMG2:imgV4 R1:rectmidL1 R2:rectmid R3:rectmidR1 R4:rectmidR2 R5:(rectmidL2) AlphaArray:alphaArray];
                self.scoreLab.attributedText = [self scoreLable:2];
                self.titleLab.text = titleArr[1];
                
                
                break;
            case 2:
                
                alphaArray  = @[@"1",@"0.9",@"0.5",@"0.5",@"0.9"];
                [self setImageOfzPpsition:isLOrR Z1:zPoint0 Z2:zPoint1 Z3:zPoint2 Z4:zPoint2 Z5:zPoint1 IMG1:imgV4 IMG2:imgV3 R1:rectmid R2:rectmidR1 R3:rectmidR2 R4:rectmidL2 R5:rectmidL1 AlphaArray:alphaArray];
                
                self.scoreLab.attributedText = [self scoreLable:1];
                self.titleLab.text = titleArr[0];
                
                
                break;
            case 3:
                alphaArray  = @[@"0.9",@"0.5",@"0.5",@"0.9",@"1"];
                
                [self setImageOfzPpsition:isLOrR Z1:zPoint1 Z2:zPoint2 Z3:zPoint2 Z4:zPoint1 Z5:zPoint0 IMG1:imgV3 IMG2:imgV2 R1:rectmidR1 R2:rectmidR2 R3:rectmidL2 R4:rectmidL1 R5:rectmid AlphaArray:alphaArray];
                self.scoreLab.attributedText = [self scoreLable:5];
                self.titleLab.text = titleArr[4];
                
                
                break;
            case 4:
                alphaArray  = @[@"0.5",@"0.5",@"0.9",@"1",@"0.9"];
                
                [self setImageOfzPpsition:isLOrR Z1:zPoint2 Z2:zPoint2 Z3:zPoint1 Z4:zPoint0 Z5:zPoint1 IMG1:imgV2 IMG2:imgV1 R1:rectmidR2 R2:rectmidL2 R3:rectmidL1 R4:rectmid R5:rectmidR1 AlphaArray:alphaArray];
                
                self.scoreLab.attributedText = [self scoreLable:4];
                self.titleLab.text = titleArr[3];
                
                break;
            case 5:
                alphaArray  = @[@"0.5",@"0.9",@"1",@"0.9",@"0.5"];
                
                [self setImageOfzPpsition:isLOrR Z1:zPoint2 Z2:zPoint1 Z3:zPoint0 Z4:zPoint1 Z5:zPoint2 IMG1:imgV1 IMG2:imgV5 R1:rectmidL2 R2:rectmidL1 R3:rectmid R4:rectmidR1 R5:rectmidR2 AlphaArray:alphaArray];
                
                self.scoreLab.attributedText = [self scoreLable:3];
                self.titleLab.text = titleArr[2];
                
                break;
            case 6:
                alphaArray  = @[@"0.9",@"1",@"0.9",@"0.5",@"0.5"];
                
                [self setImageOfzPpsition:isLOrR Z1:zPoint1 Z2:zPoint0 Z3:zPoint1 Z4:zPoint2 Z5:zPoint2 IMG1:imgV5 IMG2:imgV4 R1:rectmidL1 R2:rectmid R3:rectmidR1 R4:rectmidR2 R5:rectmidL2 AlphaArray:alphaArray];
                
                self.scoreLab.attributedText = [self scoreLable:2];
                self.titleLab.text = titleArr[1];
                
                break;
            case 7:
                alphaArray  = @[@"1",@"0.9",@"0.5",@"0.5",@"0.9"];
                
                [self setImageOfzPpsition:isLOrR Z1:zPoint0 Z2:zPoint1 Z3:zPoint2 Z4:zPoint2 Z5:zPoint1 IMG1:imgV4 IMG2:imgV3 R1:rectmid R2:rectmidR1 R3:rectmidR2 R4:rectmidL2 R5:rectmidL1 AlphaArray:alphaArray];
                
                self.scoreLab.attributedText = [self scoreLable:1];
                self.titleLab.text = titleArr[0];
                
                break;
            case 8:
                alphaArray  = @[@"0.9",@"0.5",@"0.5",@"0.9",@"1"];
                
                [self setImageOfzPpsition:isLOrR Z1:zPoint1 Z2:zPoint2 Z3:zPoint2 Z4:zPoint1 Z5:zPoint0 IMG1:imgV3 IMG2:imgV2 R1:rectmidR1 R2:rectmidR2 R3:rectmidL2 R4:rectmidL1 R5:rectmid AlphaArray:alphaArray];
                self.scoreLab.attributedText = [self scoreLable:5];
                self.titleLab.text = titleArr[4];
                
                break;
            case 9:
                alphaArray  = @[@"0.5",@"0.5",@"0.9",@"1",@"0.9"];
                
                [self setImageOfzPpsition:isLOrR Z1:zPoint2 Z2:zPoint2 Z3:zPoint1 Z4:zPoint0 Z5:zPoint1 IMG1:imgV2 IMG2:imgV1 R1:rectmidR2 R2:rectmidL2 R3:rectmidL1 R4:rectmid R5:rectmidR1 AlphaArray:alphaArray];
                
                self.scoreLab.attributedText = [self scoreLable:4];
                self.titleLab.text = titleArr[3];
                
                break;
            case 10:
                alphaArray  = @[@"0.5",@"0.9",@"1",@"0.9",@"0.5"];
                
                [self setImageOfzPpsition:isLOrR Z1:zPoint2 Z2:zPoint1 Z3:zPoint0 Z4:zPoint1 Z5:zPoint2 IMG1:imgV1 IMG2:imgV5 R1:rectmidL2 R2:rectmidL1 R3:rectmid R4:rectmidR1 R5:rectmidR2 AlphaArray:alphaArray];
                self.scoreLab.attributedText = [self scoreLable:3];
                self.titleLab.text = titleArr[2];
                
                break;
                
                
            default:
                break;
        }
        self.scoreLab.alpha = 0;
        
    } completion:^(BOOL finished) {
        self.scoreLab.alpha = 1;
        NSLog(@"滑动动画结束");

    }];
    
    [self chooseNowModel];
    
    
}



-(void)setBannerDataArr:(NSMutableArray *)bannerDataArr{
    _bannerDataArr = bannerDataArr;
    

    for (int i = 0; i < 5; i++) {
        UIImageView * imgV = self.bannerButtonArr[i];
        
        NYNFarmCellModel *model;
        if (self.bannerDataArr.count >= i) {
            model = self.bannerDataArr[i];
        }
        
        [imgV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:PlaceImage];
    }
    
    [self chooseNowModel];
}

- (void)chooseNowModel{
    
    for (int i = 0; i < 5; i++) {
        UIImageView * imgV = self.bannerButtonArr[i];
        if (CGRectEqualToRect(imgV.frame, rectmid)) {
            NYNFarmCellModel *model = self.bannerDataArr[i];
            
            self.titleLab.text = [NSString stringWithFormat:@"%@",model.name];
            
            self.nowModel = model;
        }
        JZLog(@"rectmid:%@ \n imgV:%@",NSStringFromCGRect(rectmid),NSStringFromCGRect(imgV.frame));
        JZLog(@"");
    }
}

-(NSMutableArray *)bannerButtonArr{
    if (!_bannerButtonArr) {
        _bannerButtonArr = [[NSMutableArray alloc]init];
    }
    return _bannerButtonArr;
}



@end
