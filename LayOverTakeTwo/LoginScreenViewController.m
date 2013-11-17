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
#import "CheckInViewController.h"
#import "ParseLoginViewController.h"
#import "ParseSignupViewController.h"


@interface LoginScreenViewController ()
@property (strong, nonatomic) IBOutlet UIButton *loginWithFacebook;
@property (strong, nonatomic) IBOutlet UIButton *registerEmailButton;

-(IBAction)loginWithFacebookPressed : (id)sender;
-(IBAction)registerEmailButton:(id)sender;
//- (IBAction)logoutClicked:(id)sender;
- (IBAction)singinButtonClicked:(UIButton *)sender;

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"username"];
    [testObject save];
    
    if ([PFUser currentUser]) [self performSegueWithIdentifier:@"pushToCheckIn" sender:self];
}

-(IBAction)loginWithFacebookPressed:(id)sender{
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    

    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        //[_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [[NSUserDefaults standardUserDefaults] setObject:user.username forKey:@"userID"];
            NSLog(@"%@", user.username);
            
            
            //[self.navigationController pushViewController:[[CheckInViewController alloc] init] animated:YES];
            [self performSegueWithIdentifier:@"pushToCheckIn" sender:self];
           // [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        } else {
            NSLog(@"User with facebook logged in!");
            NSLog(@"%@", user.username);
            [[NSUserDefaults standardUserDefaults] setObject:user.username forKey:@"userID"];
            
           //[self.navigationController pushViewController:[[CheckInViewController alloc] init] animated:YES];
           [self performSegueWithIdentifier:@"pushToCheckIn" sender:self];
          //  [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        }
    }];
    
    //[_activityIndicator startAnimating]; // Show loading indicator until login is finished
}

- (IBAction)logoutClicked:(id)sender {
    [PFUser logOut];
}

- (IBAction)singinButtonClicked:(UIButton *)sender {
    
    if (![PFUser currentUser]) {
        // Customize the Log In View Controller
        ParseLoginViewController *logInViewController = [[ParseLoginViewController alloc] init];
        logInViewController.delegate = self;
        logInViewController.facebookPermissions = @[@"friends_about_me"];
        logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsSignUpButton | PFLogInFieldsDismissButton;
        
        // Customize the Sign Up View Controller
        ParseSignupViewController *signUpViewController = [[ParseSignupViewController alloc] init];
        signUpViewController.delegate = self;
        signUpViewController.fields = PFSignUpFieldsDefault;
        logInViewController.signUpController = signUpViewController;
        
        // Present Log In View Controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    else {
        // user is already checked in at this point
        [self performSegueWithIdentifier:@"pushToCheckIn" sender:self];
        //[self.navigationController pushViewController:[[CheckInViewController alloc] init] animated:YES];
    }
}

#pragma mark - PFLogInViewControllerDelegate

-(BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password{
    
    if (username && password && username.length!=0 && password.length!=0) {
        
        NSLog(@"signed in ");
        //save the username in the NSUserdefaults
        
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"userID"];
   
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //[self dismissViewControllerAnimated:NO completion:NULL];
        
        //[self performSegueWithIdentifier:@"pushToCheckIn" sender:self];
        //[self.navigationController pushViewController:[[CheckInViewController alloc] init] animated:YES];
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Please enter all fields and continue" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil]show];
    
    return NO;
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:NO completion:NULL];
    [self performSegueWithIdentifier:@"pushToCheckIn" sender:self];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}

#pragma mark - PFSignUpViewControllerDelegate

-(BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info{
    BOOL informationComplete = YES;
    
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) {
            informationComplete = NO;
            break;
        }
    }
    
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    // if yes, store the information in the defaults
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [[NSUserDefaults standardUserDefaults] setObject:user.username forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:NO completion:NULL];; // Dismiss the PFSignUpViewController
    
    //push to the next screen
    [self performSegueWithIdentifier:@"pushToCheckIn" sender:self];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
