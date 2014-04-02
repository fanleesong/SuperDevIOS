//
//  GameScene.cpp
//  ZombiesVSPlants
//
//  Created by 范林松 on 14-3-31.
//
//

#include "GameScene.h"
#include "GlobalData.h"
#include "SimpleAudioEngine.h"
#include "Plants.h"
#include "Bullets.h"
#include "PassScene.h"
#include "FailScene.h"

using namespace cocos2d;
using namespace std;
using namespace CocosDenshion;
USING_NS_CC;


GameScene::GameScene(){


}
GameScene::~GameScene(){



}
bool GameScene::init(){

   bool bRet = false;
    do {
        CC_BREAK_IF(!CCLayer::init());
        
        CCSize size = GET_WINDOWSIZE;
        
        CCSpriteFrameCache* cache=CCSpriteFrameCache::sharedSpriteFrameCache();
        cache->addSpriteFramesWithFile("Sun_default.plist");
        
        menuSprite = CCSprite::create("SeedChooser_Background.png");
        menuSprite->setScale(1.5f);
        menuSprite->setPosition(ccp(size.width/2-100, -190));
        this->addChild(menuSprite, 1);
        //移动选择植物菜单
        CCMoveTo* moveToMenu = CCMoveTo::create(2, ccp(size.width/2-100,size.height/2-140));
        CCSequence* seq2 = CCSequence::create(CCDelayTime::create(2), moveToMenu, NULL);
        menuSprite->runAction(seq2);
        
        //房子
        char backgroundLevel[20];
        sprintf(backgroundLevel, "level%d.jpg",LEVEL);
        pSprite = CCSprite::create(backgroundLevel);
        pSprite->setScaleX(2.0f);
        pSprite->setScaleY(2.0f);
        pSprite->setPosition(ccp(size.width/2+170,size.height/2));
        this->addChild(pSprite, 0);
        
        //创建YourHouse文字
        CCSprite* yourhouse = CCSprite::create("yourhouse.png");
        yourhouse->setScale(1.5f);
        yourhouse->setScaleY(2);
        yourhouse->setPosition(ccp(size.width/2-150, size.height/2+120));
        this->addChild(yourhouse,1);
        CCBlink* blink = CCBlink::create(2, 3);
        CCCallFuncN* func = CCCallFuncN::create(this, callfuncN_selector(GameScene::removeSprite));
        CCSequence* seq4 = CCSequence::create(blink, func, NULL);
        yourhouse->runAction(seq4);
        
        //移动场景
        CCMoveTo* moveto = CCMoveTo::create(2, ccp(size.width/2-130,size.height/2));
        CCSequence* seq3 = CCSequence::create(CCDelayTime::create(2), moveto, NULL);
        pSprite->runAction(seq3);
        
        //添加菜单
        this->addMenu();
        
        //菜单移动
        barMenuSprite = CCSprite::create("barMenu1.png");
        barMenuSprite->setScaleX(1.3f);
        barMenuSprite->setScaleY(1.5f);
        barMenuSprite->setPosition(ccp(size.width/2-180,size.height/2+280));
        CCMoveTo* moveToBarMenu = CCMoveTo::create(2, ccp(size.width/2-110,size.height/2+280));
        this->addChild(barMenuSprite, 1);
        CCSequence* seq1 = CCSequence::create(CCDelayTime::create(2), moveToBarMenu, NULL);
        barMenuSprite->runAction(seq1);
        
        
        //添加太阳图标
        CCSprite* sun2Sprite = CCSprite::create("sun2.png");
        sun2Sprite->setPosition(ccp(35,30));
        sun2Sprite->setScaleY(0.8);
        sun2Sprite->setScaleX(0.9);
        barMenuSprite->addChild(sun2Sprite);
        
        //添加太阳显示图标
        CCSprite* sunNumSprite = CCSprite::create("sunNum.png");
        sunNumSprite->setPosition(ccp(35,10));
        sunNumSprite->setScaleY(0.5);
        barMenuSprite->addChild(sunNumSprite, 2);
        

        //初始化数组
        plantsMenuArray = CCArray::create();
        plantsMenuArray->retain();
        
        plantsSpriteArray = CCArray::create();
        plantsSpriteArray->retain();
        
        plantsArray = CCArray::create();
        plantsArray->retain();
        
        zoombieArray = CCArray::create();
        zoombieArray->retain();
        
        carArray = CCArray::create();
        carArray->retain();
        
        beforeZombie = CCArray::create();
        beforeZombie->retain();
        this->initFlag();
        
        //初始化子弹数组
        bulletArray = CCArray::create();
        bulletArray->retain();
        
        //初始化太阳的个数
        //SunNumber = 500;
        sunNumberLB = CCLabelTTF::create("50", "Verdana-Bold", 15);
        sunNumberLB->setPosition(ccp(20, 10));
        sunNumberLB->setScaleY(1.4);
        sunNumberLB->setColor(ccc3(0, 0, 255));
        sunNumSprite->addChild(sunNumberLB, 2);
        
        //注册触摸代理
        CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this, 0, false);
        
        //时间调度
        this->schedule(schedule_selector(GameScene::createSunshine), 1);//产生阳光
        this->schedule(schedule_selector(GameScene::createShoote), 0.6);//产生子弹
        this->schedule(schedule_selector(GameScene::setSunNumberLB), 0.1);
        
        plantsIsPlanted = true;
        
        this->LevelBar();
        this->initBeforeZombie();
        //this->schedule(schedule_selector(GameScene::setLevelBar), 1);
        
        //关卡显示
        CCLabelTTF* labelLevel = CCLabelTTF::create(" ", "TrebuchetMS", 50);
        char label[20];
        sprintf(label, "第  %d  关", LEVEL);
        labelLevel->setPosition(ccp(420, 270));
        labelLevel->setColor(ccc3(255, 0, 0));
        this->addChild(labelLevel);
        labelLevel->setString(label);

        
        bRet = true;
    } while (0);
    
    return bRet;
}
#pragma mark---移除精灵
void GameScene::removeSprite(CCSprite *sprite){

    sprite->removeFromParent();
    
}
#pragma mark--添加菜单
void GameScene::addMenu(){

    //添加樱桃
    CCMenuItemToggle* toggleCherry = this->createMenuItem("CherryBomb.png", "CherryBomb 副本.png",101);
    toggleCherry->setSelectedIndex(0);//设置成彩色的；
    //添加食人花
    CCMenuItemToggle* toggleChomper = this->createMenuItem("Chomper.png", "Chomper 副本.png", 102);
    
    //添加尖椒
    CCMenuItemToggle* toggleJalapeno = this->createMenuItem("Jalapeno.png", "Jalapeno 副本.png", 103);
    
    //添加荷叶
    CCMenuItemToggle* toggleLilyPad = this->createMenuItem("LilyPad.png", "LilyPad 副本.png", 104);
    
    //添加射豆枪（100）
    CCMenuItemToggle* togglePeaShooter = this->createMenuItem("PeaShooter.png", "PeaShooter 副本.png", 105);
    
    //添加射豆枪（200）
    CCMenuItemToggle* toggleRepeater = this->createMenuItem("Repeater.png", "Repeater 副本.png", 106);
    
    //添加南瓜
    CCMenuItemToggle* toggleSquash = this->createMenuItem("Squash.png", "Squash 副本.png", 107);
    
    //添加向日葵
    CCMenuItemToggle* toggleSunFlower = this->createMenuItem("SunFlower.png", "SunFlower 副本.png", 108);
    
    //添加坚果
    CCMenuItemToggle* toggleTallNut = this->createMenuItem("TallNut.png", "TallNut 副本.png", 109);
    
    //添加三枪射豆枪
    CCMenuItemToggle* toggleThreepeater = this->createMenuItem("Threepeater.png", "Threepeater 副本.png", 110);
    
    //添加坚果墙
    CCMenuItemToggle* toggleWallNut = this->createMenuItem("WallNut.png", "WallNut 副本.png", 111);
    
    //添加重置按钮
    CCMenuItemImage* selectReset = CCMenuItemImage::create("selectReset0.png","selectReset1.png");
    selectReset->setTarget(this, menu_selector(GameScene::resetBarMenu));
    
    //添加确定按钮
    CCMenuItemImage* selectSure = CCMenuItemImage::create("selectSure0.png", "selectSure1.png");
    selectSure->setTarget(this, menu_selector(GameScene::beSure));
    
    CCMenu* menu1 = CCMenu::create(toggleCherry, toggleChomper, toggleJalapeno, toggleLilyPad, togglePeaShooter, toggleRepeater, NULL);
    menu1->setPosition(ccp(170,190));
    menu1->alignItemsHorizontallyWithPadding(-20);
    menu1->setTag(601);
    menuSprite->addChild(menu1);
    
    CCMenu* menu2 = CCMenu::create(toggleSquash, toggleSunFlower, toggleTallNut, toggleThreepeater, toggleWallNut, NULL);
    menu2->setPosition(ccp(140,120));
    menu2->alignItemsHorizontallyWithPadding(-20);
    menu2->setTag(602);
    menuSprite->addChild(menu2);
    
    CCMenu* menu3 = CCMenu::create(selectReset, selectSure, NULL);
    menu3->setPosition(ccp(170,50));
    menu3->alignItemsHorizontallyWithPadding(30);
    menu3->setTag(603);
    menuSprite->addChild(menu3);
    
}
#pragma mark-创建菜单
CCMenuItemToggle* GameScene::createMenuItem(const char *plantName1, const char *plantName2, int tag){

    CCMenuItemImage* image = CCMenuItemImage::create(plantName1, plantName1);
    image->setScale(0.5);
    CCMenuItemImage* image1 = CCMenuItemImage::create(plantName2, plantName2);
    image1->setScale(0.5);
    CCMenuItemToggle* toggle = CCMenuItemToggle::createWithTarget(this, menu_selector(GameScene::plantsMenu), image,image1, NULL);
    toggle->setTag(tag);
    return toggle;
    
}
#pragma mark--植物菜单
void GameScene::plantsMenu(CCNode* object){
    
    CCSize size = GET_WINDOWSIZE;
    
    //获取对象的tag值
    int plantsTag = object->getTag();
    CCMenuItemToggle* plantsToggle = (CCMenuItemToggle*)object;
    //声明变量
    CCSprite* cherry;
    CCSprite* chomper;
    CCSprite* jalapeno;
    CCSprite* lilypad;
    CCSprite* peashooter;
    CCSprite* repeater;
    CCSprite* squash;
    CCSprite* sunflower;
    CCSprite* tallnut;
    CCSprite* threepeater;
    CCSprite* wallnut;
    //barItem 位置ccp(size.width/2-110,size.height/2+280)
    if (plantsMenuArray->count()<6) {
        switch (plantsTag) {
            case CHERRY:
                cherry = CCSprite::create("CherryBomb.png");
                cherry->setPosition(ccp(30,190));
                cherry->setScale(0.4);
                plantsSpriteArray->addObject(cherry);
                cherry->setTag(501);
                this->addChild(cherry, 1);
                plantsToggle->setEnabled(false);//菜单按钮不可用
                break;
            case CHOMPER:
                chomper = CCSprite::create("Chomper.png");
                chomper->setPosition(ccp(80,190));
                chomper->setScale(0.4);
                plantsSpriteArray->addObject(chomper);
                chomper->setTag(502);
                this->addChild(chomper, 1);
                plantsToggle->setEnabled(false);//菜单按钮不可用
                break;
            case JALAPENO:
                jalapeno = CCSprite::create("Jalapeno.png");
                jalapeno->setPosition(ccp(130,190));
                jalapeno->setScale(0.4);
                plantsSpriteArray->addObject(jalapeno);
                jalapeno->setTag(503);
                this->addChild(jalapeno, 1);
                plantsToggle->setEnabled(false);//菜单按钮不可用
                break;
            case LILYPAD:
                lilypad = CCSprite::create("LilyPad.png");
                lilypad->setPosition(ccp(190,190));
                lilypad->setScale(0.4);
                plantsSpriteArray->addObject(lilypad);
                lilypad->setTag(504);
                this->addChild(lilypad, 1);
                plantsToggle->setEnabled(false);//菜单按钮不可用
                break;
            case PEASHOOTER:
                peashooter = CCSprite::create("PeaShooter.png");
                peashooter->setPosition(ccp(245,190));
                peashooter->setScale(0.4);
                plantsSpriteArray->addObject(peashooter);
                peashooter->setTag(505);
                this->addChild(peashooter, 1);
                plantsToggle->setEnabled(false);//菜单按钮不可用
                break;
            case REPEATER:
                repeater = CCSprite::create("Repeater.png");
                repeater->setPosition(ccp(300,190));
                repeater->setScale(0.4);
                plantsSpriteArray->addObject(repeater);
                repeater->setTag(506);
                this->addChild(repeater, 1);
                plantsToggle->setEnabled(false);//菜单按钮不可用
                break;
            case SQUASH:
                squash = CCSprite::create("Squash.png");
                squash->setPosition(ccp(30,130));
                squash->setScale(0.4);
                plantsSpriteArray->addObject(squash);
                squash->setTag(507);
                this->addChild(squash, 2);
                plantsToggle->setEnabled(false);//菜单按钮不可用
                break;
            case SUNFLOWER:
                sunflower = CCSprite::create("SunFlower.png");
                sunflower->setPosition(ccp(80,130));
                sunflower->setScale(0.4);
                plantsSpriteArray->addObject(sunflower);
                sunflower->setTag(508);
                this->addChild(sunflower, 2);
                plantsToggle->setEnabled(false);//菜单按钮不可用
                break;
            case TALLNUA:
                tallnut = CCSprite::create("TallNut.png");
                tallnut->setPosition(ccp(130,130));
                tallnut->setScale(0.4);
                plantsSpriteArray->addObject(tallnut);
                tallnut->setTag(509);
                this->addChild(tallnut, 2);
                plantsToggle->setEnabled(false);//菜单按钮不可用
                break;
            case THREEPEATER:
                threepeater = CCSprite::create("Threepeater.png");
                threepeater->setPosition(ccp(190,130));
                threepeater->setScale(0.4);
                plantsSpriteArray->addObject(threepeater);
                threepeater->setTag(510);
                this->addChild(threepeater, 2);
                plantsToggle->setEnabled(false);//菜单按钮不可用
                break;
            case WALLNUA:
                wallnut = CCSprite::create("WallNut.png");
                wallnut->setPosition(ccp(250,130));
                wallnut->setScale(0.4);
                plantsSpriteArray->addObject(wallnut);
                wallnut->setTag(511);
                this->addChild(wallnut, 2);
                plantsToggle->setEnabled(false);//菜单按钮不可用
                break;
            default:
                break;
        }
        
    }
    if(plantsMenuArray->count()<6){
        CCMenuItemToggle* toggleItem;
        if (plantsTag>=101 && plantsTag<=111){
            switch (plantsTag) {
                case CHERRY:
                    toggleItem = this->createMenuItem1("CherryBomb.png", "CherryBomb 副本.png", 201);
                    toggleItem->setScale(0.8);
                    break;
                case CHOMPER:
                    toggleItem = this->createMenuItem1("Chomper.png", "Chomper 副本.png", 202);
                    toggleItem->setScale(0.8);
                    break;
                case JALAPENO:
                    toggleItem = this->createMenuItem1("Jalapeno.png", "Jalapeno 副本.png", 203);
                    toggleItem->setScale(0.8);
                    break;
                case LILYPAD:
                    toggleItem = this->createMenuItem1("LilyPad.png", "LilyPad 副本.png", 204);
                    toggleItem->setScale(0.8);
                    break;
                case PEASHOOTER:
                    toggleItem = this->createMenuItem1("PeaShooter.png", "PeaShooter 副本.png", 205);
                    toggleItem->setScale(0.8);
                    break;
                case REPEATER:
                    toggleItem = this->createMenuItem1("Repeater.png", "Repeater 副本.png", 206);
                    toggleItem->setScale(0.8);
                    break;
                case SQUASH:
                    toggleItem = this->createMenuItem1("Squash.png", "Squash 副本.png", 207);
                    toggleItem->setScale(0.8);
                    break;
                case SUNFLOWER:
                    toggleItem = this->createMenuItem1("SunFlower.png", "SunFlower 副本.png", 208);
                    toggleItem->setScale(0.8);
                    break;
                case TALLNUA:
                    toggleItem = this->createMenuItem1("TallNut.png", "TallNut 副本.png", 209);
                    toggleItem->setScale(0.8);
                    break;
                case THREEPEATER:
                    toggleItem = this->createMenuItem1("Threepeater.png", "Threepeater 副本.png", 210);
                    toggleItem->setScale(0.8);
                    break;
                case WALLNUA:
                    toggleItem = this->createMenuItem1("WallNut.png", "WallNut 副本.png", 211);
                    toggleItem->setScale(0.8);
                    break;
                default:
                    break;
            }
            //将选中的放置到BarItem上
            plantsMenuArray->addObject(toggleItem);
            //ccp(size.width/2-110,size.height/2+280)
            for (int i = 1; i<7; i++){
                if(plantsMenuArray->count() ==i){
                    CCSprite* sprite = (CCSprite*)plantsSpriteArray->objectAtIndex(i-1);
                    CCJumpTo* jumpTo = CCJumpTo::create(0.7, ccp((size.width/2-190)+(i-1)*45, size.height/2+280), 100, 1);
                    sprite->runAction(jumpTo);
                    plantsToggle->setTag(plantsTag+100);
                }
            }
        }
    }
    
}
#pragma mark--创建菜单1
CCMenuItemToggle* GameScene::createMenuItem1(const char *plantName1, const char *plantName2, int tag){

    CCMenuItemImage* image = CCMenuItemImage::create(plantName1, plantName1);
    image->setScale(0.5);
    CCMenuItemImage* image1 = CCMenuItemImage::create(plantName2, plantName2);
    image1->setScale(0.5);
    CCMenuItemToggle* toggle = CCMenuItemToggle::createWithTarget(this, menu_selector(GameScene::plantingPlant), image,image1, NULL);
    toggle->setTag(tag);
    return toggle;

}
#pragma mark---种植植物
void GameScene::plantingPlant(CCNode *plant){

    CCMenuItemToggle* plantToggle = (CCMenuItemToggle*)plant;
    int plantsTag = plant->getTag();
    Plants* thePlant;
    switch (plantsTag) {
        case CHERRY+100:
            SunNumber -= 150;
            cherryCoolTime=5;
            plantToggle->setSelectedIndex(1);
            plantToggle->setEnabled(false);
            thePlant = new Plants(Cherry);
            plantsArray->addObject(thePlant);
            plantsIsPlanted = false;
            break;
        case CHOMPER+100:
            SunNumber -= 150;
            chomperCoolTime=7;
            plantToggle->setSelectedIndex(1);
            plantToggle->setEnabled(false);
            thePlant = new Plants(CorpseFlower);
            plantsArray->addObject(thePlant);
            plantsIsPlanted = false;
            break;
        case JALAPENO+100:
            SunNumber -= 125;
            jalapenoCoolTime=5;
            plantToggle->setSelectedIndex(1);
            plantToggle->setEnabled(false);
            thePlant = new Plants(Paprika);
            plantsArray->addObject(thePlant);
            plantsIsPlanted = false;
            break;
        case LILYPAD+100:
            SunNumber -= 25;
            lilypadCoolTime=5;
            plantToggle->setSelectedIndex(1);
            plantToggle->setEnabled(false);
            thePlant = new Plants(Lilypad);
            plantsArray->addObject(thePlant);
            plantsIsPlanted = false;
            break;
        case PEASHOOTER+100:
            SunNumber -= 100;
            peashooterCoolTime=5;
            plantToggle->setSelectedIndex(1);
            plantToggle->setEnabled(false);
            thePlant = new Plants(SmallPea);
            thePlant->setPosition(ccp(0, -100));//解决在点击菜单后，没有种植时，子弹从ccp(0,0)位置飞出的情况
            plantsArray->addObject(thePlant);
            plantsIsPlanted = false;
            break;
        case REPEATER+100:
            SunNumber -= 200;
            repeaterCoolTime=5;
            plantToggle->setSelectedIndex(1);
            plantToggle->setEnabled(false);
            thePlant = new Plants(MidllePea);
            thePlant->setPosition(ccp(0, -100));//解决在点击菜单后，没有种植时，子弹从ccp(0,0)位置飞出的情况
            plantsArray->addObject(thePlant);
            plantsIsPlanted = false;
            break;
        case SQUASH+100:
            SunNumber -= 50;
            squashCoolTime=5;
            plantToggle->setSelectedIndex(1);
            plantToggle->setEnabled(false);
            thePlant = new Plants(Pumpkin);
            plantsArray->addObject(thePlant);
            plantsIsPlanted = false;
            break;
        case SUNFLOWER+100:
            SunNumber -= 50;
            sunflowerCoolTime=5;
            plantToggle->setSelectedIndex(1);
            plantToggle->setEnabled(false);
            thePlant = new Plants(Sunflower);
            thePlant->setPosition(ccp(0, -100));//解决在点击菜单后，没有种植时，子弹从ccp(0,0)位置飞出的情况
            plantsArray->addObject(thePlant);
            plantsIsPlanted = false;
            break;
        case TALLNUA+100:
            SunNumber -= 125;
            tallnutCoolTime=5;
            plantToggle->setSelectedIndex(1);
            plantToggle->setEnabled(false);
            thePlant = new Plants(largeNut);
            plantsArray->addObject(thePlant);
            plantsIsPlanted = false;
            break;
        case THREEPEATER+100:
            SunNumber -= 325;
            threepeaterCoolTime=5;
            plantToggle->setSelectedIndex(1);
            plantToggle->setEnabled(false);
            thePlant = new Plants(ThreeBulletPea);
            thePlant->setPosition(ccp(0, -100));//解决在点击菜单后，没有种植时，子弹从ccp(0,0)位置飞出的情况
            plantsArray->addObject(thePlant);
            plantsIsPlanted = false;
            break;
        case WALLNUA+100:
            SunNumber -= 50;
            wallnutCooltime=5;
            plantToggle->setSelectedIndex(1);
            plantToggle->setEnabled(false);
            thePlant = new Plants(SmallNut);
            plantsArray->addObject(thePlant);
            plantsIsPlanted = false;
            break;
        default:
            break;
    }

    
}

