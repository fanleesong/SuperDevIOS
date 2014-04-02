//
//  PassScene.cpp
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#include "PassScene.h"
#include "MenuScene.h"
#include "GameScene.h"
using namespace std;


extern int LEVEL;
extern int SunNumber;


PassScene::PassScene(){


}
PassScene::~PassScene(){


}

bool PassScene::init(){

    INIT_CCLAYER;
    
    //获得屏幕尺寸
    CCSize size = GET_WINDOWSIZE;
    //如果本关通过
    if (LEVEL == 4) {
        //创建场景
        CCSprite *pSprite = CCSprite::create("trophy.png");
        pSprite->setScale(2.0f);
        pSprite->setPosition(ccp(size.width/2,size.height/2));
        this->addChild(pSprite);
        
        //创建说明菜单Label
        CCMenuItemFont *font = CCMenuItemFont::create("返回主菜单");
        font->setTarget(this,menu_selector(PassScene::back));
        font->setColor(ccc3(0,0,255));
        //添加如Label
        CCMenu *menu = CCMenu::create(font,NULL);
        menu->setPosition(ccp(size.width/2,size.height/2-100));
        this->addChild(menu);
        
    }else{
    
        //成功图片
        CCSprite *sprite = CCSprite::create("success.jpg");
        sprite->setScaleX(1.5f);
        sprite->setScaleY(1.1);
        sprite->setPosition(ccp(size.width/2,size.height/2));
        this->addChild(sprite,0);
        
        //返回主菜单
        CCLabelTTF *label11 = CCLabelTTF::create("返回主菜单", "Georgia-BoldItalic", 60);
        CCMenuItemLabel *label1 = CCMenuItemLabel::create(label11);
        label1->setColor(ccc3(0,0,255));
        label1->setPosition(ccp(size.width/2-280,size.height/2));
        label1->setTarget(this,menu_selector(PassScene::back));
        
        //进入下一关
        CCLabelTTF *label12 = CCLabelTTF::create("进入下一关", "Georgia-BoldItalic", 60);
        CCMenuItemLabel *label2 = CCMenuItemLabel::create(label12);
        label2->setColor(ccc3(255, 0, 0));
        label2->setPosition(ccp(size.width/2+280,size.height/2));
        label2->setTarget(this,menu_selector(PassScene::next));
        
        //加入
        CCMenu *menu = CCMenu::create(label1,label2,NULL);
        menu->setPosition(CCPointZero);
        this->addChild(menu);
        
    }
    
    CCLabelTTF *label = CCLabelTTF::create("植物大战僵尸", "Georgia-BoldItalic", 46);
    label->setPosition(ccp(size.width/2,size.height/2+280));
    this->addChild(label);
    

    
    
    return true;
}
void PassScene::back(){

    CCTransitionCrossFade *fade = CCTransitionCrossFade::create(0.2f,MenuScene::scene());
    CCDirector::sharedDirector()->replaceScene(fade);
    LEVEL = 1;//通关数归1

}
void PassScene::next(){

    LEVEL++;//如果通关level++
    SunNumber = 50;
    CCTransitionCrossFade *fade = CCTransitionCrossFade::create(1.0f,GameScene::scene());
    CCDirector::sharedDirector()->replaceScene(fade);

}
