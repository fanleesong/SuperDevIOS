//
//  LoadingScene.h
//  shows
//
//  Created by 范林松 on 14-3-25.
//
//

#ifndef __shows__LoadingScene__
#define __shows__LoadingScene__

#include <iostream>
#include "Header.h"
class LoadingScene:public CCLayer{
    
private:
    //定义一个计数器，限制打印次数
    int count;
    void timerUpdate(float interval);

public:
    LoadingScene();
    ~LoadingScene();
    
    virtual bool init();
    CREATE_FUNC(LoadingScene);
    SCENE_FUNC(LoadingScene);
    
    //表示进入的时候
    virtual void onEnter();
    virtual void onExit();
    virtual void onEnterTransitionDidFinish();

};


#endif /* defined(__shows__LoadingScene__) */
