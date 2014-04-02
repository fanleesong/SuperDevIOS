//
//  GameScene.cpp
//  shows
//
//  Created by 范林松 on 14-3-23.
//
//

#include "GameScene.h"

const int MAX_NUMBER_FISH = 60;//场内最多鱼的数量
const float weapon_scale=1.5f;
const float maxEnergyRotation=150;
const float minEnergyRotation=30;
//const int originGold = 20;
const CCSize allSize = WINSIZE_BYDIRECT;
GameScene::GameScene(){

}

CCScene * GameScene::scene(){
    CCScene *scene;
    do {
        scene = CCScene::create();
        CC_BREAK_IF(!scene);
        GameScene *layer = GameScene::create();
        CC_BREAK_IF(!layer);
        scene->addChild(layer);
    } while (0);
    return scene;
}

#pragma mark-
#pragma mark--//初始化层
bool GameScene::init(){
    if (!CCLayer::init()) {
        return false;
    }
    this->setTouchEnabled(true);
    maxEnergy=1000;
    this->loadTexture();
    this->initGameScene();
    this->schedule(schedule_selector(GameScene::updateFish),0.5f);
    this->schedule(schedule_selector(GameScene::updateHit),0.1f);
    this->schedule(schedule_selector(GameScene::changeBackground),18.0f);
//    this->schedule(schedule_selector(GameScene::checkScore),0.1f);
    this->stopOrPlay();

 
    return true;
}

#pragma mark-
#pragma mark--//初始化场景
void GameScene::initGameScene(){
    
    CCSize winSize = WINSIZE_BYDIRECT;
    
    CCSprite *bgSprite = CCSprite::create("bj00.jpg");
    bgSprite->setScale(2.0f);
    bgSprite->setScaleX(2.5f);
    bgSprite->setPosition(ccp(winSize.width/2, winSize.height/2));
    this->addChild(bgSprite,0);
    //大炮
    char tempCanon[50];
    sprintf(tempCanon,"actor_cannon1_%i1.png",1);
    weapon = (Weapon *)CCSprite::createWithSpriteFrameName(tempCanon);
    weapon->weaponLevel = 1;
    weaponLevel = 1;//本类
    weapon->setScale(weapon_scale);
    weapon->setPosition(ccp(winSize.width/2, 75));
    weapon->weaponType = normal;
    this->addChild(weapon,102);

    CCSprite *energyBox = CCSprite::create("ui_2p_004.png");
    energyBox->setScale(2.0f);
    energyBox->setPosition(CCPoint(ccp(winSize.width/2,10)));
    this->addChild(energyBox,99);

    energyPointer = CCSprite::create("ui_2p_005.png");
    energyPointer->setScale(2.0f);
    energyPointer->setPosition(CCPoint(ccp(winSize.width/2,10)));
    this->addChild(energyPointer,90);
    
    //添加顶部框体
    CCSprite *backGroundExp = CCSprite::create("ui_box_01.png");
    backGroundExp->setScale(1.5f);
    backGroundExp->setPosition(ccp(winSize.width/2,winSize.height));
    backGroundExp->setAnchorPoint(ccp(0.5f,1.0f));
    this->addChild(backGroundExp,101);
    

    
    //底部框体
    CCSprite *backGroundBottom = CCSprite::create("ui_box_02.png");
    backGroundBottom->setScale(1.5f);
    backGroundBottom->setScaleX(2.5f);
    backGroundBottom->setScaleY(2);
    backGroundBottom->setPosition(ccp(winSize.width/2 - 90,0));
    backGroundBottom->setAnchorPoint(ccp(0.5f,0));
    this->addChild(backGroundBottom,101);
    
    CCMenuItemFont *addItem = CCMenuItemFont::create("+", this, menu_selector(GameScene::addWeaponLevel));
    addItem->setFontSize(72.0f);
    addItem->setScale(1.5f);
    addItem->setFontName("Arial");
    CCMenu *addMenu = CCMenu::create(addItem,NULL);
    addMenu->setPosition(ccp(winSize.width/2+75, 10));
    addMenu->alignItemsVertically();
    this->addChild(addMenu,202);
    
    CCMenuItemFont *reduceItem = CCMenuItemFont::create("-", this, menu_selector(GameScene::reduceWeaponLevel));
    reduceItem->setFontSize(72.0f);
    reduceItem->setScale(1.5f);
    reduceItem->setFontName("Arial");
    CCMenu *reduceMenu = CCMenu::create(reduceItem,NULL);
    reduceMenu->setPosition(ccp(winSize.width/2-70, 30));
    reduceMenu->alignItemsVertically();
    this->addChild(reduceMenu,202);
    
    //金币
//    gold = (Roll *)Roll::create();
//    gold->setNumber(originGold);
//    gold->setPosition(ccp(168,10));
//    this->addChild(gold,202);
    
}

