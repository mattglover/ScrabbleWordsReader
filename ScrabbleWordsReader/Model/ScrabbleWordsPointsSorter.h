//
//  ScrabbleWordsPointsSorter.h
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrabbleWordsPointsSorter : NSObject

- (NSUInteger)pointsForWord:(NSString *)word;
- (NSArray *)sortScrabbleWordsByPoints:(NSArray *)wordsToSort;

@end
