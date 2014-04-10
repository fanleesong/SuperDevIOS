//
//  mikuRole.m
//  cmplerushing
//
//  Created by admin on 13-7-11.
//
//

#import "mikuRole.h"

@implementation mikuRole

@synthesize animeRun,animeJump;

+(id)initMiku{
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"run.plist"];
    mikuRole *mikurole = [mikuRole spriteWithSpriteFrameName:@"run1.png"];
    [mikurole.texture setAliasTexParameters];
    
    mikurole.animeRun = [self runAnimate:1 stopFrame:2];
    mikurole.animeJump = [self runAnimate:3 stopFrame:3];
    
    return mikurole;
}

+(CCAnimate*)runAnimate:(NSInteger)startframe stopFrame:(NSInteger)stopframe{
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = startframe; i < stopframe + 1; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"run%d.png",i]];
        [animFrames addObject:frame];
    }
    CCAnimation*anim=[CCAnimation animationWithSpriteFrames:animFrames delay:0.1];
    CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
    return animate;
}

@end
