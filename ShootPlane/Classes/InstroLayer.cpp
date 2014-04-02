//
//  InstroLayer.cpp
//  ShootPlane
//
//  Created by 范林松 on 14-3-11.
//
//

#include "InstroLayer.h"
#include "HelloWorldScene.h"
IntroLayer::IntroLayer(){



}
IntroLayer ::~IntroLayer(){


}
//加载背景
void IntroLayer ::loadBackground(){
    
    //设置背景1属性并添加到视图上
    this->background1 = CCSprite::createWithSpriteFrameName("background_2.png");
    this->background1->setAnchorPoint(ccp(0.5, 0));
    this->background1->setPosition(ccp(160, adjustmentBg));
    this->addChild(background1,0);
    //设置背景2
    this->backgroudd2 = CCSprite::createWithSpriteFrameName("background_2.png");
    this->backgroudd2->setAnchorPoint(ccp(0.5,0));
    this->backgroudd2->setPosition(ccp(160,568 + adjustmentBg));
    this->addChild(backgroudd2,0);
    
    
}
//背景轮换滚动
void IntroLayer::backgroundScrollRelpace(){
    
    adjustmentBg--;
    
    if (adjustmentBg <= 0) {
        adjustmentBg = 568;
    }
    background1->setPosition(ccp(160,adjustmentBg));
    backgroudd2->setPosition(ccp(160, adjustmentBg - 568));
    
    
}
//更新
void IntroLayer::update(float delate){

    //调用背景更换
    this->backgroundScrollRelpace();

}

bool IntroLayer::init(){

    kCCLAYER_IS_INIT;
    //加载贴图缓存
    CCTexture2D *texture = CCTextureCache::sharedTextureCache()->textureForKey("gameArts.png");
    //加载批量帧
    CCSpriteBatchNode *spriteBatch = CCSpriteBatchNode::createWithTexture(texture);
    this->addChild(spriteBatch);
    //调用加载视图方法
    this->loadBackground();
    this->scheduleUpdate();//调用定时器更新

    return true;
}
void IntroLayer::onEnter(){

    //实例化helloWorld场景
    CCScene *pScene = HelloWorld::scene();
    //创建切换场景模式
    CCTransitionFade *transitionScene = CCTransitionFade::create(1.0,pScene,ccWHITE);
    //切换场景
    CCDirector::sharedDirector()->replaceScene(transitionScene);
    
}



