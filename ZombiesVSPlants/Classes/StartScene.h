//
//  StartScene.h
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#ifndef __ZombiesVSPlants__StartScene__
#define __ZombiesVSPlants__StartScene__

#include <iostream>
#include "Common.h"

class StartScene:public CCLayer{
    
public:
    bool isStart;
    CCMenuItemFont *fontLoad;
    
public:
    StartScene();
    ~StartScene();
    virtual bool init();
    CREATE_FUNC(StartScene);
    SCENE_FUNC(StartScene);
    
private:
    void addStartMenu();
    void replaceScene();
    void removeSpriteFromScene(CCSprite *pSprite);
};














#endif /* defined(__ZombiesVSPlants__StartScene__) */
