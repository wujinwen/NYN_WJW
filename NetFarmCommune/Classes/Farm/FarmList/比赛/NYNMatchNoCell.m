//
//  NYNMatchNoCell.m
//  NetFarmCommune
//
//  Created by ff on 2018/3/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNMatchNoCell.h"

@implementation NYNMatchNoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40)];
        self.leftLab.numberOfLines = 0;
        self.leftLab.font = JZFont(14);
        [self.contentView addSubview:self.leftLab];
        
         self.leftLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH-80, 0, SCREENWIDTH-90, 40)];
        self.rightLab.numberOfLines = 0;
        self.rightLab.font = JZFont(14);
        self.rightLab.textAlignment = 2;
        self.rightLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.rightLab];
    }
    return self;
}


- (void)letfTitle:(NSString *)title rightTitle:(NSString *)rightT{
    
    self.leftLab.text = title;
    self.rightLab.text = rightT;
}

@end
