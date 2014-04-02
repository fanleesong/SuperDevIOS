//
//  GameScene.h
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#ifndef __ZombiesVSPlants__GameScene__
#define __ZombiesVSPlants__GameScene__

#include <iostream>
#include "Common.h"
#include "Plants.h"
#include "Zombies.h"


#define CHERRY 101
#define CHOMPER 102
#define JALAPENO 103
#define LILYPAD 104
#define PEASHOOTER 105
#define REPEATER 106
#define SQUASH 107
#define SUNFLOWER 108
#define TALLNUA 109
#define THREEPEATER 110
#define WALLNUA 111


class GameScene:public CCLayer{

public:
    GameScene();
    ~GameScene();
    virtual bool init();
    CREATE_FUNC(GameScene);
    SCENE_FUNC(GameScene);
public:
    void moveScenePosition();
//    void sunAction();
    void plantsMenu(CCNode* object);
    CCMenuItemToggle* createMenuItem(const char* plantName,const char* plantName2, int tag);
    CCMenuItemToggle* createMenuItem1(const char* plantName,const char* plantName2, int tag);
    void resetBarMenu();
    void beSure();//菜单确认按钮
    void addMenu();//添加菜单
    void plantingPlant(CCNode* plant);//种植植物
    CCPoint getPositionMessage(CCPoint point);
    void initFlag();//初始化flag；
    int getFlag(CCPoint point);
    void setFlagValue(CCPoint point);//设置植物种植位置的标志
    void setFlagValue1(CCPoint point);
    void createSunshine();//创建阳光
    void createShoote();//创建子弹
    void removeSprite(CCSprite* sprite);
    void addZombie();//添加僵尸
    void checkHitWithBulletAndPlant();//检测子弹与僵尸的碰撞
    void setSunNumberLB();
    void createSunshineWithoutSunflower();//非向日葵产生的阳光
    void LevelBar();//初始化关卡进度条
    void setLevelBar();//设置关卡进度条
    void appearZombie();//根据timer控制僵尸出现的数量
    void appearZombie1();
    void appearZombie2();
    void pass();//过关
    void judgeCoolTime();//判断植物的冷却时间
    void reduceCoolTime();//每秒钟减少一次冷却时间
    void checkHitOtherPlantsAndZombie();//检测其他植物（辣椒，食人花等），与僵尸的碰撞
    void zombieBoomDie(Zombies* zoombie);//僵尸被炸死的动作
    void collapseZombie(Zombies* zoombie);//僵尸被南瓜压死的动作
    void chomperAction1(Plants* plant);//食人花正常动作
    void chomperAction2(Plants* plant);//食人花吃僵尸的动作
//    void chomperAction3(Plants* plant);//食人花咀嚼僵尸的动作
    void changeFailedScene();//切换到失败场景
    void checkFial();//检测僵尸是否进入房子
    void changeSuccessScene();
    void addCar();//添加小车
    void checkHitCarWithZoombie();//检查小车和僵尸
    void removeCar(CCNode* node, CCArray* array);
    void initBeforeZombie();//初始化刚开始出现的僵尸，游戏开始后移除
    void removeBeforeZombie();
    
public:
    virtual void onExit();
    virtual bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);
//    virtual void ccTouchCancelled(CCTouch *pTouch, CCEvent *pEvent);
    
public:
    CCSprite* pSprite;//背景精灵
    CCSprite* menuSprite;//菜单
    CCSprite* barMenuSprite;//菜单条
    CCArray* plantsMenuArray;//菜单中存放的数组
    CCArray* plantsArray;//游戏中存放的植物
    CCArray* plantsSpriteArray;//存放选择植物是生成的临时植物精灵
    CCArray* zoombieArray;//存放游戏中的僵尸
    CCArray* carArray;
    CCLabelTTF* sunNumberLB;
    CCArray* beforeZombie;
    bool plantsIsPlanted;//植物是否被种植的标志
    int flag[9][5];//不能重复种植的标志,0可以种植，1不可以种植
    char sunNum[10];
    int timer;//时间标志，控制僵尸出现的数量
    CCControlSlider* theLevelBar;//关卡进度条
    int theLevelBarProgressBar;//设置进度条的值
    int thePassNumberOfZombie;//过关所需要打死僵尸的数量
    int productZombie;//每关要产生僵尸的数量
    
    //CCMenuIteToggle中每个菜单项的冷却时间
    int cherryCoolTime;
    int chomperCoolTime;
    int jalapenoCoolTime;
    int lilypadCoolTime;
    int peashooterCoolTime;
    int repeaterCoolTime;
    int squashCoolTime;
    int sunflowerCoolTime;
    int tallnutCoolTime;
    int threepeaterCoolTime;
    int wallnutCooltime;
    
};





#endif /* defined(__ZombiesVSPlants__GameScene__) */
