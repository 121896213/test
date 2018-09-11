
/**弹出框的View*/

#import <UIKit/UIKit.h>

@interface PopupViewHUD : UIView

+ (PopupViewHUD *)shared;


/**错误提示*/
+ (void)showErrorPopup:(NSString *)error;
/**成功提示*/
+ (void)showSuccessPopup:(NSString *)success;
/**注意提示*/
+ (void)showPromptPopup:(NSString *)prompt;

@end
