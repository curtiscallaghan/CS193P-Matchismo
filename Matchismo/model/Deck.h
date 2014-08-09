//
//  Deck.h
//  Matchismo
//
//  Created by Curtis Callaghan on 8/9/14.
//  Copyright (c) 2014 curtis. All rights reserved.
//

@import Foundation;
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card*)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
