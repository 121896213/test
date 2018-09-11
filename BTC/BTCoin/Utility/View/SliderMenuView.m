
#import "SliderMenuView.h"
#import "SliderMenuTopScrollView.h"
#import "TabBarController.h"



#define weakSelf(Target) __weak typeof(Target) weakself = Target


@interface SliderMenuBottomScroView ()


@end

@implementation SliderMenuBottomScroView

/**
 *  重写手势，如果是左滑，则禁用掉scrollview自带的
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        if([pan translationInView:self].x > 0.0f && self.contentOffset.x == 0.0f)
        {
            return NO;
        }
    }
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}

@end


@interface SliderMenuView ()<UIScrollViewDelegate>
{
    /**当前view高度*/
    CGFloat _self_H;
    /**顶部scroViewFrame*/
    CGRect _topScroV_F;
    /**底部scroViewFrame*/
    CGRect _bottomoScroV_F;
    /**记录上次的值*/
    __block NSInteger _lastInt;
    
    /**记录第一次初始化时 setContentOffset*/
    BOOL _isFirstInit;
    /**标题的个数*/
    NSInteger _titleInteger;
    /**类型*/
    SliderMenuViewType _type;
}

@property (nonatomic, strong) SliderMenuTopScrollView *topScroView;
//@property (nonatomic, strong) UIScrollView *bottomScroView;
/**是否要回调 不判断会出现 点顶部按钮会有两个回调的事件*/
@property (nonatomic, assign) __block BOOL isHandle;
/**当前view宽度*/
@property (nonatomic, assign) CGFloat self_W;
//记录滑动之后的 值
@property (nonatomic, assign) __block NSInteger lastSelectIndex;

@end

@implementation SliderMenuView

/**
 *  修改
 *
 *  @param index     索引
 *  @param bgColor   背景颜色
 *  @param textColor 文字颜色
 */
- (void)setIndex:(int)index backgroudColor:(UIColor *)bgColor textColor:(UIColor *)textColor
{
    SliderLabel *slider = [self.topScroView viewWithTag:index];
    if (slider)
    {
        [slider setTextColor:textColor];
        [slider setBackgroundColor:bgColor];
        slider.bTitle = YES;
    }
}