#pragma mark-
#pragma mark--//加载缓存图片
void GameScene::loadTexture(){
    
    //加载大炮
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("cannon.plist");
    cannonSheet = CCSpriteBatchNode::create("cannon.png");
    this->addChild(cannonSheet,102);

    
    //加载鱼
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("fish.plist");
    fishSheet = CCSpriteBatchNode::create("fish.png");
    this->addChild(fishSheet,12);
    
    //加载子弹
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("bullet.plist");
    bulletSheet = CCSpriteBatchNode::create("bullet.png");
    this->addChild(bulletSheet,13);
    
    //加载网
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("net.plist");
    netSheet = CCSpriteBatchNode::create("net.png");
    this->addChild(netSheet,14);
    
    //加载金币
    CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("8goldItem.plist");
    goldItemSheet = CCSpriteBatchNode::create("8goldItem.png");
    this->addChild(goldItemSheet,15);
    
}
#pragma mark--子弹发射碰撞是的音效
void GameScene::playBoundingEffectsMusic(){
    SimpleAudioEngine::sharedEngine()->playEffect("bg_music03.caf");
    SimpleAudioEngine::sharedEngine()->setEffectsVolume(0.5f);

}


#pragma mark-
#pragma mark--//向场景中添加鱼
void GameScene::addFish(){
    
    int number = 10;
    int type = rand()%11+1;
    CCArray *oneFish = CCArray::create();
    char temp[100];
    for(int i=1;i<number;i++){
        sprintf(temp,"fish0%i_0%i.png",type,i);
        CCSpriteFrame *spriteFrame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(temp);
        CCAnimationFrame *animateFrame = new CCAnimationFrame();
        animateFrame->autorelease();
        animateFrame->initWithSpriteFrame(spriteFrame,1,NULL);
        oneFish->addObject(animateFrame);
    }
    CCAnimation *animation = CCAnimation::create(oneFish, 0.1f);
    CCAnimate *animate = CCAnimate::create(animation);
    CCRepeatForever *fishAction = CCRepeatForever::create(animate);
    char tempFish[100];
    sprintf(tempFish,"fish0%i_0%i.png",type,1);
    Fish *fishs = (Fish *)Fish::createWithSpriteFrameName(tempFish);
    fishs->setScale(1.0f);
    fishs->fishLevel = type;
    fishs->isCatched = false;
    fishs->runAction(fishAction);
    fishs->addPath();
    fishs->run();
    fishSheet->addChild(fishs);
}


#pragma mark-
#pragma mark--//不断更新场景中的鱼
void GameScene::updateFish(){
    if(fishSheet->getChildren()->count()< MAX_NUMBER_FISH){
        this->addFish();
    }
}

