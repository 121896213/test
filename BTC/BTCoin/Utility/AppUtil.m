//
//  AppUtil.m
//  mengShare
//
//  Created by jeebee on 15/5/4.
//  Copyright (c) 2015年 macro. All rights reserved.
//

#import "AppUtil.h"
#import <CommonCrypto/CommonDigest.h> // for md5
#import "NSString+Custom.h"

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"


@implementation AppUtil
{
    
}

+ (UIColor *)appLineColor
{
    return [AppUtil colorFromHexString:@"#ebebeb"];
}


+ (UIColor *)appBlueColor
{
    return [AppUtil colorFromHexString:@"#61C6D7"];
}

+ (UIColor *)appRedColor
{
    return [AppUtil colorFromHexString:@"#FF464F"];
}

+ (UIColor *)appThemeColor
{
    return [AppUtil colorFromHexString:@"#1d232a"];
}

+ (UIColor *)appTimeSharingColor
{
    return [AppUtil colorFromHexString:@"#11141a"];
}

+ (UIColor *)appBottomBarColor
{
    return [AppUtil colorFromHexString:@"#192026"];
}

+ (UIColor *)appBorderColor
{
    return [AppUtil colorFromHexString:@"#f0efed"];
}

+ (UIColor *)appLightGrayColor
{
    return [AppUtil colorFromHexString:@"#f8f7f5"];
}

+ (UIColor *)appGrayColor
{
    return [AppUtil colorFromHexString:@"#999999"];
}

+ (UIColor *)appGreenColor
{
    return [AppUtil colorFromHexString:@"#75CF52"];
}

+ (UIColor *)appBlackColor
{
    return [AppUtil colorFromHexString:@"#333333"];
}


+ (UIColor *)appOrangeColor
{
    return [AppUtil colorFromHexString:@"#FF942B"];
}

+ (UIColor *)appBackgroundColor
{
    return [AppUtil colorFromHexString:@"#F2F2F2"];
}

+ (UIColor *)appBuyColor
{
    return [AppUtil colorFromHexString:@"#e70d30"];
}

+ (UIColor *)appSaleColor
{
    return [AppUtil colorFromHexString:@"#089000"];
}

+ (UIColor *)appTextColorWithValue:(double)value
{
    if (value >= 0) {
        
        return [AppUtil colorFromHexString:@"#FF0000"];
    }
    else
    {
        return [AppUtil colorFromHexString:@"#32B431"];
    }
}

