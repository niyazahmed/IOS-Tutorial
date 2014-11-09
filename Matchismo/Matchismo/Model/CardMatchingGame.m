//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Niyaz on 11/6/14.
//  Copyright (c) 2014 Niyaz. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic,readwrite)NSInteger score;
@property (nonatomic,strong)NSMutableArray *cards; //cards
@property (nonatomic)enum gameType;
@end


@implementation CardMatchingGame

@synthesize gameType = _gameType;

-(void)setGameType:(enum category) gameType {
    _gameType = gameType;
}

-(enum category) gameType {
    return _gameType;
}

- (NSMutableArray*) cards {
    if(!_cards){
        _cards= [[NSMutableArray alloc]init];
    }
    return _cards;
}


-(instancetype) initWithCardCount:(NSInteger) count usingDeck:(Deck *) deck {
    self =[super init];
    if(self) {
        for(int i=0;i<count;i++) {
            Card *card = [deck drawRandomCard];
            if(card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
    
}


-(instancetype) init{
    return nil;
}

#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define COST_TOCHOSE 1

-(void) chooseCardAtIndex:(NSInteger)index {
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched){
        if(card.isChosen) {
            card.chosen = NO;
        } else {
            //match another card
            for(Card *anotherCard in self.cards) {
                if(anotherCard.isChosen && !anotherCard.isMatched) {
                    int matchScore = [card match:@[anotherCard]];
                    if(matchScore) {
                        self.score = matchScore * MATCH_BONUS;
                        card.matched = YES;
                        anotherCard.matched = YES;
                        break;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        anotherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TOCHOSE;
            card.chosen = YES;
        }
    }
    
}


-(Card *) cardAtIndex:(NSInteger) index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}



@end
