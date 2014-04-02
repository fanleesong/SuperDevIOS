//
//  SystemScene.cpp
//  shows
//
//  Created by 范林松 on 14-3-23.
//
//

#include "SystemScene.h"
#include "GameScene.h"
#include "LoadingScene.h"

CCScene * SystemScene::scene(){

    CCScene *scene;
    do {
        scene = CCScene::create();
        CC_BREAK_IF(!scene);
        
        SystemScene *layer = SystemScene::create();
        CC_BREAK_IF(!layer);
        
        scene->addChild(layer);
    } while (0);
    
    return scene;

}

SystemScene ::SystemScene(){

}
SystemScene::~SystemScene(){


}
bool SystemScene::init(){

    if (!CCLayer::init()) {
        return false;
    }
    
    CCSize winSize = WINSIZE_BYDIRECT;
    
    //放置图片
    CCSprite *bgSprite = CCSprite::create("loading2.png");
    bgSprite->setScaleX(1.2f);
    bgSprite->setPosition(CCPoint(winSize.width/2, winSize.height/2));//设置图片位置-->图片的中心点位置
    this->addChild(bgSprite);//在场景中加载图片子类
    //菜单
    //clickSingle
    CCMenuItemImage *oneImage = CCMenuItemImage::create("one.png","one_select.png",this,menu_selector(SystemScene::clickSingle));
    oneImage->setPosition(CCPointMake(-270, -130));
    CCMenuItemImage *multiImage = CCMenuItemImage::create("mutil.png","mutil_select.png",this,menu_selector(SystemScene::clickMutil));
    multiImage->setPosition(CCPointMake(285, -120));
    CCMenuItemImage *updateImage = CCMenuItemImage::create("update_call.png","update_call.png",this,menu_selector(SystemScene::clickUpdate));
    updateImage->setScale(0.7f);
    updateImage->setPosition(CCPointMake(80, -230));
    CCMenu *menu = CCMenu ::create(oneImage,multiImage,updateImage,NULL);
    this->addChild(menu);

    
    //添加菜单
//    CCMenuItemFont *start = CCMenuItemFont::create("开始游戏", this,menu_selector(SystemScene::startGame));
//    CCMenuItemFont *setting = CCMenuItemFont::create("设置游戏", this,menu_selector(SystemScene::setGame));
//
//    CCMenu *menus = CCMenu::create(start,setting,NULL);
//    menus->alignItemsVertically();//排列方式
//    menus->alignItemsVerticallyWithPadding(18.0f);
//    this->addChild(menus);

    return true;
}
void SystemScene::clickMutil(CCObject *sender){
    
    CCLog("%s",__FUNCTION__);

}
void SystemScene::clickSingle(CCObject *sender){
    
    //点击该方法是 会切换到 LoadingLayer
    CCScene *sin = LoadingScene::scene();
    //使用动画切换场景--2s钟后 切换到新的LoadingLayer场景
    CCTransitionSplitRows *trans = CCTransitionSplitRows::create(2, sin);
    
    //调用该方法意味着 销毁当前的Layer 切换到下一个场景
    CCDirector::sharedDirector()->replaceScene(trans);


}
void SystemScene::clickUpdate(CCObject *sender){

    CCLog("%s",__FUNCTION__);
    
}
/*
void SystemScene::startGame(){
//    CCLog("%s",__FUNCTION__);
    //切换场景
//    CCTransitionFadeBL *fadeBl = CCTransitionFadeBL::create(0.2f, GameScene::scene());
//    CCTransitionPageTurn *page = CCTransitionPageTurn::create(0.2f, GameScene::scene(), false);
     CCTransitionFade *page = CCTransitionFade::create(0.5f, GameScene::scene());
    CCDirector::sharedDirector()->replaceScene(page);

}
void SystemScene:: setGame(){
    CCLog("%s",__FUNCTION__);    
}
*/





