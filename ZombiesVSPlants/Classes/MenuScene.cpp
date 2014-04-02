//
//  MenuScene.cpp
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#include "MenuScene.h"
#include "GameScene.h"
#include "PassScene.h"
#include "FailScene.h"

MenuScene::MenuScene(){


}
MenuScene::~MenuScene(){


}
bool MenuScene::init(){
    
    INIT_CCLAYER;
    
    //获取设备尺寸
    CCSize size = CCDirector::sharedDirector()->getWinSize();
    //添加场景
    CCSprite* pSprite = CCSprite::create("main_background.png");
//    pSprite->setScale(2.0f);
    pSprite->setScaleX(2.4f);
    pSprite->setScaleY(2.0f);
    pSprite->setPosition( ccp(size.width/2, size.height/2) );
    this->addChild(pSprite, 0);
    
    //创建成就图片
    CCMenuItemImage *sucessImage = CCMenuItemImage::create("chengjiu.png", "chengjiu1.png");
    sucessImage->setScale(1.5f);
    sucessImage->setPosition(ccp(size.width/2-80,size.height/2-100));
    
    //创建点击图片按钮-并添加点击事件
    CCMenuItemImage *imageBtn1 = CCMenuItemImage::create("select10.png","select11.png");
    imageBtn1->setScale(2.0f);
    imageBtn1->setTarget(this, menu_selector(MenuScene::adventureMode));
    imageBtn1->setPosition(ccp(size.width/2+230,size.height/2+200));
    
    //
    CCMenuItemImage *imageBtn2 = CCMenuItemImage::create("select20.png", "select21.png");
    imageBtn2->setScale(2.0f);
#warning mark--
    imageBtn2->setTarget(this, menu_selector(MenuScene::fail));
    imageBtn2->setPosition(ccp(size.width/2+230,size.height/2+90));
    
    CCMenuItemImage* imageBtn3 = CCMenuItemImage::create("select30.png", "select31.png");
    imageBtn3->setScale(2.0f);
#warning mark--
    imageBtn3->setTarget(this,menu_selector(MenuScene::pass));
    imageBtn3->setPosition(ccp(size.width/2+230,size.height/2));
    
    
    CCMenuItemImage* imageBtn4 = CCMenuItemImage::create("select40.png", "select41.png");
    imageBtn4->setScale(2.0f);
    imageBtn4->setPosition(ccp(size.width/2+220,size.height/2-90));
    
    CCMenuItemImage* imageBtn5 = CCMenuItemImage::create("SelectorScreen_Almanac.png", "SelectorScreen_AlmanacHighlight.png");
    imageBtn5->setScale(1.5f);
    imageBtn5->setPosition(ccp(size.width/2+70,size.height/2-160));
    
    CCMenuItemImage* imageBtn6 = CCMenuItemImage::create("shop0.png", "shop1.png");
    imageBtn6->setScale(1.5f);
    imageBtn6->setPosition(ccp(size.width/2+370,size.height/2-150));
    
    CCMenu* menu = CCMenu::create(sucessImage, imageBtn1, imageBtn2, imageBtn3, imageBtn4, imageBtn5, imageBtn6, NULL);
    menu->setPosition(CCPointZero);
    this->addChild(menu);

    return true;
}
//切换场景
void MenuScene::adventureMode(){
    
    CCTransitionCrossFade *fade = CCTransitionCrossFade::create(0.2f,GameScene::scene());
    CCDirector::sharedDirector()->replaceScene(fade);
    

}

void MenuScene::fail(){

    CCTransitionCrossFade *fade = CCTransitionCrossFade::create(0.2f,FailScene::scene());
    CCDirector::sharedDirector()->replaceScene(fade);

}
void MenuScene::pass(){

    CCTransitionCrossFade *fade = CCTransitionCrossFade::create(0.2f,PassScene::scene());
    CCDirector::sharedDirector()->replaceScene(fade);


}