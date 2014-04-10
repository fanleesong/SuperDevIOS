//
//  coinSliver.h
//  cmplerushing
//
//  Created by admin on 13-7-18.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface coins : CCSprite

+(id)initCoins;

+(CCAnimate*)runAnimate:(NSInteger)startframe stopFrame:(NSInteger)stopframe;

@end
