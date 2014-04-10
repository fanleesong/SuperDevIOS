//
//  mikuRole.h
//  cmplerushing
//
//  Created by admin on 13-7-11.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface mikuRole : CCSprite{
    CCAnimate *animeRun;
    CCAnimate *animeJump;
}

@property(nonatomic,retain)CCAnimate *animeRun;
@property(nonatomic,retain)CCAnimate *animeJump;

+(id)initMiku;
+(CCAnimate*)runAnimate:(NSInteger)startframe stopFrame:(NSInteger)stopframe;

@end
