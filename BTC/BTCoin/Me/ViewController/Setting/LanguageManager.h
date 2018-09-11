//
//  LanguageManager.h
//  BTCoin
//
//  Created by Shizi on 2018/4/23.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#define FGGetStringWithKeyFromTable(key, tbl) [[LanguageManager sharedInstance] getStringForKey:key withTable:tbl]

@interface LanguageManager : NSObject

DEFINE_SINGLETON_FOR_HEADER(UserInfo)

@property(nonatomic, copy)NSString *language;

+(id)sharedInstance;

-(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table;

-(void)changeNowLanguage;

- (NSString *)getNowlanguage;

-(void)setNewLanguage:(NSString*)language;

-(void)resetRootViewController;


@end

@interface NSBundle (Language)

+ (void)setLanguage:(NSString *)language;

@end
