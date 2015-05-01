//
//  ScrabbleWordsService.h
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrabbleWordsService : NSObject

- (NSArray *)validWordsForLetters:(NSString *)letters orderedByMaxPoints:(BOOL)ordered;

@end