#pragma mark-
#pragma mark--//更新碰撞
void GameScene::updateHit(){

    CCSize winSize = WINSIZE_BYDIRECT;
    Fish *fish;
    Bullet *bullet;
    Net *net;
//    Gold *golden;
    CCScaleTo *scale0 = CCScaleTo::create(0.3f,3.0f);
    CCScaleTo *scale1 = CCScaleTo::create(0.3f,0.8f);
    CCObject *bulletObject = NULL;
    //遍历子弹
    CCARRAY_FOREACH(bulletSheet->getChildren(),bulletObject){
        bullet = (Bullet *)bulletObject;
        if(bullet->isHit){
            continue;
        }
        if(bullet->getPosition().x>(winSize.width+bullet->getContentSize().width)||
           bullet->getPosition().x<(-bullet->getContentSize().width)){
            continue;
        }
        CCObject *fishObject = NULL;
        /*******************检测鱼和子弹碰撞**************************/
        CCARRAY_FOREACH(fishSheet->getChildren(),fishObject){
            fish = (Fish *)fishObject;
            if(bullet->isHit){
                continue;
            }
            if (fish->boundingBox().intersectsRect(bullet->boundingBox())) {
                this->playBoundingEffectsMusic();//播放音效
                bullet->isHit = true;
                char temp[100];
                sprintf(temp,"net0%i.png",weaponLevel);
                Net *net = (Net *)Net::createWithSpriteFrameName(temp);
                net->setPosition(bullet->getPosition());
                CCMoveTo *moveTo = CCMoveTo::create(0.03f, ccp(bullet->getPosition().x-10,bullet->getPosition().y+40));
                bulletSheet->removeChild(bullet,true);//移除子弹
                netSheet->addChild(net);
                CCCallFuncO *scaleNetAfterShow = CCCallFuncO::create(this, callfuncO_selector(GameScene::afterShowNet), net);
                CCSequence *netSequence = CCSequence::create(moveTo,scale0,scale1,scale0,scale1,scaleNetAfterShow,NULL);
                net->runAction(netSequence);
            }
        }
    }
    /***************************检测渔网和鱼碰撞***************************/
    CCObject *netObject = NULL;
    CCARRAY_FOREACH(netSheet->getChildren(),netObject){
        net = (Net *)netObject;
        if(net->isHit){
            continue;
        }
        CCObject *fishObject1 = NULL;
        CCARRAY_FOREACH(fishSheet->getChildren(), fishObject1){
            fish = (Fish *)fishObject1;
            if(fish->isCatched){
                continue;
            }
            if (net->boundingBox().intersectsRect(fish->boundingBox())) {
                if(!(fish->randomCatch(weaponLevel))){
                    continue;
                }else{
                    fish->isCatched = true;
                    this->updateEnergy(fish->fishLevel);
                    CCArray *fishes = CCArray::create();
                    int number;
                    if(fish->fishLevel < 8){
                        number = 3;
                    }else{
                        number = 5;
                    }
                    for(int i=1;i<number;i++){
                        char temp[100];
                        sprintf(temp,"fish0%i_catch_0%i.png",fish->fishLevel,i);
                        CCSpriteFrame *spriteFrame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(temp);
                        CCAnimationFrame *animateFrame = new CCAnimationFrame();
                        animateFrame->autorelease();
                        animateFrame->initWithSpriteFrame(spriteFrame,1, NULL);
                        fishes->addObject(animateFrame);
                    }
                    CCAnimation *animation = CCAnimation::create(fishes,0.2f);
                    CCAnimate *animate = CCAnimate::create(animation);
                    CCActionInterval *fishCatchAction = CCRepeat::create(animate, 2);
                    CCCallFuncO *func0 = CCCallFuncO::create(this,callfuncO_selector(GameScene::afterCatch),fish);
                    CCSequence *animalSequence = CCSequence::create(fishCatchAction,func0);
                    fish->stopAllActions();
                    fish->runAction(animalSequence);
                    //金币
                    CCSprite *money = CCSprite::create("+5.png");
                    money->setPosition(fish->getPosition());//与鱼的位置相同
                    CCMoveTo *move = CCMoveTo::create(0.6,CCPointMake(120,20));
                    CCCallFuncO *moneyAfterShow = CCCallFuncO::create(this,callfuncO_selector(GameScene::afterShowMoney), money);
                    CCSequence *moneySequence = CCSequence::create(scale0,scale1,scale0,scale1,move,moneyAfterShow,NULL);
                    money->runAction(moneySequence);
                    this->addChild(money,109);
//                    char tempGold[100];//金币
//                    sprintf(tempGold,"gold0%i.png",1);
//                    golden = (Gold *)Gold::createWithSpriteFrameName(tempGold);
//                    golden->setPosition(ccp(money->getPosition().x - money->getContentSize().width/2,money->getPosition().y - money->getContentSize().height/2));
//                    CCArray *goldArray = CCArray::create();
//                    for (int i = 1; i<=9; i++) {
//                        char temp[100];
//                        sprintf(temp,"gold0%i.png",i);
//                        CCSpriteFrame *spriteFrame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(temp);
//                        CCAnimationFrame *animateFrame = new CCAnimationFrame();
//                        animateFrame->autorelease();
//                        animateFrame->initWithSpriteFrame(spriteFrame,1,NULL);
//                        goldArray->addObject(animateFrame);
//                    }
//                    CCAnimation *goldAnimation = CCAnimation::create(goldArray,0.02f);
//                    CCAnimate *goldAnimate = CCAnimate::create(goldAnimation);
//                    CCActionInterval *goldAction = CCRepeat::create(goldAnimate,2);
//                    CCCallFuncO *afterShowGoldens = CCCallFuncO::create(this,callfuncO_selector(GameScene::afterShowGoldens),golden);
//                    CCMoveTo *goldenMove = CCMoveTo::create(0.15,CCPointMake(120,20));
//                    CCSequence *goldenSequence = CCSequence::create(goldAction,goldenMove,afterShowGoldens,NULL);
//                    golden->runAction(goldenSequence);
//                    this->addChild(golden,101);
                    CCCallFuncO *scoreShow = CCCallFuncO::create(this,callfuncO_selector(GameScene::scoreShow), NULL);
                    CCActionInterval *acitonInterval = CCActionInterval::create(0.5);
                    CCSequence *scoreSequence = CCSequence::create(acitonInterval,scoreShow,NULL);
                    money->runAction(scoreSequence);
                }
            }
        }else{
//            gold->setNumber(gold->getNumber()-5);
        }
        net->isHit = true;
    }


}

