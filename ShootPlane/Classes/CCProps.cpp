//
//  CCProps.cpp
//  ShootPlane
//
//  Created by 范林松 on 14-3-10.
//
//

#include "CCProps.h"
//实现构造函数
CCProps::CCProps():__prop(NULL){
}
//实现析构函数
CCProps::~CCProps(){
    //安全释放
    CC_SAFE_RELEASE_NULL(__prop);
}

//实现初始化创建节点方法
CCProps * CCProps::create(void){
    //实例化一个新的对象
	CCProps * pRet = new CCProps();
    //初始化OK后自动释放内存
    if (pRet && pRet->init()){
        pRet->autorelease();
    }else{
        //否则就安全删除
        CC_SAFE_DELETE(pRet);
    }
	return pRet;
}
//初始化类型-->指定该节点的类型
void CCProps::initWithType(propsType type){
    
    this->type = type;
    cocos2d::CCString *propKey = cocos2d::CCString::createWithFormat("enemy%d_fly_1.png",type);
    this->setProp(CCSprite::createWithSpriteFrameName(propKey->getCString()));
    this->getProp()->setPosition(ccp((arc4random()%268)+23, 732));

}
//创建动画
void CCProps::propAnimation(){
    cocos2d::CCMoveTo* act1 = cocos2d::CCMoveTo::create(1, ccp(__prop->getPosition().x, 400));
    cocos2d::CCMoveTo* act2 = cocos2d::CCMoveTo::create(0.2, ccp(__prop->getPosition().x, 402));
    cocos2d::CCMoveTo* act3 = cocos2d::CCMoveTo::create(1, ccp(__prop->getPosition().x, 732));
    cocos2d::CCMoveTo* act4 = cocos2d::CCMoveTo::create(1, ccp(__prop->getPosition().x, -55));
    __prop->runAction(cocos2d::CCSequence::create(act1, act2, act3, act4,NULL));
    
}
