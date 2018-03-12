//
//  MyControl.h
//  test_demo
//
//  Created by ZhangCheng on 14-3-6.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//
//使用此类，在工程pch文件里面加入该头文件，即可在工程内任意地方进行创建
//此类设计模式为最简单的工厂模式
//UI，mycontrol
//网络  httpdownload
//数据库  SQL


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIViewExt.h"
#import "UIColor+colorkuozan.h"

#import <ifaddrs.h>
#import <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#import <dlfcn.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface MyControl : NSObject
#pragma mark --创建Label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text;
#pragma mark --创建View
+(UIView*)viewWithFrame:(CGRect)frame;
#pragma mark --创建imageView
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName;
#pragma mark --创建button
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title;

+(UIButton*)createJZButtonWithFrame:(CGRect)frame  Target:(id)target Action:(SEL)action Title:(NSString*)title;
#pragma mark --创建UITextField
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font;

//适配器的方法  扩展性方法
//现有方法，已经在工程里面存在，如果修改工程内所有方法，工作量巨大，就需要使用适配器的方法
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName;


#pragma mark --判断导航的高度64or44
+(float)isIOS7;
+(NSString*)dateFormat:(long long)utime;
+(NSString *)stringFromDate:(NSDate *)date;

+(CGFloat)getTextHeight:(NSString *)string andWith:(CGFloat)with andFontSize:(CGFloat)fontSize;
+(CGFloat)getTextWith:(NSString *)string andHeight:(CGFloat)height andFontSize:(CGFloat)fontSize;
#pragma mark --返回带颜色的字体
+ (NSAttributedString *)CreateNSAttributedString:(NSString *)titleName thePartOneIndex:(NSRange)range1 withColor:(id)Color1 withFont:(id)Font1 andPartTwoIndex:(NSRange)range2 withColor:(id)Color2 withFont:(id)Font2;

#pragma mark --返回坐标是否在中国
//- (void)reverseGeocodeWithCLLocation:(CLLocation *)location manager:(CLGeocoder *)manager Block:(void (^)(BOOL isError, BOOL isInCHINA))block;

#pragma mark --Label返回又行间距
+(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace baselineOffset:(CGFloat)baselineOffset;

// 图片剪切
+ (UIImage*)clipImageWithImage:(UIImage*)image inRect:(CGRect)rect;
// 图片压缩
+ (UIImage*)imageCompressImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
//lb行距
-(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace baselineOffset:(CGFloat)baselineOffset;
+ (UIImage *)imageFromView: (UIView *) theView;





//根据图片获取图片的主色调
+(UIColor*)mostColor:(UIImage*)image;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)beginCurrentVC;
+ (BOOL)isPhoneNumber:(NSString *)str;
//+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSString *) localWiFiIPAddress;

//获取ip地址
- (NSArray *)getIpAddresses;

//获取万维网ip
+ (NSString *) whatismyipdotcom;

//iphone获取本机IP
+ (NSString *)getIPAddresses;

//dic转str
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//str转dic
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
//str转array
+ (NSString*)arrayToJSONString:(NSArray *)array;
+ (NSString *)toJSONData:(id)theData;

//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeTimestampMillisecond;
//获取当前时间   (24小时)
+(NSString*)getCurrentTimes;

//时间戳转时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

//获取年-月-日格式的时间
+(NSString*)getCurrentDayTime;

//时间转时间戳
+(NSString *)timeToTimeCode:(NSDate *)date;
@end







