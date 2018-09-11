//
//  SZEditPhotoCell.h
//  BTCoin
//
//  Created by sumrain on 2018/8/31.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SZEditPhotoCelllHeight FIT(60)
#define SZEditPhotoCellReuseIdentifier  @"SZEditPhotoCellReuseIdentifier"

typedef void(^SelectPhotos)(void);
typedef void(^EditPhotos)(void);

@interface SZEditPhotoCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView* photoView;
@property (nonatomic,copy) SelectPhotos selectPhotos;
@property (nonatomic,copy) EditPhotos   editPhotos;
-(void)setStyleIsShowDelete:(BOOL)isShowDelete indexPath:(NSIndexPath*)indexPath;
@end
