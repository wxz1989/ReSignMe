//
//  ReSignMeTests.m
//  ReSignMeTests
//
//  Created by Carpe Lucem Media Group on 2/9/13.
//  Copyright (c) 2013 Carpe Lucem Media Group. All rights reserved.
//
//  This file is part of ReSignMe.
//
//  ReSignMe is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  ReSignMe is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with ReSignMe.  If not, see <http://www.gnu.org/licenses/>.

#import "AppDelegate.h"
#import "SecurityManager.h"
#import "CertificateModel.h"
#import <OCMock/OCMock.h>

#import <XCTest/XCTest.h>

@interface AppResignerTests : XCTestCase

@end

@interface AppDelegate(UnitTests)
@property (nonatomic, strong) SecurityManager *sm;
@end

@implementation AppResignerTests
AppDelegate *appDelegate;

- (void)setUp
{
    [super setUp];
    
    appDelegate = (AppDelegate *)[NSApp delegate];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testApplicationDidFinishLaunching {
    [appDelegate applicationDidFinishLaunching:nil];
    XCTAssertNotNil(appDelegate.sm, @"Security manager was not initialized");
    XCTAssertNotNil(appDelegate.outputPathURL, @"The output path should be populated on initialization");
    XCTAssertEqualObjects(appDelegate.dropView.delegate, appDelegate, @"The AppDropView has not beeen set!");
}

- (void)testPopulateCertIsCalledAtInit {
    id appDelegateMock = [OCMockObject mockForClass:[AppDelegate class]];
    [[appDelegateMock expect] populateCertPopDown:[OCMArg any]];
    [appDelegateMock verify];
}

- (void)testAppShouldTerminate {
    XCTAssertTrue([appDelegate applicationShouldTerminateAfterLastWindowClosed:nil], @"App should be set to terminate on last window close");
}

- (void)testLoadUserDefaults {
    //confirm fields are set
    XCTAssertNotNil(appDelegate.outputPathURL, @"The output path was not set in user defaults.");
}

//- (void)testPopulateCertPopDown {
//    id mockCertModel = [OCMockObject mockForClass:[CertificateModel class]];
//    [[[mockCertModel stub] andReturn:@"My Label"] label];
//    
//    id mockCertPopDownBtn = [OCMockObject mockForClass:[NSPopUpButton class]];
//    [[mockCertPopDownBtn expect] removeAllItems];
//    [[mockCertPopDownBtn expect] addItemWithTitle:[OCMArg any]];
//    appDelegate.certPopDownBtn = mockCertModel;
//    
//    //NSArray *models = @[mockCertModel];
//    
//    [appDelegate populateCertPopDown:[NSArray arrayWithObject:mockCertModel]];
////    
////    [mockCertPopDownBtn verify];
//}

- (void)testOutputPathURL
{
    NSURL *myPathURL = [NSURL URLWithString:@"/usr/bin"];
    [appDelegate setOutputPathURL:myPathURL];
    
    NSString *myPath = [myPathURL path];
    NSString *returnedPath = appDelegate.pathTextField.stringValue;
    XCTAssertEqualObjects(myPath, returnedPath, @"The path set with NSURL should equal the path in the text field!");
}

@end
