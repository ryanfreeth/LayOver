//
//  profileViewController.m
//  LayOverTakeTwo
//
//  Created by Artem Goryaev on 11/16/2013.
//  Copyright (c) 2013 Ashish Agarwal. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end


@implementation ProfileViewController

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
    
    int randomNumber = arc4random() % 8 + 1; //int for random image
    NSString *imageName = [[NSString alloc] initWithFormat:@"profileBG%i.png", randomNumber];
    self.profileBackgroundView.image = [UIImage imageNamed: imageName];
    
    // Add a nice corner radius to the image
    self.profileImageView.layer.cornerRadius = 75.0f;
    self.profileImageView.layer.masksToBounds = YES;
    self.backImageView.layer.cornerRadius = 75.0f;
    self.backImageView.layer.masksToBounds = YES;
    
    self.profileImageView.alpha = 0.0;
    
    // Add logout navigation bar button
    /*UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"MENU" style:UIBarButtonItemStyleBordered target:self action:@selector(menuButtonTouchHandler:)];
    self.navigationItem.rightBarButtonItem = logoutButton;*/
    
    // If the user is already logged in, display any previously cached values before we get the latest from Facebook.
    if ([PFUser currentUser]) {
        [self updateProfile];
    }
    
    //TODO: check if user logged in with facebook first
    // Send request to Facebook
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error) {
            // Parse the data received
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            
            NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
            
            if (facebookID) {
                userProfile[@"facebookId"] = facebookID;
            }
            
            if (userData[@"name"]) {
                userProfile[@"name"] = userData[@"name"];
            }
            
            if (userData[@"location"][@"name"]) {
                userProfile[@"location"] = userData[@"location"][@"name"];
            }
            
            if (userData[@"gender"]) {
                userProfile[@"gender"] = userData[@"gender"];
            }
            
            if (userData[@"birthday"]) {
                userProfile[@"birthday"] = userData[@"birthday"];
            }
            
            if (userData[@"relationship_status"]) {
                userProfile[@"relationship"] = userData[@"relationship_status"];
            }
            
            if ([pictureURL absoluteString]) {
                userProfile[@"pictureURL"] = [pictureURL absoluteString];
            }
            
            [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
            [[PFUser currentUser] saveInBackground];
            
            [self updateProfile];
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
            [self logoutButtonTouchHandler:nil];
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButtonClicked:(UIButton *)sender {
    [self logoutButtonTouchHandler:nil];
}

#pragma mark - NSURLConnectionDataDelegate

/* Callback delegate methods used for downloading the user's profile picture */

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // As chuncks of the image are received, we build our data file
    [self.imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // All data has been downloaded, now we can set the image in the header image view
    UIImage *image = [UIImage imageWithData:self.imageData];
    float minSize;
    if (image.size.height <= image.size.width) minSize = image.size.height; else minSize = image.size.width;
    image = [self imageByCropping: [UIImage imageWithData:self.imageData] toSize: CGSizeMake(minSize, minSize)];

    self.profileImageView.image = image; //[UIImage imageWithData:self.imageData];
    [UIView animateWithDuration:0.5 animations:^{
        self.profileImageView.alpha = 1.0;
    }];
    
}

#pragma mark - Helper methods

// Set received values if they are not nil and reload the table
- (void)updateProfile {
    if ([[PFUser currentUser] objectForKey:@"profile"][@"location"]) {
        self.locationLabel = [[PFUser currentUser] objectForKey:@"profile"][@"location"];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"gender"]) {
        self.genderLabel =  [[PFUser currentUser] objectForKey:@"profile"][@"gender"];
    }
    
    // Set the name in the view label
    if ([[PFUser currentUser] objectForKey:@"profile"][@"name"]) {
        self.userNameLabel.text = [[PFUser currentUser] objectForKey:@"profile"][@"name"];
    }
    
    // Download the user's facebook profile picture
    self.imageData = [[NSMutableData alloc] init]; // the data will be loaded in here
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"pictureURL"]) {
        NSURL *pictureURL = [NSURL URLWithString:[[PFUser currentUser] objectForKey:@"profile"][@"pictureURL"]];
        
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:2.0f];
        // Run network request asynchronously
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        if (!urlConnection) {
            NSLog(@"Failed to download picture");
        }
    }
}

- (UIImage *)imageByCropping:(UIImage *)image toSize:(CGSize)size
{
    double x = (image.size.width - size.width) / 2.0;
    double y = (image.size.height - size.height) / 2.0;
    
    CGRect cropRect = CGRectMake(x, y, size.height, size.width);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

- (void)logoutButtonTouchHandler:(id)sender {
    // Logout user, this automatically clears the cache
    [PFUser logOut];
    
    // Return to login view controller
    
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

@end
