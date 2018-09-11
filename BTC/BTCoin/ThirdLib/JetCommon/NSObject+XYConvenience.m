//
//  NSObject+XYConvenience.m
//  WisePal
//
//  Created by sunon002 on 15-5-8.
//  Copyright (c) 2015年 Jet.Luo. All rights reserved.
//

#import "NSObject+XYConvenience.h"
#import <objc/runtime.h>
@implementation NSObject (XYConvenience)

//-- Valid
- (BOOL)validObject {
    if((NSNull *)self == [NSNull null]) {
        return NO;
    }
    return YES;
}

- (BOOL)isKindOfStringClass {
    if ([self validObject]) {
        if ([self isKindOfClass:[NSString class]]) {
            if ([(NSString *)self isEqualToString:@"(null)"]) {
                return NO;
            }
            return YES;
        }
    }
    return NO;
}

- (BOOL)isKindOfNumberClass {
    if ([self validObject]) {
        if ([self isKindOfClass:[NSNumber class]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isKindOfStringOrNumberClass {
    if ([self validObject]) {
        if ([self isKindOfClass:[NSNumber class]] || [self isKindOfClass:[NSString class]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isKindOfDateClass {
    if ([self validObject]) {
        if ([self isKindOfClass:[NSDate class]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isKindOfDataClass {
    if ([self validObject]) {
        if ([self isKindOfClass:[NSData class]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isKindOfArrayClass {
    if ([self validObject]) {
        if ([self isKindOfClass:[NSArray class]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isKindOfDictionaryClass {
    if ([self validObject]) {
        if ([self isKindOfClass:[NSDictionary class]]) {
            return YES;
        }
    }
    return NO;
}

- (NSArray * _Nullable)objectAllPropertys {
    NSMutableArray *props = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        const char* char_f =property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
    }
    free(properties);
    return props;
}
- (BOOL)objectHasPropertyName:(NSString *)pname {
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        const char* char_f =property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        if([pname isEqualToString:propertyName]) {
            return YES;
        }
    }
    free(properties);
    return NO;
}

//-- 弹窗
- (void)alertViewCancelOrOkMessage:(NSString *)mess WithBlock:(BlockAlertViewOkCancel)block {
    XYAlertView *alertView = [[XYAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:mess delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"确认", nil), nil];
    alertView.dictInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:block,@"BlockAlertViewOkCancel", nil];
    [alertView show];
}

- (void)alertViewTitle:(NSString *)title
                messge:(NSString *)message
            cancelText:(NSString *)cancelText
            affirmText:(NSString *)affirmText
             withBlock:(BlockAlertViewOkCancel)block {
    XYAlertView *alertView = [[XYAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:cancelText
                                              otherButtonTitles:affirmText, nil];
    alertView.dictInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:block,@"BlockAlertViewOkCancel",affirmText,@"AffirmText", nil];
    [alertView show];
}

- (void)xyAlertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSDictionary *dict = alertView.dictInfo;
    BlockAlertViewOkCancel block = [dict valueForKey:@"BlockAlertViewOkCancel"];
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:[dict valueForKey:@"AffirmText"]]) {
        block(YES);
    } else {
        block(NO);
    }
}

+ (BOOL)isValidateString:(NSString *)string croppedLen:(NSInteger)len {
    if (!string) {
        return YES;
    }
    NSUInteger  character = 0;
    for(int i=0; i< [string length];i++){
        int a = [string characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fa5){ //判断是否为中文
            character += 2;
        } else {
            character += 1;
        }
    }
    if (character <= len) {
        return YES;
    } else {
        return NO;
    }
}

@end


#pragma mark - Class XYNewProperty
@implementation NSObject (XYNewProperty)

- (NSMutableDictionary *)dictInfo {
    return objc_getAssociatedObject(self, @"key_dictInfo");
}
- (void)setDictInfo:(NSMutableDictionary *)dictInfo {
    objc_setAssociatedObject(self, @"key_dictInfo", dictInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


#pragma mark - Class XYNewProperty
@implementation XYAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if(self) {
        self.xyDelegate = delegate;
    }
    return self;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([self.xyDelegate respondsToSelector:@selector(xyAlertView:clickedButtonAtIndex:)]) {
        [self.xyDelegate xyAlertView:alertView clickedButtonAtIndex:buttonIndex];
    }
}

@end
