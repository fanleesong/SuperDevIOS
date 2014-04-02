//
//  Bullets.cpp
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#include "Bullets.h"
using namespace std;
extern CCArray *bulletArray;//扩展数组
//有参构造函数
Bullet::Bullet(Plants *aplants,CCPoint point,CCLayer *layer){
    
    //根据植物名称创建植物对象
    plants = new Plants(aplants->plantsName);
    switch (aplants->plantsName) {
        case Sunflower:{
            
            this->creatSunflowerBullet(point, layer);
            break;
        }
        case SmallPea:
        case MidllePea:
        case ThreeBulletPea:{
            this->creatPeaBullet(point, layer);
            break;
        }
        default:
            break;
    }
    
    
}
//创建向日葵
void Bullet::creatSunflowerBullet(CCPoint point,CCLayer *layer){
    
    //从缓存中读取
    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("Sun_default.plist");
    this->initWithFile("Sun－1（被拖移）.tiff");
    this->setScale(0.5);
    
    char temp[50];
    CCArray *plistArray = CCArray::createWithCapacity(10);
    for (int i = 1; i< 22; i++) {
        sprintf(temp,"Sun－%i（被拖移）.tiff",i);
        CCSpriteFrame *frame = cache->spriteFrameByName(temp);
        plistArray->addObject(frame);
    }
    //创建动画
    CCAnimation *animation = CCAnimation::createWithSpriteFrames(plistArray);
    CCAnimate *animate = CCAnimate::create(animation);
    this->runAction(CCRepeatForever::create(animate));//创建永久动作
    
    //创建目录精灵
    CCMenuItemSprite *menuSprite = CCMenuItemSprite::create(this,this,this,menu_selector(Bullet::collectSunshine));
    menuSprite->setTag(4002);
    CCMenu *menu = CCMenu::create(menuSprite,NULL);
    menu->setPosition(ccp(point.x+20,point.y+30));
    menu->setEnabled(true);
    menu->setTag(4001);
    layer->addChild(menu);//在场景中添加
    //设置跳跃
    CCJumpTo *jumpTo = CCJumpTo::create(1.0f,ccp(menu->getPosition().x-40,menu->getPosition().y-25),30,1);
    menu->runAction(jumpTo);
    menu->setZOrder(1000);//设置z轴目标点
    
}
//搜集阳光
void Bullet::collectSunshine(CCNode *sender){
    
    sender->stopAllActions();
    CCSize size = GET_WINDOWSIZE;
    //    CCMoveTo *moveTo = CCMoveTo::create(1.0f,ccp(size.width/2+60,size.height/2+320));
//    ccp((size.width/2-190)+(i-1)*45, size.height/2+280)
//    CCMoveTo *moveTo = CCMoveTo::create(1.0f,ccp(60,320));
    CCMoveTo *moveTo = CCMoveTo::create(1.0f,ccp(size.width/2-180,size.height/2+280));
    CCCallFuncND *funcND = CCCallFuncND::create(this,callfuncND_selector(Bullet::moveSunshine),sender->getParent());
    CCSequence *sequence = CCSequence::create(moveTo,funcND,NULL);
    sender->getParent()->runAction(sequence);
    
}
//移动阳光
void Bullet::moveSunshine(CCNode *sender,CCMenu *menu){
    
    extern int SunNumber;
    SunNumber = SunNumber+50;
    menu->removeFromParent();
    
}
//
void Bullet::creatPeaBullet(CCPoint point,CCLayer *layer){
    
    bulletArray->retain();
    position = point;
    
    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("PeashooterBullet_default.plist");
    this->initWithSpriteFrameName("PeashooterBullet－1（被拖移）.tiff");
    this->setPosition(ccp(point.x+10, point.y+10));
    this->setScale(0.5);
    bulletArray->addObject(this);//把子弹添加到数组里
    layer->addChild(this);//加入场景
    float distance = 500-this->getPosition().x;
    float time = distance/BulletSpeedRatio;
    CCMoveTo *moveTo = CCMoveTo::create(time,ccp(500,this->getPosition().y));
    this->runAction(moveTo);
    if (plants->plantsName == MidllePea) {
        this->creatPeaBulletOfMid(this,layer);
    }
    
    
}
void Bullet::creatPeaBulletOfMid(CCNode *sender,CCLayer *layer){
    
    CCSprite *sunSprite = (Bullet *)CCSprite::createWithSpriteFrameName("PeashooterBullet－1（被拖移）.tif");
    sunSprite->setPosition(ccp(position.x+10,position.y+7));
    sunSprite->setScale(0.5f);
    bulletArray->addObject(sunSprite);
    layer->addChild(sunSprite);
    float distance = 500-sunSprite->getPosition().x;
    float time = distance/BulletSpeedRatio;
    CCMoveTo *moveTo = CCMoveTo::create(time,ccp(500,sunSprite->getPosition().y));
    CCSequence *sequence = CCSequence::create(CCDelayTime::create(0.1f),moveTo,NULL);
    sunSprite->runAction(sequence);
    
}
void Bullet::creatPeaBulletOfThree(CCNode *sender,CCLayer *layer){
    
    CCSprite* sunSprite = (Bullet*)CCSprite::createWithSpriteFrameName("PeashooterBullet－1（被拖移）.tiff");
    sunSprite->setPosition(ccp(position.x+10, position.y+4));
    sunSprite->setScale(0.5);
    bulletArray->addObject(sunSprite);//把子弹添加到数组里边
    layer->addChild(sunSprite);
    float distance1 = 500-sunSprite->getPosition().x;
    float time1 = distance1/BulletSpeedRatio;
    CCMoveTo *moveTo1 = CCMoveTo::create(time1, ccp(500,sunSprite->getPosition().y));
    CCSequence* seq = CCSequence::create(CCDelayTime::create(0.2), moveTo1, NULL);
    sunSprite->runAction(seq);
    
}


Bullet::~Bullet(){
    
    //释放
    delete plants;
    
}
