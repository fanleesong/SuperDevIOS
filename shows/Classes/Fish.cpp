//
//  Fish.cpp
//  shows
//
//  Created by 范林松 on 14-3-23.
//
//

#include "Fish.h"
//命中率--打中精灵的概率
const int odds[][2] = {
    {20,30},
    {20,40},
    {20,50},
    {30,70},
    {40,100},
    {50,150},
    {60,200},
    {50,300},
    {50,300},
    {60,300},
    {70,300},
    {80,300}
};
/*
const int pathArray[][8]={
//   0-x    1-y  2-x  3-y  4-x  5-y  6   7
    {-200, 100, 240, 320, 560, 240, 150, 190},//0左到右（偏上）--·
    {-200,-100, 240, 320, 560, 120, 125, 200},//1左到右（	偏下）
    {-100, -50, 240, 320, 560,-100, 110, 240},//2左下到右下
    {-100, 330, -20,-100, 550, 380, 270, 130},//3左上到右上
    {  50,-100,  30, 350, 500, 350,  70, 180},//4左下到右上
    { 600, 100, 300, 100,-100, 300, -20,  40},//5右到左（偏上）
    { 550, 300, 300, -50,-150, 160, -60,  25},//6右上到左
    { 600, 240, -20, 350,-150,-100,  10, -30},//7右到左偏下
    { 550,-100, 450, 350,-100, 350,  70,  20},//8右下到左上
    { 400, 400, 150, 420, 100,-100, -20, -80},//9上到下偏左1
    { 300, 400, 600, 100,  50,-100,-130, -35},//10上到下偏右2
    {  50, 400, 600, 150, 250,-100,-160, -60},//11上到下偏右1
    { 300, 550,-100, 100, 100,-100, -50,-105},//12上到下偏左2
    {  25,-100, 350, 200, 100, 400, 150,  60},//13下到上
    { 200,-100,-200, 240, 350, 400,  10, 160},//14下到上
    { 400,-100, 500, 200, 200, 400, 120,  40},//15下到上
    { 450,-100,-100, 200, 260, 400,   0, 110},//16下到上
};*/
int commonNum = 2.5;
int commonTarget = 1.8;
const int pathArray[][8]={
    //   0-x    1-y  2-x  3-y  4-x  5-y  6   7
    {-200*commonNum, 100*commonNum, 240*commonNum, 320*commonNum, 560*commonNum, 240*commonNum, 150*commonTarget, 190*commonTarget},//0左到右（偏上）--·
    {-200*commonNum,-100*commonNum, 240*commonNum, 320*commonNum, 560*commonNum, 120*commonNum, 125*commonTarget, 200*commonTarget},//1左到右（	偏下）
    {-100*commonNum, -50*commonNum, 240*commonNum, 320*commonNum, 560*commonNum,-100*commonNum, 110*commonTarget, 240*commonTarget},//2左下到右下
    {-100*commonNum, 330*commonNum, -20*commonNum,-100*commonNum, 550*commonNum, 380*commonNum, 270*commonTarget, 130*commonTarget},//3左上到右上
    {  50*commonNum,-100*commonNum,  30*commonNum, 350*commonNum, 500*commonNum, 350*commonNum,  70*commonTarget, 180*commonTarget},//4左下到右上
    { 600*commonNum, 100*commonNum, 300*commonNum, 100*commonNum,-100*commonNum, 300*commonNum, -20*commonTarget,  40*commonTarget},//5右到左（偏上）
    { 550*commonNum, 300*commonNum, 300*commonNum, -50*commonNum,-150*commonNum, 160*commonNum, -60*commonTarget,  25*commonTarget},//6右上到左
    { 600*commonNum, 240*commonNum, -20*commonNum, 350*commonNum,-150*commonNum,-100*commonNum,  10*commonTarget, -30*commonTarget},//7右到左偏下
    { 550*commonNum,-100*commonNum, 450*commonNum, 350*commonNum,-100*commonNum, 350*commonNum,  70*commonTarget,  20*commonTarget},//8右下到左上
    { 400*commonNum, 400*commonNum, 150*commonNum, 420*commonNum, 100*commonNum,-100*commonNum, -20*commonTarget, -80*commonTarget},//9上到下偏左1
    { 300*commonNum, 400*commonNum, 600*commonNum, 100*commonNum,  50*commonNum,-100*commonNum,-130*commonTarget, -35*commonTarget},//10上到下偏右2
    {  50*commonNum, 400*commonNum, 600*commonNum, 150*commonNum, 250*commonNum,-100*commonNum,-160*commonTarget, -60*commonTarget},//11上到下偏右1
    { 300*commonNum, 550*commonNum,-100*commonNum, 100*commonNum, 100*commonNum,-100*commonNum, -50*commonTarget,-105*commonTarget},//12上到下偏左2
    {  25*commonNum,-100*commonNum, 350*commonNum, 200*commonNum, 100*commonNum, 400*commonNum, 150*commonTarget,  60*commonTarget},//13下到上
    { 200*commonNum,-100*commonNum,-200*commonNum, 240*commonNum, 350*commonNum, 400*commonNum,  10*commonTarget, 160*commonTarget},//14下到上
    { 400*commonNum,-100*commonNum, 500*commonNum, 200*commonNum, 200*commonNum, 400*commonNum, 120*commonTarget,  40*commonTarget},//15下到上
    { 450*commonNum,-100*commonNum,-100*commonNum, 200*commonNum, 260*commonNum, 400*commonNum,   0*commonTarget, 110*commonTarget},//16下到上
};
#define TOTALPATH 17
#define SPRITE_OFFSET 0
//const int moveTime = 15;
const int moveTime = 30;

