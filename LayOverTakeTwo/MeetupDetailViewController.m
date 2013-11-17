//
//  MeetupDetailViewController.m
//  LayOverTakeTwo
//
//  Created by Ashish Agarwal on 2013-11-17.
//  Copyright (c) 2013 Ashish Agarwal. All rights reserved.
//

#import "MeetupDetailViewController.h"
#import "Parse/Parse.h"

@interface MeetupDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *vendorNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *vendorLocationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

@end

@implementation MeetupDetailViewController

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
    self.title = [NSString stringWithFormat:@"%@", [self.vendorObj objectForKey:@"name"]];
    //[self.view setBackgroundColor:[UIColor blueColor]];
    
	[self.backgroundImageView setImage:[UIImage imageNamed:[self.vendorObj objectForKey:@"background"]]];
    
    //NSString *location = [NSString stringWithFormat:@"%@", [self.vendorObj objectForKey:@"location"]];
    self.vendorNameLabel.text = [NSString stringWithFormat:@"%@", [self.vendorObj objectForKey:@"name"]];
    self.vendorLocationLabel.text = [NSString stringWithFormat:@"%@", [self.vendorObj objectForKey:@"location"]];
    
    
    // Add a nice corner radius to the image
    self.profileImageView.layer.cornerRadius = 75.0f;
    self.profileImageView.layer.masksToBounds = YES;
    //self.backgroundImageView.layer.cornerRadius = 75.0f;
    //self.backgroundImageView.layer.masksToBounds = YES;
    
    [self.profileImageView setImage:[UIImage imageNamed:[self.vendorObj objectForKey:@"icon"]]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
