//
//  MyControl.m
//  test_demo
//
//  Created by ZhangCheng on 14-3-6.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import "MyControl.h"


@implementation MyControl
//工厂模式   +方法
//label  button  imageView  View
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text
{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //限制行数
    label.numberOfLines=0;
    //对齐方式
    
    label.textAlignment=NSTextAlignmentLeft;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:font];
    //单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=[UIColor blackColor];
    //自适应（行数~字体大小按照设置大小进行设置）
    label.adjustsFontSizeToFitWidth=YES;
    label.text=text;
    return label;
}
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    //设置背景图片，可以使文字与图片共存
//    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //图片与文字如果需要同时存在，就需要图片足够小 详见人人项目按钮设置
//    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    

}

+(UIButton*)createJZButtonWithFrame:(CGRect)frame  Target:(id)target Action:(SEL)action Title:(NSString*)title;{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    //设置背景图片，可以使文字与图片共存
    //    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //图片与文字如果需要同时存在，就需要图片足够小 详见人人项目按钮设置
    //    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled=YES;
    return imageView;
}
+(UIView*)viewWithFrame:(CGRect)frame
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    
    return view;

}
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    textField.backgroundColor=[UIColor whiteColor];
    //灰色提示框
    textField.placeholder=placeholder;
    //文字对齐方式
    textField.textAlignment=NSTextAlignmentLeft;
    textField.secureTextEntry=YESorNO;
    //边框
    textField.borderStyle=UITextBorderStyleNone;
    //键盘类型
    textField.keyboardType=UIKeyboardTypeEmailAddress;
    //关闭首字母大写
    textField.autocapitalizationType=NO;
    //清除按钮
    textField.clearButtonMode=YES;
    //左图片
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 32, 0)];
    textField.leftView=imageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右图片
    textField.rightView=rightImageView;
    //编辑状态下一直存在
    textField.rightViewMode=UITextFieldViewModeWhileEditing;
    //自定义键盘
    //textField.inputView
    //字体
    textField.font=[UIFont systemFontOfSize:font];
    //字体颜色
    textField.textColor=[UIColor blackColor];
    return textField;

}
#pragma  mark 适配器方法
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName
{
   UITextField*text= [self createTextFieldWithFrame:frame placeholder:placeholder passWord:YESorNO leftImageView:imageView rightImageView:rightImageView Font:font];
    text.background=[UIImage imageNamed:imageName];
    return  text;
}


#pragma -mark 判断导航的高度
//+(float)isIOS7{
//    float height;
//    
//    
//  
//    
//    if (IOS7) {
//        height=64.0;
//    }else{
//        height=44;
//    }
//    
//    
//    return height;
//}
#pragma mark 判断屏幕尺寸
+(CGSize)_size
{
    CGSize _size = [[UIScreen mainScreen]bounds].size;
    return _size;
}
+(NSString*)dateFormat:(long long)utime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *nowStr =[dateFormatter stringFromDate:[NSDate date]];
    NSString *utimeStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:utime/1000]];
    
    
    if([utimeStr isEqualToString:nowStr] == YES){
        [dateFormatter setDateFormat:@"HH:mm"];
        utimeStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:utime/1000]];
    }
    
    return utimeStr;
}

//NSDate转NSString
+(NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+(CGFloat)getTextHeight:(NSString *)string andWith:(CGFloat)with andFontSize:(CGFloat)fontSize
{

    
    return [string boundingRectWithSize:CGSizeMake(with, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}  context:nil].size.height;
}

+(CGFloat)getTextWith:(NSString *)string andHeight:(CGFloat)height andFontSize:(CGFloat)fontSize
{
    
    
    return [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}  context:nil].size.width;
}

//+(CGSize)boundingRectWithSize:(CGSize)size
//{
//    NSDictionary *attribute = @{NSFontAttributeName: self.font};
//    
//    CGSize retSize = [self.text boundingRectWithSize:size
//                                             options:\
//                      NSStringDrawingTruncatesLastVisibleLine |
//                      NSStringDrawingUsesLineFragmentOrigin |
//                      NSStringDrawingUsesFontLeading
//                                          attributes:attribute
//                                             context:nil].size;
//    
//    return retSize;
//}

+ (NSAttributedString *)CreateNSAttributedString:(NSString *)titleName thePartOneIndex:(NSRange)range1 withColor:(id)Color1 withFont:(id)Font1 andPartTwoIndex:(NSRange)range2 withColor:(id)Color2 withFont:(id)Font2
{
    NSString *moneyStr = titleName;
    NSMutableAttributedString *monstr = [[NSMutableAttributedString alloc]initWithString:moneyStr];
    //设置：在0-3个单位长度内的内容显示成红色
    //    [monstr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    [monstr addAttribute:NSForegroundColorAttributeName value:Color1 range:range1];
    
    [monstr addAttribute:NSFontAttributeName value:Font1 range:range1];
    
    [monstr addAttribute:NSForegroundColorAttributeName value:Color2 range:range2];
    
    [monstr addAttribute:NSFontAttributeName value:Font2 range:range2];
    return monstr;
}

