//
//  parseLoginViewController.m
//  LayOverTakeTwo
//
//  Created by Artem Goryaev on 11/17/2013.
//  Copyright (c) 2013 Ashish Agarwal. All rights reserved.
//

#import "ParseLoginViewController.h"

@interface ParseLoginViewController ()

@end

@implementation ParseLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Start-up.png"]];
    imageView.frame = self.logInView.frame;
    [self.logInView addSubview:imageView];
    [self.logInView sendSubviewToBack: imageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
