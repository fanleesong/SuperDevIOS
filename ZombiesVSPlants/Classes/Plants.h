//
//  Plants.h
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#ifndef __ZombiesVSPlants__Plants__
#define __ZombiesVSPlants__Plants__

#include <iostream>

#include "Common.h"
//定义宏  伤害系数（攻击力*伤害系数 = 血量减少）
#define kAttackForceRatio 1

//定义各种类型的植物
typedef enum {
    
    Sunflower = 0,//向日葵
    SmallPea ,//小豌豆
    MidllePea ,//中等豌豆
    ThreeBulletPea, //三发豌豆
    Pumpkin,//南瓜
    Paprika,//辣椒
    Cherry,//樱桃
    SmallNut,//小坚果
    largeNut,//大坚果
    Lilypad,//荷叶
    CorpseFlower,//食人花
    
}PlantsName;

//植物的各种技能
typedef enum {
    
    BulletSkill = 0,//子弹
    BombSkill,//爆炸
    SwallowSkill,//吞噬
    CollapseSkill,//压塌
    SankSkill,//下沉
    ChimeaSkill,//喷火（辣椒的技能）
    ObstructSkill,//阻挡(坚果)
    GraftingSkill,//可以做嫁接的载体（荷叶）
    SunshineShill,//产生太阳
    
}SpecialSkill;

//场景植物种类
typedef enum {
    
    Aquatic = 0,//水生植物
    LandMammals,//陆地植物
    
}PlacePlantsType;

//植物生长的时间
typedef enum {
    
    Day = 0,
    Night,
    
}TimePlantsType;


//创建植物类
class Plants :public CCSprite {
    
    
public:
    //声明变量
    PlacePlantsType placeType;
    TimePlantsType timeType;
    SpecialSkill specialSkill;
    PlantsName plantsName;
    
    CCArray *addZombieAttackThisPlant;//存放攻击这个植物的僵尸
    float attackForce;//攻击力
    float lifeForce;//生命力
    int attackFrequency;//攻击频率
    
    bool needWait;//是否处于冷却状态
    int plantInterval;//种植时间间隔（技能冷却时间）
    int tempPlantInterval;//(备份)
    int needSunshine;//需要的阳光值
    
    int createSunInterval;//产生阳关的间隔
    int tempCreateSunInterval;//temp（备份）
    
    int createPeaInterval;//创建豌豆子弹的间隔时间
    int tempCreatePeaInterval;//备份豌豆产生子弹的间隔时间
    
    bool canAttack;//是否能攻击
    
    
public:
    
    //一些方法的声明
    Plants(PlantsName name);//在构造函数中进行初始化植物名称
    ~Plants();//析构函数
    
    /**************基本植物******************/
    void createPlantByName(char *name);//创建植物根据植物名称
    void runRepeatAction(CCArray *plistArray);//重复动作（永久动作）
    void runOnceAction(CCArray *plistArray);//非永久性动作
    
    /***************辣椒、樱桃、坚果*****************/
    
    void paprikaCherryAction();//辣椒和樱桃的动作（爆炸动作）
    void removePlants();//移除植物
    void smallNutActionEatOverByZombie();//小坚果动作(被吃受损动作)
    void smallNutActionEatOverMoreHarm();//受损更严重
    void largeNutActionEatOvetByZombie();//大坚果动作(被吃受损动作)
    void largeNutActionEatOverMoreharm();//受损更严重
    
    /**************食人花******************/
    
    void corpseFlowerAction1();//食人花动作1
    void corpseFlowerAction2();//食人花动作2
    void corpseFlowerAction3();//食人花动作3
    
    /**************南瓜动作******************/
    void pumpKinAction(CCSprite *pumpKin,CCPoint point);//南瓜动作
    void pumpKinMoveAction(CCNode *sender,CCSprite *pumpKin);//移除南瓜
    
};


#endif /* defined(__ZombiesVSPlants__Plants__) */
