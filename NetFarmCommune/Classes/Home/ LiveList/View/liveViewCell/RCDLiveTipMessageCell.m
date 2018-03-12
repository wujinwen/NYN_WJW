//
//  RCDLiveTipMessageCell.m
//  RongIMKit
//
//  Created by xugang on 15/1/29.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import "RCDLiveTipMessageCell.h"
#import "RCDLiveTipLabel.h"
#import "RCDLiveKitUtility.h"
#import "RCDLiveKitCommonDefine.h"
#import "RCDLiveGiftMessage.h"
#import "NYNMessageContent.h"
#import "NYNLiveGiftMessege.h"
@interface RCDLiveTipMessageCell ()<RCDLiveAttributedLabelDelegate>
@end

@implementation RCDLiveTipMessageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tipMessageLabel = [RCDLiveTipLabel greyTipLabel];
        self.tipMessageLabel.textAlignment = NSTextAlignmentLeft;
//        self.tipMessageLabel.delegate = self;
        self.tipMessageLabel.userInteractionEnabled = YES;
        [self.baseContentView addSubview:self.tipMessageLabel];
        self.tipMessageLabel.font = [UIFont systemFontOfSize:16.f];;
        self.tipMessageLabel.marginInsets = UIEdgeInsetsMake(0.5f, 0.5f, 0.5f, 0.5f);
    }
    return self;
}

- (void)setDataModel:(RCDLiveMessageModel *)model {
    [super setDataModel:model];

    RCMessageContent *content = model.content;
    if ([content isMemberOfClass:[RCInformationNotificationMessage class]]) {
        RCInformationNotificationMessage *notification = (RCInformationNotificationMessage *)content;
        NSString *localizedMessage = [RCDLiveKitUtility formatMessage:notification];
        self.tipMessageLabel.text = localizedMessage;
        self.tipMessageLabel.textColor = RCDLive_HEXCOLOR(0xffb83c);
    }else if ([content isMemberOfClass:[RCTextMessage class]]){
        RCTextMessage *notification = (RCTextMessage *)content;
        NSString *localizedMessage = [RCDLiveKitUtility formatMessage:notification];
        NSString *name=@"";
        if (content.senderUserInfo) {
            name = [NSString stringWithFormat:@"%@:",content.senderUserInfo.name];
        }
        NSString *str =[NSString stringWithFormat:@"%@ %@",name,localizedMessage];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0x3ceff)) range:[str rangeOfString:name]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:([UIColor whiteColor]) range:[str rangeOfString:localizedMessage]];
        self.tipMessageLabel.attributedText = attributedString.copy;
    }else if ([content isMemberOfClass:[RCDLiveGiftMessage class]]){
        RCDLiveGiftMessage *notification = (RCDLiveGiftMessage *)content;
        NSString *name=@"";
        if (content.senderUserInfo) {
            name = content.senderUserInfo.name;
        }
        NSString *localizedMessage = @"送了一个钻戒";
        if(notification && [notification.type isEqualToString:@"1"]){
          localizedMessage = @"为主播点了赞";
        }
        
        NSString *str =[NSString stringWithFormat:@"%@ %@",name,localizedMessage];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0x3ceff)) range:[str rangeOfString:name]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0xf719ff)) range:[str rangeOfString:localizedMessage]];
        self.tipMessageLabel.attributedText = attributedString.copy;
    }else if ([content isMemberOfClass:[NYNLiveGiftMessege class]]){
        NYNLiveGiftMessege *notification = (NYNLiveGiftMessege *)content;
//        [liveVCell.headImage sd_setImageWithURL:[NSURL  URLWithString:content.senderUserInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"占位图"]];
        
        NSString *name=@"";
        if (content.senderUserInfo) {
            name = content.senderUserInfo.name;
        }
        
        NSURL *url = [NSURL URLWithString: notification.content];// 获取的图片地址
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]]; // 根据地址取出图片
        
        //生成文本附件
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = image;
        attch.bounds = CGRectMake(0, 0, 20, 20);
        // 创建带有图片的富文本
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        
        NSString *localizedMessage =[NSString stringWithFormat:@"送了一个"] ;
        
        NSString *str =[NSString stringWithFormat:@"%@ %@",name,localizedMessage];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0x3ceff)) range:[str rangeOfString:name]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0xf719ff)) range:[str rangeOfString:localizedMessage]];
        //拼接字符串
        [attributedString appendAttributedString:string];
