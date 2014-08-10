//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Curtis Callaghan on 8/8/14.
//  Copyright (c) 2014 curtis. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardsDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation CardGameViewController

-(CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:self.deck];
    return _game;
}

-(Deck *)deck
{
    if(!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck*)createDeck
{
    return [[PlayingCardsDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *button in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [button setTitle:[self titleForCard:card]
                forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
        button.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (NSString *)titleForCard:(Card*)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card*)card
{
    return [UIImage imageNamed:card.isChosen ?  @"cardfront" : @"cardback"];
}

@end
