//
//  CCPlane.cpp
//  ShootPlane
//
//  Created by 范林松 on 14-3-10.
//
//

#include "CCPlane.h"
//实现析构函数和构造函数
CCPlane::CCPlane():planeType(0), hp(0), speed(0),__id(0){


}
//实现析构函数
CCPlane::~CCPlane(){

    CCLOG("%s",__FUNCTION__);
    
}
//初始化精灵帧
CCPlane *CCPlane::createWithSpriteFrameName(const char *pszSpriteFrameName){

    //实例化一个精灵对象
    CCPlane *pSprite = new CCPlane;
    
    //判断精灵是否存在，并初始化精灵帧
    if (pSprite && pSprite->initWithSpriteFrameName(pszSpriteFrameName)) {
        pSprite->autorelease();
        return pSprite;
    }
    //安全删除
    CC_SAFE_DELETE(pSprite);
    
    return NULL;
    
}