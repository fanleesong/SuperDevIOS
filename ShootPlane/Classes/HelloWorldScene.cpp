#include "HelloWorldScene.h"
#define WINDOWHEIGHT CCDirector::sharedDirector()->getWinSize().height

USING_NS_CC;
static int __cnt = 1;

/*
CCScene* HelloWorld::scene()
{
    CCScene *scene = CCScene::create();
    HelloWorld *layer = HelloWorld::create();
    scene->addChild(layer);
    return scene;
}
 */


//构造函数，实现实例变量初始化
HelloWorld::HelloWorld():
background1(NULL),background2(NULL),
scoreLabel(NULL),score(0),
adjustmentBg(0),adminPlayer(NULL),
bullets(NULL),bulletsNum(0),
bigBullets(false),changeBullets(false),
bulletSpeed(0),bulletTiming(0),
__Planes(NULL),bigPlane(0),
smallPlane(0),mediumPlane(0),
__props(NULL),isProps(0),
isExist(false),isGameFinish(false){

    
    
}
//析构函数销毁内存
HelloWorld::~HelloWorld(){

    //析构函数，安全释放
    CC_SAFE_RELEASE_NULL(__Planes);
    CC_SAFE_RELEASE_NULL(__props);

}

bool HelloWorld::init()
{
    kCCLAYER_IS_INIT;
    
    CCTexture2D *texture = CCTextureCache::sharedTextureCache()->textureForKey("gameArts.png");
    CCSpriteBatchNode *spriteBatch = CCSpriteBatchNode::createWithTexture(texture);
    this->addChild(spriteBatch);
    
    this->initData();
    this->loadBackground();
    this->loadPlayer();
    this->madeBullet();
    this->resetBullet();
    this->scheduleUpdate();
    this->setTouchEnabled(true);
    
    return true;
}

void HelloWorld::update(float delta){
    if (!isGameFinish) {
        this->backgrouneScroll();
        this->firingBullets();
        this->addFoePlane();
        this->moveFoePlane();
        this->collisionDetection();
        this->makeProps();
        this->bulletTimingFn();
        this->resetProps();
    }
}


void HelloWorld::initData() {
    adjustmentBg = 568;
    bulletsNum = 0;
    bigBullets = false;
    changeBullets = false;
    bulletTiming = 900;
    bulletSpeed = 25;
    bigPlane = 0;
    smallPlane = 0;
    mediumPlane = 0;
    isProps = 0;
    score = 0;
    isExist = false;
    isGameFinish = false;
    this->setPlanes(CCArray::create());
    //foePlanes->retain();
    
}

/* ----资源加载-------*/

// 载入背景
void HelloWorld::loadBackground()
{
    this->background1 = CCSprite::createWithSpriteFrameName("background_2.png");
    this->background1->setAnchorPoint(ccp(0.5, 0));
    this->background1->setPosition(ccp(160, adjustmentBg));
    this->background1->setScale(1.5);
    this->addChild(background1,0);
    
    this->background2 = CCSprite::createWithSpriteFrameName("background_2.png");
    this->background2->setAnchorPoint(ccp(0.5, 0));
    this->background2->setScale(1.5);
    this->background2->setPosition(ccp(160, 568+adjustmentBg));
    this->addChild(background2,0);
    
    this->scoreLabel = CCLabelTTF::create("0000", "MarkerFelt-Thin", 18.0);
    this->scoreLabel->setColor(ccc3(0, 0, 0));
    this->scoreLabel->setAnchorPoint(ccp(0,1));
    this->scoreLabel->setPosition(ccp(10, WINDOWHEIGHT-10));
    this->addChild(scoreLabel,4);
    
}

// 背景滚动
void HelloWorld::backgrouneScroll()
{
    adjustmentBg--;
    
    if (adjustmentBg<=0) {
        adjustmentBg = 568;
    }
    background1->setPosition(ccp(160, adjustmentBg));
    background2->setPosition(ccp(160, adjustmentBg-568));
    
    
}
// 玩家飞机加载
void HelloWorld::loadPlayer()
{
    
    CCArray *playerActionArray = CCArray::create();
    for (int i = 1 ; i<=2; i++) {
        CCString* key = CCString::createWithFormat("hero_fly_%d.png", i);
        //从内存池中取出Frame
        CCSpriteFrame* frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(key->getCString());
        //添加到序列中
        playerActionArray->addObject(frame);
    }
    CCLog("----------  %d",playerActionArray->count());
    //将数组转化为动画序列,换帧间隔0.1秒
    CCAnimation* animPlayer = CCAnimation::createWithSpriteFrames(playerActionArray, 0.1f);
    //生成动画播放的行为对象
    CCAnimate* actPlayer = CCAnimate::create(animPlayer);
    //清空缓存数组
    playerActionArray->removeAllObjects();
    
    adminPlayer = CCSprite::createWithSpriteFrameName("hero_fly_1.png");
    adminPlayer->setPosition(ccp(160,50));
    this->addChild(adminPlayer,3);
    adminPlayer->runAction(CCRepeatForever::create(actPlayer));
    
    
}



