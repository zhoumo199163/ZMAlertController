//
//  ViewController.m
//  ZMAlertController
//
//  Created by zm on 2017/2/27.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertController+ZM_ShowAlertController.h"

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
    [UIAlertController showAlertWithTitle:@"twoButton" message:@"cancel and someone" cancelButtonTitle:@"cancel" otherButtonTitle:@"i am someone" handler:^(UIAlertAction * _Nonnull action, NSInteger index) {
        if(index == 0) NSLog(@"this is cancelAlert");
        else NSLog(@"this is someone");
            
    }];
}

- (IBAction)clickedFreeButton:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"free buttons" message:@"all buttons" preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:@"cancel" otherButtonTitles:@"one",@"two",@"three", nil];
    [alertController showAlertControllerWithAnimated:YES handler:^(UIAlertAction * _Nonnull action, NSInteger index) {
        NSLog(@"%@",action.title);
    }];
}



@end