+ (void)customizeNavigationBar
{    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[AppUtil appThemeColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
}

+ (id)valueOfKey:(NSString *)key inData:(NSArray *)data withFields:(NSArray *)fields
{
    NSInteger index = [fields indexOfObject:key];
    
    if (index < data.count) {
        
        if ([data isKindOfClass:[NSArray class]]) {
            id obj = [data objectAtIndex:index];
            
            return obj;
        }
    }
    
    return @"";
}


+ (void)closeKeyboard
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

+ (UIBarButtonItem *)backBarButtonWithoutTitle
{
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    
    temporaryBarButtonItem.title = @"";
    
    return temporaryBarButtonItem;
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    
    /* convert the string into a int */
    unsigned int colorValueR,colorValueG,colorValueB,colorValueA;
    NSString *hexStringCleared = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if(hexStringCleared.length == 3) {
        /* short color form */
        /* im lazy, maybe you have a better idea to convert from #fff to #ffffff */
        hexStringCleared = [NSString stringWithFormat:@"%@%@%@%@%@%@", [hexStringCleared substringWithRange:NSMakeRange(0, 1)],[hexStringCleared substringWithRange:NSMakeRange(0, 1)],
                            [hexStringCleared substringWithRange:NSMakeRange(1, 1)],[hexStringCleared substringWithRange:NSMakeRange(1, 1)],
                            [hexStringCleared substringWithRange:NSMakeRange(2, 1)],[hexStringCleared substringWithRange:NSMakeRange(2, 1)]];
    }
    if(hexStringCleared.length == 6) {
        hexStringCleared = [hexStringCleared stringByAppendingString:@"ff"];
    }
    
    /* im in hurry ;) */
    NSString *red = [hexStringCleared substringWithRange:NSMakeRange(0, 2)];
    NSString *green = [hexStringCleared substringWithRange:NSMakeRange(2, 2)];
    NSString *blue = [hexStringCleared substringWithRange:NSMakeRange(4, 2)];
    NSString *alpha = [hexStringCleared substringWithRange:NSMakeRange(6, 2)];
    
    [[NSScanner scannerWithString:red] scanHexInt:&colorValueR];
    [[NSScanner scannerWithString:green] scanHexInt:&colorValueG];
    [[NSScanner scannerWithString:blue] scanHexInt:&colorValueB];
    [[NSScanner scannerWithString:alpha] scanHexInt:&colorValueA];
    
    
    return [UIColor colorWithRed:((colorValueR)&0xFF)/255.0
                           green:((colorValueG)&0xFF)/255.0
                            blue:((colorValueB)&0xFF)/255.0
                           alpha:((colorValueA)&0xFF)/255.0];
    
    
}



+ (BOOL)isValidPhoneNumInput:(NSString *)input
{
    if (input.length == 11)
        return YES;
    else
        return NO;
}

+ (BOOL)isValidAccount:(NSString *)account
{
    NSString *accountRegex = @"^[a-zA-Z0-9_]{6,12}+$";
    NSPredicate *accountPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",accountRegex];
    
    return [accountPredicate evaluateWithObject:account];
}



+ (BOOL)isValidPassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    return [passWordPredicate evaluateWithObject:passWord];
}

+ (BOOL)validNewPatternPassword:(NSString *)password {
    
    if (password.length < 6 || password.length > 16 || [AppUtil isPureInt:password] || [AppUtil isPureCharacters:password]) {
        return false;
    }
    
    NSRange _range = [password rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        return false;
    }
    
    if ([AppUtil isValidateContainLetter:password] && [AppUtil isValidPassword:password]) {
        return true;
    }
    
    return false;
}

//判断是否是纯字母
+ (BOOL)isPureCharacters:(NSString *)string {
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

//手机号码格式验证
+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//邮箱格式验证
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL) isValidateBankCard:(NSString *)card{
    NSString *phoneRegex = @"^\\d{13,20}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:card];
}

+(BOOL) isValidatePersonCard:(NSString *)card{
    NSString *phoneRegex = @"^(\\d{6})(\\d{4})(\\d{2})(\\d{2})(\\d{3})([0-9]|X|x)$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:card];
}

+ (BOOL)isPureInt:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+(BOOL) isValidateContainLetter:(NSString *)string {
    NSString *letterRegex = @"(?i)[^a-z]*[a-z]+[^a-z]*";
    NSPredicate *letterTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", letterRegex];
    return [letterTest evaluateWithObject:string];
}

+(void) startLoadingForView:(UIView*)view{
    //    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+(void) endLoadingForView:(UIView*)view{
    //    [MBProgressHUD hideHUDForView:view animated:YES];
}


+ (NSString *)md5:(NSString *)string
{
    @try {
        // Create pointer to the string as UTF8
        const char *ptr = [string UTF8String];
        
        // Create byte array of unsigned chars
        unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
        
        // Create 16 byte MD5 hash value, store in buffer
        
        //        CC_MD5(ptr, strlen(ptr), md5Buffer);
        
        CC_LONG length = (CC_LONG)strlen(ptr);
        CC_MD5(ptr, length, md5Buffer);
        
        // Convert MD5 value in the buffer to NSString of hex values
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x",md5Buffer[i]];
        
        return output;
    }
    @catch (NSException *exception) {
        DLog(@"%@", [exception description]);
    }
}

