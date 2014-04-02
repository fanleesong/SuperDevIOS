//
//  Zombies.h
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#ifndef __ZombiesVSPlants__Zombies__
#define __ZombiesVSPlants__Zombies__

#include <iostream>
#include "Common.h"


#define LIFEVALUE 10;
typedef enum
{
    Zombie=0,//正常僵尸
    BucketheadZombie,//头上戴水桶的僵尸
    ConeheadZombie,//头上戴路障牌的僵尸
    FlagZombie,//手拿红旗的僵尸
    PoleVaultingZombie,//手拿撑杆的僵尸
    PoleVaultingZombieWalk,
}ZombieType;
class Zombies:public CCSprite{
    
public:
    ZombieType zombieType;
    double blood;//血量
    char plistStr[50];//加载的纹理图册的名字
    char attackStr[50];//不同类型攻击纹理图册
    char dieStr[50];//加载死亡的纹理图集名字
    Zombies(ZombieType zombieType);//构造函数
    void runZombieAction(char* plist);//僵尸正常行走的action
    void loadSpriteFrameFiles();  //预先加载纹理图集
    void changeIsJump();
    void unPoleVaultingZombieRun();
    
    bool isAttack;
    bool isJump;
    void runAttackAction();//运行攻击的方法
    void runDieAction();//死亡
    //    void reduceBlood();  //减少血量
    void startMove();  //开始移动
    void remove();
    void runBoomDie();//被炸死
    void continueMove();
    void Jump();//僵尸跳过植物
    void Jump2();//僵尸跳过植物
    
public:
//    CCSpriteBatchNode *zombieSheet;//僵尸
    
};


#endif /* defined(__ZombiesVSPlants__Zombies__) */