#pragma mark-确定菜单
void GameScene::beSure(){

    CCSize size = GET_WINDOWSIZE;
    
    for (int i = 501; i<512; i++) {
        this->removeChildByTag(i);
    }
    CCMenu* menu = CCMenu::createWithArray(plantsMenuArray);
    menu->setPosition(ccp(size.width/2-80, size.height/2+280));
    menu->alignItemsHorizontallyWithPadding(-18);//菜单间隔
    this->addChild(menu,2);
    
    //添加准备安放植物字体
    CCSpriteFrameCache* cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("PrepareGrowPlants_default.plist");
    CCSprite* fontSprite = CCSprite::createWithSpriteFrameName("PrepareGrowPlants1.tiff");
    fontSprite->setPosition(ccp(240, 160));
    fontSprite->setPosition(ccp(size.width/2, size.height/2));
    this->addChild(fontSprite);
    char fontName[30];
    CCArray* fontArray = CCArray::create();
    fontArray->retain();
    for (int i = 1; i <= 3; i++){
        sprintf(fontName, "PrepareGrowPlants%d.tiff", i);
        CCSpriteFrame* frame = cache->spriteFrameByName(fontName);
        fontArray->addObject(frame);
    }
    CCAnimation* animation = CCAnimation::createWithSpriteFrames(fontArray, 0.8);
    CCAnimate* animate = CCAnimate::create(animation);
    CCCallFuncN* funcn = CCCallFuncN::create(this, callfuncN_selector(GameScene::removeSprite));
    CCSequence* seq = CCSequence::create(CCDelayTime::create(2), animate, funcn, NULL);
    fontSprite->runAction(seq);
    //菜单的植物样式可选
    for (int i = 0; i < plantsMenuArray->count(); i++) {
        CCMenuItemToggle* toggle = (CCMenuItemToggle*)plantsMenuArray->objectAtIndex(i);
        if(toggle->getTag() == 204){
            toggle->setEnabled(true);
        }else if(toggle->getTag() == 207){
            toggle->setEnabled(true);
        }else if(toggle->getTag() == 208){
            toggle->setEnabled(true);
        }else if(toggle->getTag() == 211){
            toggle->setEnabled(true);
        }else{
            toggle->setSelectedIndex(1);
            toggle->setEnabled(false);
        }
    }
    //添加植物后植物菜单的移动归位
    CCMoveTo* moveTo = CCMoveTo::create(2.0, ccp(170, -180));
    menuSprite->runAction(moveTo);
    this->moveScenePosition();
    
    //添加小车
    CCCallFunc* funcar = CCCallFunc::create(this, callfunc_selector(GameScene::addCar));
    CCSequence* seqcar = CCSequence::create(CCDelayTime::create(2), funcar, NULL);
    this->runAction(seqcar);
    this->removeBeforeZombie();
    //各种植物的冷却时间<需多长时间才能继续种植>
    cherryCoolTime = 5;
    chomperCoolTime = 7;
    jalapenoCoolTime = 5;
    lilypadCoolTime = 5;
    peashooterCoolTime = 5;
    repeaterCoolTime = 5;
    squashCoolTime = 5;
    sunflowerCoolTime = 2;
    tallnutCoolTime = 5;
    threepeaterCoolTime = 5;
    wallnutCooltime = 5;
    
    timer = 0;//初始化控制僵尸数量的标志
    productZombie = 0;
    this->schedule(schedule_selector(GameScene::appearZombie), 1);
    this->schedule(schedule_selector(GameScene::createSunshineWithoutSunflower), 5);
    this->schedule(schedule_selector(GameScene::checkHitWithBulletAndPlant), 0.01);
    this->schedule(schedule_selector(GameScene::judgeCoolTime), 0.1);
    this->schedule(schedule_selector(GameScene::reduceCoolTime), 1);
    this->schedule(schedule_selector(GameScene::checkHitOtherPlantsAndZombie), 0.5);
    this->schedule(schedule_selector(GameScene::checkFial), 0.5);
    this->schedule(schedule_selector(GameScene::checkHitCarWithZoombie), 0.01);
//    this->schedule(schedule_selector(GameScene::pass), 1);
 

}
#pragma mark------------checkHitCarWithZoombie--------------
void GameScene::checkHitCarWithZoombie(){

    CCArray* tempCarArray = CCArray::create();
    tempCarArray->retain();
    CCArray* tempZombieArray = CCArray::create();
    tempZombieArray->retain();
    for (int i = 0; i < carArray->count(); i++){
        for (int j = 0 ; j < zoombieArray->count(); j++)
        {
            CCSprite* sprite = (CCSprite*)carArray->objectAtIndex(i);
            Zombies* zoombie = (Zombies*)zoombieArray->objectAtIndex(j);
            CCPoint spritePoint = sprite->getPosition();
            CCPoint zoombiePoint = pSprite->convertToWorldSpace(zoombie->getPosition());
            if(zoombiePoint.x-spritePoint.x>0 && zoombiePoint.x-spritePoint.x<30 && zoombiePoint.y == spritePoint.y)
            {
                CCMoveTo* moveToEnd = CCMoveTo::create(4, ccp(500,spritePoint.y));
                CCCallFuncN* func = CCCallFuncN::create(this, callfuncN_selector(GameScene::removeSprite));
                CCCallFuncND* funcnd = CCCallFuncND::create(this, callfuncND_selector(GameScene::removeCar), tempCarArray);
                CCSequence* seq = CCSequence::create(moveToEnd,func,funcnd, NULL);
                sprite->runAction(seq);
                tempZombieArray->addObject(zoombie);
                tempCarArray->addObject(sprite);
                zoombie->stopAllActions();
                zoombie->runDieAction();
            }
        }
    }
    for (int i = 0; i < tempZombieArray->count(); i++)
    {
        if(tempZombieArray->count() != 0)
        {
            zoombieArray->removeObject(tempZombieArray->objectAtIndex(i));
        }
    }


}
#pragma mark------------checkHitCarWithZoombie相关--------------
void GameScene::removeCar(CCNode *node,CCArray *array){

    for ( int i = 0 ; i < array->count(); i++) {
        if(array->count() != 0)
        {
            carArray->removeObject(array->objectAtIndex(i));
        }
    }

}


