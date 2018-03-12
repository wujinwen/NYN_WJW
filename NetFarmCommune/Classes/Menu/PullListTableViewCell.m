//
//  PullListTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "PullListTableViewCell.h"
@interface PullListTableViewCell()

/**
 *  line color
 */
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIView *selectedBgView;

@end


@implementation PullListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.lineColor = [UIColor whiteColor];
    self.selectedBgView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView = self.selectedBgView;
}


-(void)setMenuModel:(ZWPullMenuModel *)menuModel{
    _menuModel = menuModel;
 
    [self.listImageView sd_setImageWithURL:[NSURL URLWithString:menuModel.pimg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.farmName.text = menuModel.title;
    self.numberLabel.text  = [NSString stringWithFormat:@"观看人数%@",menuModel.popurlar];
    self.messsegeFarmLabel.text =menuModel.intro ;
}
-(void)setZwPullMenuStyle:(ZWPullMenuStyle)zwPullMenuStyle{
    _zwPullMenuStyle = zwPullMenuStyle;
    switch (zwPullMenuStyle) {
        case PullMenuDarkStyle:
        {
            self.selectedBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
            self.farmName.textColor = [UIColor whiteColor];
            self.lineColor = [UIColor whiteColor];
        }
            break;
        case PullMenuLightStyle:
        {
            self.selectedBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            self.farmName.textColor = [UIColor blackColor];
            self.lineColor = [UIColor lightGrayColor];
        }
            break;
        default:
            break;
    }
}

-(void)setIsFinalCell:(BOOL)isFinalCell{
    _isFinalCell = isFinalCell;
    if (!isFinalCell) {
        [self drawLineSep];
    }
}
- (void)drawLineSep{
    CAShapeLayer *lineLayer = [CAShapeLayer new];
    lineLayer.strokeColor = self.lineColor.CGColor;
    lineLayer.frame = self.bounds;
    lineLayer.lineWidth = 0.5;
    UIBezierPath *sepline = [UIBezierPath bezierPath];
    [sepline moveToPoint:CGPointMake(15, self.bounds.size.height-0.5)];
    [sepline addLineToPoint:CGPointMake(self.bounds.size.width-15, self.bounds.size.height-0.5)];
    lineLayer.path = sepline.CGPath;
    [self.layer addSublayer:lineLayer];
}
- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
}
@end
