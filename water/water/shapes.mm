#include "shapes.h"
//#include "graphics.hpp"

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>

//========================================================
// tShape
//========================================================
tShape::tShape()
{
  mNParticles = mNConstraints = 0;
}

//========================================================
// AddPoint
//========================================================
int tShape::AddParticle(const tShapeParticle & particle)
{
  mParticles[mNParticles++] = particle;
  return mNParticles - 1;
}

//========================================================
// AddStickConstraint
//========================================================
int tShape::AddStickConstraint(const tStickConstraint & constraint)
{
  mConstraints[mNConstraints++] = constraint;
  return mNConstraints - 1;
}

//========================================================
// SetCoGPosition
//========================================================
void tShape::SetCoGPosition(const tVector2 & pos)
{
  float totalMass = 0.0f;
  tVector2 cog(0.0f, 0.0f);
  for (int i = 0 ; i < mNParticles ; ++i)
  {
    cog += mParticles[i].mPos / mParticles[i].mInvMass;
    totalMass += 1.0f / mParticles[i].mInvMass;
  }
  if (totalMass > 0.0f)
  {
    cog /= totalMass;
    tVector2 delta = pos - cog;
    for (int i = 0 ; i < mNParticles ; ++i)
    {
      mParticles[i].mPos += delta;
      mParticles[i].mOldPos = mParticles[i].mPos;
    }
  }
}

//==============================================================
// Move
//==============================================================
void tShape::Move(const tVector2 & delta)
{
  for (int i = 0 ; i < mNParticles ; ++i)
  {
    mParticles[i].mPos += delta;
    mParticles[i].mOldPos = mParticles[i].mPos;
  }
}

//========================================================
// SetParticleForces
//========================================================
void tShape::SetParticleForces(const tVector2 & f)
{
  for (int i = 0 ; i < mNParticles ; ++i)
  {
    mParticles[i].mForce = f;
  }
}

//========================================================
// Integrate
//========================================================
void tShape::Integrate(float dt)
{
  static const float damping = 0.02f; // 0-1
  tVector2 tmp;
  for (int i = 0 ; i < mNParticles ; ++i)
  {
    tmp = mParticles[i].mPos;
    mParticles[i].mPos += (1.0f - damping) * 
      (mParticles[i].mPos - mParticles[i].mOldPos) + 
      (dt*dt * mParticles[i].mInvMass) * mParticles[i].mForce;
    mParticles[i].mOldPos = tmp;
  }
}

//========================================================
// ResolveConstraints
//========================================================
void tShape::ResolveConstraints(unsigned nIter, 
                                tPenetrationResolver & resolver)
{
  int i;
  for (unsigned iIter = 0 ; iIter < nIter ; ++iIter)
  {
    // our constraints
    for (i = 0 ; i < mNConstraints ; ++i)
    {
      const tStickConstraint & con = mConstraints[i];
      tShapeParticle & p1 = mParticles[con.mI1];
      tShapeParticle & p2 = mParticles[con.mI2];
      tVector2 delta = p2.mPos - p1.mPos;
      float deltaLen = delta.GetLength();
      float diff = (deltaLen - con.mRestLen) / 
        (deltaLen * (p1.mInvMass + p2.mInvMass));
      p1.mPos += (diff * p1.mInvMass) * delta;
      p2.mPos -= (diff * p2.mInvMass) * delta;
    }
    // make sure points aren't penetrating the world
    int numMoved = 0;
    for (i = 0 ; i < mNParticles ; ++i)
    {
      if (resolver.ResolvePenetration(mParticles[i]))
        ++numMoved;
    }
    if (numMoved > 2)
    {
      for (i = 0 ; i < mNParticles ; ++i)
      {
        mParticles[i].mOldPos = mParticles[i].mPos;
      }
    }
  }
}

//========================================================
// tStickConstraint
//========================================================
tStickConstraint::tStickConstraint(int i1, int i2, tShape * shape)
{
  mI1 = i1;
  mI2 = i2;
  int t;
  mRestLen = (shape->GetParticles(t)[i1].mPos -
              shape->GetParticles(t)[i2].mPos).GetLength();
}

//========================================================
// tRectangle
//========================================================
::tRectangle::tRectangle(float width, float height, float density)
{
  float totalMass = density * width * height;

  int TL = AddParticle(tShapeParticle(tVector2(-0.5f * width, 0.5f * height),
                                      totalMass / 4.0f));
  int BL = AddParticle(tShapeParticle(tVector2(-0.5f * width, -0.5f * height), 
                                      totalMass / 4.0f));
  int BR = AddParticle(tShapeParticle(tVector2(0.5f * width, -0.5f * height),
                                      totalMass / 4.0f));
  int TR = AddParticle(tShapeParticle(tVector2(0.5f * width, 0.5f * height), 
                                      totalMass / 4.0f));

  // diagonals
  AddStickConstraint(tStickConstraint(TL, BR, this));
  AddStickConstraint(tStickConstraint(TR, BL, this));
  // edges
  AddStickConstraint(tStickConstraint(TL, TR, this));
  AddStickConstraint(tStickConstraint(BL, BR, this));
  AddStickConstraint(tStickConstraint(TL, BL, this));
  AddStickConstraint(tStickConstraint(TR, BR, this));
}

//========================================================
// Draw
//========================================================
void ::tRectangle::Draw()
{
	int t;
    
    glColor4f(1.0f,0.0f, 0.0f,1.0f);
	static const float verts[4 * 2] = 
	{ 
		GetParticles(t)[0].mPos.x,GetParticles(t)[0].mPos.y,
		GetParticles(t)[1].mPos.x,GetParticles(t)[1].mPos.y,
		GetParticles(t)[2].mPos.x,GetParticles(t)[2].mPos.y,
		GetParticles(t)[3].mPos.x,GetParticles(t)[3].mPos.y
	};
	glVertexPointer(2,GL_FLOAT,0, verts);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
}

//========================================================
// MovePointOutOfObject
//========================================================
bool ::tRectangle::MovePointOutOfObject(tVector2 & _pos, tVector2 & _normal)
{
  int nObjectParticles;
  const tShapeParticle * objectParticles = GetParticles(nObjectParticles);
  // smallest penetration distance found
  float smallestDist = 999999.0f;
  tVector2 surfacePos = _pos;
  for (int iObjectParticle = 0 ; 
       iObjectParticle < nObjectParticles ; 
       ++iObjectParticle)
  {
    // the points are in order for traversing the object. 
    int iStart = iObjectParticle;
    int iEnd = (iStart+1) % nObjectParticles;
    const tVector2 & posStart = objectParticles[iStart].mPos;
    const tVector2 & posEnd = objectParticles[iEnd].mPos;
    tVector2 edgeDelta = posEnd - posStart;
    float edgeLen = edgeDelta.GetLength();
    tVector2 edgeDir = edgeDelta / edgeLen;
    tVector2 edgeNormal(edgeDir.y, -edgeDir.x); // points out of the object

    // dist is the penetration distance
    float dist = -Dot(_pos - posStart, edgeNormal);
    if (dist <= 0.0f)
      return false;

    if (dist < smallestDist)
    {
      smallestDist = dist;
      surfacePos = _pos + dist * edgeNormal;
      _normal = edgeNormal;
    }
  }
  _pos = surfacePos;
  return true;
}
