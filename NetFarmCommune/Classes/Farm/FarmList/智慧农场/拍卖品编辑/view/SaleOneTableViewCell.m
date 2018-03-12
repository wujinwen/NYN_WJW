//
//  SaleOneTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/23.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "SaleOneTableViewCell.h"

@implementation SaleOneTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}


-(void)initiaInterface{
  
    CGFloat x = JZWITH(90) ;
    CGFloat h =JZHEIGHT(80);
    for (int i = 0; i<8; i++) {
        _farmImageView = [[UIImageView alloc]init];
        _farmImageView.frame =CGRectMake(x*(i%4)+10,10+(h*(4/3)), x,h );
        _farmImageView.image = [UIImage imageNamed:@"占位图"];
        
        
        [self addSubview:_farmImageView];
        
    
    }
    
    
}
@end
