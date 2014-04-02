//
//  Weapon.h
//  shows
//
//  Created by 范林松 on 14-3-23.
//
//

#ifndef __shows__Weapon__
#define __shows__Weapon__

#include <iostream>
#include "Header.h"
typedef enum{
    normal=0,
    laser
}WeaponType;

class Weapon:public CCSprite{

public:
    
    WeaponType weaponType;//大炮类型
    int weaponLevel;//大炮等级
    
};
#endif /* defined(__shows__Weapon__) */
