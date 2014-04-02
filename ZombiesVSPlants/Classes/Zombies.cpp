//
//  Zombies.cpp
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#include "Zombies.h"

Zombies::Zombies(ZombieType zombieType){
    this->loadSpriteFrameFiles();
    isAttack = false;
    this->setScale(0.6f);
    switch (zombieType) {
        case 0:
            this->zombieType=zombieType;
            this->blood=1*LIFEVALUE;
            this->initWithSpriteFrameName("Zombie1.png");
            sprintf(plistStr, "Zombie");
            break;
        case 1:
            this->zombieType=zombieType;
            this->initWithSpriteFrameName("BucketheadZombie1.png");
            this->blood=1.5*LIFEVALUE;
            sprintf(plistStr, "BucketheadZombie");
            break;
        case 2:
            this->zombieType=zombieType;
            this->initWithSpriteFrameName("ConeheadZombie1.png");
            this->blood=LIFEVALUE;
            sprintf(plistStr, "ConeheadZombie");
            break;
        case 3:
            this->zombieType=zombieType;
            this->initWithSpriteFrameName("FlagZombie1.png");
            this->blood=LIFEVALUE;
            sprintf(plistStr, "FlagZombie");
            break;
        case 4:
            this->zombieType=zombieType;
            this->initWithSpriteFrameName("PoleVaultingZombie1.png");
            this->blood=LIFEVALUE;
            this->isJump = false;
            sprintf(plistStr, "PoleVaultingZombie");
            break;
        case 5:
            this->zombieType=zombieType;
            this->initWithSpriteFrameName("PoleVaultingZombieWalk1.png");
            this->blood=LIFEVALUE;
            this->isJump = false;
            sprintf(plistStr, "PoleVaultingZombieWalk");
            break;
            
        default:
            break;
    }
    runZombieAction(plistStr);
}

void Zombies::loadSpriteFrameFiles(){
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("Zombie_default.plist");
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("BucketheadZombie_default.plist");
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("ConeheadZombie_default.plist");
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("FlagZombie_default.plist");
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("PoleVaultingZombie_default.plist");
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("PoleVaultingZombieWalk_default.plist");
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("PoleVaultingZombieJump_default.plist");
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("PoleVaultingZombieJump2_default.plist");
}

void Zombies::continueMove()
{
    this->stopAllActions();
    switch (zombieType) {
        case 0:
            
            sprintf(plistStr, "Zombie");
            break;
        case 1:
            
            sprintf(plistStr, "BucketheadZombie");
            break;
        case 2:
            
            sprintf(plistStr, "ConeheadZombie");
            break;
        case 3:
            
            sprintf(plistStr, "FlagZombie");
            break;
        case 4:
            sprintf(plistStr, "PoleVaultingZombie");
            break;
        case 5:
            sprintf(plistStr, "PoleVaultingZombieWalk");
            break;
        default:
            break;
    }
    runZombieAction(plistStr);
    
}

//根据僵尸类型类型的不同执行不同的动作
void Zombies::runZombieAction(char* plist){
    char name[50];
    sprintf(name, "%s_default.plist",plist);
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile(name);
    CCDictionary* dic=CCDictionary::createWithContentsOfFile(name);
    dic->retain();
    CCDictionary* a=(CCDictionary*)dic->objectForKey("frames");
    a->retain();
    int num=a->allKeys()->count();
    CCArray* allFrames=CCArray::createWithCapacity(10);
    allFrames->retain();
    for (int i=0; i<num; i++) {
        char frame[50];
        sprintf(frame, "%s%d.png",plist,i+1);
        
        CCSpriteFrame* frames=CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(frame);
        allFrames->addObject(frames);
    }
    CCAnimation* animation=CCAnimation::createWithSpriteFrames(allFrames,0.08f);
    allFrames->release();
    CCAnimate* animate=CCAnimate::create(animation);
    CCRepeatForever* forever=CCRepeatForever::create(animate);
    this->runAction(forever);
}

