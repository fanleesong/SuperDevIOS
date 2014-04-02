//
//  MenuScene.h
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#ifndef __ZombiesVSPlants__MenuScene__
#define __ZombiesVSPlants__MenuScene__

#include <iostream>
#include "Common.h"

class MenuScene:public CCLayer{

public:
    MenuScene();
    ~MenuScene();
    virtual bool init();
    CREATE_FUNC(MenuScene);
    SCENE_FUNC(MenuScene);
    
public:
    //冒险方法
    void adventureMode();
    void fail();
    void pass();

};



#endif /* defined(__ZombiesVSPlants__MenuScene__) */
