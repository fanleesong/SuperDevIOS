//
//  SystemScene.h
//  shows
//
//  Created by 范林松 on 14-3-23.
//
//

#ifndef __shows__SystemScene__
#define __shows__SystemScene__

#include <iostream>
#include "Header.h"

/*
 这个简单的捕鱼游戏Demo只是完成了简单的：
 1.场景切换、数据加载、武器等级更换<大炮的升级>、
 2.鱼的随机游动、大炮发射子弹、撒网、捕鱼
 3.子弹、鱼、网的碰撞检测等；
 4.场景及背景音乐的定时更换，碰撞时得音效；
 
 仅供参考、入门练习用例；
 
 第一部分：Cocos2d-x简单游戏<捕鱼达人>代码实现|第一部分：鱼类
 第二部分：Cocos2d-x简单游戏<捕鱼达人>代码实现|第二部分：子弹、渔网、大炮类
 第三部分：Cocos2d-x简单游戏<捕鱼达人>代码实现|第三部分：菜单类
 第四部分：Cocos2d-x简单游戏<捕鱼达人>代码实现|第四部分：加载场景类
 第五部分：Cocos2d-x简单游戏<捕鱼达人>代码实现|第五部分：游戏类
 */


class SystemScene:public CCLayer {
private:
//   void startGame();
//    void setGame();
    //声明点击进入单人游戏的事件
    void clickSingle(CCObject *sender);
    void clickUpdate(CCObject *sender);
    void clickMutil(CCObject *sender);
    
public:
    
    SystemScene();
    ~SystemScene();
    
    virtual bool init();
    static CCScene* scene();
    CREATE_FUNC(SystemScene);
    
};





#endif /* defined(__shows__SystemScene__) */