+ (UIViewController *)getLoginViewController
{
    UIStoryboard * user = [UIStoryboard storyboardWithName:@"UserModule" bundle:nil];
    UIViewController *vc = [user instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    return vc;
}

+ (NSString *)currentTimeInterval
{
    NSDate *datenow = [NSDate date];                                        //NSDate用来表示公历的GMT时间
    NSTimeZone *zone = [NSTimeZone systemTimeZone];                         //时区信息
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];     //转换为当地时间(如北京时间)
    NSTimeInterval timeStamp = [localeDate timeIntervalSince1970];    
    return [NSString stringWithFormat:@"%ld",(long)timeStamp];
}

+ (NSTimeInterval)getTimeStamp:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yy:MM:dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:timeString];
    NSTimeInterval timeStamp = [date timeIntervalSince1970];
    return timeStamp;
}

+ (NSDate *)getDateWithString:(NSString *)string
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *inputDate = [inputFormatter dateFromString:string];
    
    return inputDate;
}

+ (NSDate *)getDateWithString:(NSString *)string withFormat:(NSString *)format
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *inputDate = [inputFormatter dateFromString:string];
    
    return inputDate;
}

+ (NSString *)getStrWithDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    
    NSString * str = [dateFormatter stringFromDate:date];
    
    return str;
}

+ (NSDate *)getDateWithStr:(NSString *)str format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    NSDate *date = [dateFormatter dateFromString:str];
    
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    
    return localeDate;
}

+ (NSString *)getDateStringWithDate:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

//获得指定格式的当前日期
+ (NSString *)getCurrentDateWithFormat:(NSString *)formatStr
{
    //获取当前日期
    NSDate *date = [NSDate date];
    //获取时间戳
    NSString *dateString = [self getDateStringWithDate:date withFormat:formatStr];
    
    return dateString;
}

+ (NSString *)getDateStringWithString:(NSString *)string withFormat:(NSString *)format
{
    if (string) {
        
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *inputDate = [inputFormatter dateFromString:string];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:format];
        //用[NSDate date]可以获取系统当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:inputDate];
        
        return currentDateStr;
    }
    
    return @"";
}
/**
 *  时间戳转字符串
 */
+ (NSString *) datetimeStrFormatter:(NSString *)dateStr formatter:(NSString *)formatterStr
{
    if(dateStr ==nil){
        return @"";
    }
    NSDate *dateTime = [NSDate dateWithTimeIntervalSince1970:[dateStr integerValue]];
    NSDateFormatter *displayTimeFormatter = [[NSDateFormatter alloc]init];
    //[displayTimeFormatter setDateFormat:@"yyyy-MM-dd"];
    if([formatterStr isEqualToString:@"yyyy-MM-dd"]
       ||[formatterStr isEqualToString:@"yyyy-MM-dd HH:mm"]
       ||[formatterStr isEqualToString:@"yyyy-MM-dd HH:mm:ss"]
       ||[formatterStr isEqualToString:@"yyyy.MM.dd"]
       ||[formatterStr isEqualToString:@"HH:mm:ss"]
       ||[formatterStr isEqualToString:@"yy.MM.dd"]){
        [displayTimeFormatter setDateFormat:[NSString stringWithString:formatterStr]];
    }else{
        [displayTimeFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSString *formatterTimeStr= [NSString stringWithFormat:@"%@", [displayTimeFormatter stringFromDate:dateTime]];
    return formatterTimeStr;
}

+ (NSDate *)dateFromISO8601String:(NSString *)string
{
    
    if (!string) return nil;
    
    struct tm tm;
    time_t t;
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    
    return [NSDate dateWithTimeIntervalSince1970:t]; // 零时区
    //    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];//东八区
}

+ (NSString *)getTimeString:(NSTimeInterval)interval
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString * dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (UITableView *)processTableViewHeaderFooterWithTableView:(UITableView *)tableView{
    
    tableView.sectionHeaderHeight = 0.5;
    tableView.sectionFooterHeight = 0.5;
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 0.5)];
    header.backgroundColor = [UIColor clearColor];
    tableView.tableHeaderView = header;
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 0.5)];
    footer.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = footer;
    
    return tableView;
}

