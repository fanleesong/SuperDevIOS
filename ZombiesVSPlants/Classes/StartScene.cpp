//
//  StartScene.cpp
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#include "StartScene.h"
#include "MenuScene.h"


StartScene::StartScene():isStart(false){

}

StartScene::~StartScene(){



}
bool StartScene::init(){
    
    bool bRet = false;
    do {
        CC_BREAK_IF(!CCLayer::init());
    
        CCSize winSize = GET_WINDOWSIZE;
        //加载开始场景的背景
        CCSprite *bgSprite = CCSprite::create("titlescreen.png");
        bgSprite->setScaleX(2.5f);
        bgSprite->setScaleY(2.0f);
        bgSprite->setPosition(ccp(winSize.width/2,winSize.height/2));
        this->addChild(bgSprite,0);
        
        //添加Logo
        CCSprite *logoSprite = CCSprite::create("pvz_logo.png");
        logoSprite->setScale(2.0f);
        logoSprite->setPosition(ccp(winSize.width/2-90,winSize.height/2+230));
        this->addChild(logoSprite);
        //logo2
        CCSprite *circleSprite = CCSprite::create("popcap.png");
        circleSprite->setPosition(ccp(winSize.width/2+300,winSize.height/2+230));
        this->addChild(circleSprite,0);
        //添加
        CCSprite *downSprite = CCSprite::create("down.png");
        downSprite->setScale(2.0f);
        downSprite->setPosition(ccp(winSize.width/2,winSize.height/2-150));
        this->addChild(downSprite,0);
        //添加草坪
        CCSprite *grassSprite = CCSprite::create("scrollgrass.png");
        grassSprite->setScale(2.0f);
        grassSprite->setPosition(ccp(winSize.width/2-250,winSize.height/2-50));
        CCRotateBy *rotate = CCRotateBy::create(4.0f,360);
        CCScaleBy *scaleBy = CCScaleBy::create(4.0f,0.4);
        CCMoveTo *moveTo = CCMoveTo::create(4.0f,ccp(winSize.width/2+270,winSize.height/2-30));
        CCSpawn *spawn = CCSpawn::create(rotate,scaleBy,moveTo,NULL);
        CCCallFuncO *func0 = CCCallFuncO::create(this, callfuncO_selector(StartScene::removeSpriteFromScene), grassSprite);
        CCSequence *sequence = CCSequence::create(spawn,func0,NULL);
        grassSprite->runAction(sequence);
        this->addChild(grassSprite);
        //添加全景草坪
        CCSprite *groudSprite = CCSprite::create("grass.png");
        //创建一个时间进度出现的动画
        CCProgressTimer *progress = CCProgressTimer::create(groudSprite);
        progress->setPosition(ccp(winSize.width/2-10,winSize.height/2-90));
        progress->setScale(2.0f);
        //设置进度条的样式
        progress->setType(kCCProgressTimerTypeBar);
        //7秒钟由0变为100
        CCProgressFromTo *progressTo = CCProgressFromTo::create(4,0,100);
        progress->setMidpoint(CCPointZero);
        progress->runAction(progressTo);
        this->addChild(progress);
        
        //添加开始按钮
        fontLoad = CCMenuItemFont::create("Loading...", this, menu_selector(StartScene::replaceScene));
        fontLoad->setFontSize(50);
        fontLoad->setColor(ccc3(255, 0, 0));
        fontLoad->setPosition(ccp(winSize.width/2,winSize.height/2-150));
        CCMenu *menu = CCMenu::create(fontLoad,NULL);
        menu->setPosition(CCPointZero);
        this->addChild(menu);
        //创建回调函数
        CCCallFunc *fun1 = CCCallFunc::create(this, callfunc_selector(StartScene::addStartMenu));
        //设置延迟5秒后执行func1
        CCSequence *menuSequence = CCSequence::create(CCDelayTime::create(4.3),fun1,NULL);
        this->runAction(menuSequence);
        
        bRet = true;
    } while (0);
    return bRet;
}
//添加考试菜单
void StartScene::addStartMenu(){

    isStart = true;
    //创建文字
    CCString *string = CCString::create("Start Game");
    fontLoad->setString(string->getCString());

}
//切换场景
void StartScene::replaceScene(){
    
    if (isStart == true) {
        CCTransitionCrossFade *fadeScene = CCTransitionCrossFade::create(0.2f,MenuScene::scene());
        CCDirector::sharedDirector()->replaceScene(fadeScene);
    }
    
}
//移除旋转草坪
void StartScene::removeSpriteFromScene(CCSprite *pSprite){
    pSprite->removeFromParentAndCleanup(true);
}







