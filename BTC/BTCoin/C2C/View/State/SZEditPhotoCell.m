//
//  SZEditPhotoCell.m
//  BTCoin
//
//  Created by sumrain on 2018/8/31.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZEditPhotoCell.h"
@interface SZEditPhotoCell()
@property (nonatomic,strong)UIButton* deleteBtn;
@end

@implementation SZEditPhotoCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews
{
    
    UIImageView* photoView=[UIImageView new];
    [photoView setUserInteractionEnabled:YES];
    [photoView setImage:[UIImage imageNamed:@"c2c_upload_photo"]];
    [self addSubview:photoView];
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(FIT(0));
    }];
    
    UIButton* deleteBtn=[UIButton new];
    [deleteBtn setImage:[UIImage imageNamed:@"c2c_delete_photo"] forState:UIControlStateNormal];
    [photoView addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(FIT(0));
        make.width.height.mas_equalTo(FIT(19));
    }];
    
    UITapGestureRecognizer* touchTapGest=[UITapGestureRecognizer new];
    [photoView addGestureRecognizer:touchTapGest];
    [[touchTapGest rac_gestureSignal] subscribeNext:^(id x) {
        if (self.selectPhotos) {
            self.selectPhotos();
        }
    }];
    
    UILongPressGestureRecognizer* longGest=[UILongPressGestureRecognizer new];
    [photoView addGestureRecognizer:longGest];
    [[longGest rac_gestureSignal] subscribeNext:^(id x) {
        if (self.editPhotos) {
            self.editPhotos();
        }
    }];
    self.photoView=photoView;
    self.deleteBtn=deleteBtn;
}


-(void)setStyleIsShowDelete:(BOOL)isShowDelete indexPath:(NSIndexPath*)indexPath{
    
    [self.deleteBtn setHidden:!isShowDelete];
}
@end