// 发射子弹
void HelloWorld::firingBullets()
{
    this->bullets->setPosition(ccp(this->bullets->getPositionX(),this->bullets->getPositionY()+bulletSpeed));
    if (this->bullets->getPositionY()>WINDOWHEIGHT-20) {
        //[self resetBullet];
        this->resetBullet();
    }
    
}

// 子弹还原
void HelloWorld::resetBullet()
{
    
    if ((bigBullets&&changeBullets)||(!bigBullets&&changeBullets)) {
        this->bullets->removeFromParent();
        this->madeBullet();
        changeBullets = false;
    }
    
    bulletSpeed = (460-(this->adminPlayer->getPositionY() + 50))/15;
    if (bulletSpeed<5)
    {
        bulletSpeed=5;
    }
    this->bullets->setPosition(ccp(this->adminPlayer->getPositionX(),this->adminPlayer->getPositionY()+50));
}

// 制造子弹
void HelloWorld::madeBullet()
{
    bullets= CCSprite::createWithSpriteFrameName((!bigBullets)?"bullet1.png":"bullet2.png");
    bullets->setAnchorPoint(ccp(0.5,0.5));
    this->addChild(bullets);
}

// --------------飞机移动-----------------------


bool HelloWorld::ccTouchBegan(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    return true;
}

void HelloWorld::ccTouchMoved(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    CCPoint touchLocation = this->convertTouchToNodeSpace(pTouch);
    CCPoint oldTouchLocation = pTouch->getPreviousLocationInView();
    
    oldTouchLocation = CCDirector::sharedDirector()->convertToGL(oldTouchLocation);
    oldTouchLocation = this->convertToNodeSpace(oldTouchLocation);
    
    CCPoint translation = ccpSub(touchLocation, oldTouchLocation);
    this->panForTranslation(translation);
    
    
}

void HelloWorld::ccTouchEnded(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    
}

void HelloWorld::ccTouchCancelled(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    
}

void HelloWorld::registerWithTouchDispatcher()
{
    CCDirector* pDirector = CCDirector::sharedDirector();
    pDirector->getTouchDispatcher()->addTargetedDelegate(this, kCCMenuHandlerPriority + 1, true);
}



CCPoint HelloWorld::boundLayerPos(CCPoint newPos)
{
    CCPoint retval = newPos;
    retval.x = adminPlayer->getPositionX()+newPos.x;
    retval.y = adminPlayer->getPositionY()+newPos.y;
    
    if (retval.x>=286) {
        retval.x = 286;
    }else if (retval.x<=33) {
        retval.x = 33;
    }
    
    if (retval.y >=WINDOWHEIGHT-50) {
        retval.y = WINDOWHEIGHT-50;
    }else if (retval.y <= 43) {
        retval.y = 43;
    }
    
    return retval;
}

void HelloWorld::panForTranslation(CCPoint translation)
{
    if (!isGameFinish) {
        adminPlayer->setPosition(this->boundLayerPos(translation));
    }
}


// -------------------------------------------

// 移动敌机
void HelloWorld::moveFoePlane()
{
    CCObject* foeObj;
    CCARRAY_FOREACH(this->getPlanes(), foeObj){
        CCPlane *foe = (CCPlane *)foeObj;
        foe->setPosition(ccp(foe->getPositionX(), foe->getPositionY()-foe->speed));
        // 敌机出了底屏
        if (foe->getPositionY()< -75) {
            //CCLog("-------  out of scream  1   __id=%d",foe->__id);
            foe->stopAllActions();
            this->getPlanes()->removeObject(foe);
            if(foe == NULL){
            }else{
                //CCLog("-------  out of scream  2   __id=%d",foe->__id);
                foe->removeFromParent();//// ??????
                //CCLog("--------------  foe is NOT NULL removve from parent (%d) %d",foe->__id,foe==NULL);
            }
        }
    }
}

