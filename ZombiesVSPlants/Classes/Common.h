//
//  Common.h
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#ifndef ZombiesVSPlants_Common_h
#define ZombiesVSPlants_Common_h

#include "cocos2d.h"
#include "cocos-ext.h"
#include "SimpleAudioEngine.h"

using namespace cocos2d;
using namespace std;
using namespace CocosDenshion;

USING_NS_CC;
USING_NS_CC_EXT;

//初始化场景
#define SCENE_FUNC(__TYPE__)\
    static cocos2d::CCScene *scene(){\
        __TYPE__ *sl = __TYPE__::create();\
        cocos2d::CCScene *scene = cocos2d::CCScene ::create();\
        scene->addChild(sl);\
        return scene;\
    }

//获得场景尺寸
#define GET_WINDOWSIZE CCDirector::sharedDirector()->getWinSize()

//初始化场景
#define INIT_CCLAYER \
    if ( !CCLayer::init() ){\
        return false;\
    }



#endif
