//
//  coinSliver.m
//  cmplerushing
//
//  Created by admin on 13-7-18.
//
//

#import "coins.h"

@implementation coins

+(id)initCoins{
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"coin.plist"];
    coins *coin = [coins spriteWithSpriteFrameName:@"coin1.png"];
    [coin runAction:[CCRepeatForever actionWithAction:[self runAnimate:1 stopFrame:6]]];
    
    return coin;
}

+(CCAnimate*)runAnimate:(NSInteger)startframe stopFrame:(NSInteger)stopframe{
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = startframe; i < stopframe + 1; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"coin%d.png",i]];
        [animFrames addObject:frame];
    }
    CCAnimation*anim=[CCAnimation animationWithSpriteFrames:animFrames delay:0.1];
    CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
    return animate;
}

@end
