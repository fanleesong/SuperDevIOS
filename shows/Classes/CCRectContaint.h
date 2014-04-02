//
//  CCRectContaint.h
//  shows
//
//  Created by 范林松 on 14-3-25.
//
//

#ifndef __shows__CCRectContaint__
#define __shows__CCRectContaint__

#include <iostream>
#include "Header.h"

class CCRectContaint:public CCRect{
    
public:
//    bool CCRectContainsPoint(CCRect rect, CCPoint point);
   static bool CCRectContainsPoint(const CCRect& rect, const CCPoint& point);
   bool containsPoint(const CCPoint& point) const;
    
};

#endif /* defined(__shows__CCRectContaint__) */
