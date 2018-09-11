//
//  NSString+Custom.m
//  MengShare
//
//  Created by jeebee on 6/1/15.
//  Copyright (c) 2015 MyCompany. All rights reserved.
//

#import "NSString+Custom.h"
#import "NSString+Regex.h"


@implementation NSString(Custom)

// Remove white space in left and right
- (NSString *)trim
{
    if (nil == self) return nil;
    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:whitespace];
}

- (NSString *)stringValue
{
    return self;
}

- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self,NULL,CFSTR("!*'();:@&=+$,/?%#[]"),kCFStringEncodingUTF8));

    return result;
}


- (NSString*)URLDecodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)self, CFSTR(""),kCFStringEncodingUTF8));CFSTR(""),kCFStringEncodingUTF8;

    return result;
} 

- (NSString*)clean
{
    NSArray *cleanedCharacterSets = @[[NSCharacterSet whitespaceAndNewlineCharacterSet],
                                      [NSCharacterSet characterSetWithCharactersInString:@"&nbsp;"]];
    
    NSString *cleanedString  = self;
    for (NSCharacterSet *characterSet in cleanedCharacterSets) {
        cleanedString = [cleanedString stringByTrimmingCharactersInSet:characterSet];
    }
    return cleanedString;
}

//nsstring 转 UTF8
- (NSString *)URLEncodingUTF8String {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
    return result;
}

- (NSString *)stringByReversed
{
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i=self.length; i>0; i--) {
        [s appendString:[self substringWithRange:NSMakeRange(i-1, 1)]];
    }
    return s;
}  

- (NSString *)truncateByByteLength:(NSInteger)len {
    if (self == nil) {
        return self;
    }
    
    NSData * wholeData = [self dataUsingEncoding:NSUTF8StringEncoding];

    if (wholeData.length < len) {
        return self;
    }
    
    NSString * resultStr = @"";
    NSInteger l = 0;
    for (NSInteger i = 0; i < self.length; i++) {
        NSString * subStr = [self substringWithRange:NSMakeRange(i, 1)];
        NSData * charData = [subStr dataUsingEncoding:NSUTF8StringEncoding];
        NSInteger charl = charData.length;
        if (l + charl > len) {
            break;
        }
        
        l += charl;
        resultStr = [resultStr stringByAppendingString:subStr];
    }
    
    return resultStr;
}

- (NSString *)toMoneyCapitalLetters {
    //设置数据格式
    NSNumberFormatter*numberFormatter = [[NSNumberFormatter alloc] init];
    
    // NSLocale的意义是将货币信息、标点符号、书写顺序等进行包装，如果app仅用于中国区应用，为了保证当用户修改语言环境时app显示语言一致，则需要设置NSLocal（不常用）
    numberFormatter.locale= [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    //全拼格式
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    
    //小数点后最少位数
    [numberFormatter setMinimumFractionDigits:2];
    
    //小数点后最多位数
    [numberFormatter setMaximumFractionDigits:6];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    
    NSString* formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    
    //通过NSNumberFormatter转换为大写的数字格式eg:一千二百三十四
    //替换大写数字转为金额
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"一"withString:@"壹"];
    
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"二"withString:@"贰"];
    
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"三"withString:@"叁"];
    
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"四"withString:@"肆"];
    
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"五"withString:@"伍"];
    
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"六"withString:@"陆"];
    
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"七"withString:@"柒"];
    
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"八"withString:@"捌"];
    
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"九"withString:@"玖"];
    
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"〇"withString:@"零"];
    
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"千"withString:@"仟"];
    
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"百"withString:@"佰"];
    
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"十"withString:@"拾"];
    
    //对小数点后部分单独处理
    // rangeOfString前面的参数是要被搜索的字符串，后面的是要搜索的字符
    if([formattedNumberString rangeOfString:@"点"].length>0)
    {
        //将“点”分割的字符串转换成数组，这个数组有两个元素，分别是小数点前和小数点后
        NSArray* arr = [formattedNumberString componentsSeparatedByString:@"点"];
        
        //如果对一不可变对象复制，copy是指针复制（浅拷贝）和mutableCopy就是对象复制（深拷贝）。如果是对可变对象复制，都是深拷贝，但是copy返回的对象是不可变的。
        //这里指的是深拷贝
        NSMutableString* lastStr = [[arr lastObject]mutableCopy];
        NSLog(@"---%@---长度%ld", lastStr, lastStr.length);
        
        if(lastStr.length>=2)
        {
            //在最后加上“分”
            [lastStr insertString:@"分"atIndex:lastStr.length];
        }
        
        if(![[lastStr substringWithRange:NSMakeRange(0,1)]isEqualToString:@"零"])
        {
            //在小数点后第一位后边加上“角”
            [lastStr insertString:@"角"atIndex:1];
        }
        
        //在小数点左边加上“元”
        formattedNumberString = [[arr firstObject]stringByAppendingFormat:@"元%@",lastStr];
    } else//如果没有小数点
    {
        formattedNumberString = [formattedNumberString stringByAppendingString:@"元"];
    }
    
    return [formattedNumberString stringByAppendingString:@"整"];
}

-(NSString *)convertSpecifiedPrecisionFloatString:(int)precision{
    NSString *format = [NSString stringWithFormat:@"%%.%df",precision];
    return [NSString stringWithFormat:format,[self floatValue]];
}


/**
 身份证出生日期那八位显示为******
 
 @return
 */
- (NSString *)formateCardID {
    if (18 != self.length) {
        return nil;
    }
    
    return [self stringByReplacingCharactersInRange:NSMakeRange(6, 8) withString:@"********"];
}
//字典转json格式字符串：
+(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