//        NSURL *url = [NSURL URLWithString: notification.content];// 获取的图片地址
//        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]]; // 根据地址取出图片
//        
//        //生成文本附件
//        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
//        attch.image = image;
//        attch.bounds = CGRectMake(0, 0, 40, 40);
//        // 创建带有图片的富文本
//        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//        
//        NSString *localizedMessage =[NSString stringWithFormat:@"送了一个"] ;
//        
//        NSString *str =[NSString stringWithFormat:@"%@ %@",name,localizedMessage];
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
//        
//        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0x3ceff)) range:[str rangeOfString:name]];
//        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0xf719ff)) range:[str rangeOfString:localizedMessage]];
//        //拼接字符串
//        [attributedString appendAttributedString:string];
        self.tipMessageLabel.attributedText = attributedString.copy;
    }
    else if ([content isMemberOfClass:[NYNMessageContent class]]){
        NYNMessageContent *notification = (NYNMessageContent *)content;
        
        NSString *localizedMessage = notification.msg;
        NSString *name=@"";
        if (content.senderUserInfo) {
            name = [NSString stringWithFormat:@"%@:",content.senderUserInfo.name];
        }
        NSString *str =[NSString stringWithFormat:@"%@ %@",name,localizedMessage];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:(RCDLive_HEXCOLOR(0x3ceff)) range:[str rangeOfString:name]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:([UIColor whiteColor]) range:[str rangeOfString:localizedMessage]];
        self.tipMessageLabel.attributedText = attributedString.copy;
    }

    NSString *__text = self.tipMessageLabel.text;
    CGSize __labelSize = [RCDLiveTipMessageCell getTipMessageCellSize:__text];
    if ([content isMemberOfClass:[NYNLiveGiftMessege class]]){
        __labelSize = CGSizeMake(__labelSize.width+30, 40);
    }
    if (_isFullScreenMode) {
        self.tipMessageLabel.frame = CGRectMake(6,0, __labelSize.width, __labelSize.height);
//        self.tipMessageLabel.backgroundColor = RCDLive_HEXCOLOR(0x000000);
//        self.tipMessageLabel.alpha = 0.5;

    }else{
        self.tipMessageLabel.frame = CGRectMake((self.baseContentView.bounds.size.width - __labelSize.width) / 2.0f,0, __labelSize.width, __labelSize.height);
//        self.tipMessageLabel.backgroundColor = RCDLive_HEXCOLOR(0xBBBBBB);
//        self.tipMessageLabel.alpha = 1;
    }
}



- (void)attributedLabel:(RCDLiveAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    NSString *urlString=[url absoluteString];
    if (![urlString hasPrefix:@"http"]) {
        urlString = [@"http://" stringByAppendingString:urlString];
    }
    if ([self.delegate respondsToSelector:@selector(didTapUrlInMessageCell:model:)]) {
        [self.delegate didTapUrlInMessageCell:urlString model:self.model];
        return;
    }
}

/**
 Tells the delegate that the user did select a link to an address.
 
 @param label The label whose link was selected.
 @param addressComponents The components of the address for the selected link.
 */
- (void)attributedLabel:(RCDLiveAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents
{
    
}

/**
 Tells the delegate that the user did select a link to a phone number.
 
 @param label The label whose link was selected.
 @param phoneNumber The phone number for the selected link.
 */
- (void)attributedLabel:(RCDLiveAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber
{
    NSString *number = [@"tel://" stringByAppendingString:phoneNumber];
    if ([self.delegate respondsToSelector:@selector(didTapPhoneNumberInMessageCell:model:)]) {
        [self.delegate didTapPhoneNumberInMessageCell:number model:self.model];
        return;
    }
}

-(void)attributedLabel:(RCDLiveAttributedLabel *)label didTapLabel:(NSString *)content
{
    if ([self.delegate respondsToSelector:@selector(didTapMessageCell:)]) {
        [self.delegate didTapMessageCell:self.model];
    }
}

+ (CGSize)getTipMessageCellSize:(NSString *)content{
    CGFloat maxMessageLabelWidth = 220;
    CGSize __textSize = CGSizeZero;
    if (RCDLive_IOS_FSystenVersion < 7.0) {
        __textSize = RCDLive_RC_MULTILINE_TEXTSIZE_LIOS7(content, [UIFont systemFontOfSize:16.0f], CGSizeMake(maxMessageLabelWidth, MAXFLOAT), NSLineBreakByTruncatingTail);
    }else {
        __textSize = RCDLive_RC_MULTILINE_TEXTSIZE_GEIOS7(content, [UIFont systemFontOfSize:16.0f], CGSizeMake(maxMessageLabelWidth, MAXFLOAT));
    }
    __textSize = CGSizeMake(ceilf(__textSize.width)+10 , ceilf(__textSize.height)+6);    return __textSize;
}
@end
