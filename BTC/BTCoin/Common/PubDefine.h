//
//  PubDefine.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#ifndef LePats_PubDefine_h
#define LePats_PubDefine_h



#ifdef DEBUG

#define ENABLE_ASSERT_STOP          1
#define ENABLE_DEBUGLOG             1

#endif

// 颜色日志
#define XCODE_COLORS_ESCAPE_MAC @"\033["
#define XCODE_COLORS_ESCAPE_IOS @"\xC2\xA0["
#define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_MAC
#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color
#define LogBlue(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,150,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogRed(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg250,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogGreen(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,235,30;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

// debug log
#ifdef ENABLE_DEBUGLOG
#define APP_DebugLog(...) NSLog(__VA_ARGS__)
#define APP_DebugLogBlue(...) LogBlue(__VA_ARGS__)
#define APP_DebugLogRed(...) LogRed(__VA_ARGS__)
#define APP_DebugLogGreen(...) LogGreen(__VA_ARGS__)
#else
#define APP_DebugLog(...) do { } while (0);
#define APP_DebugLogBlue(...) do { } while (0);
#define APP_DebugLogRed(...) do { } while (0);
#define APP_DebugLogGreen(...) do { } while (0);
#endif

// log
#define APP_Log(...) NSLog(__VA_ARGS__)

// assert
#ifdef ENABLE_ASSERT_STOP
#define APP_ASSERT_STOP                     {LogRed(@"APP_ASSERT_STOP"); NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);}
#define APP_ASSERT(condition)               {NSAssert(condition, @" ! Assert");}
#else
#define APP_ASSERT_STOP                     do {} while (0);
#define APP_ASSERT(condition)               do {} while (0);
#endif


/////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Redefine

#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]
#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define SelfNavBar                          self.navigationController.navigationBar
#define SelfTabBar                          self.tabBarController.tabBar
#define SelfNavBarHeight                    self.navigationController.navigationBar.bounds.size.height
#define SelfTabBarHeight                    self.tabBarController.tabBar.bounds.size.height
#define ScreenRect                          [[UIScreen mainScreen] bounds]
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define TouchHeightDefault                  44
#define TouchHeightSmall                    32
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewHeight                      self.view.bounds.size.height
#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height
#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetOffsetX(f, x)                CGRectMake(RectX(f)+x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetOffsetY(f, y)                CGRectMake(RectX(f), RectY(f)+y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define RectFour(x, y, w, h)                CGRectMake(x, y, w, h)
#define DATE_COMPONENTS                     NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
#define TIME_COMPONENTS                     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
#define FlushPool(p)                        [p drain]; p = [[NSAutoreleasePool alloc] init]
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define SelfDefaultToolbarHeight            self.navigationController.navigationBar.frame.size.height
#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsiOS7Later                         !(IOSVersion < 7.0)

#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)


#define TabBarHeight                        (iPhoneX?82.0f:49.0f)
#define NaviBarHeight                       44.0f
#define HeightFor4InchScreen                568.0f
#define HeightFor3p5InchScreen              480.0f
#define StatusBarHeight                     (iPhoneX?44.0f:20.0f)
#define NavigationStatusBarHeight           (iPhoneX?88.0f:64.0f)
#define TopOfStatusBar_IPhoneX              (iPhoneX?24.0f:0.0f)
#define Botoom_IPhoneX                      (iPhoneX?34.0f:0.0f)

#define ViewCtrlTopBarHeight                (IsiOS7Later ? (NaviBarHeight + StatusBarHeight) : NaviBarHeight)
#define IsUseIOS7SystemSwipeGoBack          (IsiOS7Later ? YES : NO)
#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? 1 : 0
#define iOS10 [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0 ? 1 : 0
#define iOS11 [[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0 ? 1 : 0

#define LocalizedString(str) NSLocalizedString(str, @"")


//app（程序版本号）
#define app_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//app名称
#define app_Name [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//app包名
#define app_BundleId [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

//////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - app define


#define Is4Inch                                 [UtilityFunc is4InchScreen]

#define RGB_AppWhite                            RGB(252.0f, 252.0f, 252.0f)

