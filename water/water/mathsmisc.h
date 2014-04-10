//==============================================================
// Copyright (C) 2004 Danny Chapman 
//               danny@rowlhouse.freeserve.co.uk
//--------------------------------------------------------------
//               
/// @file mathsmisc.hpp 
//                     
//==============================================================
#ifndef MATHSMISC_HPP
#define MATHSMISC_HPP
#include <stdlib.h>

inline int Limit(int val, int min, int max) {
    if (val < min) return min; 
	else if (val > max) return max;
	else return val;
}

inline float Cube(float val) {return val * val * val;}

/// Returns a random number between v1 and v2
inline float RangedRandom(float v1, float v2) {
    return v1 + (v2-v1)*((float)rand())/((float)RAND_MAX);}

#endif