void Zombies::runDieAction()
{
    this->blood = 0;
    int type=this->zombieType;
    this->stopAllActions();
    switch (type) {
        case 0:
        case 1:
        case 2:
            sprintf(dieStr, "ZombieDie");
            break;
        case 3:
            sprintf(dieStr, "ZombieDie");
            break;
        case 4:
            sprintf(dieStr, "PoleVaultingZombieDie");
            break;
        default:
            break;
    }
    char name[50];
    sprintf(name, "%s_default.plist",dieStr);
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile(name);
    CCDictionary* dic=CCDictionary::createWithContentsOfFile(name);
    dic->retain();
    CCDictionary* a=(CCDictionary*)dic->objectForKey("frames");
    a->retain();
    int num=a->allKeys()->count();
    CCArray* allFrames=CCArray::createWithCapacity(10);
    allFrames->retain();
    for (int i=0; i<num; i++) {
        char frame[50];
        sprintf(frame, "%s%d.png",dieStr,i+1);
        
        CCSpriteFrame* frames=CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(frame);
        allFrames->addObject(frames);
    }
    CCAnimation* animation=CCAnimation::createWithSpriteFrames(allFrames,0.2f);
    allFrames->release();
    CCAnimate* animate=CCAnimate::create(animation);
    //CCRepeatForever* forever=CCRepeatForever::create(animate);
    
    CCCallFunc* func=CCCallFunc::create(this, callfunc_selector(Zombies::remove));
    CCSequence* seq=CCSequence::create(animate,func,NULL);
    //CCRepeatForever* forever=CCRepeatForever::create(animate);
    this->runAction(seq);
    //this->removeFromParent();
    
}

void Zombies::runAttackAction()
{ int type=this->zombieType;
    this->stopAllActions();
    switch (type) {
        case 0:
            sprintf(attackStr, "ZombieAttack");
            break;
        case 1:
            sprintf(attackStr, "BucketheadZombieAttack");
            break;
        case 2:
            sprintf(attackStr, "ConeheadZombieAttack");
            break;
        case 3:
            sprintf(attackStr, "FlagZombieAttack");
            break;
        case 4:
            sprintf(attackStr, "PoleVaultingZombieAttack");
            break;
        case 5:
            sprintf(attackStr, "PoleVaultingZombieAttack");
            break;
        default:
            break;
    }
    this->runZombieAction(attackStr);
    
}

void Zombies::runBoomDie()
{
    this->stopAllActions();
    char name[50];
    sprintf(name, "BoomDie_default.plist");
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile(name);
    CCDictionary* dic=CCDictionary::createWithContentsOfFile(name);
    dic->retain();
    CCDictionary* a=(CCDictionary*)dic->objectForKey("frames");
    a->retain();
    int num=a->allKeys()->count();
    CCArray* allFrames=CCArray::createWithCapacity(10);
    allFrames->retain();
    for (int i=0; i<num; i++) {
        char frame[50];
        sprintf(frame, "BoomDie%d.png",i+1);
        
        CCSpriteFrame* frames=CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(frame);
        allFrames->addObject(frames);
    }
    CCAnimation* animation=CCAnimation::createWithSpriteFrames(allFrames,0.1);
    allFrames->release();
    CCAnimate* animate=CCAnimate::create(animation);
    CCCallFunc* func=CCCallFunc::create(this, callfunc_selector(Zombies::remove));
    CCSequence* seq=CCSequence::create(animate,func,NULL);
    //CCRepeatForever* forever=CCRepeatForever::create(animate);
    this->runAction(seq);
    
}
#pragma mark------------控制僵尸向前移动的动作--------------------------------
void Zombies::startMove()
{
    //要根据距离计算出时间（让速度是一个恒定的值）
    float x = this->getPosition().x;
    //    float y = this->getPosition().y;
    float distance = (x+70);
    float time = distance*0.1;
    CCMoveTo* move=CCMoveTo::create(time, ccp(-70, this->getPosition().y));
    CCCallFunc* func=CCCallFunc::create(this, callfunc_selector(Zombies::remove));
    CCSequence* seq=CCSequence::create(move,func,NULL);
    this->runAction(seq);
}

void Zombies::remove()
{
    // this->removeFromParentAndCleanup(true);
    this->removeFromParent();
}

