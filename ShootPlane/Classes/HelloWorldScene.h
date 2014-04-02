#ifndef __HELLOWORLD_SCENE_H__
#define __HELLOWORLD_SCENE_H__

#include "commonHeader.h"
#include "CCPlane.h"
#include "CCProps.h"

class HelloWorld : public cocos2d::CCLayer{
    
private:
    //背景
    CCSprite *background1;
    CCSprite *background2;
    
    CCLabelTTF *scoreLabel;//分数标签
    int score;//分数值
    

    int adjustmentBg;//自适应背景
    
    /*我的飞机*/
    CCSprite *adminPlayer;//飞机
    CCSprite *bullets;//子弹
    int bulletsNum;//子弹数量
    int bulletSpeed;//子弹速度
    int bulletTiming;// 特殊子弹时间
    //子弹样式
    bool bigBullets;//大子弹
    bool changeBullets;//变化子弹
    
    /*对方飞机*/
    //cocos2d::CCSprite *Plane;
    CC_SYNTHESIZE_RETAIN(CCArray *, __Planes, Planes);
    /*添加飞机的时间*/
    int bigPlane;
    int smallPlane;
    int mediumPlane;
    
    //道具
    CC_SYNTHESIZE_RETAIN(CCProps *, __props, Prop);
    //道具添加时间
    int isProps;
    //判断是否存在
    bool isExist;
    
    //游戏是否结束
    bool isGameFinish;

    
    
    
public:
    HelloWorld();
    ~HelloWorld();
    
    //初始化场景
    virtual bool init();
    //回调函数
    void menuCloseCallback(CCObject* pSender);
    CREATE_FUNC(HelloWorld);
    
    virtual void update(float delta);
    //添加触碰事件
    virtual bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchCancelled(CCTouch *pTouch, CCEvent *pEvent);
    virtual void registerWithTouchDispatcher();
    
    SCENE_FUNC(HelloWorld);
    
protected:
    
    void initData();
    void loadBackground();
    void loadPlayer();
    void backgrouneScroll();
    void madeBullet();
    void resetBullet();
    void firingBullets();
    CCPoint boundLayerPos(CCPoint newPos);
    void panForTranslation(CCPoint translation);
    void moveFoePlane();
    void addFoePlane();
    CCPlane* makeBigFoePlane();
    CCPlane* makeMediumFoePlane();
    CCPlane* makeSmallFoePlane();
    void makeProps();
    void resetProps();
    void bulletTimingFn();
    void collisionDetection();
    void fowPlaneHitAnimation(CCPlane* foePlane);
    void fowPlaneBlowupAnimation(CCPlane*foePlane);
    void playerBlowupAnimation();
    void playerBlowupEnd(CCObject* sender);
    void blowupEnd(CCObject* sender);
    void gameOver();
    void restartFn();
    
};

#endif // __HELLOWORLD_SCENE_H__
