//
//  Roll.h
//  shows
//
//  Created by 范林松 on 14-3-24.
//
//

#ifndef __shows__Roll__
#define __shows__Roll__

#include <iostream>
#include "Header.h"
#include "Score.h"


class Roll:public CCSprite {
    
public:
    int m_nNumber;              //显示的数字
    int m_maxCol;               //最大显示位数
    CCArray *numArray;   //存放每个数字的数组
    CCPoint m_point;            //坐标
    bool  zeroFill;             //是否开启0填充
    ScoreStyle style;             //滚动样式
    
public:
    
    Roll();
    ~Roll();
    CREATE_FUNC(Roll);
    void rebuildEffect();
    void clearEffect();
    int getNumber();
    void setNumber(int num);
    
};


#endif /* defined(__shows__Roll__) */


