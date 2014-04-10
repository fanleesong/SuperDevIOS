#ifndef PARTICLE_HPP
#define PARTICLE_HPP

#include "vector2.h"
//#define CALC_NORMAL_FIELD

// representation of each particle.
// position/vel are in world space.
// The order of fields has a significant impact on speed because of
// cache misses
class tParticle
{
public:
	// The next particle when were stored in a linked list (the spatial grid)
	tParticle * mNext;
	// position
	tVector2 mR;
	// previous position
	tVector2 mOldR;
	// density calculated at this particle
	float mDensity;
	// pressure - diagnosed from density
	float mP;
	// velocity - diagnosed from position since we use verlet/particle
	// integration
	tVector2 mV;
	// pressure force
	tVector2 mPressureForce;
	// gViscosity force
	tVector2 mViscosityForce;
	// body force - gravity + some other forces later?
	tVector2 mBodyForce;
#ifdef CALC_NORMAL_FIELD
	// the "color field" for the normal
	float mCs;
	// the normal field (grad(mCs) so not normalised)
	tVector2 mN;
#endif
};

#endif