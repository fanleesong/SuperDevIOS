//
//  CCRectContaint.cpp
//  shows
//
//  Created by 范林松 on 14-3-25.
//
//

#include "CCRectContaint.h"
bool CCRectContaint::CCRectContainsPoint(const CCRect &rect, const CCPoint &point){

    return rect.containsPoint(point);

}
bool CCRectContaint::containsPoint(const CCPoint &point)const{

    bool bRet = false;
    
    if (point.x >= getMinX() && point.x <= getMaxX()//注意这里的等号
        && point.y >= getMinY() && point.y <= getMaxY()){//注意这里的等号
            bRet = true;
        }
        return bRet;
}