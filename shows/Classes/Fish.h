//
//  Fish.h
//  shows
//
//  Created by 范林松 on 14-3-23.
//
//

#ifndef __shows__Fish__
#define __shows__Fish__

#include <iostream>
#include "Header.h"


//class Fish:public CCSprite{
class Fish:public CCSprite{
    
public:
    bool isCatched;//是否被抓
    CCSpeed *path;//速度
    int fishLevel;//鱼的类别
//    CCSpriteBatchNode *fishSheets;
//    CCSprite *m_sprite;
    CREATE_FUNC(Fish);
//    virtual bool init();
public:
    void removeFish(CCSprite *sprites);
    void addPath();
    void run();//
    //使用贝塞尔曲线创建鱼游动的路径
    void moveWithBezier(CCNode *mySprite,CCPoint startPoint,CCPoint endPoint,CCPoint controlPoint,float startAngle,float endAngle,float dirTime);
    bool randomCatch(int bowLevel);

    
};



#endif /* defined(__shows__Fish__) */
