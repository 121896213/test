



#import <UIKit/UIKit.h>

@interface SliderMenuBottomScroView : UIScrollView

@end

/**SliderMenuView的类型*/
typedef NS_ENUM(NSInteger,SliderMenuViewType){
    
    /**房间专属*/
    SliderMenuViewType_Room,
    /**正常*/
    SliderMenuViewType_Normal,
};

@interface SliderMenuView : UIView

@property (nonatomic, strong) SliderMenuBottomScroView *bottomScroView;
/**显示显示指定下标的红色提示*/
@property (nonatomic, assign) NSInteger showBadgeIndex;
/**H红色提示的颜色*/
@property (nonatomic, strong) UIColor *badgeColor;
/**标题的背景色*/
@property (nonatomic, strong) UIColor *titleBagColor;
/**默认选择的是哪一个按钮*/
@property (nonatomic, assign) NSInteger defaultSelectIndex;
/**顶部的控制menu的背景色*/
@property (nonatomic, strong) UIColor *topBagColor;

- (void)showUnBadgeIndex:(NSInteger)showBadgeIndex;

- (void)setIndex:(int)index backgroudColor:(UIColor *)bgColor textColor:(UIColor *)textColor;

- (void)setIndex:(int)index plant:(BOOL)bTitle;

/**
 *  滚动控制视图
 *
 *  @param frame       frame
 *  @param titles      标题数组
 *  @param selectIndex 默认选择的模块（1，2，3，4....下标是按照1开始计算 不是从0开始计算）
 *  @param type        类型
 *
 */
- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withDefaultSelectIndex:(NSInteger)selectIndex withType:(SliderMenuViewType)type;
/**存储view的数组*/
@property (nonatomic, strong) NSArray *viewArrays;
/**点击顶部按钮 或者滑动切换对应页面时候的回调*/
@property (nonatomic, copy) void (^DidSelectSliderIndex)(NSInteger index);
/**交易按钮*/
@property (nonatomic, strong) UIButton *tradingBtn;

- (void)hanleBlockWith:(NSInteger)index;
/**设置默认选择的模块 红点会消失*/
- (void)setDefaultIndex:(int)nIndex;

/**重置全部的红点提示*/
- (void)resetAllBadgePrompt;

/**重置会默认选择第一个按钮*/
- (void)resetSelectFirstIndex;

/**是否显示顶部的分割线*/
- (void)setTopLineViewHide:(BOOL)value;

/**是否显示title下面的横线*/
- (void)setTitleLineViewHide:(BOOL)value;

/**皮肤切换*/
- (void)setThemeSkin;
@end
