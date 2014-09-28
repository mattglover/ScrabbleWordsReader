//
//  ScrabbleWordsFactory.m
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import "ScrabbleWordsFactory.h"

@interface ScrabbleWordsFactory ()

@property (nonatomic, assign) ScrabbleWordsFactoryConfig configuration;
@property (nonatomic, strong, readwrite) NSDictionary *scrabbleWords;

@end

@implementation ScrabbleWordsFactory

- (instancetype)initWithConfiguration:(ScrabbleWordsFactoryConfig)configuration {
    if (self = [super init]) {
        _configuration = configuration;
        
        [self loadScrabbleWords];
    }
    return self;
}

- (instancetype)init {
    return [self initWithConfiguration:ScrabbleWordsFactoryConfigDefault];;
}

#pragma mark - Private Methods
- (void)loadScrabbleWords {
    
    NSString *scrabbleWordsJSONFilename;
    
    switch (self.configuration) {
        case ScrabbleWordsFactoryConfigDefault:
            scrabbleWordsJSONFilename =  @"scrabble-words";
            break;
        
        case ScrabbleWordsFactoryConfigDemoFile:
            scrabbleWordsJSONFilename = @"demo";
            break;
    }
    
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:scrabbleWordsJSONFilename ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    self.scrabbleWords = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
}

@end
