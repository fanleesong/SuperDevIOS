//
//  CCProps.h
//  ShootPlane
//
//  Created by 范林松 on 14-3-10.
//
//

#ifndef __ShootPlane__CCProps__
#define __ShootPlane__CCProps__

#include <iostream>
#include "commonHeader.h"

//声明一个枚举类型
typedef enum {
    propsTypeBomb = 4,
    propsTypeBullet = 5
}propsType;

//创建一个节点类
class CCProps: public cocos2d:: CCNode{
public:
    
    CCProps();//构造函数
    ~CCProps();//析构函数
    static CCProps * create(void);//静态创建节点方法
    void initWithType(propsType type);//初始化节点类型
    void propAnimation();//创建对象
    CC_SYNTHESIZE_RETAIN(CCSprite *, __prop, Prop);
    
public:
    propsType type;
    
};


#endif /* defined(__ShootPlane__CCProps__) */