// 添加飞机
void HelloWorld::addFoePlane()
{
    bigPlane++;
    smallPlane++;
    mediumPlane++;
    
    if (bigPlane>500) {
        CCPlane *foePlane = this->makeBigFoePlane();
        this->addChild(foePlane,3);
        this->getPlanes()->addObject(foePlane);
        bigPlane = 0;
    }
    
    if (mediumPlane>400) {
        CCPlane *foePlane = this->makeMediumFoePlane();
        this->addChild(foePlane,3);
        this->getPlanes()->addObject(foePlane);
        mediumPlane = 0;
    }
    
    if (smallPlane>45) {
        CCPlane *foePlane = this->makeSmallFoePlane();
        this->addChild(foePlane,3);
        this->getPlanes()->addObject(foePlane);
        smallPlane = 0;
    }
    
}

// 造大飞机
CCPlane* HelloWorld::makeBigFoePlane()
{
    
    CCArray *bigFoePlaneActionArray = CCArray::create();
    for (int i = 1 ; i<=2; i++) {
        CCString* key = CCString::createWithFormat("enemy2_fly_%i.png", i);
        //从内存池中取出Frame
        CCSpriteFrame* frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(key->getCString());
        //添加到序列中
        bigFoePlaneActionArray->addObject(frame);
    }
    
    //将数组转化为动画序列,换帧间隔0.1秒
    CCAnimation* animPlayer = CCAnimation::createWithSpriteFrames(bigFoePlaneActionArray, 0.1f);
    //生成动画播放的行为对象
    CCAnimate* actPlayer = CCAnimate::create(animPlayer);
    //清空缓存数组
    bigFoePlaneActionArray->removeAllObjects();
    
    CCPlane *bigFoePlane = CCPlane::createWithSpriteFrameName("enemy2_fly_1.png");
    bigFoePlane->setPosition(ccp((arc4random()%210)+55, 732));
    bigFoePlane->planeType = 2;
    bigFoePlane->hp = 30;
    bigFoePlane->runAction(CCRepeatForever::create(actPlayer));
    bigFoePlane->speed = (arc4random()%2)+2 ;
    bigFoePlane->__id = __cnt++;
    return bigFoePlane;
}

// 造中飞机
CCPlane* HelloWorld::makeMediumFoePlane()
{
    CCPlane *mediumFoePlane = CCPlane::createWithSpriteFrameName("enemy3_fly_1.png");
    mediumFoePlane->setPosition(ccp((arc4random()%268)+23, 732));
    mediumFoePlane->planeType=3;
    mediumFoePlane->hp=15;
    mediumFoePlane->speed = (arc4random()%3)+2;
    mediumFoePlane->__id = __cnt++;
    return mediumFoePlane;
}

// 造小飞机
CCPlane* HelloWorld::makeSmallFoePlane()
{
    CCPlane *smallFoePlane = CCPlane::createWithSpriteFrameName("enemy1_fly_1.png");
    smallFoePlane->setPosition(ccp((arc4random()%240)+17, 732));
    smallFoePlane->planeType=1;
    smallFoePlane->hp=1;
    smallFoePlane->speed=(arc4random()%4)+2;
    smallFoePlane->__id = __cnt++;
    return smallFoePlane;
}

// 制作道具
void HelloWorld::makeProps()
{
    isProps++;
    if (isProps>500) {//1520
        this->setProp(CCProps::create());
        this->getProp()->initWithType((propsType)((arc4random()%2)+4));// ?????
        this->addChild(this->getProp()->getProp());
        this->getProp()->propAnimation();
        //this->getProp()->retain(); ?????
        isProps = 0;
        isExist = true;
    }
}
//  没接住道具, 出了底屏
void HelloWorld::resetProps()
{
    if (isExist) {
        if(this->getProp()->getProp()->getPositionY() < -75){
            isExist = false;
            CCLog("==============  没接住道具, 出了底屏");
        }
    }
}


// 子弹持续时间
void HelloWorld::bulletTimingFn()
{
    if (bigBullets) {
        if (bulletTiming>0) {
            bulletTiming--;
        }else {
            bigBullets = false;
            changeBullets = true;
            bulletTiming = 900;
        }
    }
}

