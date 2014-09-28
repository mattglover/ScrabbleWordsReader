//
//  ScrabbleWordsControllerTestCase.m
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ScrabbleWordsValidator.h"

#import "ScrabbleWordsFactory.h"

#define USE_DEMO_FILE // Uncomment this define for speedier tests

@interface ScrabbleWordsValidatorTestCase : XCTestCase

@property (nonatomic, strong) ScrabbleWordsValidator *validator;

@end

@implementation ScrabbleWordsValidatorTestCase

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
#ifdef USE_DEMO_FILE
    ScrabbleWordsFactory *wordsFactory = [[ScrabbleWordsFactory alloc] initWithConfiguration:ScrabbleWordsFactoryConfigDemoFile];
#else
    ScrabbleWordsFactory *wordsFactory = [[ScrabbleWordsFactory alloc] initWithConfiguration:ScrabbleWordsFactoryConfigDefault];
#endif
    
    self.validator = [[ScrabbleWordsValidator alloc] initWithScrabbleWordsDictionary:wordsFactory.scrabbleWords];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.validator = nil;
    
    [super tearDown];
}

//#pragma mark - Valid Words
- (void)testAAHIsValidWord {
    XCTAssertTrue([self.validator wordIsValid:@"aah"]);
}

#ifndef USE_DEMO_FILE
- (void)testZoophilicIsValidWord {
    XCTAssertTrue([self.validator wordIsValid:@"zoophilic"]);
}
#endif

#pragma mark - Invalid Words
- (void)testTwoCharacterWordIsInvalid {
    XCTAssertFalse([self.validator wordIsValid:@"aa"]);
}

- (void)testAQQIsInvalidWord {
    XCTAssertFalse([self.validator wordIsValid:@"aqq"]);
}

- (void)testAasvogeIsInvalid {
    XCTAssertFalse([self.validator wordIsValid:@"aasvog"]); // mis-spelling
}

#ifndef USE_DEMO_FILE
- (void)testZoophiliciIsInvalidWord {
    XCTAssertFalse([self.validator wordIsValid:@"zoophili"]); // zoophilic with missing last 'c'
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
