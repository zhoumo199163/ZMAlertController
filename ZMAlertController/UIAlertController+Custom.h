//
//  UIAlertController+ZM_ShowAlertController.h
//  ZMAlertController
//
//  Created by zm on 2017/2/27.
//  Copyright © 2017年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^Alert_HandlerBlock)(UIAlertAction *alertAction,NSInteger alertIndex);

@class UIAlertAction;
@interface UIAlertController (Custom)


+ (_Nonnull instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;


/**
 show a cancel button and a other button with alert style
 @param title alertTitle
 @param message alertMessage
 @param cancelButtonTitle title of cancel button
 @param otherButtonTitle title of other button
 @param handler call back after click  button ,click cancel button index == 0
 */
+ (void)showAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle handler:(Alert_HandlerBlock)handler;


- (void)showAlertControllerWithAnimated:(BOOL)flag handler:(Alert_HandlerBlock)handler;

@end
NS_ASSUME_NONNULL_END
