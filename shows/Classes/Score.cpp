//
//  Score.cpp
//  shows
//
//  Created by 范林松 on 14-3-24.
//
//

#include "Score.h"

Score::Score():
m_style(ScoreStyleNormal),
m_num(0),
m_nMoveLen(0),
m_nPosCur(0),
m_nPosEnd(0),
m_texture(NULL){
    
    this->setup();

}

void Score::setup(){
    //将贴图存入缓存
    m_texture = CCTextureCache::sharedTextureCache()->addImage("number.png");
    CCSpriteFrame *frame = CCSpriteFrame::createWithTexture(m_texture, CCRect(0,0,NUM_WIDTH,NUM_HEIGHT));
    this->setDisplayFrame(frame);
//    Score *pSprite = (Score *)Score::createWithTexture(m_texture, CCRect(0,0,NUM_WIDTH,NUM_HEIGHT));
//    this->addChild(pSprite);
}
void Score::setNumber(int num){

    m_nPosCur = NUM_HEIGHT * m_num;
    m_nPosEnd = NUM_HEIGHT * num;
    
    if (ScoreStyleNormal == m_style) {
        m_nMoveLen = 4;
    }else if (ScoreStyleSameTime == m_style) {
        m_nMoveLen = (m_nPosEnd-m_nPosCur)/NUM_HEIGHT;
    }
    
    if (m_num > num) {
        this->schedule(schedule_selector(Score::onRollUP), 0.05f);
    }
    else {
        this->schedule(schedule_selector(Score::onRollDown), 0.05f);
    }
    m_num = num;

}
void Score::onRollDown(CCTime dt){

    m_nPosCur += m_nMoveLen;
    if (m_nPosCur >= m_nPosEnd) {
        m_nPosCur = m_nPosEnd;
        this->unschedule(schedule_selector(Score::onRollDown));
    }
    
    CCSpriteFrame *frame = CCSpriteFrame::createWithTexture(m_texture, CCRect(0,m_nPosCur,NUM_WIDTH,NUM_HEIGHT));
    this->setDisplayFrame(frame);

}
void Score::onRollUP(CCTime dt){

    m_nPosCur -= m_nMoveLen;
    if (m_nPosCur <= m_nPosEnd) {
        m_nPosCur = m_nPosEnd;
        this->unschedule(schedule_selector(Score::onRollUP));
    }
    CCSpriteFrame *frame = CCSpriteFrame::createWithTexture(m_texture, CCRect(0,m_nPosCur,NUM_WIDTH,NUM_HEIGHT));
    this->setDisplayFrame(frame);

}
Score::~Score(){

    this->unscheduleAllSelectors();

}





















