//
//  UIScrollView+XYFloatFooter.m
//  XYModuleChoiceView
//
//  Created by 罗显勇 on 15/5/12.
//  Copyright © 2015年 JetLuo. All rights reserved.
//

#import "UIScrollView+XYFloatFooter.h"
#import <objc/runtime.h>

NSString *const XYRefreshKeyPathContentOffset = @"contentOffset";
NSString *const XYRefreshKeyPathFrame = @"frame";

#define XYFloatFooter_Tag 1020
#define XYFloatHeader_Tag 1021

@implementation UIScrollView (XYFloatFooter)

#pragma mark - 添加属性
- (BOOL)xyFloatFooterNoFixed {
    NSNumber *number = (NSNumber *)objc_getAssociatedObject(self, @selector(xyFloatFooterNoFixed));
    return [number boolValue];
}
- (void)setXyFloatFooterNoFixed:(BOOL)xyFloatFooterNoFixed {
    objc_setAssociatedObject(self, @selector(xyFloatFooterNoFixed), [NSNumber numberWithBool:xyFloatFooterNoFixed], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 方式一：如果其他地方有对contentOffset进行监听会导致冲突
- (void)removeObserverOffsetInFloatView {
    [self removeObserver:self forKeyPath:XYRefreshKeyPathContentOffset context:NULL];
    [self removeFloatFooterView];
}
- (void)addObserverOffsetInFloatFooterView:(UIView *)footerView {
    if(![self viewWithTag:XYFloatFooter_Tag]) {
        [self addTagOnFloatFooterView:footerView];
        if (![self viewWithTag:XYFloatHeader_Tag]) {
            [self addObserver:self forKeyPath:XYRefreshKeyPathContentOffset options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:NULL];
        }
    } else {
        [self updateFrameOfFloatFooterView];
    }
}
- (void)addObserverOffsetInFloatHeaderView:(nonnull UIView *)headerView {
    if(![self viewWithTag:XYFloatHeader_Tag]) {
        [self addTagOnFloatHeaderView:headerView];
        if (![self viewWithTag:XYFloatFooter_Tag]) {
            [self addObserver:self forKeyPath:XYRefreshKeyPathContentOffset options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:NULL];
        }
    } else {
        [self updateFrameOfFloatFooterView];
    }
}

#pragma mark - 方式二：如果其他地方有对frame进行监听会导致冲突
- (void)removeObserverFrameInFloatView {
    [self removeObserver:self forKeyPath:XYRefreshKeyPathFrame context:NULL];
    [self removeFloatFooterView];
}
- (void)addObserverFrameInFloatFooterView:(nonnull UIView *)footerView {
    if(![self viewWithTag:XYFloatFooter_Tag]) {
        [self addTagOnFloatFooterView:footerView];
        if (![self viewWithTag:XYFloatHeader_Tag]) {
            [self addObserver:self forKeyPath:XYRefreshKeyPathFrame options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:NULL];
        }
    } else {
        [self updateFrameOfFloatFooterView];
    }
}
- (void)addObserverFrameInFloatHeaderView:(UIView *)headerView {
    if(![self viewWithTag:XYFloatHeader_Tag]) {
        [self addTagOnFloatHeaderView:headerView];
        if (![self viewWithTag:XYFloatFooter_Tag]) {
            [self addObserver:self forKeyPath:XYRefreshKeyPathFrame options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:NULL];
        }
    } else {
        [self updateFrameOfFloatFooterView];
    }
}
- (void)scrollViewDidScroll {
    [self updateFrameOfFloatFooterView];
}

#pragma mark - Public Methods
- (void)removeFloatFooterView {
    [[self viewWithTag:XYFloatFooter_Tag] removeFromSuperview];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if([keyPath isEqualToString:XYRefreshKeyPathContentOffset]) {
        [self updateFrameOfFloatFooterView];
        [self updateFrameOfFloatHeaderView];
    } else if([keyPath isEqualToString:XYRefreshKeyPathFrame]) {
        [self updateFrameOfFloatFooterView];
        [self updateFrameOfFloatHeaderView];
    }
}

//-- FooterView
- (CGFloat)heightOfFloatFooterView {
    return CGRectGetHeight([[self viewWithTag:XYFloatFooter_Tag] bounds]);
}
- (void)addTagOnFloatFooterView:(UIView *)footerView {
    [footerView setTag:XYFloatFooter_Tag];
    [footerView removeFromSuperview];
    [self addSubview:footerView];
    CGFloat height = [self heightOfFloatFooterView];
    [footerView setFrame:CGRectMake(0, CGRectGetHeight(self.frame)-height, CGRectGetWidth(footerView.frame), height)];
    [footerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
}
- (void)updateFrameOfFloatFooterView {
    UIView *footerView = [self viewWithTag:XYFloatFooter_Tag];
    if(!footerView) return;
    CGFloat height   = CGRectGetHeight(self.frame);
    CGFloat offset_y = self.contentOffset.y;
    CGFloat content_h= self.contentSize.height;
    CGFloat insets_bottom = self.contentInset.bottom;
    CGFloat insets_top = self.contentInset.top;
    CGFloat now_y = 0;
    if (!self.xyFloatFooterNoFixed) {
        if(content_h+insets_top+insets_bottom > height) { //-- 内容高度+顶部嵌入高度>显示高度
            if(offset_y + insets_top + height  >= content_h + insets_bottom + insets_top) {
                now_y = content_h + insets_bottom - [self heightOfFloatFooterView];
            } else {
                now_y = offset_y + height - [self heightOfFloatFooterView];
            }
        } else {
            if (offset_y >= -insets_top) { //-- 上拉跟着
                now_y = height - insets_bottom - insets_top;
            } else { //-- 下拉固定
                now_y = height - insets_bottom + offset_y;
            }
        }
    } else {
        if(content_h+insets_top+insets_bottom > height) {
            now_y = content_h + insets_bottom - [self heightOfFloatFooterView];
        } else {
            now_y = height - insets_bottom - insets_top;
        }
    }
    [footerView setFrame:CGRectMake(0, now_y, CGRectGetWidth(self.frame), [self heightOfFloatFooterView])];
}

//-- HeaderView
- (CGFloat)heightOfFloatHeaderView {
    return CGRectGetHeight([[self viewWithTag:XYFloatHeader_Tag] bounds]);
}
- (void)addTagOnFloatHeaderView:(UIView *)headerView {
    [headerView setTag:XYFloatHeader_Tag];
    [headerView removeFromSuperview];
    [self addSubview:headerView];
    CGFloat height = [self heightOfFloatHeaderView];
    [headerView setFrame:CGRectMake(0, -height, CGRectGetWidth(headerView.frame), height)];
    [headerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
}
- (void)updateFrameOfFloatHeaderView {
    UIView *headerView = [self viewWithTag:XYFloatHeader_Tag];
    if(!headerView) return;
    CGFloat offset_y = self.contentOffset.y;
    CGFloat insets_h = self.contentInset.top;
    CGFloat now_y = 0;
    if(offset_y >= -1*insets_h) {
        now_y = offset_y;
    } else {
        now_y = -1 * insets_h;
    }
    [headerView setFrame:CGRectMake(0, now_y, CGRectGetWidth(self.frame), CGRectGetHeight(headerView.frame))];
}

@end



















