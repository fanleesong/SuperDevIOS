#include "HelloWorldScene.h"
#include "SimpleAudioEngine.h"
//#include "AnimatePacker.h"
#include "CCParticleSystemQuadLoader.h"
#include "Box2D.h"

USING_NS_CC;
using namespace std;
using namespace CocosDenshion;

CCScene* HelloWorld::scene(){
    CCScene *scene = CCScene::create();
    HelloWorld *layer = HelloWorld::create();
    scene->addChild(layer);
    return scene;
}

bool HelloWorld::init()
{
    if ( !CCLayer::init() ){
        return false;
    }
    
    
    //    CCSize size = CCDirector::sharedDirector()->getWinSize();
    //    //通过textureCache
    //    CCTexture2D *texture = CCTextureCache::sharedTextureCache()->addImage("Boom.gif");
    //    //从缓存中获取数据sprite帧
    //    CCSprite *sprite = CCSprite::createWithTexture(texture);
    //    //获取缓存中图片的某一部分
    //    CCSprite *partSprite = CCSprite::createWithTexture(texture,CCRect(0,0,45,21));
    //    partSprite->setPosition(ccp(size.width/2+200,size.height/2+30));
    //    sprite->setPosition(ccp(size.width/2,size.height/2));
    //    this->addChild(sprite);
    //    this->addChild(partSprite);
    //
    //    //直接使用CCSprite获取数据
    //    CCSprite *boom = CCSprite::create("CloseNormal.png");
    //    boom->setScaleX(3);
    //    boom->setScaleY(4);
    //    boom->setPosition(ccp(size.width/2+199,size.height/2+120));
    //    this->addChild(boom);
    //
    ////    //是否可以获取gif文件呢?--不能
    //    CCSprite *gifSprite = CCSprite::create("BucketheadZombie.gif");
    //    gifSprite->setPosition(ccp(size.width/2-120,size.height/2-120));
    //    this->addChild(gifSprite);
    //
    //    //从缓存中读取plist文件中的单个图片文件精灵
    //    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    //    cache->addSpriteFramesWithFile("FlagZombie_default.plist");
    //    CCSprite *zombies = CCSprite::createWithSpriteFrameName("FlagZombie1.png");
    //    zombies->setPosition(ccp(size.width/2,size.height/2));
    //    this->addChild(zombies);
    //
    //
    //    //从缓存中读取
    //    CCSpriteFrameCache *cachess = CCSpriteFrameCache::sharedSpriteFrameCache();
    //    cache->addSpriteFramesWithFile("FlagZombie_default.plist");
    //
    //    char temp[50];
    //    CCArray *plistArray = CCArray::createWithCapacity(10);
    //    for (int i = 1; i< 13; i++) {
    //        sprintf(temp,"FlagZombie%i.png",i);
    //        CCSpriteFrame *frame = cache->spriteFrameByName(temp);
    //        plistArray->addObject(frame);
    //    }
    //    //创建动画
    //    CCAnimation *animation = CCAnimation::createWithSpriteFrames(plistArray);
    //    CCAnimate *animate = CCAnimate::create(animation);
    //    sprite->runAction(CCRepeatForever::create(animate));//创建永久动作
    
    //    //常用播放音乐方法
    //    //1.循环播放音乐
    //    SimpleAudioEngine::sharedEngine()->playBackgroundMusic("bg_music03.caf",true);
    //    //播放音乐，只播放一遍
    //    SimpleAudioEngine::sharedEngine()->playBackgroundMusic("bg_music03.caf");
    //    //2.停止音乐
    //    SimpleAudioEngine::sharedEngine()->stopBackgroundMusic();
    //    //3.暂停音乐
    //    SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
    //    //4.继续播放音乐
    //    SimpleAudioEngine::sharedEngine()->resumeBackgroundMusic();
    //    //5.倒带播放音乐
    //    SimpleAudioEngine::sharedEngine()->rewindBackgroundMusic();
    //    //6.判断背景音乐是否在播放
    //    bool isPlay = SimpleAudioEngine::sharedEngine()->isBackgroundMusicPlaying();
    //    if (isPlay) {
    //        CCLog("playing");
    //    }else{
    //        CCLog("pause");
    //    }
    //    //7.播放音乐特效
    //    m_nSoundId = SimpleAudioEngine::sharedEngine()->playEffect("");
    //    //8.循环播放音乐特效
    //     m_nSoundId = SimpleAudioEngine::sharedEngine()->playEffect("", true);
    //    //9.停止播放音乐特效
    //    SimpleAudioEngine::sharedEngine()->stopEffect(m_nSoundId);
    //    //10.释放音乐资源
    //    SimpleAudioEngine::sharedEngine()->unloadEffect(m_nSoundId);
    //    //11、增大背景音乐播放大小
    //    SimpleAudioEngine::sharedEngine()->setBackgroundMusicVolume(SimpleAudioEngine::sharedEngine()->getBackgroundMusicVolume()+0.1f);
    //    //12.减少背景音乐大小
    //    SimpleAudioEngine::sharedEngine()->setBackgroundMusicVolume(SimpleAudioEngine::sharedEngine()->getBackgroundMusicVolume()-0.1f);
    //    //13.增大音效
    //    SimpleAudioEngine::sharedEngine()->setEffectsVolume(SimpleAudioEngine::sharedEngine()->getEffectsVolume()+0.1f);
    //    //14.减小音效
    //    SimpleAudioEngine::sharedEngine()->setEffectsVolume(SimpleAudioEngine::sharedEngine()->getEffectsVolume()-0.1f);
    //    //15.停止音效播放
    //    SimpleAudioEngine::sharedEngine()->pauseEffect(m_nSoundId);
    //    //16.恢复音效播放
    //    SimpleAudioEngine::sharedEngine()->resumeEffect(m_nSoundId);
    //    //17.暂停所有音效
    //    SimpleAudioEngine::sharedEngine()->pauseAllEffects(m_nSoundId);
    //    //18.恢复所有音效
    //    SimpleAudioEngine::sharedEngine()->resumeAllEffects();
    //    //19.停止所有音效
    //    SimpleAudioEngine::sharedEngine()->stopAllEffects();
    
    
    /*************************cocos2dx--CCUserDefault实现基础数据的存储************************************/
    //保存数据
    /* CCUserDefault::sharedUserDefault()->setBoolForKey("boolValue", true);
     CCUserDefault::sharedUserDefault()->setStringForKey("String", "this is String");
     CCUserDefault::sharedUserDefault()->setIntegerForKey("integer", 2);
     CCUserDefault::sharedUserDefault()->setFloatForKey("float",0.9f);
     CCUserDefault::sharedUserDefault()->setDoubleForKey("double",2.3);
     //读取数据
     string ret = CCUserDefault::sharedUserDefault()->getStringForKey("String");
     CCLog("String is %s",ret.c_str());
     int num = CCUserDefault::sharedUserDefault()->getIntegerForKey("integer");
     CCLog("%d",num);
     bool flag = CCUserDefault::sharedUserDefault()->getBoolForKey("boolValue");
     CCLog("%d",flag);
     float toe = CCUserDefault::sharedUserDefault()->getFloatForKey("float");
     CCLog("%f",toe);
     double doucs = CCUserDefault::sharedUserDefault()->getDoubleForKey("double");
     CCLog("%f",doucs);
     */
    /*************************使用AnimatePacker处理动画************************************/
    /*
     1.首先要有纹理图片和对应的plist文件对纹理的剪切信息，可以通过texturePacker或使用Zwoptex工具
     2.使用AnimatePacker创建animation并拖动Sprites（每一帧形成动画）
     3.保存文件为xml格式
     4.在Cocos2dx项目中资源中将纹理图片、plist文件、动画的xml文件资源
     5.在Cocos2dx项目中引入AnimatePacker.h和AnimatePacker.cpp文件Singleton.h
     */
    //    AnimatePacker ::getInstance()->loadAnimations("animat.xml");//处理后的XML文件
    //    CCSprite *sprite = CCSprite::create("grossini_dance.png");
    //    sprite->setPosition(ccp(180,20));
    //    sprite->runAction(CCRepeatForever::create(AnimatePacker::getInstance()->getSequence("ani01")));
    
    /***************CCParticleSystemQuadLoader.h粒子效果*****************/
    //    CCParticleExplosion://爆炸粒子效果
    //    CCParticleFire://火焰粒子效果
    //    CCParticleFireworks://烟花效果
    //    CCParticleFlower://花束效果
    //    CCParticleGalaxy://星系粒子效果
    //    CCParticleMeteor://流星粒子效果
    //    CCParticleRain://雨滴效果
    //    CCParticleSmoke://烟雾效果
    //    CCParticleSnow://雪花效果
    //    CCParticleSpiral://涡轮粒子效果
    //    CCParticleSun://太阳粒子效果
    //根据图片创建粒子系统
    /*    CCParticleSystem *particle = CCParticleFireworks::create();
     particle->setTexture(CCTextureCache::sharedTextureCache()->addImage("image.png"));
     this->addChild(particle);
     //根据属性创建粒子系统
     CCParticleSystem *m_emitter;
     m_emitter = new CCParticleSystemQuad();
     m_emitter->initWithTotalParticles(50);
     //设置纹理
     m_emitter->setTexture(CCTextureCache::sharedTextureCache()->addImage("image.png"));
     m_emitter->setDuration(-1);
     //设置对齐(重力)
     m_emitter->setGravity(CCPointZero);
     //角度
     m_emitter->setAngle(90);
     m_emitter->setAngleVar(360);
     //粒子速度
     m_emitter->setSpeed(160);
     m_emitter->setSpeedVar(0);
     //杠杆支点
     m_emitter->setTangentialAccel(30);
     m_emitter->setTangentialAccelVar(0);
     //粒子坐标
     m_emitter->setPosition(CCPointMake(160, 20));
     m_emitter->setPosVar(CCPointZero);
     //粒子声明周期
     m_emitter->setLife(4);
     m_emitter->setLifeVar(1);
     //粒子旋转
     m_emitter->setStartSpin(0);
     m_emitter->setStartSizeVar(0);
     m_emitter->setEndSpin(0);
     m_emitter->setEndSpinVar(0);
     //粒子颜色
     ccColor4F startColor = {0.5f,0.5f,0.5f,1.0f};
     m_emitter->setStartColor(startColor);
     ccColor4F startColorVar = {0.5f,0.5f,0.5f,1.0f};
     m_emitter->setStartColorVar(startColorVar);
     ccColor4F endColor = {0.1f,0.1f,0.1f,0.2f};
     m_emitter->setStartColor(endColor);
     ccColor4F endColorVar = {0.1f,0.1f,0.1f,0.2f};
     m_emitter->setStartColorVar(endColorVar);
     //粒子尺寸
     m_emitter->setStartSizeVar(40.0f);
     m_emitter->setStartSize(80.0f);
     m_emitter->setEndSize(kParticleStartSizeEqualToEndSize);
     //每秒出现粒子数
     m_emitter->setEmissionRate(m_emitter->getTotalParticles()/m_emitter->getLife());
     //添加混合
     m_emitter->setBlendAdditive(true);
     
     this->addChild(m_emitter,10);
     */
    
    //1.创建Box2d世界代码---
    //无重力状态创建一个物理世界并设置两个状态，允许睡眠和开启连续物理测试
    /*
     允许睡眠，可以提高物理世界中物理的处理效果，只有在发生碰撞时才唤醒；
     开启物理测试原因：
     计算机智能把一段连续的时间分成许多离散的时间点，再对每个时间点之间的行为进行演算，如果时间的分割不够细致，
     速度较快的两个物体碰撞时就可能产生“穿透"现象，开启物理将启用特殊算法来避免物质现象，最后设置了碰撞时间的监听器
     */
    /*  b2Vec2 gravity;
     gravity.Set(0.0f, -10.0f);
     b2World *world = new b2World(gravity);
     world->SetAllowSleeping(true);
     world->SetContinuousPhysics(true);
     //2.创建一个地面盒子
     //物理定义
     b2BodyDef groudBodyDef;
     groudBodyDef.position.Set(0, 0);//bottom left center
     //创建一个地面
     b2Body *groundBody = world->CreateBody(&groudBodyDef);
     //定义包围盒子
     b2EdgeShape groundBox;
     #define PTM_RATIO 32
     //地面
     CCSize s = CCDirector::sharedDirector()->getWinSize();
     groundBox.Set(b2Vec2(0, 0), b2Vec2(s.width/PTM_RATIO, 0));
     groundBody->CreateFixture(&groundBox,0);
     //顶面
     groundBox.Set(b2Vec2(0,s.height/ PTM_RATIO), b2Vec2(s.width/PTM_RATIO, s.height/PTM_RATIO));
     groundBody->CreateFixture(&groundBox,0);
     //左面
     groundBox.Set(b2Vec2(0,s.height/ PTM_RATIO), b2Vec2(0,0));
     groundBody->CreateFixture(&groundBox,0);
     //右面
     groundBox.Set(b2Vec2(s.width/PTM_RATIO,s.height/ PTM_RATIO), b2Vec2(s.width/PTM_RATIO, 0));
     groundBody->CreateFixture(&groundBox,0);
     
     */
    
    
    //    CCSize visibleSize = CCDirector::sharedDirector()->getVisibleSize();
    //    CCPoint origin = CCDirector::sharedDirector()->getVisibleOrigin();
    //
    //    CCMenuItemImage *pCloseItem = CCMenuItemImage::create(
    //                                        "CloseNormal.png",
    //                                        "CloseSelected.png",
    //                                        this,
    //                                        menu_selector(HelloWorld::menuCloseCallback));
    //
    //	pCloseItem->setPosition(ccp(origin.x + visibleSize.width - pCloseItem->getContentSize().width/2 ,
    //                                origin.y + pCloseItem->getContentSize().height/2));
    //
    //    CCMenu* pMenu = CCMenu::create(pCloseItem, NULL);
    //    pMenu->setPosition(CCPointZero);
    //    this->addChild(pMenu, 1);
    //
    //    CCLabelTTF* pLabel = CCLabelTTF::create("Hello World", "Arial", 24);
    //
    //    pLabel->setPosition(ccp(origin.x + visibleSize.width/2,
    //                            origin.y + visibleSize.height - pLabel->getContentSize().height));
    //
    //    this->addChild(pLabel, 1);
    //    CCSprite* pSprite = CCSprite::create("HelloWorld.png");
    //    pSprite->setPosition(ccp(visibleSize.width/2 + origin.x, visibleSize.height/2 + origin.y));
    //    this->addChild(pSprite, 0);
    
    //    CCSize s = CCDirector::sharedDirector()->getWinSize();
    //    CCLabelTTF *label = CCLabelTTF::create("Icon-57.png","宋体",80);
    //    label->setPosition(ccp(s.width/2,s.height/2));
    //
    //    //移动
    //    CCMoveBy *moveTo = CCMoveBy::create(5, ccp(s.width/2-150, s.height/2-40));
    //    //缩放
    //    CCScaleBy *scaleBy = CCScaleBy::create(5, .5f);
    //    //旋转
    //    CCRotateBy *rotateBy = CCRotateBy::create(5,720);
    //    //同时执行以上动作
    //    CCSpawn *spawn = CCSpawn::create(moveTo,scaleBy,rotateBy,NULL);
    //    //消失
    //    CCCallFunc *func = CCCallFunc::create(this, callfunc_selector(HelloWorld::removeFromParent));
    //    //让动作按顺序执行
    //    CCSequence *seq = CCSequence::create(spawn,func,NULL);
    //    label->runAction(seq);
    //    this->addChild(label);
    
    size = CCDirector::sharedDirector()->getWinSize();
    //    CCSprite *scrollGrassSprite = CCSprite::create("Icon-57.png");
    //    scrollGrassSprite->setPosition(ccp(size.width/2-200,size.height/2-50));
    //    scrollGrassSprite->setScale(2.0f);
    //    //应为是滚动的草坪故要对静态图片进行处理
    //    CCMoveBy *moveTo = CCMoveBy::create(5, ccp(size.width/2-150, size.height/2-40));
    //    //设置旋转方式--5秒钟旋转720度
    //    CCRotateBy *rotateBy = CCRotateBy::create(5,2*360);
    //    //设置缩放/5秒钟缩放0.5
    //    CCScaleBy *scaleBy = CCScaleBy::create(5,0.7);
    //    //将缩放和旋转通过spawn球-->组织起来
    //    CCSpawn *spawn = CCSpawn::create(moveTo,rotateBy,scaleBy,NULL);
    //    //通过回调函数----开始动画直至移除--循环调用
    //    CCCallFuncN *removeFunc =CCCallFuncN::create(this,callfuncN_selector(HelloWorld::removeFromParent));
    //    //通过队列将关键动作串联起来
    //    CCSequence *scaleRotateSequce = CCSequence::create(spawn,removeFunc,NULL);
    //    //运行动画
    //    scrollGrassSprite->runAction(scaleRotateSequce);
    //    this->addChild(scrollGrassSprite);
    
    //    this->setTouchEnabled(true);
    /*单个从缓存中获取*/
    //    texture = CCTextureCache::sharedTextureCache()->addImage("player.png");
    //    float width =  texture->getContentSize().width/4;
    //    float height = texture->getContentSize().height;
    //    CCSprite *sprite = CCSprite::createWithTexture(texture,CCRectMake(0, 0, width, height));
    //    sprite->setPosition(ccp(size.width/2,size.height/2));
    //    this->addChild(sprite);
    /*从缓存中获取动画*/
    /*说明：
     原理：实在已有的大图种分别占位，而缓存中大图是不会显示的，
     分别添加时，就是在原来的大图中寻找图片的位置对应放置
     
     1.player.png中又4张图片；
     2.使用
     CCSprite *pSprite = CCSprite::create("player.png");
     CCTexture2D *pText2d = CCTextureCache::sharedTextureCache()->addImage("player.png");
     
     添加的精灵都是大图精灵，一个大图包含所有动作的图片；
     3.创建时通过计算的出大图中单个小精灵的尺寸获取对应元素；
     4.创建CCAnimation  *animation = CCAnimation::create();//创建动画
     用于存储动画帧
     5.使用循环分别截取大图种包含的分动作
     6.使用CCAnimate::create(animation)转换为真正的动作
     7.使用CCRepeatForever::create()让动作无限重复
     也可使用animation->setLoops(-1);//无限循环
     8.让精灵执行动作
     pSprite->runAction();
     */
    //    CCSprite *pSprite = CCSprite::create("player.png");
    //    CCTexture2D *pText2d = CCTextureCache::sharedTextureCache()->addImage("player.png");
    //    //获取大图宽高
    //    float w = pSprite->getContentSize().width/4;
    //    float h = pSprite->getContentSize().height;
    //    CCAnimation  *animation = CCAnimation::create();//创建动画
    //    animation->setDelayPerUnit(0.2f);//设置动画每一帧的间隔
    ////    animation->setLoops(-1);//无限循环
    //    for (int i = 0; i<4; i++) {
    //        animation->addSpriteFrameWithTexture(pText2d, CCRectMake(i*w,0, 100, h));
    //        pSprite = CCSprite::createWithTexture(pText2d,CCRectMake(0, 0,100, 99));
    //        pSprite->runAction(CCRepeatForever::create(CCAnimate::create(animation)));
    //
    //    }
    //    pSprite->setPosition(ccp(size.width/4, size.height/2));
    //    this->addChild(pSprite);
    
    /*获取每个单帧的动画图片
     
     有5张飞机的连续动作的图片:player1,player2,player3,player4,player5
     分别创建帧，然后添加到CCAnimation中
     
     */
    //    CCSprite *pSprite = CCSprite::create("player1.png");
    //    //获取大图宽高
    //    float w = pSprite->getContentSize().width;
    //    float h = pSprite->getContentSize().height;
    //    CCAnimation  *animation = CCAnimation::create();//创建动画
    //    animation->setDelayPerUnit(0.2f);//设置动画每一帧的间隔
    ////    animation->setLoops(-1);//无限循环
    //    for (int i = 1; i<6; i++) {
    //        CCString *names = CCString::createWithFormat("player%d.png",i);
    //        CCSpriteFrame *frame = CCSpriteFrame::create(names->getCString(), CCRectMake(0, 0, w, h));
    //        animation->addSpriteFrame(frame);
    //        pSprite->runAction(CCRepeatForever::create(CCAnimate::create(animation)));
    //    }
    //    pSprite->setPosition(ccp(size.width/4, size.height/2));
    //    this->addChild(pSprite);
    
    /*
     如何读取plist文件中的图片FlagZombie_default.png单帧图片动画
     1.先将FlagZombie_default.png文件的
     大图FlagZombie_default.png添加到精灵；
     2.将FlagZombie_default.plist文件添加到CCSpriteFrameCache
     3.定义一个数组用于存储动画精灵帧
     4.定义动画帧对象接收单帧动画
     5.设置CCAnimation
     6.将CCAnimation 封装到CCAnimate
     7.让pSprite执行动画
     
     */
    //    //创建大图精灵
    //    CCSprite *pSprite = CCSprite::create("FlagZombie_default.png");
    //    //将大图对应的plist文件读取到CCSpriteFrameCache中
    //    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    //    cache->addSpriteFramesWithFile("FlagZombie_default.plist");
    //    char temp[100];
    //    //定义一个数组存储CCAnimationFrame
    //    CCArray *arr = CCArray ::create();
    //    //循环添加动画帧
    //    for (int i = 1; i <= 12;i++) {
    //        //拼接获取plist文件中的单个图片帧
    //        sprintf(temp,"FlagZombie%d.png",i);
    //        CCSpriteFrame *frame = cache->spriteFrameByName(temp);
    //        //创建动画帧
    //        CCAnimationFrame *animationframe = new CCAnimationFrame();
    //        animationframe ->initWithSpriteFrame(frame, 1, NULL);
    //        animationframe->autorelease();
    //        //将动画帧存入
    //        arr->addObject(animationframe);
    //    }
    //    //将动画帧存入静态动画库中及放置的间隔时间
    //    CCAnimation *animation = CCAnimation::create(arr,0.2);
    //    animation->setLoops(-1);//设置无限循环
    ////    animation->setDelayPerUnit(0.2f);//设置每帧动画放置间隔的时间
    //    pSprite->runAction(CCAnimate::create(animation));
    //    pSprite->setPosition(ccp(size.width/2,size.height/2));
    //    this->addChild(pSprite);
    
    //    this->setTouchEnabled(true);
    
    //    //将大图对应的plist文件读取到CCSpriteFrameCache中
    //    CCSpriteFrameCache *cache = CCSpriteFrameCache::sharedSpriteFrameCache();
    //    cache->addSpriteFramesWithFile("FlagZombie_default.plist");
    //    //创建大图精灵
    //    CCSprite *pSprite = CCSprite::createWithSpriteFrameName("FlagZombie1.png");
    //
    //    CCArray *array = CCArray::create();
    //    //循环添加动画帧
    //    for (int i = 1; i <= 7;i++) {
    //        //拼接获取plist文件中的单个图片帧
    //        CCString *name = CCString::createWithFormat("FlagZombie%d.png",i);
    //        CCSpriteFrame *frame = cache->spriteFrameByName(name->getCString());
    //        CCLog("%.2f",frame->getRect().size.height);
    //        CCAnimationFrame *animationframe = new CCAnimationFrame();
    //        animationframe ->initWithSpriteFrame(frame, 1, NULL);
    //        animationframe->autorelease();
    //        array->addObject(animationframe);
    //    }
    //    CCAnimation *animation = CCAnimation::create(array,0.2f);
    //    animation->setLoops(-1);
    //
    //    //僵尸自身的动作
    //    CCAnimate *animate = CCAnimate::create(animation);
    //    //僵尸移动到目标位置
    //    CCMoveTo *moveBy = CCMoveTo::create(25, ccp(size.width/2-300,size.height/2));
    //    //合并动作，同时进行动作
    //    CCSpawn *spwan = CCSpawn::create(animate,moveBy,NULL);
    //    CCCallFuncN *removeFunc =CCCallFuncN::create(this,callfuncN_selector(HelloWorld::removeFromParent));
    //    CCSequence *sequence = CCSequence::create(spwan,removeFunc,NULL);
    //    pSprite->runAction(sequence);
    //
    //    //设置精灵原始位置
    //    pSprite->setPosition(ccp(size.width/2+300,size.height/2));
    //    this->addChild(pSprite);
    
    /*系统自带的粒子火焰*/
    //    CCParticleFire *fire = CCParticleFire::create();
    //    fire->setPosition(ccp(size.width/2,size.height/2));
    //    this->addChild(fire);
    //    //烟花粒子
    //    CCParticleFireworks *work = CCParticleFireworks::create();
    //    work->setPosition(ccp(size.width/2,size.height/2));
    //    this->addChild(work);
    //    //旋转粒子
    //    CCParticleGalaxy *Galaxy = CCParticleGalaxy::create();
    //    Galaxy->setPosition(ccp(size.width/2,size.height/2));
    //    this->addChild(Galaxy);
    
    /*
     使用ParticleDesigner工具制作的粒子
     1.使用第三方工具制作出粒子效果；
     2.将文件保存为“.plist”文件，并拖入项目中
     3.使用CCParticleSystemQuad  创建粒子
     
     */
    
    /*
     CCParticleSystemQuad *quad = CCParticleSystemQuad::create("test.plist");
     quad->setPosition(ccp(size.width/2,size.height/2));
     this->addChild(quad);
     
     //获取从地图编辑器上获取的文件
     CCTMXTiledMap *titlMap = CCTMXTiledMap::create("Map.tmx");
     this->addChild(titlMap);
     
     //获取组名中的对象点
     CCTMXObjectGroup *group =titlMap->objectGroupNamed("Path");
     //获取Path中的点
     CCDictionary *dict = group->objectNamed("Point1");
     //获取该字典中的键值（设定的点得位置）
     float x = dict->valueForKey("x")->floatValue();//x轴坐标
     float y = dict->valueForKey("y")->floatValue();//y轴坐标
     //将点的位置存放在所有的点得数组中
     CCPointArray *pointArray = CCPointArray::create(8);
     for (int i = 1; i<=8;i++) {
     CCString *string = CCString::createWithFormat("Point%d",i);
     CCDictionary *d = group->objectNamed(string->getCString());
     float x = d->valueForKey("x")->floatValue();
     float y = d->valueForKey("y")->floatValue();
     CCPoint point = CCPoint(x,y);
     pointArray->addControlPoint(point);
     }
     
     //测试一下位置是否正确
     CCSprite *sprite = CCSprite::create("Icon-small.png");
     sprite->setPosition(ccp(x, y));
     this->addChild(sprite);
     //通过标记控制点进行数组中控制点执行动作
     CCCardinalSplineTo *lineMove = CCCardinalSplineTo::create(1,pointArray,1);
     sprite->runAction(lineMove);
     */
    
    
    //    this->createShark(1, kSharkMove);
    this->creatOtherFish(11);
    this->creatOtherFish(10);
    this->creatOtherFish(8);
    this->creatOtherFish(9);
    this->creatOtherFish(7);
    this->creatOtherFish(6);
    this->creatOtherFish(5);
    this->creatOtherFish(4);
    this->creatOtherFish(3);
    this->creatOtherFish(1);
    this->creatOtherFish(2);
    
    return true;
    
}