#pragma mark-
#pragma mark--//暂停或开始
void GameScene::stopOrPlay(){
    
    CCSize winSize = WINSIZE_BYDIRECT;
    CCSprite *stopSprite = CCSprite::create("pause.png");
    CCSprite *playSprite = CCSprite::create("play.png");
    CCMenuItemSprite *stopItem = CCMenuItemSprite::create(stopSprite,NULL, this,menu_selector(GameScene::pause));
    CCMenuItemSprite *playItem = CCMenuItemSprite::create(playSprite,NULL, this,menu_selector(GameScene::play));
    CCMenu *didClick = CCMenu::create(stopItem,playItem,NULL);
    didClick->setScale(1.5f);
    didClick->alignItemsHorizontally();
    didClick->alignItemsHorizontallyWithPadding(25.0f);
    didClick->setPosition(ccp(winSize.width/2+750,winSize.height/2+450));
    this->addChild(didClick,203);

}

#pragma mark-
#pragma mark--//移除网
void GameScene::removeNet(CCSprite *sender){

    CCSprite *sprite = (CCSprite *)sender;
    sprite->removeFromParentAndCleanup(true);


}
#pragma mark
#pragma mark--暂停
void GameScene::pause(){
    CCSize winSize = WINSIZE_BYDIRECT;
    CCDirector::sharedDirector()->pause();
    this->setTouchEnabled(false);
    SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
    if (!this->getChildByTag(300)) {
        CCLayerColor *showLayer = CCLayerColor::create(ccc4(0, 0,0,150),winSize.width,winSize.height);
        showLayer->setTag(300);
        CCMenuItemFont *goOnMenuItem = CCMenuItemFont::create("继续游戏",this,menu_selector(GameScene::play));
        CCMenuItemFont *goBackUIMenuItem = CCMenuItemFont::create("回主界面",this,menu_selector(GameScene::gobackMainUI));
        CCMenu *menu = CCMenu::create(goOnMenuItem,goBackUIMenuItem,NULL);
        menu->alignItemsVertically();
        menu->alignItemsVerticallyWithPadding(18);
        showLayer->addChild(menu,301);
        this->addChild(showLayer,300);
    }
}