//返回是否在中国
//- (void)reverseGeocodeWithCLLocation:(CLLocation *)location manager:(CLGeocoder *)manager Block:(void (^)(BOOL isError, BOOL isInCHINA))block{
//
//    NSLog(@"进入前线程:%@",[NSThread currentThread]);
//    __block BOOL isInCHINA;
//    [manager reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        NSLog(@"进入后线程后:%@",[NSThread currentThread]);
//
//
//    }completeBlock:(void (^)(BOOL isError, BOOL isInCHINA))block{
//    }];
//    
//}

+(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace baselineOffset:(CGFloat)baselineOffset {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    // 设置文本偏移量
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(baselineOffset) range:range];
    return attributedString;
}


// 图片剪切
+ (UIImage*)clipImageWithImage:(UIImage*)image inRect:(CGRect)rect {
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, rect, imageRef);
    
    UIImage* clipImage = [UIImage imageWithCGImage:imageRef];
    
    //    CGImageCreateWithImageInRect(CGImageRef  _Nullable image, <#CGRect rect#>)
    
    //    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();      // 不同的方式
    
    UIGraphicsEndImageContext();
    
    //    NSData* data = [NSData dataWithData:UIImagePNGRepresentation(clipImage)];
    
    //    BOOL flag = [data writeToFile:@"/Users/gua/Desktop/Image/后.png" atomically:YES];
    
    //    GGLogDebug(@"========压缩后=======%@",clipImage);
    
    return clipImage;
    
}

// 图片压缩
+ (UIImage*)imageCompressImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth {
    
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth;
    
    CGFloat targetHeight;
    
    if (height > width) {
        targetWidth = defineWidth;
        
        targetHeight = (defineWidth / width) * height;
    }else{
        targetHeight = defineWidth;
        
        targetWidth = (defineWidth / height) * width;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

-(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace baselineOffset:(CGFloat)baselineOffset {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    // 设置文本偏移量
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(baselineOffset) range:range];
    return attributedString;
}

+ (UIImage *)imageFromView: (UIView *) viewToCapture
{
    UIGraphicsBeginImageContextWithOptions(viewToCapture.bounds.size, NO, 0.0);
    [viewToCapture.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
    
//    UIGraphicsBeginImageContext(theView.frame.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [theView.layer renderInContext:context];
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return theImage;
}


//根据图片获取图片的主色调
+(UIColor*)mostColor:(UIImage*)image{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(image.size.width / 50, image.size.height / 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (red==255&&green==255&&blue==255) {//去除白色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
                
            }
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)beginCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


#pragma 正则匹配手机号
//匹配手机号最终用的这里,之前那里没有用

+ (BOOL)isPhoneNumber:(NSString *)str



{
    
    if ([str length] == 0) {
        
        return NO;
        
    }
    
    NSString *regex = @"^((17[0-9])|(13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        return NO;
        
    } 
    
    return YES;
    
}

//+ (NSString*)dictionaryToJson:(NSDictionary *)dic
//
//{
//    
//    NSError *parseError = nil;
//    
//    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic
//                         
//                                                        options:NSJSONWritingPrettyPrinted
//                         
//                                                          error:&parseError];
//    
//    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//}

//获取ip地址
//- (NSArray *)getIpAddresses{
//    NSString *address = @"error";
//    struct ifaddrs *interfaces = NULL;
//    struct ifaddrs *temp_addr = NULL;
//    int success = 0;
//    // retrieve the current interfaces - returns 0 on success
//    success = getifaddrs(&interfaces);
//    if (success == 0)
//    {
//        // Loop through linked list of interfaces
//        temp_addr = interfaces;
//        while(temp_addr != NULL)
//        {
//            if(temp_addr->ifa_addr->sa_family == AF_INET)
//            {
//                // Check if interface is en0 which is the wifi connection on the iPhone
//                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
//                {
//                    // Get NSString from C String
//                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//                }
//            }
//            temp_addr = temp_addr->ifa_next;
//        }
//    }
//    // Free memory
//    freeifaddrs(interfaces);
//    return [address UTF8String];
//}


//获取万维网ip
+ (NSString *) whatismyipdotcom
{
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://www.baidu.com"];
    NSString *ip = [NSString stringWithContentsOfURL:ipURL encoding:1 error:&error];
    return ip ? ip : [error localizedDescription];
}


+ (NSString *) localWiFiIPAddress
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"])  // Wi-Fi adapter
                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
}

//iphone获取本机IP
+ (NSString *)getIPAddresses {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//字典转字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
+ (NSString *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        NSMutableString * mutStr = [NSMutableString stringWithString:jsonString];
        NSRange range={0,jsonString.length};
        [mutStr replaceOccurrencesOfString:@"" withString:@"" options:NSLiteralSearch range:range];
        NSRange range2={0,mutStr.length};
        [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
        
        
        return mutStr;
    }else{
        return nil;
    }
}

//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeTimestampMillisecond {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}

+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

+(NSString*)getCurrentDayTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    if ([timeString isKindOfClass:[NSString class]]) {
        
        // 格式化时间
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
//        [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        [formatter setDateFormat:@"yyyy-MM-dd"];

        
        // 毫秒值转化为秒
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
        NSString* dateString = [formatter stringFromDate:date];
        return dateString;

    }else{
        return @"";
    }
  }


+(NSString *)timeToTimeCode:(NSDate *)date{
    NSTimeInterval a=[date timeIntervalSince1970]*1000;
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;

}

@end
