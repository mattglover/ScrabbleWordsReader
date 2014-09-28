//
//  ScrabbleWordsFactoryTextCase.m
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ScrabbleWordsFactory.h"

@interface ScrabbleWordsFactoryTextCase : XCTestCase

@property (nonatomic, strong) ScrabbleWordsFactory *sut;

@end

@implementation ScrabbleWordsFactoryTextCase

- (void)setUp {
    [super setUp];

}

- (void)tearDown {
    self.sut = nil;
    
    [super tearDown];
}

- (void)testInitWithNoConfigArgumentLoadsFullWordsFile {
    self.sut = [[ScrabbleWordsFactory alloc] init];
    XCTAssertEqual([self.sut.scrabbleWords count], 26);
}

- (void)testInitWithDefaultConfigArgumentLoadsFullWordsFile {
    self.sut = [[ScrabbleWordsFactory alloc] initWithConfiguration:ScrabbleWordsFactoryConfigDefault];
    XCTAssertEqual([self.sut.scrabbleWords count], 26);
}

- (void)testInitWithDemoFileConfigArgumentLoadsFullWordsFile {
    self.sut = [[ScrabbleWordsFactory alloc] initWithConfiguration:ScrabbleWordsFactoryConfigDemoFile];
    XCTAssertEqual([self.sut.scrabbleWords count], 1);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
