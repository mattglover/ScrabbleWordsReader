//
//  ScrabbleWordsServiceTestCase.m
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ScrabbleWordsService.h"

@interface ScrabbleWordsServiceTestCase : XCTestCase

@property (nonatomic, strong) ScrabbleWordsService *sut;

@end

@implementation ScrabbleWordsServiceTestCase

- (void)setUp {
    [super setUp];

    self.sut = [[ScrabbleWordsService alloc] init];
}

- (void)tearDown {
    self.sut = nil;
    
    [super tearDown];
}

- (void)testRequestingValidWordsWith10CharacterReturnsValidWords {
    NSArray *validWords = [self.sut validWordsForLetters:@"abtrstuiomgn" orderedByMaxPoints:NO];
    XCTAssertNotNil(validWords);
    XCTAssertGreaterThan([validWords count], 0);
}

- (void)testRequestingValidWordsWithNilCharactersReternsNil {
    NSArray *validWords = [self.sut validWordsForLetters:nil orderedByMaxPoints:NO];
    XCTAssertNil(validWords);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