+ (UIImage *)makeAspactImageWithImage:(UIImage *)image targetSize:(CGSize)size
{
    size = CGSizeMake(size.width * 2, size.height * 2);
    
    CGRect rect;
    
    if (image.size.width <= size.width && image.size.height <= size.height) {
        
        return image;
    }
    
    float heightAfterScale = image.size.height * size.width / image.size.width;
    
    if (heightAfterScale > size.height) {
        
        float hDiff = heightAfterScale - size.height;
        
        rect = CGRectMake(0.0, hDiff/2, size.width, heightAfterScale - hDiff);
        
        UIImage *tmpImage = [AppUtil imageWithImageSimple:image scaledToSize:rect.size];
        
        CGImageRef newImageRef = CGImageCreateWithImageInRect(tmpImage.CGImage, rect);
        
        UIImage *image = [UIImage imageWithCGImage:newImageRef];
        
        CGImageRelease(newImageRef);
        
        return image;
    }
    else
    {
        rect = CGRectMake(0.0, 0.0, size.width, heightAfterScale);
        
        UIImage *tmpImage = [AppUtil imageWithImageSimple:image scaledToSize:rect.size];
        
        return tmpImage;
    }
}

+ (UIImage*)imageWithImageSimple:(UIImage*)image
{
    CGRect deviceFrame = [[UIScreen mainScreen] applicationFrame];
    float deviceScale = [[UIScreen mainScreen] scale];
    
    float fWidthBounce = deviceFrame.size.width * deviceScale;
    float fHeighBounce = deviceFrame.size.height * deviceScale;
    
    float imgWidth = image.size.width;
    float imgHeigh = image.size.height;
    
    BOOL scaleDone = YES;
    
    if (imgWidth > fWidthBounce || imgHeigh > fHeighBounce) {
        
        scaleDone = NO;
    }
    else
    {
        scaleDone = YES;
    }
    
    if (scaleDone) {
        
        return image;
        
    }else{
        
        CGFloat widthFactor = fWidthBounce / imgWidth;
        CGFloat heightFactor = fHeighBounce / imgHeigh;
        CGFloat scaleFactor;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        
        imgWidth = imgWidth * scaleFactor;
        imgHeigh = imgHeigh * scaleFactor;
        
        CGSize size = CGSizeMake(imgWidth, imgHeigh);
        
        return [[self class] imageWithImageSimple:image scaledToSize:size];
        
    }
}



+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark -  每4个字符当中添加两个空格
+ (NSString * )changeOverPayCardStirngWithString:(NSString *)old{
    
    NSMutableString * string = [[NSMutableString alloc]initWithString:old];
    if (old && old.length == 12) {
        [string insertString:@"  " atIndex:8];
        [string insertString:@"  " atIndex:4];
    }
    return string;
}


+ (void)makeCircleAvatarView:(UIView *)avatar
{
    avatar.layer.cornerRadius = (avatar.frame.size.height/2);
    avatar.layer.masksToBounds = YES;
    [avatar setContentMode:UIViewContentModeScaleAspectFill];
    avatar.userInteractionEnabled = YES;
}

+ (void)shadowForLabel:(UILabel *)label
{
    label.layer.shadowOpacity = 0.9;
    label.layer.shadowRadius = 3.0;
    label.layer.shadowColor = [UIColor blackColor].CGColor;
    label.layer.shadowOffset = CGSizeMake(0.0, 1.0);
}

