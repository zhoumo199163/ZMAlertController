//
//  UIAlertController+ZM_ShowAlertController.m
//  ZMAlertController
//
//  Created by zm on 2017/2/27.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "UIAlertController+ZM_ShowAlertController.h"
#import <objc/runtime.h>

static char alertHandlerKey;

@implementation UIAlertController (ZM_ShowAlertController)

- (void)setHandler:(handlerBlock)handler{
    objc_setAssociatedObject(self, &alertHandlerKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (handlerBlock)handler{
    return objc_getAssociatedObject(self, &alertHandlerKey);
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    if(cancelButtonTitle){
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
             [alertController handler](action,0);
        }];
        [alertController addAction:cancelAction];
    }
    
    if(otherButtonTitles){
        va_list buttonTitles;
        va_start(buttonTitles, otherButtonTitles);
        NSString *buttonTitle ;
        NSInteger buttonIndex = 1;
        for(buttonTitle = otherButtonTitles;buttonTitle != nil;buttonTitle = va_arg(buttonTitles, NSString *)){
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alertController handler](action,buttonIndex);
            }];
            [alertController addAction:alertAction];
            buttonIndex ++;
        }
       
        va_end(buttonTitles);
    }
    return alertController;
}


+ (void)showAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle handler:(void (^__nullable)(UIAlertAction *action, NSInteger index))handler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
    [alertController showAlertControllerWithAnimated:YES handler:handler];
}

- (void)showAlertControllerWithAnimated:(BOOL)flag handler:(void (^ __nullable)(UIAlertAction *action, NSInteger index))handler{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self setHandler:handler];
    NSAssert(keyWindow, @"there is no keyWindow,maybe you can set makeKeyAndVisible");
    [keyWindow.rootViewController presentViewController:self animated:flag completion:^{
        
    }];
}


@end
