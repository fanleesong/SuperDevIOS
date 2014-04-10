//
//  gameoverLayer.m
//  cmplerushing
//
//  Created by admin on 13-7-18.
//
//

#import "gameoverLayer.h"
#import "startLayer.h"
#import "gameLayer.h"

@implementation gameoverLayer

+(id) scene
{
    CCScene *scene = [CCScene node];
	gameoverLayer *layer = [gameoverLayer node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if((self=[super init]))
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCMenuItemFont *item1 = [CCMenuItemFont itemWithString:@"replay" target:self selector:@selector(goReplay:)];
        CCMenuItemFont *item2 = [CCMenuItemFont itemWithString:@"main" target:self selector:@selector(goMain:)];
        
        CCMenu *menu=[CCMenu menuWithItems:item1, item2, nil];
        [menu alignItemsHorizontallyWithPadding:50];
        [menu setPosition:ccp(winSize.width/2,winSize.height/2)];
        [self addChild:menu];
    }
    return self;
}

-(void)goReplay:(id)sender{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[gameLayer scene] withColor:ccBLACK]];
}

-(void)goMain:(id)sender{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[startLayer scene] withColor:ccBLACK]];
}

@end
