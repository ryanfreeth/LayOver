//
//  ChatRoomViewController.h
//  LayOverTakeTwo
//
//  Created by Ashish Agarwal on 2013-11-17.
//  Copyright (c) 2013 Ashish Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Reachability.h"

@interface ChatRoomViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, PF_EGORefreshTableHeaderDelegate>{
    UITextField *tfEntry;
    
    IBOutlet UITableView *chatTable;
    NSMutableArray *chatData;
    PF_EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;
    
    NSString *className;
    NSString *userName;
}

@property(nonatomic, strong) IBOutlet UITextField *tfEntry;
@property (nonatomic, strong) IBOutlet UITableView *chatTable;
@property (nonatomic, strong) NSMutableArray *chatData;

-(void) registerForKeyboardNotifications;
-(void) freeKeyboardNotifications;
-(void) keyboardWasShown:(NSNotification*)aNotification;
-(void) keyboardWillHide:(NSNotification*)aNotification;
-(void) loadLocalChat;

@end