#pragma mark------------checkHitCarWithZoombie相关--------------
#pragma mark-----------检查僵尸进入小屋-----------------------
void GameScene::checkFial(){

    for (int i = 0; i < zoombieArray->count(); i++)
    {
        if(zoombieArray->count() != 0)
        {
            Zombies* zoombie = (Zombies*)zoombieArray->objectAtIndex(i);
            CCPoint zoombiePoint = pSprite->convertToWorldSpace(zoombie->getPosition());
            if(zoombiePoint.x <= -10)//如果成立，则所有植物和僵尸停止动作
            {
                CCSprite* sprite = CCSprite::create("ZombiesWon.png");
                sprite->setPosition(ccp(240, 160));
                sprite->setScale(0.5);
                this->addChild(sprite);
                CCBlink* blink = CCBlink::create(2, 2);
                CCCallFunc* func = CCCallFunc::create(this, callfunc_selector(GameScene::changeFailedScene));
                CCSequence* seq = CCSequence::create(blink,func, NULL);
                sprite->runAction(seq);
                
                for (int j = 0 ;j < plantsArray->count(); j++)
                {
                    if(plantsArray->count() != 0)
                    {
                        Plants* plant = (Plants*)plantsArray->objectAtIndex(j);
                        plant->stopAllActions();
                    }
                    
                }
                for (int k = 0 ; k < zoombieArray->count(); k++)
                {
                    if(zoombieArray->count() != 0)
                    {
                        Zombies* stopZombie = (Zombies*)zoombieArray->objectAtIndex(k);
                        stopZombie->stopAllActions();
                    }
                    
                }
                
                CCCallFunc* func1 = CCCallFunc::create(this, callfunc_selector(GameScene::changeFailedScene));
                CCSequence* seq1 = CCSequence::create(CCDelayTime::create(3), func1, NULL);
                this->runAction(seq1);
            }
        }
    }

}
#pragma mark---------------------checkFial相关--------------------------------
void GameScene::changeFailedScene(){

//    CCTransitionCrossFade* fade = CCTransitionCrossFade::create(0.5, FailScene::scene());
//    CCDirector::sharedDirector()->replaceScene(fade);

}
void GameScene::changeSuccessScene(){

    CCTransitionCrossFade* fade = CCTransitionCrossFade::create(1, PassScene::scene());
    CCDirector::sharedDirector()->replaceScene(fade);


}
#pragma mark-----------------------checkFial相关------------------------------
#pragma mark---checkHitOtherPlantsAndZombie------------
void GameScene::checkHitOtherPlantsAndZombie(){

    CCArray* eatedPlant = CCArray::create();
    eatedPlant->retain();
    CCArray* boomedZombie = CCArray::create();
    boomedZombie->retain();
    for (int i = 0;  i < plantsArray->count();  i++)
    {
        for (int j = 0 ; j < zoombieArray->count(); j++)
        {
            Plants* plant = (Plants*)plantsArray->objectAtIndex(i);
            Zombies* zoombie = (Zombies*)zoombieArray->objectAtIndex(j);
            CCPoint plantPoint = plant->getPosition();
            CCPoint zoombiePoint = pSprite->convertToWorldSpace(zoombie->getPosition());
            
            if(zoombiePoint.x-plantPoint.x >-50 && zoombiePoint.x-plantPoint.x<30 && zoombiePoint.y-plantPoint.y>=0 && zoombiePoint.y-plantPoint.y<20){
                if(plant->plantsName == Pumpkin){//判断是否为南瓜
                    plant->stopAllActions();
                    plant->pumpKinAction(plant, zoombiePoint);
                    eatedPlant->addObject(plant);
                    boomedZombie->addObject(zoombie);
                    //this->pass();
                    zoombie->isAttack = true;
                    CCCallFuncN* func = CCCallFuncN::create(this, callfuncN_selector(GameScene::collapseZombie));
                    CCSequence* seq = CCSequence::create(CCDelayTime::create(0.6), func, NULL);
                    zoombie->runAction(seq);
                }
                
            }
            
            if(zoombiePoint.x-plantPoint.x >= 10 && zoombiePoint.x-plantPoint.x<20 && zoombiePoint.y-plantPoint.y>=0 && zoombiePoint.y-plantPoint.y<20){
                if(plant->plantsName == CorpseFlower){
                    if(plant->canAttack){
                        
                        CCCallFuncN* funcn3 = CCCallFuncN::create(zoombie, callfuncN_selector(GameScene::removeSprite));
                        CCSequence* seq1 = CCSequence::create(CCDelayTime::create(0.8), funcn3, NULL);
                        zoombie->runAction(seq1);
                        //zoombie->removeFromParent();
                        boomedZombie->addObject(zoombie);
                        //this->pass();
                        zoombie->isAttack = false;
#warning mark-----------------------
                        CCCallFuncN* funcn1 = CCCallFuncN::create(this, callfuncN_selector(GameScene::chomperAction1));
                        CCCallFuncN* funcn2 = CCCallFuncN::create(this, callfuncN_selector(GameScene::chomperAction2));
                        CCSequence* seq = CCSequence::create(funcn1,funcn2, NULL);
                        plant->runAction(seq);
                    }
                }
                
            }
            //碰撞检测----会跳的僵尸
#warning mark---------------另一种过检测碰撞的方法
            if(zoombiePoint.x-plantPoint.x >0 && zoombiePoint.x-plantPoint.x<10 && zoombiePoint.y-plantPoint.y>=0 && zoombiePoint.y-plantPoint.y<20){
                if(zoombie->zombieType == PoleVaultingZombie){
                    if(!zoombie->isJump){
                        if(plant->plantsName == SmallNut){
                            //检测生命值  小坚果受损严重
                            if(plant->lifeForce > 8 && plant->lifeForce <= 15){
                                plant->smallNutActionEatOverMoreHarm();//生命值还高时
                            }
                            if(plant->lifeForce > 1 && plant->lifeForce <= 8){
                                plant->smallNutActionEatOverMoreHarm();//生命值几乎没有是
                            }
                        }
                        //大坚果
                        if(plant->plantsName == largeNut)
                        {
                            if(plant->lifeForce > 10 && plant->lifeForce <= 20)
                            {
                                plant->largeNutActionEatOvetByZombie();
                            }
                            if(plant->lifeForce > 1 && plant->lifeForce <= 10)
                            {
                                plant->largeNutActionEatOverMoreharm();
                            }
                            
                        }
                        
                        //如果植物的生命值不为0----开始在碰撞是自动减少生命值
                        if(plant->lifeForce != 0)
                        {
                            plant->lifeForce--;
                        }
                        if(!zoombie->isAttack)//判断僵尸是否在攻击
                        {
                            zoombie->runAttackAction();//执行攻击动作
                            zoombie->isAttack = true;//改变僵尸为攻击状态
                            plant->addZombieAttackThisPlant->addObject(zoombie);//将正在攻击的僵尸存入
                        }
                        if(plant->lifeForce == 0){//判断植物生命力----植物生命力为0时
                            //当植物的生命值为0时<此时指的是:植物先死掉，而僵尸还活着>
                            //找到存入数组中僵尸,继续执行之前的相应动作,并更改其为不处于攻击状态
                            for (int i = 0; i < plant->addZombieAttackThisPlant->count(); i++){
                                if(plant->addZombieAttackThisPlant->count() != 0){
                                    Zombies* zoombie = (Zombies*)plant->addZombieAttackThisPlant->objectAtIndex(i);
                                    zoombie->continueMove();
                                    zoombie->startMove();//该方法是控制僵尸的行走动作的
                                    zoombie->isAttack = false;
                                    
                                }
                            }
                            //通过植物的生命值先为0时，就让僵尸吃掉
                            eatedPlant->addObject(plant);
                            plant->removeFromParent();
                        }
                        
                    }
                }else{
                    if(plant->plantsName == SmallNut){
                        
                        if(plant->lifeForce > 8 && plant->lifeForce <= 15){
                            plant->smallNutActionEatOverByZombie();
                        }
                        if(plant->lifeForce > 1 && plant->lifeForce <= 8){
                            plant->smallNutActionEatOverMoreHarm();
                        }
                    }
                    
                    if(plant->plantsName == largeNut){
                        if(plant->lifeForce > 10 && plant->lifeForce <= 20){
                            plant->largeNutActionEatOvetByZombie();
                        }
                        if(plant->lifeForce > 1 && plant->lifeForce <= 10){
                            plant->largeNutActionEatOverMoreharm();
                        }
                        
                    }
                    
                    
                    if(plant->lifeForce != 0){
                        plant->lifeForce--;
                    }
                    if(!zoombie->isAttack)//判断僵尸是否在攻击
                    {
                        zoombie->runAttackAction();
                        zoombie->isAttack = true;
                        plant->addZombieAttackThisPlant->addObject(zoombie);
                    }
                    if(plant->lifeForce == 0)//判断植物生命力
                    {
                        for (int i = 0; i < plant->addZombieAttackThisPlant->count(); i++)
                        {
                            if(plant->addZombieAttackThisPlant->count() != 0)
                            {
                                Zombies* zoombie = (Zombies*)plant->addZombieAttackThisPlant->objectAtIndex(i);
                                zoombie->continueMove();
                                zoombie->startMove();
                                zoombie->isAttack = false;
                                
                            }
                        }
                        eatedPlant->addObject(plant);
                        this->setFlagValue1(plant->getPosition());
                        plant->removeFromParent();
                    }
                    
                    
                }
            }
            if(plant->plantsName == Paprika)
            {
#warning mark------------------------------
                if(plantPoint.y == zoombiePoint.y)
                {
                    CCCallFuncN* funcn = CCCallFuncN::create(this, callfuncN_selector(GameScene::zombieBoomDie));
                    CCSequence* seq = CCSequence::create(CCDelayTime::create(2), funcn, NULL);
                    zoombie->runAction(seq);
                    eatedPlant->addObject(plant);
                    boomedZombie->addObject(zoombie);
                    //this->pass();
                    
                }
            }
            if(plant->plantsName == Cherry)
            {
                float distance = sqrtf((plantPoint.x-zoombiePoint.x)*(plantPoint.x-zoombiePoint.x)+(plantPoint.y-zoombiePoint.y)*(plantPoint.y-zoombiePoint.y));
                if(distance <= 80)
                {
                    CCCallFuncN* funcn = CCCallFuncN::create(this, callfuncN_selector(GameScene::zombieBoomDie));
                    CCSequence* seq = CCSequence::create(CCDelayTime::create(1.4), funcn, NULL);
                    zoombie->runAction(seq);
                    eatedPlant->addObject(plant);
                    boomedZombie->addObject(zoombie);
                    //this->pass();
                }
            }
            
            if(zoombie->zombieType == PoleVaultingZombie)
            {
                if(zoombiePoint.x-plantPoint.x >0 && zoombiePoint.x-plantPoint.x<22 && zoombiePoint.y-plantPoint.y>=0 && zoombiePoint.y-plantPoint.y<20)
                {
                    if(!zoombie->isJump)
                    {
                        zoombie->Jump();
                    }
                }
            }
        }
    }
    
    for (int i = 0; i < eatedPlant->count(); i++)
    {
        if(eatedPlant->count() != 0)
        {
            plantsArray->removeObject(eatedPlant->objectAtIndex(i));
        }
    }
    for(int i = 0; i < boomedZombie->count(); i++)
    {
        if(boomedZombie->count() != 0)
        {
            zoombieArray->removeObject(boomedZombie->objectAtIndex(i));
        }
    }
    
    eatedPlant->release();
    boomedZombie->release();


}
#pragma mark---checkHitOtherPlantsAndZombie相关------------------------------

