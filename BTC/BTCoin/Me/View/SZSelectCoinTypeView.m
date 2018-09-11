//
//  SZSelectCoinTypeView.m
//  BTCoin
//
//  Created by sumrain on 2018/7/3.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZSelectCoinTypeView.h"
#import "SZPromotionCoinTypeCell.h"
@interface SZSelectCoinTypeView ()<CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView* _collectionView;
    CHTCollectionViewWaterfallLayout *_collectionViewLayout;
    
}
@end

@implementation SZSelectCoinTypeView

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self setSubView:frame];
    }
    
    return self;
}

-(void)setSubView:(CGRect)frame{
    
    _collectionViewLayout= [[CHTCollectionViewWaterfallLayout alloc]init];
//    _collectionViewLayout.sectionInset = UIEdgeInsetsMake(FIT(1), FIT(1), FIT(1), FIT(1));
    _collectionViewLayout.columnCount = 4;
//    _collectionViewLayout.headerHeight = FIT(5);
    _collectionViewLayout.minimumColumnSpacing = FIT(1);
    _collectionViewLayout.minimumInteritemSpacing = FIT(1);
    
    if(!_collectionView){
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,frame.size.width, frame.size.height) collectionViewLayout:_collectionViewLayout];
        _collectionView.pagingEnabled = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[SZPromotionCoinTypeCell class] forCellWithReuseIdentifier:SZPromotionCoinTypeCellReuseIdentifier];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.backgroundColor=[UIColor blueColor];
        [_collectionView.mj_header setHidden:YES];
        [_collectionView.mj_footer setHidden:YES];
    }
    [self.contentView addSubview:_collectionView];
    self.contentView.backgroundColor=[UIColor whiteColor];
    [self setDirectionType:SZPopViewFromDirectionTypeCenter];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SZPromotionCoinTypeCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SZPromotionCoinTypeCellReuseIdentifier forIndexPath:indexPath];
    cell.coinTypeLab.text=self.dataList[indexPath.row];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self disMissView];
    [self.delegate selectCoinType:self coinType:self.dataList[indexPath.row]];

}

#pragma mark -CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(FIT(93), FIT(65));
}


-(void)setDataList:(NSMutableArray *)dataList{
    _dataList=[[NSMutableArray alloc]initWithArray:dataList];
  

    [_collectionView reloadData];
    
}

@end
