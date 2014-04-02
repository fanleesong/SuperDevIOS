//
//  Plants.cpp
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#include "Plants.h"
#include <string.h>//导入字符串头文件
using namespace std;

//构造函数---初始化枚举默认值
Plants::Plants(PlantsName name){
    
    plantsName = name;
    needWait = false;
    canAttack = true;
    addZombieAttackThisPlant = CCArray::create();
    addZombieAttackThisPlant->retain();//内存retainCount+1
    
    switch (name) {
        case Sunflower:{//是太阳花时
            placeType = LandMammals;//陆地植物
            timeType = Day;//白天
            specialSkill = SunshineShill;//照射
            lifeForce = 10;//声明力10
            plantInterval = 5;//生长速度
            tempPlantInterval = 5;//备份时间
            needSunshine = 50;//需要的阳光数50
            
            createSunInterval = 5;//创建阳光的速度
            tempCreateSunInterval = 5;//备份
            char title[] = "SunFlower";
            this->createPlantByName(title);
            
            break;
        }
        case SmallPea:{//小豌豆
            
            placeType = LandMammals;//陆地植物
            timeType = Day;//白天
            specialSkill = SunshineShill;//照射
            lifeForce = 10;//声明力10
            plantInterval = 5;//生长速度
            tempPlantInterval = 5;//备份时间
            needSunshine = 100;//需要的阳光数200
            
            createSunInterval = 5;//创建阳光的速度
            tempCreateSunInterval = 5;//备份
            char title[] = "PeaShooter";
            this->createPlantByName(title);
            
            break;
        }
        case MidllePea:{//中等豌豆
            
            placeType = LandMammals;//陆地植物
            timeType = Day;//白天
            specialSkill = SunshineShill;//照射
            lifeForce = 10;//声明力10
            plantInterval = 5;//生长速度
            tempPlantInterval = 5;//备份时间
            needSunshine = 200;//需要的阳光数200
            
            createSunInterval = 5;//创建阳光的速度
            tempCreateSunInterval = 5;//备份
            char title[] = "Repeater";
            this->createPlantByName(title);
            
            
            break;
        }
        case ThreeBulletPea:{//三个豌豆
            
            placeType = LandMammals;//陆地植物
            timeType = Day;//白天
            specialSkill = SunshineShill;//照射
            lifeForce = 10;//声明力10
            plantInterval = 5;//生长速度
            tempPlantInterval = 5;//备份时间
            needSunshine = 325;//需要的阳光数325
            
            createSunInterval = 5;//创建阳光的速度
            tempCreateSunInterval = 5;//备份
            char title[] = "Threepeater";
            this->createPlantByName(title);
            
            
            break;
        }
        case Pumpkin:{//南瓜
            
            placeType = LandMammals;//陆地植物
            timeType = Day;//白天
            specialSkill = SunshineShill;//照射
            lifeForce = 10;//声明力10
            plantInterval = 5;//生长速度
            tempPlantInterval = 5;//备份时间
            needSunshine = 50;//需要的阳光数50
            
            char title[] = "Squash";
            this->createPlantByName(title);
            
            
            break;
        }
        case Paprika:{//辣椒
            
            placeType = LandMammals;//陆地植物
            timeType = Day;//白天
            specialSkill = SunshineShill;//照射
            lifeForce = 10;//声明力10
            plantInterval = 5;//生长速度
            tempPlantInterval = 5;//备份时间
            needSunshine = 125;//需要的阳光数125
            
            char title[] = "Jalapeno";
            this->createPlantByName(title);
            
            
            break;
        }
        case Cherry:{//樱桃
            
            placeType = LandMammals;//陆地植物
            timeType = Day;//白天
            specialSkill = SunshineShill;//照射
            lifeForce = 10;//声明力10
            plantInterval = 5;//生长速度
            tempPlantInterval = 5;//备份时间
            needSunshine = 150;//需要的阳光数150
            
            char title[] = "CherryBomb";
            this->createPlantByName(title);
            
            
            break;
        }
        case SmallNut:{//小坚果
            
            placeType = LandMammals;//陆地植物
            timeType = Day;//白天
            specialSkill = SunshineShill;//照射
            lifeForce = 20;//声明力10
            plantInterval = 5;//生长速度
            tempPlantInterval = 5;//备份时间
            needSunshine =  50;//需要的阳光数50
            
            char title[] = "WallNut";
            this->createPlantByName(title);
            
            break;
        }
            
        case largeNut:{//大坚果
            
            placeType = LandMammals;//陆地植物
            timeType = Day;//白天
            specialSkill = SunshineShill;//照射
            lifeForce = 30;//声明力10
            plantInterval = 5;//生长速度
            tempPlantInterval = 5;//备份时间
            needSunshine =  125;//需要的阳光数125
            
            char title[] = "TallNut";
            this->createPlantByName(title);
            
            break;
        }
        case Lilypad:{//荷叶
            
            placeType = LandMammals;//陆地植物
            timeType = Day;//白天
            specialSkill = SunshineShill;//照射
            lifeForce = 10;//声明力10
            plantInterval = 5;//生长速度
            tempPlantInterval = 5;//备份时间
            needSunshine =  25;//需要的阳光数25
            
            char title[] = "LilyPad";
            this->createPlantByName(title);
            
            break;
        }
        case CorpseFlower:{//食人花
            
            placeType = LandMammals;//陆地植物
            timeType = Day;//白天
            specialSkill = SunshineShill;//照射
            lifeForce = 10;//声明力10
            plantInterval = 5;//生长速度
            tempPlantInterval = 5;//备份时间
            needSunshine =  150;//需要的阳光数150
            
            char title[] = "Chomper";
            this->createPlantByName(title);
            
            break;
        }
    }
    this->setScale(0.5f);
    
}
#warning mark----创建植物---------------------------------------
/*____________根据植物名称创建植物______________*/
void Plants::createPlantByName(char name[]){
    
    char temp[100];
    //帧缓存
    CCSpriteFrameCache *cacheFrame = CCSpriteFrameCache::sharedSpriteFrameCache();
    //将缓存的对应plist文件追加到temp
    sprintf(temp,"%s_default.plist",name);
    //从帧文件中添加精灵
    cacheFrame->addSpriteFramesWithFile(temp);
#warning mark--此处有bug---当植物为豌豆荚时无法读取
    //取出plist文件中的字典
    CCDictionary *dic = CCDictionary::createWithContentsOfFile(temp);
    CCDictionary *dic2 = (CCDictionary *)dic->objectForKey("frames");
    int num = dic2->allKeys()->count();//获取键为frames的字典数
    
    sprintf(temp,"%s－2（被拖移）.tiff",name);
    this->initWithSpriteFrameName(temp);//创建精灵
    
    CCArray *plistArray = CCArray::createWithCapacity(20);
    for (int i = 1; i < num; i++) {
        sprintf(temp, "%s－%i（被拖移）.tiff",name,i);//取出对应精灵图片
        CCSpriteFrame *frame = cacheFrame->spriteFrameByName(temp);
        plistArray->addObject(frame);//图片加入数组
    }
    if (strcmp(name, "Jalapeno")== 0 || strcmp(name, "CherryBomb") == 0) {
        this->runOnceAction(plistArray);
    }
    this->runRepeatAction(plistArray);
    
    
    
}
void Plants::runOnceAction(CCArray *plistArray){
    
    //创建静态动作
    CCAnimation *plistAnimation = CCAnimation::createWithSpriteFrames(plistArray,0.15f);;
    //创建动态动作
    CCAnimate *plistAnimate = CCAnimate::create(plistAnimation);
    //让动作持续--生产辣椒和樱桃
    CCCallFunc *callFunc = CCCallFunc::create(this,callfunc_selector(Plants::paprikaCherryAction));
#warning mark------------
    CCSequence *sequnece = CCSequence::create(plistAnimate,plistAnimate,callFunc,NULL);;
    this->runAction(sequnece);
    
}
/*____________移除植物______________*/
void Plants::removePlants(){
    
    this->removeFromParent();
    
}
/*____________辣椒樱桃______________*/
void Plants::paprikaCherryAction(){
    
    
    if (this->plantsName == Cherry) {//樱桃
        this->initWithFile("Boom.gif");
        CCCallFunc *func = CCCallFunc::create(this,callfunc_selector(Plants::removePlants));
        CCSequence *seq = CCSequence::create(CCDelayTime::create(1),func,NULL);
        this->runAction(seq);
    }else if(this->plantsName == Paprika){//辣椒
        //从缓存中读取图片放置到plistArray中
        CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
        cache->addSpriteFramesWithFile("JalapenoAttack_default.plist");
        char temp[50];
        CCArray *plistArray = CCArray::createWithCapacity(10);
        for (int i = 1; i<=8; i++) {
            sprintf(temp,"JalapenoAttack－%i（被拖移）.tiff",i);
            CCSpriteFrame *fame = cache->spriteFrameByName(temp);
            plistArray->addObject(fame);
        }
        //创建动作
        CCAnimation *animation = CCAnimation::createWithSpriteFrames(plistArray,0.1f);
        CCAnimate *animate = CCAnimate::create(animation);
        CCSize size = GET_WINDOWSIZE;
        this->setPosition(ccp(size.width/2+220,this->getPosition().y));
        CCCallFunc *func = CCCallFunc::create(this, callfunc_selector(Plants::removePlants));
        CCSequence *seq = CCSequence::create(animate,func,NULL);
        this->runAction(seq);
        
    }
    
}
/*____________小坚果______________*/
void Plants::smallNutActionEatOverByZombie(){
    
    //先停止所有动作
    this->stopAllActions();
    //在从缓存中获取
    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("WallNut_cracked1_default.plist");
    this->initWithSpriteFrameName("Wallnut_cracked1－11（被拖移）.tiff");//第一张
    char temp[50];
    CCArray *plistArray = CCArray::createWithCapacity(10);
    for (int i = 1; i<12; i++) {
        sprintf(temp, "Wallnut_cracked1－%i（被拖移）.tiff",i);
        CCSpriteFrame *frame = cache->spriteFrameByName(temp);
        plistArray->addObject(frame);
    }
    CCAnimation *animation = CCAnimation::createWithSpriteFrames(plistArray);
    CCAnimate *animate = CCAnimate::create(animation);
    this->runAction(animate);
    
    
}
/*____________小坚果受损严重______________*/
void Plants::smallNutActionEatOverMoreHarm(){
    
    this->stopAllActions();
    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("WallNut_cracked2_default.plist");
    char temp[50];
    CCArray *plistArray = CCArray::createWithCapacity(10);
    for (int i = 1; i<16; i++) {
        sprintf(temp, "Wallnut_cracked2－%i（被拖移）.tiff",i);
        CCSpriteFrame *frame = cache->spriteFrameByName(temp);
        plistArray->addObject(frame);
    }
    CCAnimation *animation = CCAnimation::createWithSpriteFrames(plistArray);
    CCAnimate *animate = CCAnimate::create(animation);
    this->runAction(animate);
    
}
/*____________大坚果______________*/
void Plants::largeNutActionEatOvetByZombie(){
    
    this->stopAllActions();
    char temp[50];
    CCArray *plistArray = CCArray::createWithCapacity(10);
    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("TallNutCracked1_default.plist");
    for (int i = 1;i<14; i++) {
        sprintf(temp,"TallnutCracked1－%i（被拖移）.tiff",i);
        CCSpriteFrame *frame = cache->spriteFrameByName(temp);
        plistArray->addObject(frame);
    }
    CCAnimation *animation = CCAnimation::createWithSpriteFrames(plistArray);
    CCAnimate *animate = CCAnimate::create(animation);
    this->runAction(animate);
    
}
/*____________大坚果受损严重______________*/
void Plants::largeNutActionEatOverMoreharm(){
    
    this->stopAllActions();
    char temp[50];
    CCArray *plistArray = CCArray::createWithCapacity(10);
    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("TallnutCracked2_default.plist");
    for (int i = 1; i<13; i++) {
        sprintf(temp,"TallnutCracked2－%i（被拖移）.tiff",i);
        CCSpriteFrame *frame = cache->spriteFrameByName(temp);
        plistArray->addObject(frame);
    }
    CCAnimation *animation = CCAnimation::createWithSpriteFrames(plistArray);
    CCAnimate *animate = CCAnimate::create(animation);
    this->runAction(animate);
    
}
/*____________荷叶的三个动作______________*/
void Plants::corpseFlowerAction1(){
    
    //能够袭击
    canAttack = true;
    this->stopAllActions();
    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("Chomper_default.plist");
    char temp[50];
    CCArray *plistArray = CCArray::createWithCapacity(10);
    for(int i=1;i<=13;i++)
    {
        sprintf(temp, "Chomper－%i（被拖移）.tiff",i);
        CCSpriteFrame *frame = cache->spriteFrameByName(temp);
        plistArray->addObject(frame);
    }
    CCAnimation *animation = CCAnimation::createWithSpriteFrames(plistArray, 0.1);
    CCAnimate *animate = CCAnimate::create(animation);
    this->runAction(CCRepeatForever::create(animate));
    
}
void Plants::corpseFlowerAction2(){
    //不能袭击
    canAttack = false;
    this->stopAllActions();
    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("ChomperAttack_default.plist");
    char temp[50];
    CCArray *plistArray = CCArray::createWithCapacity(10);
    for(int i=1;i<=9;i++)
    {
        sprintf(temp, "ChomperAttack－%i（被拖移）.tiff",i);
        CCSpriteFrame *frame = cache->spriteFrameByName(temp);
        plistArray->addObject(frame);
    }
    CCAnimation *animation = CCAnimation::createWithSpriteFrames(plistArray, 0.1);
    CCAnimate *animate = CCAnimate::create(animation);
    CCCallFunc *func = CCCallFunc::create(this, callfunc_selector(Plants::corpseFlowerAction3));
    CCSequence *seq = CCSequence::create(animate,func,NULL);
    this->runAction(seq);
    
    
}
void Plants::corpseFlowerAction3(){
    
//  this->stopAllActions();
    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("ChomperDigest_default.plist");
    char temp[50];
    CCArray *plistArray = CCArray::createWithCapacity(10);
    for(int i=1;i<=6;i++)
    {
        sprintf(temp, "ChomperDigest－%i（被拖移）.tiff",i);
        CCSpriteFrame *frame = cache->spriteFrameByName(temp);
        plistArray->addObject(frame);
    }
    CCAnimation *animation = CCAnimation::createWithSpriteFrames(plistArray, 0.2);
    CCAnimate *animate = CCAnimate::create(animation);
    CCCallFunc *func = CCCallFunc::create(this, callfunc_selector(Plants::corpseFlowerAction1));
    CCRepeat* forever = CCRepeat::create(animate,5);
    CCSequence *seq = CCSequence::create(forever ,func,NULL);
    this->runAction(seq);
    
    
}

