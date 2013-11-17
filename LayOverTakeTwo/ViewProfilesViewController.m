//
//  ViewProfilesViewController.m
//  LayOverTakeTwo
//
//  Created by Ashish Agarwal on 2013-11-17.
//  Copyright (c) 2013 Ashish Agarwal. All rights reserved.
//

#import "ViewProfilesViewController.h"
#import "Parse/Parse.h"
#import "ProfileViewController.h"

@interface ViewProfilesViewController ()
@property(nonatomic, strong) NSArray *userList;
@property (strong, nonatomic) IBOutlet UITableView *usersTable;

@end

@implementation ViewProfilesViewController

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
	
    //PFQuery *query = [PFUser query];
    //self.userList = [query findObjects];
    
    self.userList = [PFCloud callFunction:@"matches" withParameters:@{}];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.userList) return [self.userList count];
        else return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.userList) return nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10 , 75, 75)];
    [imageView setImage:[UIImage imageNamed:@"UnknownProfile.png"]];
    [cell.contentView addSubview:imageView];
    
    PFUser *userObject = [self.userList objectAtIndex:indexPath.row];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 220, 20)];
    
    label.text = [NSString stringWithFormat:@"%@", [userObject objectForKey:@"username"]];
    label.numberOfLines = 1;
    [cell.contentView addSubview:label];
    
    UILabel *comingFromLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, 220, 20)];
    comingFromLabel.text = @"Coming From: ";
    [comingFromLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    
    UILabel *goingToLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 220, 20)];
    goingToLabel.text = @"Going To: ";
    [goingToLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    
    [cell.contentView addSubview:comingFromLabel];
    [cell.contentView addSubview:goingToLabel];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //ProfileViewController *profileViewController = [[ProfileViewController alloc] init];
    //self.navigationController
    [self performSegueWithIdentifier:@"pushProfile" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
