//
//  powerBar.m
//  cmplerushing
//
//  Created by admin on 13-7-17.
//
//

#import "powerBar.h"

@implementation powerBar

@synthesize bar;

+(id)initPowerBar{
    powerBar *powerbar = [powerBar node];
    
    CCTexture2D *bartexture =[[CCTextureCache sharedTextureCache] addImage: @"powerbar.png"];
    powerbar.bar = [CCSprite spriteWithTexture:bartexture];
    powerbar.bar.anchorPoint = CGPointMake(0, 0.5);
    powerbar.bar.position = ccp(powerbar.bar.position.x-powerbar.bar.contentSize.width/2, 0);
    
    CCTexture2D *uitexture =[[CCTextureCache sharedTextureCache] addImage: @"powerui.png"];
    CCSprite *ui = [CCSprite spriteWithTexture:uitexture];
    
    [powerbar addChild:ui];
    [powerbar addChild:powerbar.bar];
    
    return powerbar;
}

//- (void) draw
//{
//    CGPoint vertices[] = { ccp(0, 0), ccp(rightX, 0), ccp(rightX, frameHeight), ccp(0, frameHeight) };
//    
//    glEnable(GL_LINE_SMOOTH);
//    
//    // draw filled rectangle with black
//    glColor4ub(0, 0, 0, 255);
//    glVertexPointer(2, GL_FLOAT, 0, vertices);
//    glEnableClientState(GL_VERTEX_ARRAY);
//    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);  // notice: the first parameter is important
//    glDisableClientState(GL_VERTEX_ARRAY);
//    
//    // draw a non-filled rectangle, use cocos2d function: drawPoly
//    glColor4ub(255, 0, 0, 255);
//    glLineWidth(1);
//    drawPoly(vertices, 4, YES);
//}

@end
