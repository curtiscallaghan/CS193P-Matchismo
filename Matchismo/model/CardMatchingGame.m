//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Curtis Callaghan on 8/9/14.
//  Copyright (c) 2014 curtis. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSUInteger mode;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (strong, nonatomic, readwrite) NSString *lastConsideration;
@property (strong, nonatomic) NSMutableArray *cardsToMatch; // of Card
@end

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if ( !_cards ) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)cardsToMatch
{
    if ( !_cardsToMatch ) _cardsToMatch = [[NSMutableArray alloc] init];
    return _cardsToMatch;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck*)deck
               matchingCardsMode:(NSUInteger)mode
{
    self = [super init];
    
    if (self) {
        self.mode = mode;
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card*)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    self.lastConsideration = nil;
    
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            
            if (self.mode == 2) {
            
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = card.matched = YES;
                            self.lastConsideration = [NSString stringWithFormat:@"Matched %@ %@ for %d points.", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            self.lastConsideration = [NSString stringWithFormat:@"%@ %@ don’t match! %d point penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                        }
                        break;
                    }
                }
                
                if (!self.lastConsideration) {
                    self.lastConsideration = card.contents;
                }
            }
            else {
                
                if ([self.cardsToMatch count] == 2) {
                    int matchScore = [card match:self.cardsToMatch];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        for (Card *matchedCard in self.cardsToMatch) {
                            matchedCard.matched = YES;
                        }
                        card.matched = YES;
                        //self.lastConsideration = [NSString stringWithFormat:@"Matched %@ %@ for %d points.", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                        [self.cardsToMatch removeAllObjects];
                    }
                    else {
                        self.score -= MISMATCH_PENALTY;
                        [[self.cardsToMatch firstObject] setChosen:NO];
                        [self.cardsToMatch removeObjectAtIndex:0];
                        [self.cardsToMatch addObject:card];
                    }
                }
                else {
                    [self.cardsToMatch addObject:card];
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