- (void)setIndex:(int)index plant:(BOOL)bTitle
{
    SliderLabel *slider = [self.topScroView viewWithTag:index];
    if(slider)
    {
        slider.bTitle = bTitle;
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withDefaultSelectIndex:(NSInteger)selectIndex withType:(SliderMenuViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.isHandle = YES;
        _self_W = frame.size.width;
        _self_H = frame.size.height;
        
        if (type == SliderMenuViewType_Room) {
            
            _topScroV_F = (CGRect){0,0,_self_W - 50,40};
            
            self.tradingBtn.frame = CGRectMake(CGRectGetMaxX(_topScroV_F), 0, 50, 40);
            [self addSubview:self.tradingBtn];
            
        }else{
            _topScroV_F = (CGRect){0,0,_self_W,40};
        }
        
        _bottomoScroV_F = (CGRect){0,CGRectGetMaxY(_topScroV_F),_self_W,(_self_H-CGRectGetMaxY(_topScroV_F))};
        _lastSelectIndex = selectIndex;
        _titleInteger = titles.count;
        _type = type;
        
        //顶部控制menu
        self.topScroView = [[SliderMenuTopScrollView alloc] initWithFrame:_topScroV_F withTitles:titles withDefaultSelectIndex:(selectIndex-1) withType:_type];
        [self addSubview:self.topScroView];
        @WeakObj(self);
        _topScroView.DidSelectSliderIndex = ^(NSInteger index){
            @StrongObj(self)
            self.isHandle = NO;
            [self.bottomScroView setContentOffset:(CGPoint){(index-1)*self.self_W,0} animated:NO];
            [self hanleBlockWith:index];
            self.lastSelectIndex = index;
            [self.topScroView setTitleIndex:index badgeHide:YES];
            self.isHandle = YES;
        };
        //底部视图
        _isFirstInit = YES;
        [self addSubview:self.bottomScroView];
        [self.bottomScroView setContentOffset:(CGPoint){(selectIndex-1)*_self_W,0} animated:YES];
        _isFirstInit = NO;

    }
    return self;
}

- (void)dealloc {
    DLog(@"dealloc");
    _bottomScroView.delegate = nil;
}

- (void)hanleBlockWith:(NSInteger)index
{
    
    if (_lastSelectIndex!=index)
    {
        if (self.DidSelectSliderIndex)
        {
            self.DidSelectSliderIndex(index);
            _lastSelectIndex = index;
        }
    }
}

- (UIButton *)tradingBtn{
    
    if (!_tradingBtn) {
        
        _tradingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tradingBtn.backgroundColor = color_ffbd5b;
        _tradingBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_tradingBtn setTitle:@"交易" forState:UIControlStateNormal];
        [_tradingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _tradingBtn;
}

- (UIScrollView *)bottomScroView{
    
    if (!_bottomScroView)
    {
        _bottomScroView = [[SliderMenuBottomScroView alloc]initWithFrame:_bottomoScroV_F];
        _bottomScroView.bounces = NO;
        _bottomScroView.pagingEnabled = YES;
        _bottomScroView.showsHorizontalScrollIndicator = NO;
        _bottomScroView.showsVerticalScrollIndicator = NO;
        _bottomScroView.delegate = self;
    }
    return _bottomScroView;
}

- (void)setViewArrays:(NSArray *)viewArrays{
    _viewArrays = viewArrays;
    self.bottomScroView.contentSize = (CGSize){viewArrays.count*_self_W,_bottomoScroV_F.size.height};
    for (int i =0; i!=viewArrays.count; i++) {
        UIView *targetView = (UIView *)viewArrays[i];
        targetView.frame = (CGRect){i*_self_W,0,_self_W,CGRectGetHeight(self.bottomScroView.frame)};
        [self.bottomScroView addSubview:targetView];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (!_isFirstInit) {
        NSString *index = [NSString stringWithFormat:@"%.0f",scrollView.contentOffset.x/_self_W];
        [self.topScroView setLineViewOriginX:scrollView.contentOffset.x withIndex:[index integerValue]];
        weakSelf(self);
        if (self.isHandle) {
            if (_lastInt!=[index intValue]) {
                _lastInt = [index intValue];
                [weakself hanleBlockWith:(_lastInt+1)];
                [weakself.topScroView setTitleIndex:(_lastInt +1) badgeHide:YES];
            }
        }
    }
}

#pragma mark 显示指定标题的红点提示图标
- (void)setShowBadgeIndex:(NSInteger)showBadgeIndex{
    [self.topScroView setTitleIndex:showBadgeIndex badgeHide:NO];
}

- (void)showUnBadgeIndex:(NSInteger)showBadgeIndex
{
    [self.topScroView setTitleIndex:showBadgeIndex badgeHide:YES];
}

- (void)setBadgeColor:(UIColor *)badgeColor{
    [self.topScroView setTitleBadgeColor:badgeColor];
}

- (void)setTitleBagColor:(UIColor *)titleBagColor{
    [self.topScroView setTitleBagColor:titleBagColor];
}

- (void)setTopBagColor:(UIColor *)topBagColor{
    
    self.topScroView.backgroundColor = topBagColor;
}
/**默认选择的是哪一个按钮*/
-(void)setDefaultSelectIndex:(NSInteger)defaultSelectIndex{
    
    _defaultSelectIndex = defaultSelectIndex;
    if (self.DidSelectSliderIndex) {
        self.topScroView.DidSelectSliderIndex(defaultSelectIndex);
    }
}


- (void)setDefaultIndex:(int)nIndex
{
    [self hanleBlockWith:nIndex];
    if (self.topScroView)
    {
        [self.topScroView setTitleIndex:nIndex badgeHide:YES];
    }
}

/**重置会默认选择第一个按钮*/
- (void)resetSelectFirstIndex{
    
    [self.topScroView setAnimationTime:0.f];
    [self.bottomScroView setContentOffset:(CGPoint){(0)*_self_W,0} animated:YES];
    [self.topScroView setAnimationTime:0.25f];

}
/**移除全部的红点提示*/
- (void)resetAllBadgePrompt{
    for (int i=1; i!=_titleInteger; i++) {
        [self hanleBlockWith:i];
        [self.topScroView setTitleIndex:i badgeHide:YES];
    }
}

/**是否显示顶部的分割线*/
- (void)setTopLineViewHide:(BOOL)value{
    
    self.topScroView.topLineView.hidden = value;
}


/**是否显示title下面的横线*/
- (void)setTitleLineViewHide:(BOOL)value{
    
    self.topScroView.lineView.hidden = value;
}


#pragma mark - 切换皮肤
- (void)setThemeSkin{
    
    //重置！为了皮肤切换颜色
    [self hanleBlockWith:1];
    [self hanleBlockWith:0];
    
    
}


@end



