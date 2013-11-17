//
//  MeetupViewController.m
//  LayOverTakeTwo
//
//  Created by Ashish Agarwal on 2013-11-17.
//  Copyright (c) 2013 Ashish Agarwal. All rights reserved.
//

#import "MeetupViewController.h"
#import "MeetupDetailViewController.h"
#import "Parse/Parse.h"

@interface MeetupViewController ()
@property (strong, nonatomic) IBOutlet UITableView *vendorLocations;
@property (strong, nonatomic) NSArray *vendorList;
@property (nonatomic) NSInteger selectedRow;


@end

@implementation MeetupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    PFQuery *query = [PFQuery queryWithClassName:@"vendors"];
    self.vendorList = [query findObjects];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Vendors Nearby";
	
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.vendorList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    PFObject *vendor = [self.vendorList objectAtIndex:indexPath.row];
    NSLog(@"vendor name is - %@", [NSString stringWithFormat:@"%@",[vendor objectForKey:@"name"]]);
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[vendor objectForKey:@"name"]] ;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //PFObject *vendorObject = [self.vendorList objectAtIndex:indexPath.row];
    self.selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"detailMeetupSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"detailMeetupSegue"]) {
        MeetupDetailViewController *vc = [segue destinationViewController];
        [vc setVendorObj:[self.vendorList objectAtIndex:self.selectedRow]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
