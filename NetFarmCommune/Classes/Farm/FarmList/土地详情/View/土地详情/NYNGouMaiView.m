//
//  NYNGouMaiView.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNGouMaiView.h"

@implementation NYNGouMaiView

//-(instancetype)initWithFrame:(CGRect)frame withIndex:(int)index{
//    if (self = [super initWithFrame:frame]){
//       
//    }
//    return self;
//}

//+(instancetype)initWithType:(int)index{
//    
////    return backView;
//}

- (void)ConfigDataWithIndex:(int)index withFrame:(CGRect)rect
{
//    CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45), SCREENWIDTH, JZHEIGHT(45))
    self.frame = rect;
    self.backgroundColor = Colorf4f4f4;
    
    UILabel *hejiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, JZWITH(35), self.height)];
    hejiLabel.text = @"合计:";
    hejiLabel.font = JZFont(13);
    hejiLabel.textColor = Color252827;
    [self addSubview:hejiLabel];
    
    UILabel *MoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(hejiLabel.right, 0, JZWITH(150), self.height)];
    MoneyLabel.textColor = Colorf8491a;
    MoneyLabel.font = JZFont(15);
    MoneyLabel.text = @"¥00.00";
    [self addSubview:MoneyLabel];
    _heJiLabel = MoneyLabel;
    
    UIButton *goumaiButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(100), 0, JZWITH(100), self.height)];
    goumaiButton.backgroundColor = [UIColor colorWithHexString:@"9ECC5B"];
    [goumaiButton setTitle:@"立即订购" forState:0];
    [goumaiButton setTitleColor:[UIColor whiteColor] forState:0];
    goumaiButton.titleLabel.font = JZFont(14);
    [self addSubview:goumaiButton];
    [goumaiButton addTarget:self action:@selector(goumai) forControlEvents:UIControlEventTouchUpInside];
    
    self.goumaiBT = goumaiButton;
    
    UIButton *otherButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(1) - JZWITH(200), 0, JZWITH(100), self.height)];
    otherButton.backgroundColor = [UIColor colorWithHexString:@"9ECC5B"];
    [otherButton setTitle:@"加入购物车" forState:0];
    [otherButton setTitleColor:[UIColor whiteColor] forState:0];
    otherButton.titleLabel.font = JZFont(14);
    [self addSubview:otherButton];
    
    [otherButton addTarget:self action:@selector(jiarugouwuche) forControlEvents:UIControlEventTouchUpInside];
    
    self.jiaGouWuCheBT = otherButton;
    
    if (index == 1) {
        otherButton.hidden = YES;
    }else{
        
    }

}


- (void)goumai{
    JZLog(@"点击了购买");
    if (self.goumaiBlock) {
        //将自己的值传出去，完成传值
        self.goumaiBlock(@"11");
    }
    
}

- (void)jiarugouwuche{
    JZLog(@"点击了加入购物车");
    if (self.gouwucheBlock) {
        //将自己的值传出去，完成传值
        self.gouwucheBlock(@"");
    }
    
}
@end
