//
//  gameLayer.m
//  cmplerushing
//
//  Created by admin on 13-6-17.
//
//

#import "gameLayer.h"
#import "pauseLayer.h"
#import "startLayer.h"
#import "gameoverLayer.h"

@implementation gameLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	gameLayer *layer = [gameLayer node];
	[scene addChild: layer];
	return scene;
}

-(void) onEnter
{
	[super onEnter];
        
    //canjump = YES;
    forceX = 300;
    forceY = 30;
        
    size = [[CCDirector sharedDirector] winSize];
    sizep = [[CCDirector sharedDirector] winSizeInPixels];
    scalefix = sizep.width/480;
    speedfix = 0.01;
    isjump = YES;
    isonfloor = NO;
    coinnum = 0;
    runnum = 0;
    
    [self initBackground];
    [self initFloorsAndCoins];
    [self initCharacter];
    [self initUI];
    
    distance = miku.position.y - [[floorarray objectAtIndex:0] position].y;
    miku.position = CGPointMake(50, size.height+50);//初音初始从最高处下来
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"mikumusic.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"eatcoin.caf"];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"mikumusic.caf" loop:YES];
    issound = YES;
    
    [self schedule:@selector(update:)];
    
}
-(void)initCharacter{
    miku = [mikuRole initMiku];
    miku.position = CGPointMake(50, size.height/2);
    miku.scale = scalefix;
    [miku runAction:[CCRepeatForever actionWithAction:miku.animeJump]];
    [self addChild:miku];
}
-(void)initFloorsAndCoins{
    int inum = 0;
    int icount = 0;
    isfrontblank = NO;
    floorarray = [[CCArray alloc] initWithCapacity:20];
    coinarray = [[CCArray alloc] initWithCapacity:20];
    for (int i=0; i<20; i++) {
        floorA *floora = [floorA initFloorA];
        floora.scale = scalefix;
        //floora.visible = YES;
        [self addChild:floora];
        [floorarray addObject:floora];
        
        coins *coin = [coins initCoins];
        [self addChild:coin];
        [coinarray addObject:coin];
    }
    while (inum<20) {
        icount ++;
        if (inum < 10) {
            [[floorarray objectAtIndex:inum] setPosition:CGPointMake(icount*35,size.height/2 - 50)];
            [[coinarray objectAtIndex:inum] setPosition:CGPointMake(icount*35,[[floorarray objectAtIndex:inum] position].y+50)];
            inum ++;
        }else{
            randomnum = [self getRandomNumber:0 to:2];
            if (randomnum == 0) {
                isfrontblank = YES;
                continue;
            }
            if (isfrontblank) {
                [[floorarray objectAtIndex:inum] setPosition:CGPointMake(icount*35,[self getRandomNumber:100 to:size.height-100])];
                [[coinarray objectAtIndex:inum] setPosition:CGPointMake(icount*35,[[floorarray objectAtIndex:inum] position].y+[self getRandomNumber:30 to:100])];
                isfrontblank = NO;
            }else{
                [[floorarray objectAtIndex:inum] setPosition:CGPointMake(icount*35,[[floorarray objectAtIndex:inum-1] position].y)];
                [[coinarray objectAtIndex:inum] setPosition:CGPointMake(icount*35,[[floorarray objectAtIndex:inum] position].y+[self getRandomNumber:30 to:100])];
            }
            inum ++;
        }
    }
}
-(void)initBackground{
    //大背景图片2张
    bksprite1 = [CCSprite spriteWithFile:@"gamebk1.png"];
    bksprite1.anchorPoint = CGPointMake(0,0);
    bksprite1.position=CGPointMake(0,0);
    bksprite1.scale = 2;
    [bksprite1.texture setAliasTexParameters];
    [self addChild:bksprite1];
    
    bksprite2 = [CCSprite spriteWithFile:@"gamebk1.png"];
    bksprite2.flipX = YES;
    bksprite2.anchorPoint = CGPointMake(0, 0);
    bksprite2.position = ccp(bksprite1.position.x+bksprite1.contentSize.width*2, bksprite2.position.y);
    bksprite2.scale = 2;
    [bksprite2.texture setAliasTexParameters];
    [self addChild:bksprite2];
    
    bkmovespeed = 0.1;
    
    //    background *bk = [background node];
    //    bk.bkmovespeed = 10;
    //    [self addChild:bk];
}
-(void)initUI{
    
    //控制初音按钮
    CCMenuItemImage *btnjump = [CCMenuItemImage itemWithNormalImage:@"btnjump.png" selectedImage:@"btnjump.png" block:^(id sender) {
        if (miku.position.y < 300 && powerbar.bar.contentSize.width >= 10){ //canjump) {
            [miku stopAllActions];
            [miku runAction:[CCRepeatForever actionWithAction:miku.animeJump]];
            forceY = -400;
            isjump = YES;
            isonfloor = NO;
            NSLog(@"%f",powerbar.bar.contentSize.width);
            [self updatePower:-5];
        }
    }];
    CCMenu *myMenu = [CCMenu menuWithItems:btnjump, nil];
    [myMenu alignItemsHorizontallyWithPadding:50];
    myMenu.position = CGPointMake(size.width+200,size.height/2+50);
    myMenu.scale = scalefix;
    [self addChild:myMenu];
    
    //初音体力条
    powerbar = [powerBar initPowerBar];
    powerbar.scale = scalefix;
    powerbar.position = ccp(120, size.height - 20);
    [self addChild:powerbar];
    maxpower = powerbar.bar.contentSize.width;
    
    //记录score的label
    coinscore = [CCLabelTTF labelWithString:@"coins:0" fontName:@"AppleGothic" fontSize:12];
    coinscore.anchorPoint = CGPointMake(1, 0.5);
    coinscore.position = ccp(size.width-20, size.height-20);
    [self addChild:coinscore];
    runscore = [CCLabelTTF labelWithString:@"run:0m" fontName:@"AppleGothic" fontSize:12];
    runscore.anchorPoint = CGPointMake(1, 0.5);
    runscore.position = ccp(size.width-20, size.height-40);
    [self addChild:runscore];
    
    //暂停游戏并弹出menu
    CCMenuItemImage *btnmenu = [CCMenuItemImage itemWithNormalImage:@"btnmenu.png" selectedImage:@"btnmenu.png" block:^(id sender) {
//        CCRenderTexture* renderTexture = [CCRenderTexture renderTextureWithWidth:size.width height:size.height];
//        [renderTexture begin];
//        [self visit];
//        [renderTexture end];
//        [renderTexture setPosition:CGPointMake(size.width/2, size.height/2)];
        
        [[CCDirector sharedDirector] pause];
        pauseLayer *pauselayer = [pauseLayer node];
        [self addChild:pauselayer];
        
    }];
    CCMenuItemImage *btnsound = [CCMenuItemImage itemWithNormalImage:@"btnsound.png" selectedImage:@"btnsound.png" block:^(id sender) {
        if (issound) {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            issound = NO;
        }else{
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"mikumusic.caf" loop:YES];
            issound = YES;
        }
    }];
    CCMenu *btnMenu = [CCMenu menuWithItems:btnmenu, btnsound, nil];
    [btnMenu alignItemsHorizontallyWithPadding:10];
    btnMenu.position = CGPointMake(size.width-100,size.height-20);
    //btnMenu.scale = scalefix;
    [self addChild:btnMenu];
}

