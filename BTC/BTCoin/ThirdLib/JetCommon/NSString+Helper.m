//
//  NSString+Helper.m
//  NetDemo
//
//  Created by lixinglou on 16/7/18.
//  Copyright © 2016年 lixinglou. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Helper)

- (BOOL)isIntValue{
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    int intValue;
    BOOL canConvert = [scanner scanInt:&intValue] && [scanner isAtEnd];
    if (!canConvert) {
        return NO;
    }
    return (intValue == INT_MAX || intValue == INT_MIN)?NO:YES;
}

- (BOOL)isFloatValue{
    
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    float val;
    
    BOOL canConvert = [scan scanFloat:&val] && [scan isAtEnd];
    if (!canConvert) {
        return NO;
    }
    //说明：float远大于int，但为了便于表示，还是用int作为溢出的标准
    return ((val >INT_MAX - 1) || (val <INT_MIN + 1))?NO:YES;
}

- (BOOL)isMobliePhone{
    
    //不验证了
    
//    NSString *regex = @"^(1(([358][0-9])|(47)|[8][0126789]))\\d{8}$";
    NSString *regex = @"^(1)\\d{10}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isEmail{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValid{
    
    return ![self.class isEmpty:[self validStr]];
}

- (NSString *)phoneTypeStr{
    
    NSString * validStr = [self visbleStr];
    if (validStr.length < 4) {
        return validStr;
    }
    NSMutableString *string = [[NSMutableString alloc] initWithString:validStr];
        for (int i = 3; i < string.length;) {
        [string insertString:@" " atIndex:i];
        i += 5;
    }
    return string;
}

