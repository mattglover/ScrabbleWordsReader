//
//  ScrabbleWordsFactory.h
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ScrabbleWordsFactoryConfig) {
    ScrabbleWordsFactoryConfigDefault = 0,
    ScrabbleWordsFactoryConfigDemoFile
};

@interface ScrabbleWordsFactory : NSObject

@property (nonatomic, strong, readonly) NSDictionary *scrabbleWords;

- (instancetype)initWithConfiguration:(ScrabbleWordsFactoryConfig)configuration;

@end
