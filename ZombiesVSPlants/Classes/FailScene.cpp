//
//  FailScene.cpp
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#include "FailScene.h"
#include "MenuScene.h"
using namespace std;

extern int LEVEL;

FailScene::FailScene(){



}
FailScene::~FailScene(){


}
bool FailScene::init(){

    INIT_CCLAYER;

    //获取屏幕尺寸
    CCSize size = GET_WINDOWSIZE;
    //添加失败图片
    CCSprite *pSprite = CCSprite::create("failscene.png");
//    pSprite->setv
//    pSprite->setScale(2);
    pSprite->setScaleX(2.4f);
    pSprite->setScaleY(2.1f);
    pSprite->setPosition(ccp(size.width/2, size.height/2));
    this->addChild(pSprite);
    
    //返回主菜单
    CCLabelTTF* label11 = CCLabelTTF::create("返回主菜单", "Georgia-BoldItalic", 60);
    CCMenuItemLabel* label1 = CCMenuItemLabel::create(label11);
    label1->setColor(ccc3(0, 0, 255));
    label1->setTarget(this, menu_selector(FailScene::back));
    //退出游戏
    CCLabelTTF* label12 = CCLabelTTF::create("退出游戏", "Georgia-BoldItalic", 60);
    CCMenuItemLabel* label2 = CCMenuItemLabel::create(label12);
    label2->setColor(ccc3(255, 0, 0));
    label2->setTarget(this, menu_selector(FailScene::exit));
    //添加返回主菜单/退出
    CCMenu* menu = CCMenu::create(label1,label2,NULL);
    menu->setPosition(ccp(size.width/2,size.height/2));
    menu->alignItemsHorizontally();
    menu->alignItemsHorizontallyWithPadding(50);
    this->addChild(menu);
    

    return true;
}
void FailScene::exit(){

    CCDirector::sharedDirector()->end();
    
}
void FailScene::back(){

    CCTransitionCrossFade *fade = CCTransitionCrossFade::create(0.2f,MenuScene::scene());
    CCDirector::sharedDirector()->replaceScene(fade);
    LEVEL = 1;//通关数归1
    
}