- (NSString *)visbleStr{
    
    return [[self validStr] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)validStr{
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)md5Str{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

/*
- (NSString *)jsonStr{
    
    NSMutableString *s = [NSMutableString stringWithString:self];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}
*/
- (NSString *)jsonFormat{
    
    NSMutableString *s = [NSMutableString stringWithString:self];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithFormat:@"\"%@\"",s];
//    return [NSString stringWithFormat:@"\"%@\"",
//            [[self stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
//            ];
}

- (NSString *)base64Str{
    
    NSData *base64Data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [base64Data base64EncodedStringWithOptions:0];
}

- (NSString *)sapBase64Str{
    NSData *base64Data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *baseValue = [base64Data base64EncodedStringWithOptions:0] ;
    
    //这里将/ 转换成_a
    baseValue = [baseValue stringByReplacingOccurrencesOfString:@"/" withString:@"_a"];
    //这里将+ 转换成_b
    baseValue = [baseValue stringByReplacingOccurrencesOfString:@"+" withString:@"_b"];
    //这里将= 转换成_c
    baseValue = [baseValue stringByReplacingOccurrencesOfString:@"=" withString:@"_c"];
    
    return baseValue;
}

- (CGSize)sizeWithFont:(UIFont *)font inSzie:(CGSize)size{
    
    NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    return [self boundingRectWithSize:size options:option attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (CGFloat)widthWithFont:(UIFont*)font{

    return ceilf([self sizeWithAttributes:@{NSFontAttributeName:font}].width);
}

- (CGFloat)heightWithFont:(UIFont*)font inWidth:(CGFloat)width{
    
    return ceilf([self sizeWithFont:font inSzie:CGSizeMake(width, MAXFLOAT)].height);
}

- (long)longValue{
    return [NSString stringToLongWithValue:self];
}

- (NSUInteger)byteLength{
    
    NSUInteger length = 0;
    for (NSUInteger charIdx = 0; charIdx < self.length; charIdx ++) {
        unichar uchar = [self characterAtIndex: charIdx];
        length += isascii(uchar) ? 1 : 2;
    }
    
    return length;
}

//得到文件的唯一文件名，比如 a/b/c.png  得到abc.png
- (NSString *)storeFilePathName{
    /*NSArray *array = [self componentsSeparatedByString:@":"];
    NSString *calString = [array lastObject];
    if( !calString ){
        calString = self ;
    }*/
    NSString *string = [self lastPathComponent];// [calString stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return string ;
}

//将文本转为图片
- (UIImage *)getQrCodeImageWithSize:(CGFloat)imageSize centerImage:(UIImage *)centerImage{

    return [self getQrCodeImageWithSize:imageSize centerImage:centerImage centerImageSize:45];
}

- (UIImage *)getQrCodeImageWithSize:(CGFloat)imageSize centerImage:(UIImage *)centerImage centerImageSize:(CGFloat)centerIamgeSize{
    
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = self;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    //因为生成的二维码模糊，所以通过createNonInterpolatedUIImageFormCIImage:outputImage来获得高清的二维码图片
    UIImage *outImg;
    @try {
        outImg = [self.class createNonInterpolatedUIImageFormCIImage:outputImage withSize:imageSize centerImage:centerImage centerImageSize:centerIamgeSize];
    } @catch (NSException *exception) {
        /*Jet in lion
        if( APP.APPFBBB_STATUS_SAP360 == 1 ){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showMessage:exception.reason];
            });
        }*/
    } @finally {
        return outImg;
    }
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size centerImage:(UIImage *)centerImage centerImageSize:(CGFloat)centerIamgeSize{
    
    if(!image){
        return nil;
    }
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CGColorSpaceRelease(cs);
    CIContext *context = [CIContext contextWithOptions:nil];
    if (!context ) {
        return nil;
    }
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    //return [UIImage imageWithCGImage:scaledImage];
    UIImage *resultImage = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    UIGraphicsBeginImageContext(CGSizeMake(size, size));
    [resultImage drawInRect:CGRectMake(0, 0, size, size)];
    
    if (centerImage) {

        CGFloat centerW = ((centerIamgeSize < 1) ||( centerIamgeSize > size ))?45:centerIamgeSize;
        CGFloat centerH=centerW;
        CGFloat centerX=(size - centerW) * 0.5;
        CGFloat centerY=(size - centerH) * 0.5;
        [centerImage drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    }
    
    UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImg;
}


+ (BOOL)isEmpty:(NSString *)str{
    
    return str == nil
    ||![str isKindOfClass:[NSString class]]
    || [str  length] == 0
    || [[str lowercaseString] isEqualToString:@"null"]
    || [@"(null)" isEqualToString:str ]
    || [@"<null>" isEqualToString:str ] ;
}

+ (BOOL)isFloatValueWithString:(NSString *)string decimalLength:(NSUInteger)decimalLenght{
    
    if (![string isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    BOOL lengthRight = NO;
    
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count < 2) {
        lengthRight = YES;
    }
    NSString *lastPath = [array lastObject];
    if (lastPath.length <= decimalLenght || (decimalLenght < 1)) {
        lengthRight = YES;
    }
    if (!lengthRight) {
        return NO;
    }
    return [string isFloatValue];
}

+ (NSString *)checkNULLstring:(NSString *)oriString{
    NSString *string = @"";
    if( !oriString ) return string;
    if( [oriString isKindOfClass:[NSNull class] ] ) return string ;
    string =[NSString stringWithFormat:@"%@" , oriString ];
    return string ;
}

//得到默认字符，当str为空时，返回默认的Str
+ (NSString *)validForStr:(NSString*)str default:(NSString*)defaultStr{
    
    return [NSString isEmpty:str]?defaultStr:str ;
}

/*
 移动设计器中分割逗号,要去掉前后空格
 */
- (NSArray <NSString *>*)dynamicComponentsSeparatedByString:(NSString *)separator{
    NSArray *array = [self componentsSeparatedByString:separator];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    
    NSUInteger nums = array.count ;
    for( NSUInteger i=0;i<nums;i++ ){
        NSString *iString = [array objectAtIndex:i];
        iString = [iString validStr];
        [mArray addObject:iString];
    }
    
    return mArray ;
}

+ (long)stringToLongWithValue:(NSString *)lValue{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber * myNumber = [f numberFromString:lValue];
    return [myNumber longValue];
}

+ (NSString *)getChineseHanZiWithNum:(NSUInteger)num{
    
    NSString *str = [@(num) description];
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    NSLog(@"%@",str);
    NSLog(@"%@",chinese);
    return chinese;
}

//根据电话号码和web环境得到文件夹名字
+ (NSString *)getFileNameWithWebAndPhoneNum:(NSString *)phoneNum{
    return nil;
    /* Jet in lion
    if( APP.domainType == SAPDomainTypeRelease ) return phoneNum;
    
    NSString *rString = phoneNum ;
    
    switch (APP.domainType) {
        case SAPDomainTypeDev:
            rString = [NSString stringWithFormat:@"Dev%@",phoneNum];
            break;
            
        case SAPDomainTypeTest:
            rString = [NSString stringWithFormat:@"Test%@",phoneNum];
            break;
            
        case SAPDomainTypeProductTest:
            rString = [NSString stringWithFormat:@"ProductTest%@",phoneNum];
            break;
            
        default:
            break;
    }
    
    return rString ;*/
}

+ (NSArray *)getRangWithStr:(NSString *)searchText FromStr:(NSString *)oriText{

    if ([NSString isEmpty:searchText] || [NSString isEmpty:oriText]) {
        return nil;
    }
    
    NSRange lastRange = [oriText rangeOfString:searchText];
    if (lastRange.location == NSNotFound || lastRange.length == 0) {
        return nil;
    }
    NSMutableArray *rangeArr = [NSMutableArray arrayWithCapacity:20];
    [rangeArr addObject:@(lastRange.location)];
    NSUInteger __block lastLoc = lastRange.location;
    NSUInteger length = searchText.length;
    if (lastLoc + length >= oriText.length) {
        return rangeArr;
    }
    
    while (1) {
        NSUInteger searchLoc = lastLoc + length;
        NSUInteger searchLength = oriText.length - searchLoc;
        NSRange searRange = NSMakeRange(searchLoc, searchLength);
        NSRange resultRange = [oriText rangeOfString:searchText options:NSCaseInsensitiveSearch range:searRange];
        if (resultRange.length != 0 && resultRange.location!= NSNotFound) {
            [rangeArr addObject:@(resultRange.location)];
            lastLoc = resultRange.location;
        }else{
            break;
        }
    }
    
    return rangeArr;
}
+(NSString *)reviseString:(NSString *)str
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}


-(NSString *)replaceStringWithAsterisk:(NSInteger)startLocation length:(NSInteger)length {
    NSString* replaceStr = self;
    for (NSInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(startLocation, 1);
        replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:@"*"];
        startLocation ++;
    }
    return replaceStr;
}


@end

@implementation NSAttributedString(Size)

///计算文本高度
- (CGFloat)heightWithWidth:(CGFloat)width{
    
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine
                                         context:nil];;
    return ceilf(textRect.size.height);

}

@end
