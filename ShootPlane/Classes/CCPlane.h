//
//  CCPlane.h
//  ShootPlane
//
//  Created by 范林松 on 14-3-10.
//
//

#ifndef __ShootPlane__CCPlane__
#define __ShootPlane__CCPlane__

#include <iostream>
#include "commonHeader.h"
//创建飞机类
class CCPlane:public cocos2d:: CCSprite {
    
public:
    //声明一个飞机类型、飞机速度、飞机编号...
    int planeType, hp, speed,__id;
    
public:
    CCPlane();//构造函数
    ~CCPlane();//析构函数
    //创建缓存精灵帧
    static CCPlane *createWithSpriteFrameName(const char *pszSpriteFrameName);
};

#endif /* defined(__ShootPlane__CCPlane__) */