void Zombies::Jump()
{
    this->isJump = true;
    this->stopAllActions();
    char name[50];
    sprintf(name, "PoleVaultingZombieJump_default.plist");
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile(name);
    CCDictionary* dic=CCDictionary::createWithContentsOfFile(name);
    dic->retain();
    CCDictionary* a=(CCDictionary*)dic->objectForKey("frames");
    a->retain();
    int num=a->allKeys()->count();
    CCArray* allFrames=CCArray::createWithCapacity(10);
    allFrames->retain();
    for (int i=0; i<num; i++) {
        char frame[50];
        sprintf(frame, "PoleVaultingZombieJump%d.png",i+1);
        
        CCSpriteFrame* frames=CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(frame);
        allFrames->addObject(frames);
    }
    CCAnimation* animation=CCAnimation::createWithSpriteFrames(allFrames,0.2);
    allFrames->release();
    CCAnimate* animate=CCAnimate::create(animation);
    CCCallFunc* func=CCCallFunc::create(this, callfunc_selector(Zombies::Jump2));
    CCMoveBy* moveBy = CCMoveBy::create(1.5, ccp(-25,0));
    CCSpawn* spawn = CCSpawn::create(animate,moveBy, NULL);
    CCSequence* seq=CCSequence::create(spawn,func,NULL);
    //CCRepeatForever* forever=CCRepeatForever::create(animate);
    this->runAction(seq);
    
}

void Zombies::Jump2()
{
    this->stopAllActions();
    this->initWithSpriteFrameName("PoleVaultingZombieJump21.png");
    char name[50];
    sprintf(name, "PoleVaultingZombieJump2_default.plist");
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile(name);
    CCDictionary* dic=CCDictionary::createWithContentsOfFile(name);
    dic->retain();
    CCDictionary* a=(CCDictionary*)dic->objectForKey("frames");
    a->retain();
    CCPoint point = this->getPosition();
    this->setPosition(ccp(point.x-45, point.y));
    int num=a->allKeys()->count();
    CCArray* allFrames=CCArray::createWithCapacity(10);
    allFrames->retain();
    for (int i=0; i<num; i++) {
        char frame[50];
        sprintf(frame, "PoleVaultingZombieJump2%d.png",i+1);
        
        CCSpriteFrame* frames=CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(frame);
        allFrames->addObject(frames);
    }
    CCAnimation* animation=CCAnimation::createWithSpriteFrames(allFrames,0.1);
    allFrames->release();
    CCAnimate* animate=CCAnimate::create(animation);
    CCCallFunc* func1 = CCCallFunc::create(this, callfunc_selector(Zombies::changeIsJump));
    CCCallFunc* func2 = CCCallFunc::create(this, callfunc_selector(Zombies::unPoleVaultingZombieRun));
    CCSequence* seq = CCSequence::create(animate, func1, func2, NULL);
    this->runAction(seq);
    
}

void Zombies::changeIsJump()
{
    //this->isJump = false;
}

void Zombies::unPoleVaultingZombieRun()
{
    this->stopAllActions();
    char name[50];
    sprintf(name, "PoleVaultingZombieWalk_default.plist");
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile(name);
    CCDictionary* dic=CCDictionary::createWithContentsOfFile(name);
    dic->retain();
    CCDictionary* a=(CCDictionary*)dic->objectForKey("frames");
    a->retain();
    int num=a->allKeys()->count();
    CCArray* allFrames=CCArray::createWithCapacity(10);
    allFrames->retain();
    for (int i=0; i<num; i++) {
        char frame[50];
        sprintf(frame, "PoleVaultingZombieWalk%d.png",i+1);
        
        CCSpriteFrame* frames=CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(frame);
        allFrames->addObject(frames);
    }
    CCAnimation* animation=CCAnimation::createWithSpriteFrames(allFrames,0.1);
    allFrames->release();
    CCAnimate* animate=CCAnimate::create(animation);
    CCCallFunc* func=CCCallFunc::create(this, callfunc_selector(Zombies::startMove));
    CCSpawn* spawn = CCSpawn::create(CCRepeat::create(animate, 100), func, NULL);
//    CCSequence* seq=CCSequence::create(animate,func,NULL);
    this->runAction(spawn);
    
}
