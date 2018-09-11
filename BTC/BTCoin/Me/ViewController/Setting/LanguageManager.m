//
//  LanguageManager.m
//  BTCoin
//
//  Created by Shizi on 2018/4/23.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "LanguageManager.h"
#import "AppDelegate.h"
#import <objc/runtime.h>
#define CNS @"zh-Hans"
#define EN @"en"
#define LANGUAGE_SET @"AppleLanguages"

@interface LanguageManager ()
@property(nonatomic,strong)NSBundle *bundle;


@end

@implementation LanguageManager
DEFINE_SINGLETON_FOR_CLASS(LanguageManager)

static LanguageManager *sharedModel;

+(id)sharedInstance
{
    if (!sharedModel)
    {
        sharedModel = [[LanguageManager alloc]init];
    }
    
    return sharedModel;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initLanguage];
    }
    
    return self;
}

-(void)initLanguage
{
    
    NSArray *tmp = [[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGE_SET];
    NSString *path;
    //默认是中文
    if ([tmp[0] containsString:CNS] || isEmptyObject(tmp))
    {
        self.language = CNS;
    }else
    {
        self.language = EN;
    }

    path = [[NSBundle mainBundle]pathForResource:self.language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
}

- (NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table
{
    if (self.bundle)
    {
        return NSLocalizedStringFromTableInBundle(key, table, self.bundle, @"");
    }
    
    return NSLocalizedStringFromTable(key, table, @"");
}

- (void)changeNowLanguage
{
    if ([self.language isEqualToString:EN]){
        [self setNewLanguage:CNS];
        self.language=CNS;
    }else{
        [self setNewLanguage:EN];
        self.language=EN;
    }
}
- (NSString *)getNowlanguage{

    if ([self.language isEqualToString:EN]) {
        return NSLocalizedString(@"English", nil);
    }else{
        return NSLocalizedString(@"中文", nil);

    }
    
}
-(void)setNewLanguage:(NSString *)language
{
    if ([language isEqualToString:self.language])
    {
        return;
    }
    
    //找到需要改成的语言路径
//    if ([language isEqualToString:EN] || [language isEqualToString:CNS])
//    {
//        NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
//        self.bundle = [NSBundle bundleWithPath:path];
//    }
//
//    self.language = language;
//    NSLog(@"%@", language);
//    [[NSUserDefaults standardUserDefaults]setObject:language forKey:LANGUAGE_SET];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    [NSBundle setLanguage:language];

    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:language, nil] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    [self resetRootViewController];
}

//重新设置
-(void)resetRootViewController
{
    [UIViewController showErrorHUDWithTitle:@"语言切换成功"];
    [[SZSundriesCenter instance]delayExecutionInMainThread:^{
        TabBarController *tab = [[TabBarController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
        tab.selectedIndex = 4;
    }];

}
@end


static const char _bundle = 0;

@interface BundleEx : NSBundle

@end

@implementation BundleEx

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &_bundle);
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

@end

@implementation NSBundle (Language)

+ (void)setLanguage:(NSString *)language {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [BundleEx class]);
    });
    
    objc_setAssociatedObject([NSBundle mainBundle], &_bundle, language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end





