//
//  ViewController.m
//  ZMAlertController
//
//  Created by zm on 2017/2/27.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertController+Custom.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedTwoButton:(id)sender {
    [UIAlertController showAlertWithTitle:@"TwoButton" message:@"cancel and someone" cancelButtonTitle:@"cancel" otherButtonTitle:@"i am someone" handler:^(UIAlertAction * _Nonnull action, NSInteger index) {
        NSLog(@"index:%ld,action:%@",(long)index,action);
    }];
}

- (IBAction)clickedCustomButton:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Custom buttons" message:@"All buttons" preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:@"cancel" otherButtonTitles:@"one",@"two",@"three", nil];
    [alertController showAlertControllerWithAnimated:YES handler:^(UIAlertAction * _Nonnull action, NSInteger index) {
        NSLog(@"index:%ld,action:%@",(long)index,action);
    }];
}




@end
