//
//  copyrightLayer.m
//  cmplerushing
//
//  Created by admin on 13-6-17.
//
//

#import "copyrightLayer.h"
#import "startLayer.h"

@implementation copyrightLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	copyrightLayer *layer = [copyrightLayer node];
	[scene addChild: layer];
	return scene;
}

-(void) onEnter
{
	[super onEnter];
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *mikuSprite = [CCSprite spriteWithFile:@"icon114.png"];//[CCSprite node];
        mikuSprite.position=ccp(size.width*0.5,size.height*0.5);
        [self addChild:mikuSprite];
        
        [self scheduleOnce:@selector(makeTransition:) delay:2];
	
}
-(void) makeTransition:(ccTime)dt
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[startLayer scene] withColor:ccBLACK]];
}

- (void) dealloc
{
	[super dealloc];
}


@end
