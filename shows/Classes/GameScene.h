//
//  GameScene.h
//  shows
//
//  Created by 范林松 on 14-3-23.
//
//

#ifndef __shows__GameScene__
#define __shows__GameScene__

#include <iostream>
#include "Header.h"
#include "Fish.h"
#include "Bullet.h"
#include "Net.h"
#include "Weapon.h"
//#include "Score.h"
//#include "Roll.h"
//#include "Gold.h"
#include "SimpleAudioEngine.h"
#include "CCRectContaint.h"
using namespace CocosDenshion;

class GameScene:public CCLayer,CCStandardTouchDelegate{
    
private:
    void loadTexture();//加载缓存
    void initGameScene();//初始化场景
    void addFish();//添加鱼
    void updateFish();//更换场景的鱼
    void updateHit();//更新
//    void checkScore();//分数变化
    void stopOrPlay();//暂停或开始
    void changeBackground();//改变场景
    void removeNet(CCSprite *sender);//移除渔网
    void updateEnergy(int addEnergy);//更新
    void setAngle(CCPoint point,CCSprite *sprite);//设置大炮旋转角度
    
    /********************/
    void playBoundingEffectsMusic();
    void play();
    void pause();
    void scoreShow();
    void addWeaponLevel();
    void reduceWeaponLevel();
    void gobackMainUI();
    void afterShowGoldens(CCSprite *sender);
    void afterShowMoney(CCSprite *pSprite);
    void afterCatch(CCSprite *pSprite);
    void afterShowNet(CCSprite *pSprite);
    void removeBullet(CCSprite *sprite);
    void removeWeapon(CCSprite *pSprite);
    
public:
    
    CCSpriteBatchNode *fishSheet;//鱼
    CCSpriteBatchNode *bulletSheet;//子弹
    CCSpriteBatchNode *netSheet;//渔网
    CCSpriteBatchNode *cannonSheet;//大炮
    CCSpriteBatchNode *goldItemSheet;//金币
    char currentMusicString[50];
    int weaponLevel;
    int energy;
    int maxEnergy;
    CCSprite *energyPointer;
    Weapon *weapon;
//    Roll *gold;
    CCArray *allFishArray;
    
public:

    GameScene();
    ~GameScene();
    virtual bool init();
    CREATE_FUNC(GameScene);
    static CCScene *scene();

    void ccTouchesBegan(CCSet *pTouches, CCEvent *pEvent);
    void ccTouchesMoved(CCSet *pTouches, CCEvent *pEvent);
    void ccTouchesEnded(CCSet *pTouches, CCEvent *pEvent);
    
    
};


#endif /* defined(__shows__GameScene__) */
