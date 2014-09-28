//
//  ScrabbleWordsController.m
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import "ScrabbleWordsController.h"

@interface ScrabbleWordsController ()

@property (nonatomic, strong) NSDictionary *scrabbleWords;

@end

@implementation ScrabbleWordsController

- (void)loadScrabbleWordsFromFilePath:(NSString *)filepath {
    NSData *jsonData = [NSData dataWithContentsOfFile:filepath];
    self.scrabbleWords = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
}

- (BOOL)wordIsValid:(NSString *)word {
    
    if ([word length] <= 2) {
        return NO;
    }
    
    __block BOOL isValid = NO;
    __block NSDictionary *dictionaryInFocus = self.scrabbleWords;
    NSArray *letters = [self lettersInWord:word];
    
    [letters enumerateObjectsUsingBlock:^(NSString *letter, NSUInteger idx, BOOL *stop) {
        
        if ([[dictionaryInFocus allKeys] containsObject:letter]) {
            dictionaryInFocus = dictionaryInFocus[letter];
            BOOL isLastLetter = idx + 1 == [letters count];
            if (isLastLetter && [dictionaryInFocus isKindOfClass:[NSDictionary class]] && ![[dictionaryInFocus allKeys] containsObject:@"$"]) {
                isValid = NO;
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

@end
