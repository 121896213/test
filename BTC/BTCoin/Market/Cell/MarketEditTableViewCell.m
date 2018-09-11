//
//  MarketEditTableViewCell.m
//  BTCoin
//
//  Created by 狮子软件 on 2018/7/12.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "MarketEditTableViewCell.h"

@interface MarketEditTableViewCell()
@property (nonatomic,strong)UIButton * selectButton;
@property (nonatomic,strong)UILabel * titleLab;
@property (nonatomic,strong)UIButton * toTopButton;

@end

@implementation MarketEditTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _selectButton = [[UIButton alloc]initWithFrame:CGRectMake(13, 14, 17, 17)];
        [_selectButton setImage:kIMAGE_NAMED(@"editMarketUnSel") forState:UIControlStateNormal];
        [_selectButton setImage:kIMAGE_NAMED(@"editMarketSel") forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectButton];
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 14, 60, 17)];
        _titleLab.textColor = UIColorFromRGB(0x333333);
        _titleLab.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:_titleLab];
        
        _toTopButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 12, 17)];
        [_toTopButton setImage:kIMAGE_NAMED(@"marketMoveTop") forState:UIControlStateNormal];
        [_toTopButton addTarget:self action:@selector(toTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_toTopButton];
        CGPoint center = self.contentView.center;
        center.x = kScreenWidth /2 + 40;
        _toTopButton.center = center;
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 47.5, kScreenWidth +100, 0.5)];
        line.backgroundColor = LineColor;
        [self.contentView addSubview:line];
    }
    return self;
}

-(void)selectButtonClick:(UIButton *)button{
    button.selected = !button.selected;
    if (self.setSelBlock) {
        self.setSelBlock(button.isSelected);
    }
}

-(void)toTopButtonClick:(UIButton *)button{
    if (self.goTopBlock) {
        self.goTopBlock();
    }
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    self.shouldIndentWhileEditing = NO;
    for (UIView * view in self.subviews) {
        if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewCellReorderControl"]) {
            for (UIView * subView in view.subviews) {
                if ([subView isKindOfClass:[UIImageView class]]) {
                    ((UIImageView *)subView).image = kIMAGE_NAMED(@"cellMove");
                    [subView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(view.mas_centerY);
                        make.leading.mas_equalTo(0);
                        make.width.height.mas_equalTo(20);
                    }];
                }
            }
        }
        NSLog(@"%@",NSStringFromClass([view class]));
    }
}

-(void)setCellWithTitle:(NSString *)title isSel:(BOOL)isSel{
    _titleLab.text = title;
    _selectButton.selected = isSel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
