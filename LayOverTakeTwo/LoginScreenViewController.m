//
//  LoginScreenViewController.m
//  LayOverTakeTwo
//
//  Created by Ashish Agarwal on 2013-11-16.
//  Copyright (c) 2013 Ashish Agarwal. All rights reserved.
//

#import "LoginScreenViewController.h"
#import <Parse/Parse.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CFNetwork/CFNetwork.h>
#import <CoreLocation/CoreLocation.h>


@interface LoginScreenViewController ()
@property (strong, nonatomic) IBOutlet UIButton *loginWithFacebook;
@property (strong, nonatomic) IBOutlet UIButton *loginEmailButton;
@property (strong, nonatomic) IBOutlet UIButton *registerEmailButton;

-(IBAction)loginWithFacebookPressed : (id)sender;
-(IBAction)loginEmailButton:(id)sender;
-(IBAction)registerEmailButton:(id)sender;

@end

@implementation LoginScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"username"];
    [testObject save];
    
    
}

-(IBAction)loginEmailButton:(id)sender{
    
}

-(IBAction)loginWithFacebookPressed:(id)sender{
    
}

-(IBAction)registerEmailButton:(id)sender{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
