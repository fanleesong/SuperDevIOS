//
//  commonHeader.h
//  ShootPlane
//
//  Created by 范林松 on 14-3-10.
//
//

#ifndef ShootPlane_commonHeader_h
#define ShootPlane_commonHeader_h

#include "cocos2d.h"

using namespace cocos2d;

#define SCENE_FUNC(__TYPE__)\
   static CCScene* scene(){\
        cocos2d:: CCScene *sl = cocos2d::CCScene::create();\
        __TYPE__ *layer = __TYPE__::create();\
        sl->addChild(layer);\
        return sl;\
    }

#define kCCLAYER_IS_INIT\
    if ( !CCLayer::init() ){\
        return false;\
    }


#endif
