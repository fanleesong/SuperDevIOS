//
//  PassScene.h
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#ifndef __ZombiesVSPlants__PassScene__
#define __ZombiesVSPlants__PassScene__

#include <iostream>
#include "Common.h"

class PassScene:public CCLayer{


public:
    PassScene();
    ~PassScene();
    virtual bool init();
    CREATE_FUNC(PassScene);
    SCENE_FUNC(PassScene);
public:
    void back();
    void next();

};


#endif /* defined(__ZombiesVSPlants__PassScene__) */
