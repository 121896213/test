//
//  AppUtil.h
//  mengShare
//
//  Created by jeebee on 15/5/4.
//  Copyright (c) 2015年 macro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppUtil : NSObject

+ (UIColor *)appLineColor;
+ (UIColor *)appBlueColor;
+ (UIColor *)appRedColor;
+ (UIColor *)appThemeColor;
+ (UIColor *)appTimeSharingColor;
+ (UIColor *)appBottomBarColor;

+ (UIColor *)appBorderColor;
+ (UIColor *)appLightGrayColor;
+ (UIColor *)appGrayColor;
+ (UIColor *)appBlackColor;
+ (UIColor *)appOrangeColor;
+ (UIColor *)appGreenColor;
+ (UIColor *)appBackgroundColor;
+ (UIColor *)appBuyColor;
+ (UIColor *)appSaleColor;
+ (UIColor *)appTextColorWithValue:(double)value;

+ (void)customizeNavigationBar;


+ (id)valueOfKey:(NSString *)key inData:(NSArray *)data withFields:(NSArray *)fields;

/**
 *  关闭键盘
 */
+ (void)closeKeyboard;

+ (UIBarButtonItem *)backBarButtonWithoutTitle;

+(void) startLoadingForView:(UIView*)view;
+(void) endLoadingForView:(UIView*)view;

+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (BOOL)isValidPhoneNumInput:(NSString *)input;
//手机号码格式验证
+ (BOOL)isValidateMobile:(NSString *)mobile;
+ (BOOL)isValidAccount:(NSString *)account;
+ (BOOL)isValidPassword:(NSString *)passWord;
+ (BOOL)validNewPatternPassword:(NSString *)password;
+ (BOOL)isPureCharacters:(NSString *)string;
+ (BOOL)isValidateEmail:(NSString *)email;
//校验银行卡号
+(BOOL) isValidateBankCard:(NSString *)card;
//校验身份号
+(BOOL) isValidatePersonCard:(NSString *)card;
+ (BOOL)isPureInt:(NSString*)string;
+(BOOL) isValidateContainLetter:(NSString *)string;
+ (NSString *)md5:(NSString *)string;

/**
 *  返回登录界面
 *
 *  @return
 */
+ (UIViewController *)getLoginViewController;

/**
 *  获取当前的时间搓
 */
+ (NSString *)currentTimeInterval;

/**
 *  把字符串时间变为时间搓
 *
 *  @param timeString 时间字符串
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)getTimeStamp:(NSString *)timeString;

/**
 *  把时间戳转化为字符串
 *
 *  @param interval 时间戳
 *
 *  @return 字符串
 */

+ (NSDate *)dateFromISO8601String:(NSString *)string;

+ (NSString *)getTimeString:(NSTimeInterval)interval;

+ (NSDate *)getDateWithString:(NSString *)string;

+ (NSDate *)getDateWithString:(NSString *)string withFormat:(NSString *)format;

+ (NSString *)getDateStringWithDate:(NSDate *)date withFormat:(NSString *)format;

+ (NSDate *)getDateWithStr:(NSString *)str format:(NSString *)format;

+ (NSString *)getStrWithDate:(NSDate *)date format:(NSString *)format;

//获得指定格式的当前日期
+ (NSString *)getCurrentDateWithFormat:(NSString *)formatStr;

+ (NSString *)getDateStringWithString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *) datetimeStrFormatter:(NSString *)dateStr formatter:(NSString *)formatterStr;

/**
 *  加工TableView,headerView,footerView全部设为0;
 *
 *  @param tableView 需要加工的TableView
 *
 *  @return 完成后的TableView
 */
+ (UITableView *)processTableViewHeaderFooterWithTableView:(UITableView *)tableView;


+ (UIImage *)makeAspactImageWithImage:(UIImage *)image targetSize:(CGSize)size;

+ (NSString * )changeOverPayCardStirngWithString:(NSString *)old;

+ (void)makeCircleAvatarView:(UIView *)avatar;

+ (void)shadowForLabel:(UILabel *)label;

+ (UIImage*)imageWithImageSimple:(UIImage*)image;

+ (UIImage *)scaleRotateImage:(UIImage *)image withMaxSize:(NSInteger )kMaxResolution;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;


+ (NSString *)encodeWithPassword:(NSString *)pwd;

+ (NSString *)priceStringWithPrice:(NSString *)price;

+ (NSString *)notificationNameWithCmdType:(NSInteger)cmdType;

//计算单个文件大小
+ (float)fileSizeAtPath:(NSString *)path;
//计算目录大小
+ (float)folderSizeAtPath:(NSString*)folderPath;

#pragma mark - JSON vs Object -
+ (NSString *)jsonStringWithObject:(id)object;
+ (id)objectWithJsonString:(NSString *)jsonString;

#pragma mark - 把NSURL的query转化为NSDictionary
+ (NSDictionary*)dictionaryFromQuery:(NSURL*)url usingEncoding:(NSStringEncoding)encoding;

#pragma mark - 礼物相关

+ (NSString *)getUrlMethodValueWithMethodName:(NSString *)methodName webaddress:(NSString *)webaddress;
+(UIViewController*)getLastVCWithSrcViewController:(UIViewController*)viewController;
@end