#define RGB_TextLightGray                       RGB(200.0f, 200.0f, 200.0f)
#define RGB_TextMidLightGray                    RGB(127.0f, 127.0f, 127.0f)
#define RGB_TextDarkGray                        RGB(100.0f, 100.0f, 100.0f)
#define RGB_TextLightDark                       RGB(50.0f, 50.0f, 50.0f)
#define RGB_TextDark                            RGB(10.0f, 10.0f, 10.0f)
#define RGB_TextAppOrange                       RGB(224.0f, 83.0f, 51.0f)
#define SIZE_TextSmall                          10.0f
#define SIZE_TextContentNormal                  13.0f
#define SIZE_TextTitleMini                      15.0f
#define SIZE_TextTitleNormal                    17.0f
#define SIZE_TextLarge                          16.0f
#define SIZE_TextHuge                           18.0f
#define XC_HTTP_TIMEOUT                         10.0f

#define NavBarColor                             UIColorFromRGB(0x192238)//背景暗黑
#define WhiteColor                              UIColorFromRGB(0xffffff)//白色
#define MainThemeBlueColor                      UIColorFromRGB(0x4E6AAE)//背景暗蓝
#define MainThemeColor                          UIColorFromRGB(0x688de8)//主题蓝
#define HomeLightColor                          UIColorFromRGB(0x4E6AAE)//主页亮蓝色
#define MainThemeHighlightColor                 UIColorFromRGBWithAlpha(0x4E6AAE,0.9)//主题高亮蓝
#define LineColor                               UIColorFromRGB(0xd1d6e2)//分割线颜色
#define MainLabelGrayColor                      UIColorFromRGB(0xA3ACC0)//label灰色
#define MainLabelLightBlackColor                UIColorFromRGB(0x656566)//label黑色
#define MainLabelBlackColor                     UIColorFromRGB(0x333333)//label黑色
#define MainViewBorderColor                     UIColorFromRGBWithAlpha(0x192238, 0.15)//view 边框色
#define TableHeaderBGColor                      UIColorFromRGB(0xdadfeb)//背景灰色
#define MainBackgroundColor                     UIColorFromRGB(0xF2F3F5)//背景灰色
#define MainBuyButtonBackgroundColor            UIColorFromRGB(0x03C087)//买入绿色
#define MainSellButtonBackgroundColor           UIColorFromRGB(0xFF6333)//卖出红色
#define MainNavBarColor                         UIColorFromRGB(0xffffff)//导航栏白色
#define MainC2CBackgroundColor                  UIColorFromRGB(0xf7f8fa)//背景灰色
#define MainC2CBlueColor                        UIColorFromRGB(0x6188EA)//C2C相关功能蓝色


#define color_333333 UIColorFromRGB(0x333333)
#define color_ffbd5b UIColorFromRGB(0xffbd5b)
#define color_f2f2f2 UIColorFromRGB(0xf2f2f2)
#define color_d2d2d2 UIColorFromRGB(0xd2d2d2)
#define color_ffdead UIColorFromRGB(0xffdead)


#define UIScreenWidth CGRectGetWidth([[UIScreen mainScreen] bounds])
#define UIScreenHeight CGRectGetHeight([[UIScreen mainScreen] bounds])
#define PERCENTW_ADAPTATION  UIScreenWidth/414.0f
#define FIT(f)  f*PERCENTW_ADAPTATION
#define FIT2(f)  (f/2)*PERCENTW_ADAPTATION
#define FIT3(f)  (f/3)*PERCENTW_ADAPTATION

#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

// RGB颜色方法
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

// 快速格式化字符串
#define FormatString(...) [NSString stringWithFormat:__VA_ARGS__]


/*
 16进制的文字颜色转RGB
 */
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#pragma mark 状态提示语
#define RequestState_NetworkErrorStr(str)  [NSString stringWithFormat:@"网络连接异常，请点击屏幕重试"]
#define RequestState_EmptyStr(str)  [NSString stringWithFormat:@"暂无数据"]

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6_Plus         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneX   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPad        ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//设备版本号
#define DeviceValue [[[UIDevice currentDevice] systemVersion] floatValue]

#define kUserId @"userId"

#define kLoginMargin 10

#endif