#pragma mark-
#pragma mark---开始
void GameScene::play(){
    
    CCDirector::sharedDirector()->resume();
    this->setTouchEnabled(true);
//    CCLog("%s",currentMusicString);
    SimpleAudioEngine::sharedEngine()->playBackgroundMusic(currentMusicString);
    if (this->getChildByTag(300)) {
        this->removeChildByTag(300, true);
    }

}


#pragma mark-
#pragma mark--//更新
void GameScene::updateEnergy(int addEnergy){

    energy += addEnergy;
//    CCLog("%i",energy);
    float rotate = ((float)energy/maxEnergy)*(maxEnergyRotation-minEnergyRotation)+minEnergyRotation;
    energyPointer->setRotation(rotate);

}
#pragma mark-
#pragma mark--//检查分数
//void GameScene::checkScore(){
//
//    if(gold->getNumber() <= 0){
//        CCDirector::sharedDirector()->pause();
//        this->setTouchEnabled(false);
//        SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
//        if (! this->getChildByTag(350)) {
//            CCLayerColor *showLayer = CCLayerColor::create(ccc4(0, 0,0, 150),480, 320);
//            showLayer->setTag(300);
//            CCMenuItemFont *showMessageMenuItem = CCMenuItemFont::create("对不起您的游戏失败，请返回主界面");
//            showMessageMenuItem->setFontSize(72);
//            showMessageMenuItem->setScale(2.0f);
//            CCMenuItemFont *goBackUIMenuItem = CCMenuItemFont::create("返回主界面",this,menu_selector(GameScene::gobackMainUI));
//            goBackUIMenuItem->setFontSize(72);
//            goBackUIMenuItem->setScale(2.0f);
//            CCMenu *menu = CCMenu::create(showMessageMenuItem,goBackUIMenuItem,NULL);
//            menu->alignItemsVertically();
//            showLayer->addChild(menu,350);
//            this->addChild(showLayer,301);
//        }
//    }
//}
#pragma mark-
#pragma mark-------返回主界面
void GameScene::gobackMainUI(){
    
    if (this->getChildByTag(300)) {
        this->removeChildByTag(300,true);
    }
    CCDirector::sharedDirector()->replaceScene(GameScene::scene());
    CCDirector::sharedDirector()->resume();

}


#pragma mark-
#pragma mark--实时更换背景
void GameScene::changeBackground(){

    int i = rand()%3;
    CCSize winSize = WINSIZE_BYDIRECT;
    //背景图片
    char tempBgImge[50];
    char tempBgMusic[50];
    sprintf(tempBgImge,"bj0%i.jpg",i);
    sprintf(tempBgMusic,"bg_music0%i.caf",i);
    CCSprite *changeBackground = CCSprite::create(tempBgImge);
    changeBackground->setScale(2.0f);
    changeBackground->setScaleX(2.5f);
    //更换背景音乐
    SimpleAudioEngine::sharedEngine()->playBackgroundMusic(tempBgMusic);
    SimpleAudioEngine::sharedEngine()->setBackgroundMusicVolume(0.02f);
    sprintf(currentMusicString,"bg_music0%i.caf",i);
    changeBackground->setPosition(ccp(winSize.width /2,winSize.height/2));
    if (this->getChildByTag(i)) {
        this->getChildByTag(i)->removeFromParentAndCleanup(true);
    }
    this->setTag(i);
    this->addChild(changeBackground,0);

}

