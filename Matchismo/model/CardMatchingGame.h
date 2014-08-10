//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Curtis Callaghan on 8/9/14.
//  Copyright (c) 2014 curtis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;

//designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck*)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card*)cardAtIndex:(NSUInteger)index;

@end
