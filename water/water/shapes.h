#ifndef SHAPES_HPP
#define SHAPES_HPP

#include "vector2.h"
//#include <vector>

/// point used in a verlet/particle representation of a shape
class tShapeParticle
{
public:
  tShapeParticle() {}
  tShapeParticle(const tVector2 & pos,
                 float mass) : 
    mPos(pos), mOldPos(pos), mForce(0.0f, 0.0f), mInvMass(1.0f / mass) {}
  tVector2 mPos;
  tVector2 mOldPos;
  tVector2 mForce;
  float mInvMass;
};

class tStickConstraint
{
public:
  tStickConstraint() {}
  // explicitly set the length
  tStickConstraint(int i1, int i2, float len) :
    mI1(i1), mI2(i2), mRestLen(len) {}
  // make the constraint calculate the length from the shape (points
  // must be set!)
  tStickConstraint(int i1, int i2, class tShape * shape);
  // indices for the points
  int mI1, mI2;
  // how far apart the points should be
  float mRestLen;
};

/// virtual base class passed in when asking the object to resolve its
/// constraints.
class tPenetrationResolver
{
public:
  virtual ~tPenetrationResolver() {}
  // should return true if the particle was modified
  virtual bool ResolvePenetration(tShapeParticle & particle) = 0;
};

/// Defines a shape that is suitable for use in a verlet/particle
/// integration scheme.
class tShape
{
public:
  tShape();
  virtual ~tShape() {}

  /// adds the particle to our list, and returns the index
  int AddParticle(const tShapeParticle & particle);

  /// adds the constraint to our list and returns the index
  int AddStickConstraint(const tStickConstraint & constraint);

  /// derived class should be able to draw itself
  virtual void Draw() = 0;

  /// Set the centre of gravity position
  void SetCoGPosition(const tVector2 & pos);

  /// move by a delta position (no rotation)
  void Move(const tVector2 & delta);

  /// Set forces that are applied to all particles
  void SetParticleForces(const tVector2 & f);

  /// integrate positions, applying forces
  void Integrate(float dt);

  /// resolve the distance constraints
  void ResolveConstraints(unsigned nIter, tPenetrationResolver & resolver);

  /// Get all the particles defining this shape
  tShapeParticle * GetParticles(int & num) {
    num = mNParticles ; return mParticles;}

  /// modify the point passed in so that it lies on the shape
  /// surface. Return value is true if the object is moved, and the
  /// normal (pointing out of the object) is set
  virtual bool MovePointOutOfObject(tVector2 & _pos, tVector2 & _normal) = 0;

private:
  int mNParticles;
  int mNConstraints;
  enum {MAX_PARTICLES = 256, MAX_CONSTRAINTS = 256};
  tShapeParticle mParticles[MAX_PARTICLES];
  tStickConstraint mConstraints[MAX_CONSTRAINTS];
};

/// a simple rectangle, starting with it's CoM at the origin
class tRectangle : public tShape
{
public:
  tRectangle(float width, 
             float height, 
             float density);

  void Draw();

  bool MovePointOutOfObject(tVector2 & _pos, 
                            tVector2 & _normal);
};

#endif