#pragma mark-
#pragma mark--Touches Event
void GameScene::ccTouchesBegan(CCSet *pTouches,CCEvent *pEvent){
    
    //大炮旋转
    CCTouch *touch = (CCTouch *)pTouches->anyObject();
    CCPoint position = touch->getLocationInView();
    position = CCDirector::sharedDirector()->convertToGL(position);
    if (position.y <= weapon->getPosition().y) {
        return;
    }
    if (weapon->weaponType == laser) {
        
    }else{
        char temp[50];
        sprintf(temp,"actor_cannon1_%i2.png",weapon->weaponLevel);
        weapon->setDisplayFrame(CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(temp));
    }
    this->setAngle(position, NULL);

    
}
void GameScene::ccTouchesMoved(CCSet *pTouches,CCEvent *pEvent){
    
    CCTouch *touch = (CCTouch *) pTouches->anyObject();
    CCPoint position = touch->getLocationInView();
    position = CCDirector::sharedDirector()->convertToGL(position);
    this->setAngle(position, NULL);

}
void GameScene::ccTouchesEnded(CCSet *pTouches,CCEvent *pEvent){
    
    //要能添加子弹
    CCSize size = WINSIZE_BYDIRECT;
    CCTouch *touch = (CCTouch *) pTouches->anyObject();
    CCPoint position = touch->getLocationInView();
    position = CCDirector::sharedDirector()->convertToGL(position);
    
    int offX=position.x-weapon->getPosition().x;
    int offY=position.y-weapon->getPosition().y;
    //如果是超级子弹
    if(weapon->weaponType == laser){
        
    }else{
        //子弹处理
        char temp[50];
        sprintf(temp,"bullet0%i.png",weapon->weaponLevel);
        Bullet *bullet = (Bullet *)Bullet::createWithSpriteFrameName(temp);
        bullet->setScale(2.5f);//子弹大小
        bullet->setPosition(weapon->getPosition());
        bullet->isHit = false;
        this->setAngle(position, bullet);//设置子弹角度
        int realY=size.height + weapon->getContentSize().height/2;
        float ratio=(float)offX/(float)offY;
        int realX=(realY-weapon->getPosition().y)*ratio+weapon->getPosition().x;
        CCPoint realDest=ccp(realX,realY);
        //偏移位置
        int offRealX=realX-weapon->getPosition().x;
        int offRealY=realY-weapon->getPosition().y;
        float length=sqrtf((offRealX * offRealX) + (offRealY * offRealY));
        float velocity=240/1;
        float realMoveDuration=length/velocity;
        
        CCMoveTo *moveTo = CCMoveTo::create(realMoveDuration, realDest);
        CCCallFuncO *removeBullet= CCCallFuncO::create(this, callfuncO_selector(GameScene::removeBullet), bullet);
        CCSequence *bulletSeque = CCSequence::create(moveTo,removeBullet,NULL);
        bullet->setRotation(weapon->getRotation());
        bullet->runAction(bulletSeque);
        bulletSheet->addChild(bullet);
    }
}

#pragma mark-
#pragma mark--//大炮旋转角度
void GameScene::setAngle(CCPoint point,CCSprite *sprite){
    
    int offX = point.x - weapon->getPosition().x;
    int offY = point.y - weapon->getPosition().y;
    if(offY <= 0){
        return;
    }
    //求出角度--x和y的长度<以大炮位置为(0,0)点>
    float ratio = (float)offY/(float)offX;
    //tan值
    float angle = atanf(ratio)/M_PI*180;
    if(angle<0){
        weapon->setRotation(-(90+angle));
        if (sprite) {//子弹跟着大炮角度转
          sprite->setRotation(weapon->getRotation());
        }
    }else if(angle>0){
        weapon->setRotation(90-angle);
        if (sprite) {
            sprite->setRotation(weapon->getRotation());
        }
    }
    
}
#pragma mark-
#pragma mark----显示分数
void GameScene::scoreShow(){
    
//    gold->setNumber(gold->getNumber()+5);

}
#pragma mark
#pragma mark----显示金币后移除
void GameScene::afterShowGoldens(CCSprite *pSprite){
    
    CCSprite *sprite = (CCSprite *)pSprite;
    if(sprite != NULL){
        sprite->removeFromParentAndCleanup(true);
    }
    
}
#pragma mark-
#pragma mark---显示钱之后移除
void GameScene::afterShowMoney(CCSprite *pSprite){
    CCSprite *sprite = (CCSprite *)pSprite;
    if(sprite != NULL){
        sprite->removeFromParentAndCleanup(true);
    }
}
#pragma mark-
#pragma mark-移除被捕鱼-
void GameScene:: afterCatch(CCSprite *pSprite){
    CCSprite *sprite = (CCSprite *)pSprite;
    if(sprite != NULL){
        fishSheet->removeChild(sprite,true);
    }
}
#pragma mark-
#pragma mark-移除网-
void GameScene::afterShowNet(CCSprite *pSprite){
    CCSprite *sprite = (CCSprite *)pSprite;
    if(sprite != NULL){
        netSheet->removeChild(sprite, true);
    }
}
#pragma mark-
#pragma mark-移除子弹-
void GameScene::removeBullet(CCSprite *pSprite){
    CCSprite *sprite = (CCSprite *)pSprite;
    if(sprite){
//        gold->setNumber(gold->getNumber()-5);
        bulletSheet->removeChild(sprite,true);
    }
}

