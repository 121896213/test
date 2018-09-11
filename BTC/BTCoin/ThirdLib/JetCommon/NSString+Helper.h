//
//  NSString+Helper.h
//  NetDemo
//
//  Created by lixinglou on 16/7/18.
//  Copyright © 2016年 lixinglou. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSValidString(str) [NSString checkNULLstring:str]
//如果为空，返回默认字符
#define NSDefaultString(str,default) [NSString validForStr:str default:defaultStr]
//时间戳，如果为空，返回“0”
#define NSTimeStampString(str) [NSString validForStr:str default:@"0"]


@interface NSString (Helper)

///是否整数,溢出时返回NO
- (BOOL)isIntValue;
///是否浮点型,溢出时返回NO
- (BOOL)isFloatValue;
///是否手机号码
- (BOOL)isMobliePhone;
///是否邮箱
- (BOOL)isEmail;
///是否有效字符串
- (BOOL)isValid;
///手机号码格式
- (NSString *)phoneTypeStr;
///去除所有空格回车
- (NSString *)visbleStr;
///除去头尾空格回车
- (NSString *)validStr;
/// md5
- (NSString *)md5Str;
/// json
//- (NSString *)jsonStr;
//变成json格式字符串
- (NSString*)jsonFormat;
///计算文本占用空间
- (CGSize)sizeWithFont:(UIFont*)font inSzie:(CGSize)size;
///计算文本高度
- (CGFloat)heightWithFont:(UIFont*)font inWidth:(CGFloat)width;
///计算文本宽度
- (CGFloat)widthWithFont:(UIFont*)font;
///base64
- (NSString *)base64Str;
//SAP base64
- (NSString *)sapBase64Str;
- (long)longValue;
//文本字节数
- (NSUInteger)byteLength;
//得到文件的唯一文件名，比如 a/b/c.png  得到abc.png
- (NSString *)storeFilePathName;

//将文本转为二维码图片
- (UIImage *)getQrCodeImageWithSize:(CGFloat)imageSize centerImage:(UIImage *)centerImage;

- (UIImage *)getQrCodeImageWithSize:(CGFloat)imageSize centerImage:(UIImage *)centerImage centerImageSize:(CGFloat)centerIamgeSize;

#pragma mark - class method

///判断是否为空
+ (BOOL)isEmpty:(NSString *)str;
///判断是否浮点型，以及小数点位数
+ (BOOL)isFloatValueWithString:(NSString *)string decimalLength:(NSUInteger)decimalLenght;
//得到非空字符
+ (NSString *)checkNULLstring:(NSString *)oriString;

//得到默认字符，当str为空时，返回默认的Str
+ (NSString *)validForStr:(NSString*)str default:(NSString*)defaultStr;

//字符转长整形
+ (long)stringToLongWithValue:(NSString *)lValue;

//将数字转为汉字
+ (NSString *)getChineseHanZiWithNum:(NSUInteger)num;

//搜索文本（多个）
+ (NSArray *)getRangWithStr:(NSString *)searchText FromStr:(NSString *)oriText;

//根据电话号码和web环境得到文件夹名字
+ (NSString *)getFileNameWithWebAndPhoneNum:(NSString *)phoneNum;

/*
 移动设计器中分割逗号,要去掉前后空格
 */
- (NSArray <NSString *>*)dynamicComponentsSeparatedByString:(NSString *)separator;

+(NSString *)reviseString:(NSString *)str;

-(NSString *)replaceStringWithAsterisk:(NSInteger)startLocation length:(NSInteger)length;

#define StringToLongInt(x) [NSString stringToLongWithValue:x]

//得到整形的字符值
#define StringFromInt(x) [NSString stringWithFormat:@"%d",x]
#define StringFromLongInt(x) [NSString stringWithFormat:@"%ld",x]

@end

@interface NSAttributedString (Size)

///计算文本高度
- (CGFloat)heightWithWidth:(CGFloat)width;
@end
