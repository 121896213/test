//
//  ApplyNoticeView.h
//  BTCoin
//
//  Created by 狮子软件 on 2018/6/13.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
/**申购时提示View*/
@interface ApplyNoticeView : UIView

@property (nonatomic,copy)void (^goNextBlock)(void);
-(void)setText:(NSString *)text;
@end
