//
//  LayOverTakeTwoTests.m
//  LayOverTakeTwoTests
//
//  Created by Ashish Agarwal on 2013-11-16.
//  Copyright (c) 2013 Ashish Agarwal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Parse/Parse.h>

@interface LayOverTakeTwoTests : XCTestCase

@end

@implementation LayOverTakeTwoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [Parse setApplicationId:@"1KJpfgJ67iKJDVktLPk4cFvwN1njyk0PVuLhAd5e"
                  clientKey:@"oFnYB7UItPQSN6dhGPhT1Voe2HykFMaLRs0v35IH"];
    
    }

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTAssert(1==1, @"One equals one");
}

- (void)testLogin
{
    [PFUser logInWithUsernameInBackground:@"ryan" password:@"layover"
                                    block:^(PFUser *user, NSError *error) {
                                        XCTAssertNotNil(user, @"User is null");
                                        XCTAssertEqual("ryan", user.username, @"User is ryan!");
                                    }];

    PFUser *currentUser = [PFUser currentUser];
    NSString *name = currentUser.username;
    NSLog(name);
    XCTAssertEqual(currentUser.username, name, @"User is actually ryan");
}

- (void)testCheckin
{
    PFQuery *query = [PFQuery queryWithClassName:@"airports"];
    XCTAssertNotNil(query, @"null");
}

@end