#pragma mark--collapseZombie-------
void GameScene::collapseZombie(Zombies *zoombie){
    
    zoombie->runDieAction();
    
}
#pragma mark-----zombieBoomDie---------
void GameScene::zombieBoomDie(Zombies *zoombie){
    
    zoombie->stopAllActions();
    zoombie->runBoomDie();
    
}
#pragma mark---chomperAction1
void GameScene::chomperAction1(Plants *plant){
    plant->corpseFlowerAction1();
}
void GameScene::chomperAction2(Plants *plant){
    plant->corpseFlowerAction2();
}

#pragma mark---checkHitOtherPlantsAndZombie相关------------------------------



#pragma mark-----------judgeCoolTime----------------------------
void GameScene::judgeCoolTime(){


    for (int j = 0; j < plantsMenuArray->count(); j++){
        CCMenuItemToggle* toggle = (CCMenuItemToggle*)plantsMenuArray->objectAtIndex(j);
        switch (toggle->getTag()){
            case CHERRY+100:
                if(cherryCoolTime == 0 && SunNumber >= 150)
                {
                    toggle->setSelectedIndex(0);
                    toggle->setEnabled(true);
                }
                else if(SunNumber < 150)
                {
                    toggle->setEnabled(false);
                    toggle->setSelectedIndex(1);
                }
                break;
            case CHOMPER+100:
                if(chomperCoolTime == 0 && SunNumber >= 150)
                {
                    toggle->setSelectedIndex(0);
                    toggle->setEnabled(true);
                }
                else if(SunNumber < 150)
                {
                    toggle->setEnabled(false);
                    toggle->setSelectedIndex(1);
                }
                break;
            case JALAPENO+100:
                if(jalapenoCoolTime == 0 && SunNumber >= 125)
                {
                    toggle->setSelectedIndex(0);
                    toggle->setEnabled(true);
                }
                else if(SunNumber < 125)
                {
                    toggle->setEnabled(false);
                    toggle->setSelectedIndex(1);
                }
                
                break;
            case LILYPAD+100:
                if(lilypadCoolTime == 0 && SunNumber >= 25)
                {
                    toggle->setSelectedIndex(0);
                    toggle->setEnabled(true);
                }
                else if(SunNumber < 25)
                {
                    toggle->setEnabled(false);
                    toggle->setSelectedIndex(1);
                }
                
                break;
            case PEASHOOTER+100:
                if(peashooterCoolTime == 0 && SunNumber >= 100)
                {
                    toggle->setSelectedIndex(0);
                    toggle->setEnabled(true);
                }
                else if(SunNumber < 100)
                {
                    toggle->setEnabled(false);
                    toggle->setSelectedIndex(1);
                }
                
                break;
            case REPEATER+100:
                if(repeaterCoolTime == 0 && SunNumber >= 200)
                {
                    toggle->setSelectedIndex(0);
                    toggle->setEnabled(true);
                }
                else if(SunNumber < 200)
                {
                    toggle->setEnabled(false);
                    toggle->setSelectedIndex(1);
                }
                
                break;
            case SQUASH+100:
                if(squashCoolTime == 0 && SunNumber >= 50)
                {
                    toggle->setSelectedIndex(0);
                    toggle->setEnabled(true);
                }
                else if(SunNumber < 50)
                {
                    toggle->setEnabled(false);
                    toggle->setSelectedIndex(1);
                }
                
                break;
            case SUNFLOWER+100:
                if(sunflowerCoolTime == 0 && SunNumber >= 50)
                {
                    toggle->setSelectedIndex(0);
                    toggle->setEnabled(true);
                }
                else if(SunNumber < 50)
                {
                    toggle->setEnabled(false);
                    toggle->setSelectedIndex(1);
                }
                
                break;
            case TALLNUA+100:
                if(tallnutCoolTime == 0 && SunNumber >= 125)
                {
                    toggle->setSelectedIndex(0);
                    toggle->setEnabled(true);
                }
                else if(SunNumber < 125)
                {
                    toggle->setEnabled(false);
                    toggle->setSelectedIndex(1);
                }
                
                break;
            case THREEPEATER+100:
                if(threepeaterCoolTime == 0 && SunNumber >= 325)
                {
                    toggle->setSelectedIndex(0);
                    toggle->setEnabled(true);
                }
                else if(SunNumber < 325)
                {
                    toggle->setEnabled(false);
                    toggle->setSelectedIndex(1);
                }
                
                break;
            case WALLNUA+100:
                if(wallnutCooltime == 0 && SunNumber >= 50)
                {
                    toggle->setSelectedIndex(0);
                    toggle->setEnabled(true);
                }
                else if(SunNumber < 50)
                {
                    toggle->setEnabled(false);
                    toggle->setSelectedIndex(1);
                }
                
                break;
                
            default:
                break;
        }
    }

}
#pragma mark-----reduceCoolTime--------------------------
void GameScene::reduceCoolTime(){

    for (int j = 0; j < plantsMenuArray->count(); j++){
        CCMenuItemToggle* toggle = (CCMenuItemToggle*)plantsMenuArray->objectAtIndex(j);
        switch (toggle->getTag())
        {
            case CHERRY+100:
                if(cherryCoolTime != 0)
                {
                    cherryCoolTime--;
                }
                break;
            case CHOMPER+100:
                if(chomperCoolTime != 0)
                {
                    chomperCoolTime--;
                }
                break;
            case JALAPENO+100:
                if(jalapenoCoolTime != 0)
                {
                    jalapenoCoolTime--;
                    
                }
                break;
            case LILYPAD+100:
                if(lilypadCoolTime != 0)
                {
                    lilypadCoolTime--;
                }
                break;
            case PEASHOOTER+100:
                if(peashooterCoolTime != 0)
                {
                    peashooterCoolTime--;
                }
                break;
            case REPEATER+100:
                if(repeaterCoolTime != 0)
                {
                    repeaterCoolTime--;
                }
                break;
            case SQUASH+100:
                if(squashCoolTime != 0)
                {
                    squashCoolTime--;
                }
                break;
            case SUNFLOWER+100:
                if(sunflowerCoolTime != 0)
                {
                    sunflowerCoolTime--;
                }
                break;
            case TALLNUA+100:
                if(tallnutCoolTime != 0)
                {
                    tallnutCoolTime--;
                }
                break;
            case THREEPEATER+100:
                if(threepeaterCoolTime != 0)
                {
                    threepeaterCoolTime--;
                }
                break;
            case WALLNUA+100:
                if(wallnutCooltime != 0)
                {
                    wallnutCooltime--;
                }
                break;
            default:
                break;
        }
    }

}

