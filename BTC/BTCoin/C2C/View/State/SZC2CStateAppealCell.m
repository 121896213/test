//
//  SZC2CStateAppealCell.m
//  BTCoin
//
//  Created by sumrain on 2018/7/17.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZC2CStateAppealCell.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>
#import "SZEditPhotoCell.h"
@interface SZC2CStateAppealCell()<CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray* datasArr;
@property (nonatomic,strong)UICollectionView* collectionView;
@property (nonatomic,strong)CHTCollectionViewWaterfallLayout *collectionViewLayout;
@end

@implementation SZC2CStateAppealCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubView];
        self.contentView.backgroundColor=MainC2CBackgroundColor;

    }
    return self;
}

-(void)setSubView{
    
  
    _collectionViewLayout= [[CHTCollectionViewWaterfallLayout alloc]init];
    //    _collectionViewLayout.sectionInset = UIEdgeInsetsMake(FIT(1), FIT(1), FIT(1), FIT(1));
    _collectionViewLayout.columnCount = 4;
    //    _collectionViewLayout.headerHeight = FIT(5);
    _collectionViewLayout.minimumColumnSpacing = FIT(10);
    _collectionViewLayout.minimumInteritemSpacing = FIT(10);
    self.datasArr=[NSMutableArray new];
    if(!_collectionView){
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,ScreenWidth-FIT(32), SZC2CStateAppealCellHeight) collectionViewLayout:_collectionViewLayout];
        _collectionView.pagingEnabled = NO;
        _collectionView.backgroundColor = MainC2CBackgroundColor;
//      _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[SZEditPhotoCell class] forCellWithReuseIdentifier:SZEditPhotoCellReuseIdentifier];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView.mj_header setHidden:YES];
        [_collectionView.mj_footer setHidden:YES];
    }
    [self addSubview:_collectionView];
  
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.datasArr.count < 6) {
        return self.datasArr.count+1;
    }else{
        return 6;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SZEditPhotoCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SZEditPhotoCellReuseIdentifier forIndexPath:indexPath];
    if (self.datasArr.count < 6 && self.datasArr.count == indexPath.row+1) {
        cell.editPhotos = ^{
        };
        [cell setStyleIsShowDelete:YES indexPath:indexPath];

    }else{
        cell.selectPhotos = ^{
            NSLog(@"选择照骗");
        };
        [cell setStyleIsShowDelete:NO indexPath:indexPath];

    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
  
}
#pragma mark -CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SZEditPhotoCelllHeight, SZEditPhotoCelllHeight);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
