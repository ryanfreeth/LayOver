//
//  CheckInViewController.m
//  LayOverTakeTwo
//
//  Created by Ashish Agarwal on 2013-11-16.
//  Copyright (c) 2013 Ashish Agarwal. All rights reserved.
//

#import "CheckInViewController.h"
#import "ViewProfilesViewController.h"
#import "Parse/Parse.h"

@interface CheckInViewController ()
@property (nonatomic, strong)NSArray *airports;
@property (strong, nonatomic) IBOutlet UITableView *airportsTable;
//@property (strong, nonatomic) IBOutlet UIButton *checkinButton;
@property (nonatomic) NSInteger selectedRow;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *checkinButton;

@end

@implementation CheckInViewController

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

    // get from parse
    PFQuery *query = [PFQuery queryWithClassName:@"airports"];
    self.airports = [query findObjects];
    
    //self.airports = [[NSMutableArray alloc] initWithObjects: @"BLI - Bellingham Intl.", @"SEA - Seattle-Tacoma Intl.", @" YVR - Vancouver Intl.", @"YXX - Abbottsford Intl.", nil];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 49.276667;
    zoomLocation.longitude= -123.119295;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 100, 194);
    // 3
    [self.mapView setRegion:viewRegion animated:YES];
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    NSLog(@"%@", username);

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.airportsTable.frame.size.width, 25)];
    return header;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.airports count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row == self.selectedRow)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    PFObject *airport = [self.airports objectAtIndex:indexPath.row];
    //airport.name;
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%@", [airport objectForKey:@"code"], [airport objectForKey:@"name"] ] ;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedRow = indexPath.row;
    [tableView reloadData];
}

-(IBAction)checkInPressed:(id)sender{
    
    PFObject *testObject = [PFObject objectWithClassName:@"checkins"];
    [testObject setObject:[PFUser currentUser] forKey:@"User"];
    [testObject setObject: [self.airports objectAtIndex:self.selectedRow] forKey:@"airport"];
    //[testObject setObject:[self.airports objectAtIndex:self.selectedRow] forKey:@"airport"];
    [testObject save];

    NSLog(@"checkin pressed");
    [self performSegueWithIdentifier:@"pushToProfile" sender:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