#pragma mark-------------------------------------创建太阳------------------------------------------------------
void GameScene::createSunshineWithoutSunflower(){
    
    CCSize size = GET_WINDOWSIZE;
    int width = (int)size.width;
    int height = (int)size.height;
    CCSprite* sunSprite1 = CCSprite::createWithSpriteFrameName("Sun－1（被拖移）.tiff");
    CCSprite* sunSprite2 = CCSprite::createWithSpriteFrameName("Sun－1（被拖移）.tiff");
    sunSprite1->setScale(0.6);
    sunSprite2->setScale(0.6);
    CCMenuItemSprite* itemsprite = CCMenuItemSprite::create(sunSprite1, sunSprite2);
    CCMenu* menu = CCMenu::create(itemsprite, NULL);
    //ccp((size.width/2-190)+(i-1)*45, size.height/2+280)
    int x;
    int y;
    do {
        x = arc4random()%(width);
//        x = arc4random()%480;
    } while (x < 78 || x >(width-78));
    do {
        y = arc4random()%(height);
//        y = arc4random()%290;
    } while (y < 78 || y >(height));
//    menu->setPosition(ccp(x, 340));
    menu->setPosition(ccp(x, size.height));
    this->addChild(menu, 2);
    //搜集太阳
    itemsprite->setTarget(this, menu_selector(Bullet::collectSunshine));
    
    
    CCArray* sunArray = CCArray::create();
    sunArray->retain();
    CCSpriteFrameCache* cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    char name[50];
    for (int i = 1; i<23; i++){
        sprintf(name, "Sun－%i（被拖移）.tiff", i);
        CCSpriteFrame* frame = cache->spriteFrameByName(name);
        sunArray->addObject(frame);
    }
    CCAnimation* animation = CCAnimation::createWithSpriteFrames(sunArray,0.3);
    CCAnimate* animate = CCAnimate::create(animation);
    sunSprite1->runAction(CCRepeatForever::create(animate));//这里不能使用菜单精灵来执行runAction动作
    CCMoveTo* moveTo = CCMoveTo::create(10, ccp(x, y));
    menu->runAction(moveTo);


}
#pragma mark-------------------移动场景----------------------------
void GameScene::moveScenePosition(){
    
    CCSize size = GET_WINDOWSIZE;
    CCMoveTo* moveTo = CCMoveTo::create(2, ccp(size.width/2+170, size.height/2));
    pSprite->runAction(moveTo);
    
}