#pragma mark-
#pragma mark--//减大炮级别
void GameScene::reduceWeaponLevel(){

    CCSize winSize = WINSIZE_BYDIRECT;
    weaponLevel--;
    if(weaponLevel == 0){
        weaponLevel = 7;
    }
    CCScaleTo *narrow = CCScaleTo::create(0.1f,0.03);
    CCCallFuncO *removeWeapon = CCCallFuncO::create(this,callfuncO_selector(GameScene::removeWeapon), weapon);
    CCSequence *bowDismissSequence = CCSequence::create(narrow,removeWeapon,NULL);
    weapon->runAction(bowDismissSequence);
    
    char temp[50];
    sprintf(temp,"actor_cannon1_%i1.png",weaponLevel);
    weapon = (Weapon*)CCSprite::createWithSpriteFrameName(temp);
    weapon->weaponLevel = weaponLevel;
    weapon->setPosition(ccp(winSize.width/2,75));
    weapon->setScale(0.03f);
    CCDelayTime *delayTime = CCDelayTime::create(0.1f);
    CCScaleTo *appear = CCScaleTo::create(0.1f,weapon_scale);
    CCSequence *bowAppearSequence = CCSequence::create(delayTime,appear,NULL);
    weapon->runAction(bowAppearSequence);
    cannonSheet->addChild(weapon,102);
    
}
#pragma mark-
#pragma mark--//添加大炮级别
void GameScene::addWeaponLevel(){

    CCSize winSize = WINSIZE_BYDIRECT;
    weaponLevel++;
    if(weaponLevel == 8){
        weaponLevel = 1;
    }
    CCScaleTo *narrow = CCScaleTo::create(0.1f,0.03);
    CCCallFuncO *removeWeapon = CCCallFuncO::create(this,callfuncO_selector(GameScene::removeWeapon),weapon);
    CCSequence *bowDismissSequence = CCSequence::create(narrow,removeWeapon,NULL);
    weapon->runAction(bowDismissSequence);
    
    char temp[50];
    sprintf(temp,"actor_cannon1_%i1.png",weaponLevel);
    weapon = (Weapon *)CCSprite::createWithSpriteFrameName(temp);
    weapon->weaponLevel = weaponLevel;
    weapon->setScale(0.03f);
    weapon->setPosition(ccp(winSize.width/2, 75));
    CCDelayTime *delayTime = CCDelayTime::create(0.1f);
    CCScaleTo *appear = CCScaleTo::create(0.1f,weapon_scale);
    CCSequence *bowAppearSequence = CCSequence::create(delayTime,appear,NULL);
    weapon->runAction(bowAppearSequence);
    cannonSheet->addChild(weapon,102);

}
#pragma mark-
#pragma mark-移除大炮-
void GameScene::removeWeapon(CCSprite *pSprite){
    CCSprite *sprite = (CCSprite *)pSprite;
    sprite->removeFromParentAndCleanup(true);

}

GameScene::~GameScene(){


}







