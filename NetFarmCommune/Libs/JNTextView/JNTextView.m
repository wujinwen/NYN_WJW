//
//  JNTextView.m
//  鸿
//
//  Created by chenhong on 15-6-1.
//  Copyright (c) 2015年 chenhong. All rights reserved.
//

#import "JNTextView.h"

@interface JNTextView()<UITextViewDelegate>
@property(nonatomic,strong) UILabel *lblPlaceholder;
@end

@implementation JNTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor=[UIColor clearColor];
        [self AddContentOfPlacehoder];
    }
    return self;
}
-(void)awakeFromNib
{
    [self AddContentOfPlacehoder];
}
/**
 *  添加占位文字控件lable
 */
-(void)AddContentOfPlacehoder
{
    UILabel *lblTxt=[[UILabel alloc] init];
    lblTxt.backgroundColor=[UIColor clearColor];
    
    lblTxt.numberOfLines=0;
    [self addSubview:lblTxt];
    self.lblPlaceholder=lblTxt;
    //设置默认的颜色
    self.placehoderColor=[UIColor lightGrayColor];
    //设置字体
    self.font=[UIFont systemFontOfSize:15];
    lblTxt.font=self.font;
    //监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextDidChange) name:UITextViewTextDidChangeNotification object:self];//UITextViewTextDidChangeNotification
    
    //设置占位文字
    self.placehoder=@"说点什么吧……";
//    
//    self.layer.cornerRadius = 5;
//    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.layer.borderWidth = 0.5;
    

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)TextDidChange
{
    //CHLog(@"TextDidChange----%@",self.text);
    self.lblPlaceholder.hidden=!(self.text.length==0);
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self TextDidChange];
}

/**
 *  设置占位文字
 */
-(void)setPlacehoder:(NSString *)placehoder
{
    _placehoder=[placehoder copy];
    self.lblPlaceholder.text=placehoder;
    //改变文字后，重新计算lable的大小
    [self setNeedsLayout];
}


-(void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor=placehoderColor;
    self.lblPlaceholder.textColor=placehoderColor;
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.lblPlaceholder.font=font;
    //改变字体后，重新计算lable的大小
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.lblPlaceholder.mj_x=5;
    self.lblPlaceholder.mj_y=8;
    self.lblPlaceholder.width=self.width-self.lblPlaceholder.mj_x *2;
    CGSize constrainedSize=CGSizeMake(self.width, MAXFLOAT);
    CGSize txtSize=[self.placehoder boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.lblPlaceholder.font} context:nil].size;
    //CGSize txtSize=[self.placehoder sizeWithFont:self.lblPlaceholder.font constrainedToSize:constrainedSize];
    self.lblPlaceholder.height=txtSize.height;
}

-(void)textViewDidChange:(UITextView *)textView
{
    
//    self.navigationItem.rightBarButtonItem.enabled=!(textView.text.length==0);
    //self.countLabel.text=[NSString stringWithFormat:@"%zd/140",textView.text.length];
}

@end