#pragma mark------------------移除之前的僵尸-----------------------------
void GameScene::removeBeforeZombie(){

    for (int i = 0; i < beforeZombie->count(); i++) {
        Zombies* zoombie = (Zombies*)beforeZombie->objectAtIndex(i);
        zoombie->removeFromParent();
    }
    beforeZombie->removeAllObjects();

}
#pragma mark----------------出现僵尸-----------------------------
void GameScene::appearZombie(){
    
    CCSize size = GET_WINDOWSIZE;

    timer++;
    if(timer <10){
        if(timer == 1){
            this->schedule(schedule_selector(GameScene::addZombie), 5);
        }
    }else if(timer >= 10 && timer<=20){
        if(timer == 10){
            CCSprite* largeWave = CCSprite::create("LargeWave.png");
            largeWave->setPosition(ccp(size.width/2, size.height/2));
            this->addChild(largeWave);
            CCBlink* blink = CCBlink::create(3, 4);
            CCCallFuncN* funcn = CCCallFuncN::create(this, callfuncN_selector(GameScene::removeSprite));
            CCSequence* seq1 = CCSequence::create(blink,funcn, NULL);
            largeWave->runAction(seq1);
            
            CCCallFunc* func = CCCallFunc::create(this, callfunc_selector(GameScene::appearZombie1));
            CCSequence* seq2 = CCSequence::create(CCDelayTime::create(3), func, NULL);
            this->runAction(seq2);
            
        }
    }else if(timer > 20){
        if(timer == 21){
            CCSprite* finalWave = CCSprite::create("FinalWave.png");
            finalWave->setPosition(ccp(size.width/2, size.height/2));
            this->addChild(finalWave);
            CCBlink* blink = CCBlink::create(3, 4);
            CCCallFuncN* funcn = CCCallFuncN::create(this, callfuncN_selector(GameScene::removeSprite));
            CCSequence* seq1 = CCSequence::create(blink,funcn, NULL);
            finalWave->runAction(seq1);
            
            CCCallFunc* func = CCCallFunc::create(this, callfunc_selector(GameScene::appearZombie2));
            CCSequence* seq2 = CCSequence::create(CCDelayTime::create(3), func, NULL);
            this->runAction(seq2);
            this->schedule(schedule_selector(GameScene::pass), 1);
        }
    }

}
#pragma mark--------------检查子弹和植物的碰撞---------------------------
void GameScene::checkHitWithBulletAndPlant(){

    CCArray* tempBulletArray = CCArray::create();//创建临时子弹数组，存放打中僵尸的子弹
    tempBulletArray->retain();
    CCArray* tempZoombieArray = CCArray::create();//存放被打中的僵尸
    tempZoombieArray->retain();
    CCArray* newZoombieArray = CCArray::create();//存放戴帽子的僵尸被击中一定次数后产生的新僵尸
    newZoombieArray->retain();
    CCArray* unHitBullet = CCArray::create();
    unHitBullet->retain();
    Bullet* bullet;
    Zombies* zombie;
    for(int i = 0; i < bulletArray->count(); i++)
    {
        for (int j = 0; j < zoombieArray->count(); j++)
        {
            bullet = (Bullet*)bulletArray->objectAtIndex(i);
            zombie = (Zombies*)zoombieArray->objectAtIndex(j);
            CCPoint bulletPoint = bullet->getPosition();
            CCPoint zoombiePoint = pSprite->convertToWorldSpace(zombie->getPosition());//因为僵尸是加在pSprite背景层上的，所以必须把pSprite转换为世界坐标，这样僵尸坐标才能正确显示;
            if(zoombiePoint.x-bulletPoint.x>-20 && zoombiePoint.x-bulletPoint.x<10 && bulletPoint.y-zoombiePoint.y>-30 && bulletPoint.y-zoombiePoint.y<40)
            {
                tempBulletArray->addObject(bullet);
                bullet->removeFromParent();
                zombie->blood -= 2;
                if (zombie->zombieType == ConeheadZombie || zombie->zombieType == BucketheadZombie) {
                    if(zombie->blood <= 0)
                    {
                        zombie->removeFromParent();
                        tempZoombieArray->addObject(zombie);
                        Zombies* newzoombie = new Zombies(Zombie);
                        newzoombie->setPosition(zombie->getPosition());
                        pSprite->addChild(newzoombie);
                        newzoombie->startMove();
                        newZoombieArray->addObject(newzoombie);
                    }
                }
                if(zombie->blood <= 0)
                {
                    CCCallFunc* func1 = CCCallFunc::create(zombie, callfunc_selector(Zombies::runDieAction));
                    CCCallFuncN* func2 = CCCallFuncN::create(zombie, callfuncN_selector(GameScene::removeSprite));
                    CCSequence* seq = CCSequence::create(func1, CCDelayTime::create(1), func2, NULL);
                    zombie->runAction(seq);
                    tempZoombieArray->addObject(zombie);
                    //this->pass();
                    //this->pass();
                }
                
            }
            if(bullet->getPosition().x == 500)
            {
                bullet = (Bullet*)bulletArray->objectAtIndex(i);
                unHitBullet->addObject(bullet);
                bullet->removeFromParent();
            }
            
        }
    }
    
    
    for (int i = 0; i < tempBulletArray->count();  i++) {
        bulletArray->removeObject(tempBulletArray->objectAtIndex(i));
    }
    
    for (int i = 0 ; i < tempZoombieArray->count(); i++) {
        zoombieArray->removeObject(tempZoombieArray->objectAtIndex(i));
    }
    
    for (int i = 0; i < newZoombieArray->count(); i++) {
        zoombieArray->addObject(newZoombieArray->objectAtIndex(i));
    }
    
    for (int i = 0; i <unHitBullet->count() ; i++) {
        bulletArray->removeObject(unHitBullet->objectAtIndex(i));
    }
    
    tempBulletArray->release();
    tempZoombieArray->release();
    newZoombieArray->release();
    unHitBullet->release();


}
#pragma mark---走过
void GameScene::pass(){

    if(zoombieArray->count() <= 0)
        
    {
        //this->unscheduleAllSelectors();
        CCCallFunc* func = CCCallFunc::create(this, callfunc_selector(GameScene::changeSuccessScene));
        CCSequence* seq = CCSequence::create(CCDelayTime::create(2), func, NULL);
        this->runAction(seq);
    }

}
#pragma mark----添加僵尸
void GameScene::addZombie(){

    if(productZombie <= theZombieArray[LEVEL-1]){
        int random;
        int randomPosition;
        if(LEVEL == 1){
            randomPosition = 2;
        }
        if(LEVEL == 2){
            do {
                randomPosition = arc4random()%4;
            } while (randomPosition == 0 || randomPosition == 4);
            
        }
        if(LEVEL >= 3){
            randomPosition = arc4random()%5;
        }
        
        for (int i = 1; i <= LEVEL; i++) {
            if(LEVEL == i){
                do {
                    random = arc4random()%(i+1);
                } while (random >= 5);
            }
        }
#warning mark--待完善
        Zombies* zombie;
        switch (random) {//随机产生僵尸的位置
            case 0:
                zombie = new Zombies(Zombie);
                zombie->setPosition(ccp(580, 50+randomPosition*53));
                pSprite->addChild(zombie);
                zombie->runZombieAction(zombie->plistStr);
                zoombieArray->addObject(zombie);
                zombie->startMove();
                this->setLevelBar();
                productZombie++;
                break;
            case 2:
                zombie = new Zombies(BucketheadZombie);
                zombie->setPosition(ccp(580, 45+randomPosition*53));
                pSprite->addChild(zombie);
                zombie->runZombieAction(zombie->plistStr);
                zoombieArray->addObject(zombie);
                zombie->startMove();
                this->setLevelBar();
                productZombie++;
                break;
            case 3:
                zombie = new Zombies(ConeheadZombie);
                zombie->setPosition(ccp(580, 45+randomPosition*53));
                pSprite->addChild(zombie);
                zombie->runZombieAction(zombie->plistStr);
                zoombieArray->addObject(zombie);
                zombie->startMove();
                this->setLevelBar();
                productZombie++;
                break;
            case 1:
                zombie = new Zombies(FlagZombie);
                zombie->setPosition(ccp(580, 45+randomPosition*53));
                pSprite->addChild(zombie);
                zombie->runZombieAction(zombie->plistStr);
                zoombieArray->addObject(zombie);
                zombie->startMove();
                this->setLevelBar();
                productZombie++;
                break;
            case 4:
                zombie = new Zombies(PoleVaultingZombie);
                zombie->setPosition(ccp(580, 45+randomPosition*53));
                pSprite->addChild(zombie);
                zombie->runZombieAction(zombie->plistStr);
                zoombieArray->addObject(zombie);
                zombie->startMove();
                this->setLevelBar();
                productZombie++;
                break;
            default:
                break;
        }
        
    }
}
#pragma mark---设置阶段条
void GameScene::setLevelBar(){

    theLevelBar->setValue(theLevelBarProgressBar);
    theLevelBarProgressBar++;
    
}
#pragma mark---出现僵尸1、2
void GameScene::appearZombie1(){
    this->unschedule(schedule_selector(GameScene::addZombie));
    this->schedule(schedule_selector(GameScene::addZombie), 3);
}