// 碰撞检测
void HelloWorld::collisionDetection()
{
    
    // 子弹跟敌机
    CCRect bulletRec = bullets->boundingBox();
    
    CCObject* foeObj;
    CCARRAY_FOREACH(this->getPlanes(), foeObj){
        CCPlane *foePlane = (CCPlane *)foeObj;
        if (bulletRec.intersectsRect(foePlane->boundingBox())  ) {
            this->resetBullet();
            this->fowPlaneHitAnimation(foePlane);
            foePlane->hp = foePlane->hp - (bigBullets?2:1);
            if (foePlane->hp<=0) {
                //CCLog("##### move out animation:   %d   for hp(%d)",foePlane->__id,foePlane->hp);
                this->fowPlaneBlowupAnimation(foePlane);
                //CCLog("##### move out begin:   %d   for hp(%d)",foePlane->__id,foePlane->hp);
                this->getPlanes()->removeObject(foePlane);
                //CCLog("##### move out end:   %d   for hp(%d)",foePlane->__id,foePlane->hp);
            }
        }
    }
    
    // 飞机跟打飞机
    CCRect playerRec = adminPlayer->boundingBox();
    playerRec.origin.x += 25;
    playerRec.size.width -= 50;
    playerRec.origin.y -= 10;
    playerRec.size.height -= 10;
    
    CCObject *foeObj3;
    CCARRAY_FOREACH(this->getPlanes(), foeObj3){
        CCPlane *foePlane = (CCPlane *)foeObj3;
        if (playerRec.intersectsRect(foePlane->boundingBox()) ) {
            CCLog("@@@@@ shit,i was killed  by:   %d",foePlane->__id);
            
            this->playerBlowupAnimation();
            this->fowPlaneBlowupAnimation(foePlane);// 同归于尽
            this->getPlanes()->removeObject(foePlane);
            this->gameOver();
        }
    }
    
    // 飞机跟道具
    
    if (isExist) {
        CCRect playerRec1 = adminPlayer->boundingBox();
        CCRect propRec = this->getProp()->getProp()->boundingBox();
        if (playerRec1.intersectsRect(propRec)) {
            
            this->getProp()->getProp()->stopAllActions();
            this->getProp()->getProp()->removeFromParent();
            isExist = false;
            
            if (this->getProp()->type == propsTypeBullet) {
                CCLog("========= 大力丸子");
                bigBullets = true;
                changeBullets = true;
            }else if (this->getProp()->type == propsTypeBomb) {
                CCLog("========= 意念一直线，敌人死光光");
                CCObject *foeObj4;
                CCARRAY_FOREACH(this->getPlanes(), foeObj4){
                    CCPlane *foePlane = (CCPlane *)foeObj4;
                    this->fowPlaneBlowupAnimation(foePlane);
                }
                this->getPlanes()->removeAllObjects();
            }
        }
    }
    
    
}

// 添加打击效果
void HelloWorld::fowPlaneHitAnimation(CCPlane* foePlane)
{
    if (foePlane->planeType == 3) {
        if (foePlane->hp==13) {
            CCArray *playerActionArray = new CCArray;
            for (int i = 1 ; i<=2; i++) {
                CCString* key = CCString::createWithFormat("enemy3_hit_%d.png",i);
                //从内存池中取出Frame
                CCSpriteFrame* frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(key->getCString());
                //添加到序列中
                playerActionArray->addObject(frame);
            }
            
            //将数组转化为动画序列,换帧间隔0.1秒
            CCAnimation* animPlayer = CCAnimation::createWithSpriteFrames(playerActionArray,0.1f);
            //生成动画播放的行为对象
            CCAnimate* actPlayer = CCAnimate::create(animPlayer);
            //清空缓存数组
            playerActionArray->removeAllObjects();
            foePlane->stopAllActions();
            foePlane->runAction(CCRepeatForever::create(actPlayer));
        }
    }else if (foePlane->planeType == 2) {
        if (foePlane->hp==20) {
            CCArray *playerActionArray = new CCArray;
            for (int i = 1 ; i<=1; i++) {
                CCString* key = CCString::createWithFormat("enemy2_hit_%d.png",i);
                //从内存池中取出Frame
                CCSpriteFrame* frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(key->getCString());
                //添加到序列中
                playerActionArray->addObject(frame);
            }
            
            //将数组转化为动画序列,换帧间隔0.1秒
            CCAnimation* animPlayer = CCAnimation::createWithSpriteFrames(playerActionArray,0.1f);
            //生成动画播放的行为对象
            CCAnimate* actPlayer = CCAnimate::create(animPlayer);
            //清空缓存数组
            playerActionArray->removeAllObjects();
            foePlane->stopAllActions();
            foePlane->runAction(CCRepeatForever::create(actPlayer));
        }
    }
}

