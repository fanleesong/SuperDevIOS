//
//  FailScene.h
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#ifndef __ZombiesVSPlants__FailScene__
#define __ZombiesVSPlants__FailScene__

#include <iostream>
#include "Common.h"

class FailScene:public CCLayer{

public:
    FailScene();
    ~FailScene();
    virtual bool init();
    CREATE_FUNC(FailScene);
    SCENE_FUNC(FailScene);
    
public:
    
    void exit();
    void back();
    


};

#endif /* defined(__ZombiesVSPlants__FailScene__) */
