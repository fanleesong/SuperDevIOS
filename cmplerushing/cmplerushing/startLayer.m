//
//  startLayer.m
//  cmplerushing
//
//  Created by admin on 13-6-17.
//
//

#import "startLayer.h"
#import "gameLayer.h"
#import "scoreLayer.h"

@implementation startLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	startLayer* layer = [startLayer node];
	[scene addChild:layer];
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLayerColor* bklayer = [CCLayerColor layerWithColor:ccc4(223, 253, 253, 255) width:size.width height:size.height];
        [self addChild:bklayer];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Miku Rushing" fontName:@"Marker Felt" fontSize:30];
        label.color = ccBLACK;
		label.position =  ccp( 150 , size.height/2+50);
		[self addChild: label];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"mikustart.plist"];
        //左侧正常速度的播放
        CCSprite *mySprite = [CCSprite spriteWithSpriteFrameName:@"mikustart1.png"];//[CCSprite node];
        mySprite.position=ccp(size.width - 150,size.height/2);
		CCSpriteBatchNode *batchNode = [CCSpriteBatchNode batchNodeWithFile:@"mikustart.png"];
		[batchNode addChild:mySprite];
		[self addChild:batchNode];
        
        NSMutableArray *animFrames = [NSMutableArray array];
		for(int i = 1; i < 4; i++) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"mikustart%d.png",i]];
            [animFrames addObject:frame];
		}
        CCAnimation*anim=[CCAnimation animationWithSpriteFrames:animFrames delay:0.2];
        CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
        CCSequence *seq = [CCSequence actions:animate,nil];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:seq];
        [mySprite runAction:repeat];
        
        CCLabelTTF *menulabel = [CCLabelTTF labelWithString:@"start" fontName:@"Marker Felt" fontSize:20];
        menulabel.color = ccBLACK;
        CCMenuItemLabel *menuItem1 = [CCMenuItemLabel itemWithLabel:menulabel block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[gameLayer scene]];
        }];
        CCLabelTTF *scorelabel = [CCLabelTTF labelWithString:@"score" fontName:@"Marker Felt" fontSize:20];
        scorelabel.color = ccBLACK;
        CCMenuItemLabel *menuItem2 = [CCMenuItemLabel itemWithLabel:scorelabel block:^(id sender) {
            [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[scoreLayer scene]]];
        }];
        CCMenu *myMenu = [CCMenu menuWithItems:menuItem1,menuItem2, nil];
        [myMenu alignItemsHorizontallyWithPadding:50];
        myMenu.position = ccp(150,size.height/2);
        [self addChild:myMenu];
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

@end
