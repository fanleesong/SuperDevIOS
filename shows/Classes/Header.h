//
//  Header.h
//  shows
//
//  Created by 范林松 on 14-3-23.
//
//

#ifndef shows_Header_h
#define shows_Header_h

#define WINSIZE_BYDIRECT CCDirector::sharedDirector()->getWinSize()

#include "cocos2d.h"
using namespace cocos2d;

#define getScreenSize() CCDirector::sharedDirector()->getWinSize()
#define ccz CCPoint(0,0)


//宏定义初始化场景时判断CCLayer初始化场景是否成功
#define CCLAYER_INIT()\
if (!CCLayer::init()) {\
return false;\
}




#define SCENE_FUNC(__TYPE__)\
static cocos2d::CCScene *scene(){\
__TYPE__ *sl = __TYPE__::create();\
cocos2d::CCScene *scene = cocos2d::CCScene ::create();\
scene->addChild(sl);\
return scene;\
}



#endif
