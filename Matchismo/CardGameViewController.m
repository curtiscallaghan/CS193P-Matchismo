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

static const int GAME_MODE_2_CARDS = 2;
static const int GAME_MODE_3_CARDS = 3;

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *lastConsiderationLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentControl;
@end

@implementation CardGameViewController

-(CardMatchingGame *)game
{
    
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:self.deck
                                          matchingCardsMode:self.gameMode];
    return _game;
}

- (NSInteger)gameMode
{
    self.gameModeSegmentControl.enabled = NO;
    return self.gameModeSegmentControl.selectedSegmentIndex == 0 ? GAME_MODE_2_CARDS : GAME_MODE_3_CARDS;
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
        self.lastConsiderationLabel.text = self.game.lastConsideration;
    }
}

- (IBAction)touchNewGameButton:(UIButton *)sender {
    
    NSString *message = @"Are you sure you want to start a new game?\nAll current progress will be lost.";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Game"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"Not now"
                                          otherButtonTitles:@"Yes, please", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex > 0) {
        [self resetUI];
        self.game = nil;
        self.deck = nil;

    }
}

- (void)resetUI
{
    for (UIButton *button in self.cardButtons) {
        [button setTitle:@""
                forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        button.enabled = YES;
    }
    self.scoreLabel.text = @"Score: 0";
    self.lastConsiderationLabel.text = @"";
    self.gameModeSegmentControl.enabled = YES;
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