-(void)update:(ccTime)dt{
    [self updateFloorsAndCoins];
    [self updateMiku];
    [self updateUIandBK];
    
}
-(void)updateFloorsAndCoins{
    //更新地板位置
    for (floorA *floor in floorarray) {
        floor.position = ccp(floor.position.x - forceX*speedfix, floor.position.y);
    }
    for (coins *coin in coinarray) {
        coin.position = ccp(coin.position.x - forceX*speedfix, coin.position.y);
    }
    if ([[floorarray objectAtIndex:0] position].x < -50) {
        int inum = [floorarray count] - 1;
        CGFloat posx = [[floorarray objectAtIndex:inum] position].x;
        //floorA *floor = [floorarray objectAtIndex:0];
        [floorarray addObject:[floorarray objectAtIndex:0]];
        [floorarray removeObjectAtIndex:0];
        [coinarray addObject:[coinarray objectAtIndex:0]];
        [coinarray removeObjectAtIndex:0];
        randomnum = [self getRandomNumber:0 to:2];
        if (randomnum == 0) {
            isfrontblank = YES;
            randomnum = [self getRandomNumber:1 to:5];
        }
        coins *coin = [coinarray objectAtIndex:inum];
        coin.visible = YES;
        if (isfrontblank) {
            [[floorarray objectAtIndex:inum] setPosition:CGPointMake(posx+randomnum*35+35,[self getRandomNumber:100 to:size.height-100])];
            [[coinarray objectAtIndex:inum] setPosition:CGPointMake(posx+randomnum*35+35,[[floorarray objectAtIndex:inum] position].y+[self getRandomNumber:30 to:100])];
            isfrontblank = NO;
        }else{
            [[floorarray objectAtIndex:inum] setPosition:CGPointMake(posx+35,[[floorarray objectAtIndex:inum-1] position].y)];
            [[coinarray objectAtIndex:inum] setPosition:CGPointMake(posx+35,[[floorarray objectAtIndex:inum] position].y+[self getRandomNumber:30 to:100])];
        }
        randomnum = [self getRandomNumber:0 to:2];
        if (randomnum == 0) {
            coin.visible = NO;
        }
        //[[floorarray objectAtIndex:inum] setPosition:CGPointMake(posx+35,size.height/2 - 50)];
    }
}
-(void)updateMiku{
    //更新初音位置
    //    CGPoint point = ccp(miku.position.x, miku.position.y - (forceY+10) * dt);
    //    CGRect rect = CGRectMake(point.x, point.y, miku.contentSize.width, miku.contentSize.height);
    isonfloor = NO;
    int i;
    for (i = 0; i < 4; i++) {
        if ([[floorarray objectAtIndex:i] position].x >= 50-miku.contentSize.width/2-25 && [[floorarray objectAtIndex:i] position].x <= 50+miku.contentSize.width/2+25) {
            CGFloat dis = miku.position.y - [[floorarray objectAtIndex:i] position].y;
            //CGRect rect1 = CGRectMake(25, miku.position.y-miku.contentSize.height/2+5, miku.contentSize.width, 5);
            //CGRect rect2 = CGRectMake([[floorarray objectAtIndex:i] position].x-[[floorarray objectAtIndex:i] contentSize].width/2, [[floorarray objectAtIndex:i] position].y+25, [[floorarray objectAtIndex:i] contentSize].width, 5);
            //if (CGRectIntersectsRect(rect1, rect2) || forceY == 0) {
            if (dis <= distance + forceY * speedfix && dis > distance-5) {
                miku.position = ccp(miku.position.x,distance + [[floorarray objectAtIndex:i] position].y);
                forceY = 0;
                if (isjump) {
                    [miku stopAllActions];
                    [miku runAction:[CCRepeatForever actionWithAction:miku.animeRun]];
                    isjump = NO;
                }
                isonfloor = YES;
                [self updatePower:0.1];
                break;
            }
        }
    }
    if (!isonfloor) {
        miku.position = ccp(miku.position.x, miku.position.y - forceY * speedfix);
        if (miku.position.y < -50) {
            //[[CCDirector sharedDirector] pause];
            [self gameover];
        }
        forceY +=15;
        if (!isjump) {
            [miku stopAllActions];
            [miku runAction:[CCRepeatForever actionWithAction:miku.animeJump]];
            isjump = YES;
        }
        isonfloor = NO;
    }
    //判断是否能吃银币
    CGRect rect1 = miku.boundingBox;
    CGRect rect2 = [[coinarray objectAtIndex:i] boundingBox];
    if (CGRectIntersectsRect(rect1, rect2)) {
        coins *coin = [coinarray objectAtIndex:i];
        if (coin.visible) {
            coin.visible = NO;
            coinnum ++;
            if (issound) {
                [[SimpleAudioEngine sharedEngine] playEffect:@"eatcoin.caf"];
            }
        }
    }
}
-(void)updatePower:(CGFloat)cutwidth{
    //更新初音体力，每次跳跃都会消耗一定体力
    if (powerbar.bar.contentSize.width + cutwidth > 0 && powerbar.bar.contentSize.width + cutwidth < maxpower) {
        powerbar.bar.contentSize = CGSizeMake(powerbar.bar.contentSize.width + cutwidth, powerbar.bar.contentSize.height);
        powerbar.bar.scaleX = (powerbar.bar.contentSize.width + cutwidth)/maxpower;
    }else if(powerbar.bar.contentSize.width + cutwidth >= maxpower){
        powerbar.bar.contentSize = CGSizeMake(maxpower, powerbar.bar.contentSize.height);
        powerbar.bar.scaleX = 1;
    }else{
        powerbar.bar.contentSize = CGSizeMake(0, powerbar.bar.contentSize.height);
        powerbar.bar.scaleX = 0;
    }
}
-(void)updateUIandBK{
    runnumfloat += 0.01;
    if (runnumfloat - runnum >= 1) {
        runnum ++;
    }
    coinscore.string = [NSString stringWithFormat:@"coins:%d",coinnum];
    runscore.string = [NSString stringWithFormat:@"run:%dm",runnum];
    
    bksprite1.position = ccp(bksprite1.position.x - bkmovespeed, bksprite1.position.y);
    if (bksprite1.position.x <= -bksprite1.contentSize.width*2) {
        bksprite1.position = ccp(bksprite2.position.x+bksprite2.contentSize.width*2, bksprite1.position.y);
    }
    bksprite2.position = ccp(bksprite2.position.x - bkmovespeed, bksprite2.position.y);
    if (bksprite2.position.x <= -bksprite2.contentSize.width*2) {
        bksprite2.position = ccp(bksprite1.position.x+bksprite1.contentSize.width*2, bksprite2.position.y);
    }
}

-(void)gameover{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"runnum"]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"runnum"] intValue] < runnum) {
            [[NSUserDefaults standardUserDefaults] setValue:runscore.string forKey:@"runnum"];
        }
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:runscore.string forKey:@"runnum"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"coinnum"]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"coinnum"] intValue] < coinnum) {
            [[NSUserDefaults standardUserDefaults] setValue:coinscore.string forKey:@"coinnum"];
        }
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:coinscore.string forKey:@"coinnum"];
    }
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[gameoverLayer scene] withColor:ccBLACK]];
}

-(int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1)));
}

- (void) dealloc
{
	[super dealloc];
}

@end
