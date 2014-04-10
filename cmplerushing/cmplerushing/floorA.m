//
//  floorA.m
//  cmplerushing
//
//  Created by admin on 13-7-11.
//
//

#import "floorA.h"

@implementation floorA

+(id)initFloorA{
    CCTexture2D * texture =[[CCTextureCache sharedTextureCache] addImage: @"floor1.png"];
    floorA *floor = [floorA spriteWithTexture:texture];
    [floor.texture setAliasTexParameters];
    return floor;
}

@end