void GameScene::appearZombie2(){
    this->unschedule(schedule_selector(GameScene::addZombie));
    this->schedule(schedule_selector(GameScene::addZombie), 2);
}

#pragma mark---添加小车
void GameScene::addCar(){
    
//    CCSize size = GET_WINDOWSIZE;
    for (int i = 0; i < 5; i++) {
        CCSprite* car = CCSprite::create("LawnMower.gif");
        car->setScale(1.8f);
        car->setPosition(ccp(-20,90+i*110));//间隔一定的间距排列小车
        this->addChild(car);
        carArray->addObject(car);
//        CCMoveTo* moveTo = CCMoveTo::create(0.6, ccp(size.width/2-330,45+i*53));
        CCMoveTo* moveTo = CCMoveTo::create(0.6, ccp(230,90+i*110));
        car->runAction(moveTo);
    }

}
#pragma mark- 重置
void GameScene::resetBarMenu(){

    plantsMenuArray->removeAllObjects();
    plantsSpriteArray->removeAllObjects();
    menuSprite->removeChildByTag(601);
    menuSprite->removeChildByTag(602);
    menuSprite->removeChildByTag(603);
    this->addMenu();
    for (int i = 501; i<512; i++) {
        this->removeChildByTag(i);
    }

}

#pragma mark--初始化flag
void GameScene::initFlag(){

    for (int i = 0; i < 9; i++) {
        for (int j = 0 ; j < 5; j++) {
            flag[i][j] = 0;
        }
    }

}
#pragma mark--产生阳光
void GameScene::createSunshine(){

    if(plantsArray->count() != 0){
        for(int i = 0; i < plantsArray->count(); i++){
            Plants* plant = (Plants*)plantsArray->objectAtIndex(i);
            if(plant->plantsName == Sunflower)
            {
                plant->createSunInterval--;
                Bullet* bullet;
                if(plant->createSunInterval == 0){
                    bullet = new Bullet(plant, plant->getPosition(), this);
                    plant->createSunInterval = plant->tempCreateSunInterval;
                }
            }
        }
    }

}
#pragma mark--产生子弹
void GameScene::createShoote(){

    if(plantsArray->count() != 0){
        for(int i = 0; i < plantsArray->count(); i++){
            Plants* plant = (Plants*)plantsArray->objectAtIndex(i);
            for(int j = 0; j < zoombieArray->count(); j++){//检测当没有僵尸的时候植物不发射子弹
                Zombies* zoombie = (Zombies*)zoombieArray->objectAtIndex(j);
                CCPoint pPosition = plant->getPosition();
                CCPoint zPosition = pSprite->convertToWorldSpace(zoombie->getPosition());//转换世界坐标
                if(zPosition.x-pPosition.x<440 && zPosition.y == pPosition.y){
                    if(plant->plantsName != Sunflower){
                        plant->createPeaInterval--;
                        Bullet* bullet;
                        if(plant->createPeaInterval == 0){
                            bullet = new Bullet(plant, plant->getPosition(), this);
                            plant->createPeaInterval = plant->tempCreatePeaInterval;
                        }
                    }
                    
                }
            }
        }
    }

}
#pragma mark--设置阳光数
void GameScene::setSunNumberLB(){

    sprintf(sunNum, "%d", SunNumber);
    sunNumberLB->setString(sunNum);

}
#pragma mark--进度条
void GameScene::LevelBar(){

    CCSize size = GET_WINDOWSIZE;
    CCSprite* levelProgress = CCSprite::create("FlagMeterLevelProgress.png");
    levelProgress->setPosition(ccp(size.width/2+200, size.height/2+310));
    levelProgress->setScale(2.0f);
    this->addChild(levelProgress);
    
    theLevelBar = CCControlSlider::create("timerBar1.png", "timerBar2.png", "timerBar3.png");
    theLevelBar->setScale(1.2f);
    theLevelBar->setMinimumValue(4);
    theLevelBar->setMaximumValue(theZombieArray[LEVEL-1]+4);
    theLevelBar->setPosition(ccp(size.width/2+200, size.height/2+290));
    this->addChild(theLevelBar);
    
    theLevelBarProgressBar = 4;
    
}
#pragma mark--僵尸初始化之前
void GameScene::initBeforeZombie(){

    CCSize size = GET_WINDOWSIZE;

    Zombies* zoombie1 = new Zombies(Zombie);
    zoombie1->setPosition(ccp(660,65));
    pSprite->addChild(zoombie1);
    beforeZombie->addObject(zoombie1);
    
    Zombies* zoombie2 = new Zombies(BucketheadZombie);
    zoombie2->setPosition(ccp(690,121));
    pSprite->addChild(zoombie2);
    beforeZombie->addObject(zoombie2);
    
    Zombies* zoombie3 = new Zombies(ConeheadZombie);
    zoombie3->setPosition(ccp(680,200));
    pSprite->addChild(zoombie3);
    beforeZombie->addObject(zoombie3);
    
    Zombies* zoombie4 = new Zombies(FlagZombie);
    zoombie4->setPosition(ccp(640,size.height/2-40));
    pSprite->addChild(zoombie4);
    beforeZombie->addObject(zoombie4);
    
    Zombies* zoombie5 = new Zombies(PoleVaultingZombie);
    zoombie5->setPosition(ccp(620,230));
    pSprite->addChild(zoombie5);
    beforeZombie->addObject(zoombie5);


}

