#ifndef WATER_HPP
#define WATER_HPP

#include "vector2.h"

void Initialise();
void ReadConfig();
void Integrate();
void DrawContainer();
void DrawWater();
void DrawObjects();
void DrawVoid();
void ApplyImpulse(const tVector2 &deltaVel);
void MoveContainer(const tVector2 &dR);
void MoveBox(const tVector2 &dR);

// for user interaction - when the user clicks, record the mouse
// position so we can track it afterwards
enum tInteractionMode 
{
	INTERACTION_NONE, 
	INTERACTION_BOX,
	INTERACTION_CONTAINER, 
	INTERACTION_FOUNTAIN
};

//tInteractionMode interactionMode = INTERACTION_NONE;
#endif
