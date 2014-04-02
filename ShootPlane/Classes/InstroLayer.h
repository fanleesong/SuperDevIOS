//
//  InstroLayer.h
//  ShootPlane
//
//  Created by 范林松 on 14-3-11.
//
//

#ifndef __ShootPlane__InstroLayer__
#define __ShootPlane__InstroLayer__

#include <iostream>
#include "commonHeader.h"
//引导层
class IntroLayer:public CCLayer {
    
private:
    //设置背景
    CCSprite *background1;
    CCSprite *backgroudd2;
    //自适应背景
    int adjustmentBg;
    //更新
    void update(float delate);
    //加载背景
    void loadBackground();
    //背景轮换
    void backgroundScrollRelpace();
    
    
public:
    
    //构造函数及析构函数
    IntroLayer();
    ~IntroLayer();
    //创建场景
    CREATE_FUNC(IntroLayer);
    virtual bool init();//初始化场景
    //
    SCENE_FUNC(IntroLayer);
    virtual void onEnter();//系统函数
    
    
};



#endif /* defined(__ShootPlane__InstroLayer__) */
