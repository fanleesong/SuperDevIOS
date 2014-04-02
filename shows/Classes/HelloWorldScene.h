#ifndef __HELLOWORLD_SCENE_H__
#define __HELLOWORLD_SCENE_H__
#include "cocos2d.h"
using namespace cocos2d;
//随机产生鱼的方法
#define kSharkCapture "capture"
#define kSharkMove "move"

class HelloWorld : public cocos2d::CCLayer
{
public:
    CCSize size;
    CCTexture2D *texture ;
    CCSpriteFrameCache *cache ;
    virtual bool init();//初始化层
    static cocos2d::CCScene* scene();
    CREATE_FUNC(HelloWorld);//创建
    virtual void ccTouchesBegan(CCSet *pTouches, CCEvent *pEvent);
    virtual void ccTouchesMoved(CCSet *pTouches, CCEvent *pEvent);
    virtual void ccTouchesEnded(CCSet *pTouches, CCEvent *pEvent);
    
    void creatOtherFish(int type);
private:
    void createShark(int fishType,char* sharkFace);
    
};

#endif // __HELLOWORLD_SCENE_H__
