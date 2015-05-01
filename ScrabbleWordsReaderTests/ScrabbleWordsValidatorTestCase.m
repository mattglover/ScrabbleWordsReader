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

//#define USE_DEMO_FILE // Uncomment this define for speedier tests
//#define EXTENDED_RANDOM_WORD_GENERATE_TEST // Comment this define for speedier tests

@interface ScrabbleWordsValidatorTestCase : XCTestCase

@property (nonatomic, strong) ScrabbleWordsValidator *validator;

@end

@implementation ScrabbleWordsValidatorTestCase

- (void)setUp {
    [super setUp];

#ifdef USE_DEMO_FILE
    ScrabbleWordsFactory *wordsFactory = [[ScrabbleWordsFactory alloc] initWithConfiguration:ScrabbleWordsFactoryConfigDemoFile];
#else
    ScrabbleWordsFactory *wordsFactory = [[ScrabbleWordsFactory alloc] initWithConfiguration:ScrabbleWordsFactoryConfigDefault];
#endif
    
    NSDictionary *wordsDictionary = wordsFactory.scrabbleWords;
    self.validator = [[ScrabbleWordsValidator alloc] initWithScrabbleWordsDictionary:wordsDictionary];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.validator = nil;
    
    [super tearDown];
}

#pragma mark - Valid Words
- (void)testAAHIsValidWord {
    XCTAssertTrue([self.validator wordIsValid:@"aah"]); // XXXXXXXXXXXXXXX
}

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

/**
 USING DEFAULT WORDS FILE
*/
#ifndef USE_DEMO_FILE
- (void)testZoophilicIsValidWord {
    XCTAssertTrue([self.validator wordIsValid:@"zoophilic"]);
}

- (void)testZoophiliIsInvalidWord {
    XCTAssertFalse([self.validator wordIsValid:@"zoophili"]); // zoophilic with missing last 'c'
}

- (void)test_saet_IsInvalidWord {
    XCTAssertFalse([self.validator wordIsValid:@"saet"]);
}

- (void)testGenerateRandomValidWords {
    NSArray *randomValidWords = [self.validator randomValidWordsFromLetters:@"atrmasoiel" maxWordLength:6];
    XCTAssertGreaterThan([randomValidWords count], 0);
}

- (void)testGenerate5LetterRandomValidWordsWhenZero6LetterWordsOccur {
    NSArray *randomValidWords = [self.validator randomValidWordsFromLetters:@"zzzzzzamia" maxWordLength:6];
    XCTAssertGreaterThan([randomValidWords count], 0);
    NSLog(@"Count: %lu", [randomValidWords count]);
    XCTAssertEqual([randomValidWords[0] length], 5);
}

#ifdef EXTENDED_RANDOM_WORD_GENERATE_TEST
- (void)testGenerateRandomValidWords_fromActualGame_1 {
    NSArray *randomValidWords = [self.validator randomValidWordsFromLetters:@"sryeornniieg" maxWordLength:6];
    NSLog(@"Count: %lu", [randomValidWords count]);
    XCTAssertGreaterThan([randomValidWords count], 0);
}

- (void)testGenerateRandomValidWords_fromActualGame_2 {
    NSArray *randomValidWords = [self.validator randomValidWordsFromLetters:@"paegatslmmoa" maxWordLength:6];
    NSLog(@"Count: %lu", [randomValidWords count]);
    XCTAssertGreaterThan([randomValidWords count], 0);
}

- (void)testGenerateRandomValidWords_fromActualGame_3 {
    NSArray *randomValidWords = [self.validator randomValidWordsFromLetters:@"ntteuwieadfh" maxWordLength:6];
    NSLog(@"Count: %lu", [randomValidWords count]);
    XCTAssertGreaterThan([randomValidWords count], 0);
}

- (void)testGenerateRandomValidWords_fromActualGame_4 {
    NSArray *randomValidWords = [self.validator randomValidWordsFromLetters:@"aneaoihcsnnr" maxWordLength:6];
    NSLog(@"Count: %lu", [randomValidWords count]);
    XCTAssertGreaterThan([randomValidWords count], 0);
}

#endif // EXTENDED_RANDOM_WORD_GENERATE_TEST

#endif // USE_DEMO_FILE

#pragma mark - Performance Test
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