#pragma mark---接收触屏事件
void onExit(){

}
bool GameScene::ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent){
//    CCLog("%f, %f", pTouch->getLocation().x, pTouch->getLocation().y);
    return true;
}

void GameScene::ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent){
    
}
void GameScene::ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent){
    
    int Flag = this->getFlag(pTouch->getLocation());

    if (Flag != 1) {//如果没被种植过
        CCPoint zeroPoint = this->getPositionMessage(pTouch->getLocation());
        if(zeroPoint.x != 0 && zeroPoint.y != 0){
            if(!plantsIsPlanted){
                Plants* plant = (Plants*)plantsArray->objectAtIndex(plantsArray->count()-1);
                plant->setScale(1.1f);
                if(plant->specialSkill == CollapseSkill){//处理几个特殊的植物
//                    plant->setAnchorPoint(ccp(0.5, 0.2));
                }else if(plant->specialSkill != ChimeaSkill && plant->specialSkill != BombSkill){
                    this->setFlagValue(pTouch->getLocationInView());
                }
                
//                plant->setPosition(pTouch->getLocationInView());
                CCLog("x->%f,y->%f",this->getPositionMessage(pTouch->getLocationInView()).x,this->getPositionMessage(pTouch->getLocationInView()).y);
                plant->setPosition(this->getPositionMessage(pTouch->getLocation()));
                this->addChild(plant,1);
                plant = NULL;
                plantsIsPlanted = true;
            }
        }
    }

}
#pragma mark---获取位置点信息，种植的位置
CCPoint GameScene::getPositionMessage(CCPoint point){
    /*
     20 为每个植物种植的间距；
     循环9次，由于第一关平均每列只能种植9个植物
     */

    for(int i = 0; i < 9; i++){//检索列
        if(point.x >= (300+i*80) && point.x <= (300+(i+1)*80)){
            for (int j = 0; j < 5; j++){//检索行
                if(point.y >= (230+j*30) && point.y <= (230+(j+1)*30)){
//                    return ccp((300+i*80), (200+j*30));
                    return ccp((float)(300+i*80), (float)300);
                }
            }
        }
    }
    return ccp(0, -100);

}
#pragma mark---getFlag
int GameScene::getFlag(CCPoint point){
    /*
     20 为每个植物种植的间距；
     循环9次，由于第一关平均每列只能种植9个植物
     
     Cocos2d: 310.442230, 297.000519
     Cocos2d: 382.446442, 277.074402
     Cocos2d: 483.225342, 292.002106
     Cocos2d: 585.084961, 292.002106
     Cocos2d: 658.980469, 292.002106
     Cocos2d: 715.854370, 290.043274
     Cocos2d: 822.712402, 288.016876
     Cocos2d: 896.472839, 277.074402
     Cocos2d: 1003.330872, 286.058044
     
     CCMoveTo* moveTo = CCMoveTo::create(0.6, ccp(size.width/2-330,45+i*53));
     CCMoveTo* moveTo = CCMoveTo::create(0.6, ccp(230,90+i*110));
     */
//    for(int i = 0; i < 9; i++){
//        if(point.x >= (20+i*46) && point.x <= (20+(i+1)*46)){
//            for (int j = 0; j < 5; j++){
//                if(point.y >= (15+j*53) && point.y <= (15+(j+1)*53)){
//                    return flag[i][j];
//                }
//            }
//        }
//    }
    
    for(int i = 0; i < 9; i++){//检索列
        if(point.x >= (300+i*80) && point.x <= (300+(i+1)*80)){
            for (int j = 0; j < 5; j++){//检索行
                if(point.y >= (230+j*30) && point.y <= (230+(j+1)*30)){
                    return flag[i][j];
                }
            }
        }
    }
    return 1;
}
#pragma mark----------setFlagValue1------------
void GameScene::setFlagValue1(CCPoint point){
    
//    for(int i = 0; i < 9; i++)
//    {
//        if(point.x >= (20+i*46) && point.x <= (20+(i+1)*46))
//        {
//            for (int j = 0; j < 5; j++)
//            {
//                if(point.y >= (15+j*53) && point.y <= (15+(j+1)*53))
//                {
//                    flag[i][j] = 0;
//                }
//            }
//        }
//    }
    for(int i = 0; i < 9; i++){//检索列
        if(point.x >= (300+i*80) && point.x <= (300+(i+1)*80)){
            for (int j = 0; j < 5; j++){//检索行
                if(point.y >= (230+j*30) && point.y <= (230+(j+1)*30)){
                    flag[i][j] = 0;
                }
            }
        }
    }
    
}

#pragma mark--设置植物种植位置的标志
void GameScene::setFlagValue(CCPoint point){
    /*
     20 为每个植物种植的间距；
     循环9次，由于第一关平均每列只能种植9个植物
     
     Cocos2d: 310.442230, 297.000519
     Cocos2d: 382.446442, 277.074402
     Cocos2d: 483.225342, 292.002106
     Cocos2d: 585.084961, 292.002106
     Cocos2d: 658.980469, 292.002106
     Cocos2d: 715.854370, 290.043274
     Cocos2d: 822.712402, 288.016876
     Cocos2d: 896.472839, 277.074402
     Cocos2d: 1003.330872, 286.058044
     
     CCMoveTo* moveTo = CCMoveTo::create(0.6, ccp(size.width/2-330,45+i*53));
     CCMoveTo* moveTo = CCMoveTo::create(0.6, ccp(230,90+i*110));
     */
//    for(int i = 0; i < 9; i++){
//        if(point.x >= (20+i*46) && point.x <= (20+(i+1)*46)){
//            for (int j = 0; j < 5; j++){
//                if(point.y >= (15+j*53) && point.y <= (15+(j+1)*53)){
//                    flag[i][j] = 1;
//                }
//            }
//        }
//    }
    for(int i = 0; i < 9; i++){//检索列
        if(point.x >= (300+i*80) && point.x <= (300+(i+1)*80)){
            for (int j = 0; j < 5; j++){//检索行
                if(point.y >= (230+j*30) && point.y <= (230+(j+1)*30)){
                    flag[i][j] = 1;
                }
            }
        }
    }
}
#pragma mark--退出时释放所有
void GameScene::onExit(){

    plantsMenuArray->release();
    plantsSpriteArray->release();
    plantsArray->release();
    zoombieArray->release();
    bulletArray->release();
    carArray->release();
    beforeZombie->release();
    this->unscheduleAllSelectors();

}














