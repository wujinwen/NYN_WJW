//
//  SelectView.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/10.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "SelectView.h"

@implementation SelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)awakeFromNib{
    [super awakeFromNib];
   
    
    [_addFriendBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
     [_findButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
     [_creatButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickBtn:(UIButton*)sender{
    NSInteger i = sender.tag-300;
    if (self.yyblock) {
        self.yyblock(i);
    }
}

@end
