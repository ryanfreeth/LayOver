//
//  ChatRoomViewController.h
//  LayOverTakeTwo
//
//  Created by Ashish Agarwal on 2013-11-17.
//  Copyright (c) 2013 Ashish Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatRoomViewController : UIViewController <UITextFieldDelegate>{
    UITextField *tfEntry;
}

@property(nonatomic, strong) IBOutlet UITextField *tfEntry;

-(void) registerForKeyboardNotifications;
-(void) freeKeyboardNotifications;
-(void) keyboardWasShown:(NSNotification*)aNotification;
-(void) keyboardWillHide:(NSNotification*)aNotification;

@end
