//
//  scoreLayer.m
//  cmplerushing
//
//  Created by admin on 13-6-17.
//
//

#import "scoreLayer.h"

@implementation scoreLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	scoreLayer *layer = [scoreLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLayerColor* bklayer = [CCLayerColor layerWithColor:ccc4(223, 253, 253, 255) width:size.width height:size.height];
        [self addChild:bklayer];
        
        NSString *scorestr = [NSString stringWithFormat:@"highest %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"runnum"]];
        CCLabelTTF *scorelabel = [CCLabelTTF labelWithString:scorestr fontName:@"Marker Felt" fontSize:20];
        scorelabel.color = ccBLACK;
		scorelabel.position =  ccp(size.width*0.5-100 ,size.height*0.4);
		[self addChild: scorelabel];
        
        NSString *coinstr = [NSString stringWithFormat:@"highest %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"coinnum"]];
        CCLabelTTF *coinlabel = [CCLabelTTF labelWithString:coinstr fontName:@"Marker Felt" fontSize:20];
        coinlabel.color = ccBLACK;
		coinlabel.position =  ccp(size.width*0.5-100 ,size.height*0.6);
		[self addChild: coinlabel];
        
        self.isTouchEnabled = YES;
	}
	return self;
}
-(void)registerWithTouchDispatcher{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [[CCDirector sharedDirector] popScene];
//    id action = [CCMoveTo actionWithDuration:0.3 position:CGPointMake(self.position.x, self.position.y + self.boundingBox.size.height)];
//    id callFunc = [CCCallFunc actionWithTarget:self selector:@selector(popself)];
//    id animSequence = [CCSequence actions:action, callFunc, nil];
//    [self runAction:animSequence];
}
-(void)popself{
   [[CCDirector sharedDirector] popScene];
}

- (void) dealloc
{
	[super dealloc];
}

@end
