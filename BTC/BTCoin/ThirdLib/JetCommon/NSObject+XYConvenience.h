//
//  NSObject+XYConvenience.h
//  WisePal
//
//  Created by sunon002 on 15-5-8.
//  Copyright (c) 2015年 Jet.Luo. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Class XYConvenience
typedef void(^BlockAlertViewOkCancel)(BOOL ok);

@interface NSObject (XYConvenience)

//-- Valid
- (BOOL)validObject;
- (BOOL)isKindOfStringClass;
- (BOOL)isKindOfNumberClass;
- (BOOL)isKindOfStringOrNumberClass;
- (BOOL)isKindOfDateClass;
- (BOOL)isKindOfDataClass;
- (BOOL)isKindOfArrayClass;
- (BOOL)isKindOfDictionaryClass;

#pragma mark - 查找属性
- (NSArray * _Nullable)objectAllPropertys;
- (BOOL)objectHasPropertyName:(NSString * _Nonnull)pname;

#pragma mark - block
- (void)alertViewCancelOrOkMessage:(NSString *_Nonnull)mess WithBlock:(BlockAlertViewOkCancel _Nonnull)block;
- (void)alertViewTitle:(NSString * _Nonnull)title
                messge:(NSString * _Nonnull)message
            cancelText:(NSString * _Nullable)cancelText
            affirmText:(NSString * _Nonnull)affirmText
             withBlock:(BlockAlertViewOkCancel _Nonnull)block;

+ (BOOL)isValidateString:(NSString * _Nonnull)string croppedLen:(NSInteger)len;

@end

#pragma mar - Class XYNewProperty
@interface NSObject (XYNewProperty)
@property(nonatomic, strong, nullable) NSMutableDictionary *dictInfo;
@end

#pragma mark - Class XYAlertView
@protocol XYAlertViewDelegate <NSObject>
- (void)xyAlertView:(UIAlertView * _Nullable)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface XYAlertView : UIAlertView<UIAlertViewDelegate>
@property (nonatomic, weak, nullable) id xyDelegate;
@end