/*____________重复动作______________*/
void Plants::runRepeatAction(CCArray *plistArray){
    
    CCAnimation *plitAnimation=CCAnimation::createWithSpriteFrames(plistArray,0.15f);
    CCAnimate *plitAnimate=CCAnimate::create(plitAnimation);
    this->runAction(CCRepeatForever::create(plitAnimate));
    
    
}
/*____________南瓜______________*/
void Plants::pumpKinAction(CCSprite *pumpKin,CCPoint point){
    
    CCPoint p1 = pumpKin->getPosition();
    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("SquashAttack_default.plist");
    char temp[50];
    CCArray *plistArray = CCArray::createWithCapacity(10);
    for(int i=1;i<=4;i++){
        sprintf(temp, "SquashAttack－%i（被拖移）.tiff",i);
        CCSpriteFrame *frame = cache->spriteFrameByName(temp);
        plistArray->addObject(frame);
    }
    CCAnimation *animation = CCAnimation::createWithSpriteFrames(plistArray, 0.3);
    CCAnimate *animate = CCAnimate::create(animation);
    pumpKin->runAction(animate);
    
    CCJumpTo *jumpTo = CCJumpTo::create(0.5, point, 50, 1);
    CCCallFuncND *funcND = CCCallFuncND::create(NULL, callfuncND_selector(Plants::pumpKinMoveAction),pumpKin);
    CCSequence *seq = CCSequence::create(jumpTo,CCDelayTime::create(1.0),funcND,NULL);
    pumpKin->runAction(seq);
    
}
void Plants::pumpKinMoveAction(CCNode *sender,CCSprite *pumpKin){
    
    pumpKin->removeFromParent();
    
}
/*____________析构______________*/
Plants::~Plants(){
    
    this->addZombieAttackThisPlant->release();
    
}

























