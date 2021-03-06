//
//  ScrabbleWordsController.h
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrabbleWordsValidator : NSObject

@property (nonatomic, strong, readonly) NSDictionary *scrabbleWords;

- (instancetype)initWithScrabbleWordsDictionary:(NSDictionary *)scrabbleWords;
- (BOOL)wordIsValid:(NSString *)word;

- (NSArray *)randomValidWordsFromLetters:(NSString *)allLetters maxWordLength:(NSUInteger)maxWordLength;

@end
