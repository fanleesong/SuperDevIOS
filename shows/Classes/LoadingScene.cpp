//
//  LoadingScene.cpp
//  shows
//
//  Created by 范林松 on 14-3-25.
//
//

#include "LoadingScene.h"
#include "GameScene.h"

LoadingScene::LoadingScene(){


}

LoadingScene::~LoadingScene(){

}

bool LoadingScene::init(){
    
    bool bRet = false;
    do {
        CC_BREAK_IF(!CCLayer::init());
        
        //创建精灵
        CCSprite *bgSprite = CCSprite::create("bg01.png");
        bgSprite->setScaleX(1.5f);
        CCSize screenSize = getScreenSize();//使用自定义的宏
        bgSprite->setPosition(CCPoint(screenSize.width/2,screenSize.height/2));
        this->addChild(bgSprite);
        
        //设置一个正在加载的loading 的标签
        CCLabelTTF *loadLabel = CCLabelTTF::create("加载中..","Arial", 50);
        loadLabel->setPosition(ccp(getScreenSize().width/2-150,getScreenSize().height/2));
        loadLabel->setAnchorPoint(ccp(0, 0.5));//设置锚点
        loadLabel->setTag(100);//设置一个tag值 用于 显示加载时找到该目标
        this->addChild(loadLabel);
        
        bRet = true;
    } while (0);
    
    return bRet;
}


#pragma mark ----------------------timerUpdate---------------------------
/*
 Interval 严格来说 Interval = 0.5 但是 Interval>0.5  Interval表示此次和上次定时器的时间间隔
 */
void LoadingScene::timerUpdate(float interval){
    //通过Tag值  取得 此CCLableTFF
    //getChildByTag 从this中找出tag为100的对象
    CCLabelTTF *label = (CCLabelTTF *) getChildByTag(100);
    const char *str = label->getString();
    char newStr[128];
    sprintf(newStr, "%s.",str);
    if (count++ > 7) {//如果打印的 “.”数大于5，即停止计数
//        CCMoveTo *move = CCMoveTo::create(0.5f,ccp(getScreenSize().width/2-400,getScreenSize().height/2));
//        label->runAction(move);
        unschedule(schedule_selector(LoadingScene::timerUpdate));
        //加载完成后，取消定时器，启动下一动作
        //调用该方法意味着 销毁当前的Layer 切换到下一个场景
        CCDirector::sharedDirector()->replaceScene(GameScene::scene());
        return;
    }
    //sprinf把"%s"，str 打印到 newstr中....
    label->setString(newStr);
    
}

#pragma mark ----------------------onEnter---------------------------
//此方法 Layer界面只要显示就会调用 viewWillAppear
void LoadingScene:: onEnter(){
    CCLayer::onEnter();
    CCLog("function is %s calling",__FUNCTION__);
    
}
void LoadingScene:: onExit(){
    CCLayer::onExit();
    CCLog("function is %s calling",__FUNCTION__);
}

#pragma mark ----------------------onEnterTransitionDidFinish---------------------------
//此方法 界面只要显示完成后就会调用 viewDidAppear
void LoadingScene:: onEnterTransitionDidFinish(){
    //    CCLayer::onEnterTransitionDidFinish();
    //    CCLog("function is %s calling",__FUNCTION__);
    
    //界面显示完成后启用定时器
    //系统有一个轻量的定时器
    //NSTimer在游戏中做不到想要的效果
    //此方法是系统自带的定时器 每隔0.5秒调用一次this，timerUpdate方法
    //timerUpdate是自定义的定时器
    this->schedule(schedule_selector(LoadingScene::timerUpdate),1.0f);
    //    this->schedule(schedule_selector(LoadingLayer::timerUpdate));//1/60秒后启动
    
}
