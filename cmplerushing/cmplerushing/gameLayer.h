//
//  gameLayer.h
//  cmplerushing
//
//  Created by admin on 13-6-17.
//
//

#import "cocos2d.h"
#import "mikuRole.h"
#import "floorA.h"
#import "CCGLView.h"
#import "powerBar.h"
#import "coins.h"
#import "SimpleAudioEngine.h"

@interface gameLayer : CCLayer{
    mikuRole *miku;
    //BOOL canjump;
    BOOL isjump;
    CGSize size;
    CGSize sizep;
    CGFloat forceX;
    CGFloat forceY;
    CCArray *floorarray;
    CCArray *coinarray;
    CGFloat scalefix;
    int randomnum;
    BOOL isfrontblank;
    CGFloat distance;
    CGFloat speedfix;
    BOOL isonfloor;
    powerBar *powerbar;
    CGFloat maxpower;
    CCLabelTTF *coinscore;
    CCLabelTTF *runscore;
    int coinnum;
    CGFloat runnumfloat;
    int runnum;
    BOOL issound;
    CCSprite *bksprite1;
    CCSprite *bksprite2;
    CGFloat bkmovespeed;
}

+(CCScene *) scene;

-(void)initCharacter;
-(void)initFloorsAndCoins;
-(void)initUI;
-(void)initBackground;

-(void)updateFloorsAndCoins;
-(void)updateMiku;
-(void)updatePower:(CGFloat)cutwidth;
-(void)updateUIandBK;

-(void)gameover;

-(int)getRandomNumber:(int)from to:(int)to;

@end
