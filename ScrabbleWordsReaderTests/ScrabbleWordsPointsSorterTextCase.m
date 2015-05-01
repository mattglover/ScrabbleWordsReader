//
//  ScrabbleWordsPointsSorterTextCase.m
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ScrabbleWordsPointsSorter.h"

@interface ScrabbleWordsPointsSorterTextCase : XCTestCase
@property (nonatomic, strong) ScrabbleWordsPointsSorter *sut;
@end

@implementation ScrabbleWordsPointsSorterTextCase

- (void)setUp {
    [super setUp];

    self.sut = [[ScrabbleWordsPointsSorter alloc] init];
}

- (void)tearDown {
    self.sut = nil;
    [super tearDown];
}

- (void)testReturnCorrentPointsForApple {
    XCTAssertEqual([self.sut pointsForWord:@"apple"], 9);
}

- (void)testReturnCorrentPointsForZombie {
    XCTAssertEqual([self.sut pointsForWord:@"zombie"], 19);
}

@end
