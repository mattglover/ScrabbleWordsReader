//
//  ScrabbleWordsControllerTestCase.m
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ScrabbleWordsController.h"

#define USE_DEMO_FILE // Uncomment this define for speedier tests

#ifdef USE_DEMO_FILE
  static NSString * const kJSONFilename = @"demo";
#else
  static NSString * const kJSONFilename = @"scrabble-words";
#endif
static NSString * const kJSONFileExt  = @"json";


@interface ScrabbleWordsController (XCTest)
@property (nonatomic, strong, readonly) NSDictionary *scrabbleWords;
@end

@interface ScrabbleWordsControllerTestCase : XCTestCase

@property (nonatomic, strong) ScrabbleWordsController *controller;

@end

@implementation ScrabbleWordsControllerTestCase

- (void)setUp {
    [super setUp];

    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.controller = [[ScrabbleWordsController alloc] init];
    
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:kJSONFilename ofType:kJSONFileExt];
    [self.controller loadScrabbleWordsFromFilePath:jsonFilePath];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.controller = nil;
    
    [super tearDown];
}

- (void)testCanLoadScrabbleWordsLoadJSON {
    XCTAssertNotNil(self.controller.scrabbleWords, @"Scrabble words dictionary should not be nil");
}

//#pragma mark - Valid Words
- (void)testAAHIsValidWord {
    XCTAssertTrue([self.controller wordIsValid:@"aah"]);
}

#ifndef USE_DEMO_FILE
- (void)testZoophilicIsValidWord {
    XCTAssertTrue([self.controller wordIsValid:@"zoophilic"]);
}
#endif

#pragma mark - Invalid Words
- (void)testTwoCharacterWordIsInvalid {
    XCTAssertFalse([self.controller wordIsValid:@"aa"]);
}

- (void)testAQQIsInvalidWord {
    XCTAssertFalse([self.controller wordIsValid:@"aqq"]);
}

- (void)testAasvogeIsInvalid {
    XCTAssertFalse([self.controller wordIsValid:@"aasvog"]); // mis-spelling
}

#ifndef USE_DEMO_FILE
- (void)testZoophiliciIsInvalidWord {
    XCTAssertFalse([self.controller wordIsValid:@"zoophili"]); // zoophilic with missing last 'c'
}
#endif

#pragma mark - Performance Test
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
