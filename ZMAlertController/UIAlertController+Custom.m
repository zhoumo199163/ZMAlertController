//
//  UIAlertController+ZM_ShowAlertController.m
//  ZMAlertController
//
//  Created by zm on 2017/2/27.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "UIAlertController+Custom.h"
#import <objc/runtime.h>

static char alertHandlerKey;

@implementation UIAlertController (Custom)

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)setHandler:(Alert_HandlerBlock)handler{
    objc_setAssociatedObject(self, &alertHandlerKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (Alert_HandlerBlock)handler{
    return objc_getAssociatedObject(self, &alertHandlerKey);
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
   __block UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    if(cancelButtonTitle){
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           Alert_HandlerBlock handlerBlock = [alertController handler];
            if(handlerBlock){
                handlerBlock(action,0);
                alertController = nil;
            }
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
                Alert_HandlerBlock handlerBlock = [alertController handler];
                if(handlerBlock){
                    handlerBlock(action,buttonIndex);
                    alertController = nil;
                }
            }];
            [alertController addAction:alertAction];
            buttonIndex ++;
        }
       
        va_end(buttonTitles);
    }
    return alertController;
}


+ (void)showAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle handler:(Alert_HandlerBlock)handler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
    [alert showAlertControllerWithAnimated:YES handler:handler];
}

- (void)showAlertControllerWithAnimated:(BOOL)flag handler:(Alert_HandlerBlock)handler{
     [self setHandler:handler];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSAssert(keyWindow, @"there is no keyWindow,maybe you can set makeKeyAndVisible");
    [keyWindow.rootViewController presentViewController:self animated:flag completion:^{
        
    }];
}


@end
