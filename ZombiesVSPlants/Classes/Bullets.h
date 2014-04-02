//
//  Bullets.h
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#ifndef __ZombiesVSPlants__Bullets__
#define __ZombiesVSPlants__Bullets__

#include <iostream>
#include "Common.h"
#include "Plants.h"
#define BulletSpeedRatio 200 //子弹速度（时间=距离/子弹速度）

class Bullet:public CCSprite {
    
public:
    
    Plants *plants;
    CCPoint position;
    
public:
    
    //子弹所属植物和位置
    //构造函数
    Bullet(Plants *aplants,CCPoint point,CCLayer *layer);
    ~Bullet();
    void creatSunflowerBullet(CCPoint point,CCLayer *layer);
    void creatPeaBullet(CCPoint point,CCLayer *layer);
    void creatPeaBulletOfMid(CCNode *sender,CCLayer *layer);//双豌豆调用
    void creatPeaBulletOfThree(CCNode *sender,CCLayer *layer);
    
    void collectSunshine(CCNode *sender);
    void moveSunshine(CCNode *sender,CCMenu *menu);
    
};



#endif /* defined(__ZombiesVSPlants__Bullets__) */
