//
//  ScrabbleWordsController.m
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import "ScrabbleWordsValidator.h"

@interface ScrabbleWordsValidator ()

@property (nonatomic, strong, readwrite) NSDictionary *scrabbleWords;

@end

@implementation ScrabbleWordsValidator

- (instancetype)initWithScrabbleWordsDictionary:(NSDictionary *)scrabbleWords {
    if (self = [super init]) {
        _scrabbleWords = scrabbleWords;
    }
    return self;
}

- (BOOL)wordIsValid:(NSString *)word {
    
    if ([word length] <= 2) {
        return NO;
    }
    
    __block BOOL isValid = NO;
    __block NSDictionary *dictionaryInFocus = self.scrabbleWords;
    NSArray *letters = [self lettersInWord:word];
    
    [letters enumerateObjectsUsingBlock:^(NSString *letter, NSUInteger idx, BOOL *stop) {
        
        if ([dictionaryInFocus isKindOfClass:[NSDictionary class]] && [[dictionaryInFocus allKeys] containsObject:letter]) {
            dictionaryInFocus = dictionaryInFocus[letter];
            BOOL isLastLetter = idx + 1 == [letters count];
            if (isLastLetter && [dictionaryInFocus isKindOfClass:[NSDictionary class]] && ![[dictionaryInFocus allKeys] containsObject:@"$"]) {
                isValid = NO;
                *stop = YES;
            } else {
                isValid = YES;
            }
        } else {
            isValid = NO;
            *stop = YES;
        }
    }];
    
    return isValid;
}

#pragma mark - Private Methods
- (NSArray *)lettersInWord:(NSString *)word {
    
    NSMutableArray *letters = [NSMutableArray array];
    for (int i=0; i < [word length]; i++) {
        NSString *letter = [NSString stringWithFormat:@"%C", [word characterAtIndex:i]];
        [letters addObject:letter];
    }
    
    return [letters copy];
}

- (NSArray *)randomValidWordsFromLetters:(NSString *)allLetters maxWordLength:(NSUInteger)maxWordLength {

    NSMutableArray *randomValidWords = [NSMutableArray array];
    
    NSUInteger maxNumberAttempts = 60000;
    for (int loop = 0; loop < maxNumberAttempts; loop++) {
        NSString *randomString = [self randomStringFromLetters:allLetters maxLength:maxWordLength];
        if ([self wordIsValid:randomString]) {
            [randomValidWords addObject:randomString];
        }
    }
    
    if ([randomValidWords count] == 0) {
        for (int loop = 0; loop < (maxNumberAttempts / 2); loop++) {
            NSString *randomString = [self randomStringFromLetters:allLetters maxLength:maxWordLength - 1];
            if ([self wordIsValid:randomString]) {
                [randomValidWords addObject:randomString];
            }
        }
    }
    
    return randomValidWords;
}

- (NSString *)randomStringFromLetters:(NSString *)allLetters maxLength:(NSUInteger)maxLength {
    
    NSArray *letters = [self lettersFromString:allLetters];
    
    NSMutableString *randomLetterCombination = [NSMutableString stringWithCapacity:maxLength];
    NSMutableArray *selectedIndexes = [NSMutableArray arrayWithCapacity:maxLength];
    uint32_t r;
    while ([selectedIndexes count] < maxLength) {
        r = arc4random_uniform((uint32_t)[letters count]);
        if (![selectedIndexes containsObject:@(r)]) {
            [selectedIndexes addObject:@(r)];
            [randomLetterCombination appendFormat:@"%@", letters[r]];
        }
    }
    
    return randomLetterCombination;
}

- (NSArray *)lettersFromString:(NSString *)string {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [string length]; i++) {
        NSString *character = [string substringWithRange:NSMakeRange(i, 1)];
        [array addObject:character];
    }
    return array;
}

@end