void HelloWorld::creatOtherFish(int type){
    
    CCSpriteFrameCache *cache  = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("fish.plist");
    char first[30];
    sprintf(first,"fish0%d_01.png",type);
//    CCLog("%s",first);
    CCSprite *pSprite = CCSprite::createWithSpriteFrameName(first);
    int arrayCount;
    if (type == 8) {
        arrayCount = 16;
    }else{
        arrayCount = 10;
    }
    CCArray *frameArray = CCArray::createWithCapacity(arrayCount);
    for (int i = 1; i <=arrayCount; i ++) {
        char temp[30];
        if (i<10) {
            sprintf(temp,"fish0%d_0%d.png",type,i);
        }else{
            CCLog("-----------");
            sprintf(temp,"fish0%d_%d.png",type,i);
        }
        CCSpriteFrame *frame = cache->spriteFrameByName(temp);
        CCAnimationFrame *animationframe = new CCAnimationFrame();
        animationframe ->initWithSpriteFrame(frame, 1, NULL);
        animationframe->autorelease();
        frameArray->addObject(animationframe);
    }
    CCAnimation *animation = CCAnimation::create(frameArray, 0.1f);
    animation->setLoops(-1);
    CCAnimate *animate = CCAnimate::create(animation);
    float x1 = (400+arc4random()%60)-100;
    float y1 = (40+arc4random()%300)-10;
    CCMoveTo *moveTo = CCMoveTo::create(5, ccp(x1,y1));
    CCSpawn *spawm = CCSpawn::create(animate,moveTo,NULL);
    CCRotateTo *rotate = CCRotateTo::create(1, 180);
    CCMoveTo *moveBy = CCMoveTo::create(5, ccp(x1+200, y1+200));
    CCSpawn *spaw2= CCSpawn::create(animate,rotate,moveBy,NULL);
    CCCallFuncN *stopActions = CCCallFuncN::create(this, callfuncN_selector(HelloWorld::stopAllActions));
    CCCallFunc *func = CCCallFunc::create(this, callfunc_selector(HelloWorld::removeFromParentAndCleanup));
    CCFiniteTimeAction *allActions = CCSequence::create(spawm,stopActions,spaw2,func,NULL);
//    CCSequence *sequence = CCSequence::create(spawm,rotate,stopActions,func,NULL);
    pSprite->runAction(allActions);
    float x = 900+arc4random()%60;
    float y = 40+arc4random()%600;
    pSprite->setPosition(ccp(x,y));
    this->addChild(pSprite);
    
}





