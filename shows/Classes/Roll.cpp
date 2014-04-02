//
//  Roll.cpp
//  shows
//
//  Created by 范林松 on 14-3-24.
//
//

#include "Roll.h"
Roll ::Roll():m_maxCol(6),
m_nNumber(0),
zeroFill(true),
style(ScoreStyleNormal){

    numArray = CCArray::create();
    this->clearEffect();
    
}
Roll::~Roll(){


}
void Roll::rebuildEffect(){

    int i=0;
    int num=m_nNumber;
    while (1) {
        if(num<=0){
            if(m_maxCol<=i&&zeroFill){
                break;
            }
        }
        int showNum = num%10;
        Score *pNumber = (Score *)numArray->objectAtIndex(i);
        pNumber->setNumber(showNum);
        i++;
        num = num/10;
    }


}
void Roll::clearEffect(){

    for(int i=0;i<numArray->count();i++){
        Score *pNumber=(Score *)numArray->objectAtIndex(i);
        this->removeChild(pNumber, true);
    }
    numArray->removeAllObjects();
    for(int i=0;i<m_maxCol;i++){
        Score *pNumber = new Score();
        pNumber->m_style = style;
        numArray->addObject(pNumber);
        pNumber->setNumber(0);
        pNumber->setPosition(CCPointMake(m_point.x - i * NUM_WIDTH, m_point.y));
        pNumber->setAnchorPoint(CCPointMake(1,0.5f));
        this->addChild(pNumber,100);
    }

}
void Roll::setNumber(int num){
    
    if(m_nNumber!=num){
        m_nNumber=num;
        this->rebuildEffect();
    }

}
int Roll:: getNumber(){
    return m_nNumber;
}