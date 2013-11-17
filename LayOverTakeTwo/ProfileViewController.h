//
//  profileViewController.h
//  LayOverTakeTwo
//
//  Created by Artem Goryaev on 11/16/2013.
//  Copyright (c) 2013 Ashish Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

@property (nonatomic, strong) NSMutableData *imageData;

- (IBAction)logoutButtonClicked:(UIButton *)sender;
@end