// 爆炸动画
void HelloWorld::fowPlaneBlowupAnimation(CCPlane*foePlane)
{
    int forSum=0;
    if (foePlane->planeType == 3) {
        forSum = 4;
        score+=6000;
    }else if (foePlane->planeType  == 2) {
        score+=30000;
        forSum = 7;
    }else if (foePlane->planeType  == 1) {
        forSum = 4;
        score+=1000;
    }
    
    scoreLabel->setString(CCString::createWithFormat("%d",score)->getCString());
    
    foePlane->stopAllActions();
    CCArray *foePlaneActionArray = new CCArray;
    
    for (int i = 1; i<=forSum ; i++ ) {
        CCString* key = CCString::createWithFormat("enemy%d_blowup_%i.png",foePlane->planeType , i);
        //从内存池中取出Frame
        CCSpriteFrame* frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(key->getCString());
        //添加到序列中
        foePlaneActionArray->addObject(frame);
    }
    
    //将数组转化为动画序列,换帧间隔0.1秒
    CCAnimation* animPlayer = CCAnimation::createWithSpriteFrames(foePlaneActionArray,0.1f);
    //生成动画播放的行为对象
    CCAnimate* actFowPlane = CCAnimate::create(animPlayer);
    //清空缓存数组
    foePlaneActionArray->removeAllObjects();
    
    //CCLog("----- 爆炸动画 begin: %d",foePlane->__id);
    foePlane->runAction(CCSequence::create(actFowPlane, CCCallFuncN::create(this, callfuncN_selector(HelloWorld::blowupEnd)), NULL));
    
    
    //CCLog("----- 爆炸动画 end: %d",foePlane->__id);
}

// 飞机爆炸
void HelloWorld::playerBlowupAnimation()
{
    
    CCArray *foePlaneActionArray = new CCArray;
    for (int i = 1; i<=4 ; i++ ) {
        CCString* key = CCString::createWithFormat("hero_blowup_%i.png", i);
        //从内存池中取出Frame
        CCSpriteFrame* frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(key->getCString());
        //添加到序列中
        foePlaneActionArray->addObject(frame);
    }
    
    //将数组转化为动画序列,换帧间隔0.1秒
    CCAnimation* animPlayer = CCAnimation::createWithSpriteFrames(foePlaneActionArray,0.1f);
    //生成动画播放的行为对象
    CCAnimate* actFowPlane = CCAnimate::create(animPlayer);
    //清空缓存数组
    foePlaneActionArray->removeAllObjects();
    
    adminPlayer->runAction(CCSequence::create(actFowPlane, NULL));
}
//
void HelloWorld::playerBlowupEnd(CCObject* sender)
{
    
}

void HelloWorld::blowupEnd(CCObject* sender)
{
    CCPlane *foePlane = (CCPlane *) sender;
    CCLog("----- blow up end: %d",foePlane->__id);
    foePlane->removeFromParent();
}

void HelloWorld::gameOver()
{
    
    isGameFinish = true;
    CCObject *nodeObj;
    CCARRAY_FOREACH(this->getChildren(), nodeObj){
        CCNode *node = (CCNode *)nodeObj;
        node->stopAllActions();
    }
    
    cocos2d::CCLabelTTF *gameOverLabel = CCLabelTTF::create("飞机大战分类" ,"MarkerFelt-Thin",35);
    gameOverLabel->setPosition(ccp(160, 300));
    this->addChild(gameOverLabel,4);
    
    cocos2d::CCLabelTTF *scoreLabel = CCLabelTTF::create(CCString::createWithFormat("%d",this->score)->getCString() ,"MarkerFelt-Thin",25);
    scoreLabel->setPosition(ccp(160, 250));
    this->addChild(scoreLabel,4);
    
    CCMenuItemFont *gameOverItem = CCMenuItemFont::create("重玩", this, menu_selector(HelloWorld::restartFn));
    gameOverItem->setFontName("MarkerFelt-Thin");
    gameOverItem->setFontSize(30);
    cocos2d::CCMenu *restart = CCMenu::create(gameOverItem,NULL);
    restart->setPosition(ccp(160, 200));
    this->addChild(restart,4);
}

void HelloWorld::restartFn()
{
    //__cnt = 1;
    this->removeAllChildren();
    this->getPlanes()->removeAllObjects();
    this->initData();
    this->loadBackground();
    this->loadPlayer();
    this->madeBullet();
    this->resetBullet();
    
}

