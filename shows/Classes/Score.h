//
//  Score.h
//  shows
//
//  Created by 范林松 on 14-3-24.
//
//

#ifndef __shows__Score__
#define __shows__Score__

#include <iostream>
#include "Header.h"
#define NUM_HEIGHT 12
#define NUM_WIDTH  9

typedef enum{
    ScoreStyleNormal,
    ScoreStyleSameTime,
}ScoreStyle;

class Score :public CCSprite {
    
public:
    Score();
    ~Score();
    ScoreStyle m_style;//分数样式
    int m_num;
    int m_nPosCur;//当前位置
    int m_nPosEnd;//结束位置
    int m_nMoveLen;//移动距离
    CCTexture2D *m_texture;
    
public:
    void setNumber(int num);
    void onRollDown(CCTime dt);
    void onRollUP(CCTime dt);
    void setup();
    
};

#endif /* defined(__shows__Score__) */
