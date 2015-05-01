//
//  ScrabbleWordsPointsSorter.m
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import "ScrabbleWordsPointsSorter.h"
#import "ScrabbleWord.h"

@interface ScrabbleWordsPointsSorter ()

@property (nonatomic, strong) NSDictionary *letterPointsMap;

@end

@implementation ScrabbleWordsPointsSorter

- (instancetype)init {

    if (self = [super init]) {
        
        self.letterPointsMap = @{ @"a" : @1,
                                  @"b" : @3,
                                  @"c" : @3,
                                  @"d" : @2,
                                  @"e" : @1,
                                  @"f" : @4,
                                  @"g" : @2,
                                  @"h" : @4,
                                  @"i" : @1,
                                  @"j" : @8,
                                  @"k" : @5,
                                  @"l" : @1,
                                  @"m" : @3,
                                  @"n" : @1,
                                  @"o" : @1,
                                  @"p" : @3,
                                  @"q" : @10,
                                  @"r" : @1,
                                  @"s" : @1,
                                  @"t" : @1,
                                  @"u" : @1,
                                  @"v" : @4,
                                  @"w" : @4,
                                  @"x" : @8,
                                  @"y" : @4,
                                  @"z" : @10,
                                  };
        
    }
    return self;
}


- (NSUInteger)pointsForWord:(NSString *)word {
    
    NSArray *letters = [self lettersInWord:word];
    __block NSUInteger total = 0;
    
    [letters enumerateObjectsUsingBlock:^(NSString *character, NSUInteger idx, BOOL *stop) {
        total += [self.letterPointsMap[character] integerValue];
    }];
    
    return total;
}

- (NSArray *)sortScrabbleWordsByPoints:(NSArray *)wordsToSort {
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"totalScore" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [wordsToSort sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}

- (NSArray *)lettersInWord:(NSString *)word {
    
    NSMutableArray *letters = [NSMutableArray array];
    for (int i=0; i < [word length]; i++) {
        NSString *letter = [NSString stringWithFormat:@"%C", [word characterAtIndex:i]];
        [letters addObject:letter];
    }
    
    return [letters copy];
}

@end
