//
//  pauseLayer.m
//  cmplerushing
//
//  Created by admin on 13-7-18.
//
//

#import "pauseLayer.h"
#import "startLayer.h"
#import "SimpleAudioEngine.h"

@implementation pauseLayer

//+(id) scene
//{
//    CCScene *scene = [CCScene node];
//	pauseLayer *layer = [pauseLayer node];
//    [scene addChild:layer];
//    return scene;
//}

-(id)init
{
    if((self=[super init]))
    {
        CCLayerColor *colorlayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 150)];
        [self addChild:colorlayer];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCMenuItemFont *item1 = [CCMenuItemFont itemWithString:@"back" target:self selector:@selector(goBack:)];
        CCMenuItemFont *item2 = [CCMenuItemFont itemWithString:@"main" target:self selector:@selector(goMain:)];
        
        CCMenu *menu=[CCMenu menuWithItems:item1, item2, nil];
        [menu alignItemsHorizontallyWithPadding:50];
        [menu setPosition:ccp(winSize.width/2,winSize.height/2)];
        [self addChild:menu];
    }
    return self;
}

-(void)goBack:(id)sender{
    [self.parent removeChild:self cleanup:YES];
    [[CCDirector sharedDirector] resume];
}

-(void)goMain:(id)sender{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[CCDirector sharedDirector] resume];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[startLayer scene] withColor:ccBLACK]];
}

@end
