//
//  ScrabbleWordsController.h
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrabbleWordsController : NSObject

- (void)loadScrabbleWordsFromFilePath:(NSString *)filepath;
- (BOOL)wordIsValid:(NSString *)word;

@end
