//
//  AdminViewController.m
//  release 2
//
//  Created by alumno on 4/20/15.
//  Copyright (c) 2015 JuanPauloLara. All rights reserved.
//

#import "AdminViewController.h"

@interface AdminViewController ()

@end

@implementation AdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_vista setProcess:[[Process alloc] initDemo]];
    [_vista setNeedsDisplay];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