//bool Fish::init(){
//    if (!CCNode::init()) {
//        return false;
//    }
//    
//    m_sprite = CCSprite::create();
//    m_sprite->retain();
//    return true;
//}

//随机
bool Fish::randomCatch(int bowLevel){

//    CCLog("%d",odds[fishLevel][0]);
    //根据大炮的等级获取打中精灵的命中率
	if (rand()% odds[fishLevel][1] < (odds[fishLevel][0] * (1 + 0.1*bowLevel)) ){
        return true;
	}
	else {
		return false;
	}
    
}
void Fish::addPath(){
//        CCLog("%s",__FUNCTION__);
    CCPoint startPoint,endPoint,controlPoint;//鱼游动路径
//    float time = rand()%10+18;//随机时间
    float time = rand()%20+18;//随机时间
    float startAngle,endAngle;//旋转
    int i = rand()%TOTALPATH;//鱼游动的路径数组的第一维
    startPoint = ccp(pathArray[i][0],pathArray[i][1]);
    controlPoint = ccp(pathArray[i][2],pathArray[i][3] );
    endPoint = ccp(pathArray[i][4],pathArray[i][5]);
    startAngle = pathArray[i][6] - SPRITE_OFFSET;
    endAngle = pathArray[i][7] - SPRITE_OFFSET;

    this->moveWithBezier(this, startPoint, endPoint, controlPoint, startAngle, endAngle,time);
}
void Fish::moveWithBezier(CCNode *mySprite,CCPoint startPoint,CCPoint endPoint,CCPoint controlPoint, float startAngle, float endAngle,float dirTime){

    int xChange = rand()%450 - 50;
    int yChange = rand()%300 - 50;
    float sx = startPoint.x + xChange;//起点x
    float sy = startPoint.y + yChange;//终点y
    CCPoint sp = CCPointMake(sx, sy);//cpp(sx,sy);

    int ex = endPoint.x + rand()%1000 - 40;
    int ey = endPoint.y + rand()%650 -40;
    CCPoint ep =CCPointMake(ex, ey);//cpp(ex,ey);
    int cx = controlPoint.x + xChange;
    int cy = controlPoint.y + yChange;
    CCPoint cp = CCPointMake(cx, cy);
    mySprite->setPosition(sp);//startPoint;
    mySprite->setRotation(startAngle);
    //动作设置---使用贝塞尔曲线
    ccBezierConfig bezier;
    bezier.controlPoint_1 = sp;
    bezier.controlPoint_2 = cp;
    bezier.endPosition = ep;
    CCBezierTo * actionMove = CCBezierTo::create(dirTime, bezier);
    CCRotateTo * actionRotate = CCRotateTo::create(dirTime, endAngle);
    CCActionInterval * action = CCSpawn::create(actionMove,actionRotate,NULL);
    CCCallFunc *func = CCCallFunc::create(this, callfunc_selector(Fish::removeFish));
    CCSequence * actionSequence = CCSequence::create(action,func,NULL);
    path = CCSpeed::create(actionSequence, 1.85f);//鱼游动的速度

}
void Fish::run(){
    this->runAction(path);
}

void Fish::removeFish(CCSprite *sprite){
    this->removeFromParentAndCleanup(true);
}

















