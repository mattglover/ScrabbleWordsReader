//
//  ScrabbleWordsService.m
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import "ScrabbleWordsService.h"
#import "ScrabbleWordsFactory.h"
#import "ScrabbleWordsValidator.h"
#import "ScrabbleWord.h"
#import "ScrabbleWordsPointsSorter.h"

@interface ScrabbleWordsService ()

@property (nonatomic, strong) ScrabbleWordsValidator *validator;
@property (nonatomic, strong) ScrabbleWordsPointsSorter *pointsSorter;

@end

@implementation ScrabbleWordsService

- (instancetype)init {
    if (self = [super init]) {
        ScrabbleWordsFactory *factory = [[ScrabbleWordsFactory alloc] init];
        self.validator = [[ScrabbleWordsValidator alloc] initWithScrabbleWordsDictionary:factory.scrabbleWords];
        self.pointsSorter = [[ScrabbleWordsPointsSorter alloc] init];
    }
    
    return self;
}

- (NSArray *)validWordsForLetters:(NSString *)letters orderedByMaxPoints:(BOOL)ordered {
    
    if (!letters) {
        return nil;
    }
    
    NSArray *validWords = [self.validator randomValidWordsFromLetters:letters maxWordLength:6];

    NSMutableArray *scrabbleWords = [NSMutableArray arrayWithCapacity:[validWords count]];
    
    [validWords enumerateObjectsUsingBlock:^(NSString *validWord, NSUInteger idx, BOOL *stop) {
        ScrabbleWord *word = [[ScrabbleWord alloc] init];
        word.word = validWord;
        word.totalScore = [self.pointsSorter pointsForWord:validWord];
        [scrabbleWords addObject:word];
    }];
    
    if (ordered) {
        scrabbleWords = [[self.pointsSorter sortScrabbleWordsByPoints:scrabbleWords] mutableCopy];
    }
    
    return scrabbleWords;
}

@end