void HelloWorld::createShark(int fishType,char* sharkFace){
    
    //fish_capture_11101_7.png 和 fish_move_11101_8.png
    //fish_capture_11102_7.png 和 fish_move_11102_8.png
    //分别将plist文件和png文件存入CCSpriteFrameCache，和CCSpriteBatchNode中是实现绑定
    CCSpriteFrameCache *cache  = CCSpriteFrameCache::sharedSpriteFrameCache();
    cache->addSpriteFramesWithFile("shark-hd.plist");
    CCSpriteBatchNode *batch = CCSpriteBatchNode::create("shark-hd.png");
    this->addChild(batch);
    CCString *names = CCString::createWithFormat("fish_%s_1110%d_1.png",sharkFace,fishType);
    CCLog("%s",names->getCString());
    CCSprite *pSprite = CCSprite::createWithSpriteFrameName(names->getCString());
    //    char temp[10];
    //    sprintf(temp,"fish_%s_1110%d_1.png",sharkFace,fishType);
    //    CCSprite *pSprite = CCSprite::createWithSpriteFrameName(temp);
    int arrayCapity =0;
    CCLog("%d",strcmp(sharkFace, kSharkCapture));
    CCLog("%d",strcmp(sharkFace, kSharkMove));
    
    if (strcmp(sharkFace, kSharkCapture)) {
        arrayCapity = 7;
    }else if(strcmp(sharkFace, kSharkMove)){
        arrayCapity = 8;
    }
    CCArray *plistArray = CCArray::createWithCapacity(arrayCapity);
    for (int i = 1;  i < plistArray->count(); i++) {
        
        CCString *stringName = CCString::createWithFormat("fish_%s_1110%d_7.png",sharkFace,fishType);
        CCSpriteFrame *frame = cache->spriteFrameByName(stringName->getCString());
        CCAnimationFrame *animationframe = new CCAnimationFrame();
        animationframe ->initWithSpriteFrame(frame, 1, NULL);
        animationframe->autorelease();
        plistArray->addObject(animationframe);
    }
    CCAnimation *animation = CCAnimation::create(plistArray, 0.2f);
    CCAnimate *animate = CCAnimate::create(animation);
    float x = 900+arc4random()%60;
    float y = 40+arc4random()%600;
    pSprite->setPosition(ccp(x,y));
    pSprite->runAction(CCRepeatForever::create(animate));
    this->addChild(pSprite);
    
    
}

void HelloWorld::ccTouchesBegan(cocos2d::CCSet *pTouches, cocos2d::CCEvent *pEvent){
    
}
void HelloWorld::ccTouchesEnded(cocos2d::CCSet *pTouches, cocos2d::CCEvent *pEvent){
    
    
}
void HelloWorld::ccTouchesMoved(cocos2d::CCSet *pTouches, cocos2d::CCEvent *pEvent){
    
}






