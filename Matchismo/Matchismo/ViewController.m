//
//  ViewController.m
//  Matchismo
//
//  Created by Niyaz on 11/4/14.
//  Copyright (c) 2014 Niyaz. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"


@interface ViewController ()
@property(nonatomic, strong) PlayingCardDeck *playingCardDeck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UIButton *restartGame;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardSwitch;
@property(nonatomic,strong) CardMatchingGame *game;
@end


@implementation ViewController

-(CardMatchingGame *) game {
    if(!_game) {
       _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                 usingDeck:[self createDeck]];
    }
    return _game;
}


-(Deck *) createDeck {
    _playingCardDeck = [[PlayingCardDeck alloc]init];
    return _playingCardDeck;
    
}
- (IBAction)restart:(id)sender {
    [self.playingCardDeck clearCards];
    [self.playingCardDeck initializeCards];
    self.game = nil;
    [self game];
    [self updateUI];
}
- (IBAction)switchGameType:(id)sender {
    if(self.cardSwitch.selectedSegmentIndex == 0) {
        self.game.gameType=twoCard;
        NSLog(@"Two Card is selected");
    } else if (self.cardSwitch.selectedSegmentIndex == 1){
        self.game.gameType=threeCard;
        NSLog(@"Three Card is selected");
    }
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    if(self.cardSwitch.isUserInteractionEnabled==YES) {
        [self.cardSwitch setUserInteractionEnabled:NO];
    }
}

-(void)updateUI {
    for(UIButton *cardButton in self.cardButtons) {
        int cardIndex =[self.cardButtons indexOfObject:cardButton];
        Card *card =[self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleOfCard:card]forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backGroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled=!card.matched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score : %d", self.game.score];
    }
}

-(NSString *) titleOfCard:(Card*) card{
    return (card.isChosen) ? card.contents: @"";
}

-(UIImage *) backGroundImageForCard:(Card*) card {
    return [UIImage imageNamed:(card.isChosen) ? @"cardFront":@"cardBack"];
}
@end