+ (UIImage *)scaleRotateImage:(UIImage *)image withMaxSize:(NSInteger )kMaxResolution
{
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    if (kMaxResolution != 0) {
        
        if (width > kMaxResolution || height > kMaxResolution) {
            CGFloat ratio = width/height;
            if (ratio > 1) {
                bounds.size.width = kMaxResolution;
                bounds.size.height = bounds.size.width / ratio;
            }
            else {
                bounds.size.height = kMaxResolution;
                bounds.size.width = bounds.size.height * ratio;
            }
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}



#pragma mark - 获取设备当前网络IP地址

+ (NSString *)encodeWithPassword:(NSString *)pwd
{
    NSString *passWord = [NSString stringWithFormat:@"%@salt:2014", pwd];
    NSString *md5Pass = [AppUtil md5:passWord];
    
    return md5Pass;
}

+ (NSString *)priceStringWithPrice:(NSString *)price
{
    return [NSString stringWithFormat:@"%.2f", [price doubleValue]/10000];
}


+ (NSString *)notificationNameWithCmdType:(NSInteger)cmdType
{
    NSString *notificationName = [NSString stringWithFormat:@"%ld", (long)cmdType];
    
    return notificationName;
}


+ (float)fileSizeAtPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size;
    }
    return 0;
}

//遍历文件夹获得文件夹大小
+ (float) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [AppUtil fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}

#pragma mark - JSON vs Object -

+ (NSString *)jsonStringWithObject:(id)object
{
    NSError *error;
    
    if (object) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
        
        if (!error) {
            
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            return jsonString;
        }
        else
        {
            DLog(@"%@", [error description]);
            return nil;
        }
    }
    
    DLog(@"object is nil");
    return nil;
}

+ (id)objectWithJsonString:(NSString *)jsonString
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:&error];
    
    if (!error) {
        
        return jsonObject;
    }
    
    DLog(@"%@", [error description]);
    return nil;
}


#pragma mark - 把NSURL的query转化为NSDictionary
+ (NSDictionary*)dictionaryFromQuery:(NSURL*)url usingEncoding:(NSStringEncoding)encoding {
    if (url == nil) {
        return nil;
    }
    
    NSString * query = [url query];
    
    NSCharacterSet * delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary * pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:query];
    
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0] stringByRemovingPercentEncoding];
            NSString* value = [[kvPair objectAtIndex:1] stringByRemovingPercentEncoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}


+ (NSString *)getUrlMethodValueWithMethodName:(NSString *)methodName webaddress:(NSString *)webaddress
{
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",methodName];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    // NSString *webaddress=@"http://www.baidu.com/dd/adb.htm?adc=e12&xx=lkw&dalsjd=12";
    NSArray *matches = [regex matchesInString:webaddress
                                      options:0
                                        range:NSMakeRange(0, [webaddress length])];
    for (NSTextCheckingResult *match in matches) {
        //NSRange matchRange = [match range];
        //NSString *tagString = [webaddress substringWithRange:matchRange];  // 整个匹配串
        //        NSRange r1 = [match rangeAtIndex:1];
        //        if (!NSEqualRanges(r1, NSMakeRange(NSNotFound, 0))) {    // 由时分组1可能没有找到相应的匹配，用这种办法来判断
        //            //NSString *tagName = [webaddress substringWithRange:r1];  // 分组1所对应的串
        //            return @"";
        //        }
        
        NSString *tagValue = [webaddress substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        //    NSLog(@"分组2所对应的串:%@\n",tagValue);
        return tagValue;
    }
    return @"";
}
+(UIViewController*)getLastVCWithSrcViewController:(UIViewController*)viewController
{
    NSArray *viewCtrls=viewController.navigationController.viewControllers;
    for (int i=0; i<viewCtrls.count; i++)
    {
        if ([viewController isEqual:viewCtrls[i]] && i!=0)
        {
            UIViewController *VC=viewCtrls[i-1];
            return VC;
        }
        
    }
    return nil;
}
@end
