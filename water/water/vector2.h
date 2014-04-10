#ifndef JIGVECTOR2_HPP
#define JIGVECTOR2_HPP

#include <math.h>

/// A 2x1 matrix
class tVector2
{
public:
    /// public access
    float x, y;
	
    tVector2(float x, float y = 0.0f) : x(x), y(y) {}
    tVector2() {}
	
    /// returns pointer to the first element
    float * GetData() {return &x;} 
    /// returns pointer to the first element
    const float * GetData() const {return &y;} 
	
    void Set(float _x, float _y) {x = _x; y = _y;}
	
    float GetLength() const {return sqrt(x*x + y*y);}
    float GetLengthSq() const {return (x*x + y*y);}
	
    /// Normalise, and return the result
    tVector2 & Normalise() {
		(*this) *= (1.0f / this->GetLength()); return *this;}
    /// Get a normalised copy
    tVector2 GetNormalised() const {
		return tVector2(*this).Normalise();}
	
    tVector2 & operator+=(const tVector2 & v) {x += v.x, y += v.y; return *this;}
    tVector2 & operator-=(const tVector2 & v) {x -= v.x, y -= v.y; return *this;}
	
    tVector2 & operator*=(float f) {x *= f; y *= f; return *this;}
    tVector2 & operator/=(float f) {x /= f; y /= f; return *this;}
	
    tVector2 operator-() const {
		return tVector2(-x, -y);}
	
    void Show(const char * str) const;
	
    friend tVector2 operator+(const tVector2 & v1, const tVector2 & v2);
    friend tVector2 operator-(const tVector2 & v1, const tVector2 & v2);
    friend tVector2 operator*(const tVector2 & v1, float f);
    friend tVector2 operator*(float f, const tVector2 & v1);
    friend tVector2 operator/(const tVector2 & v1, float f);
    friend float Dot(const tVector2 & v1, const tVector2 & v2);
	
    // c-style fns avoiding copies
    // out can also be vec1, vec2 or vec3
    friend void AddVector2(tVector2 & out, const tVector2 & vec1, const tVector2 & vec2);
    friend void AddVector2(tVector2 & out, const tVector2 & vec1, const tVector2 & vec2, const tVector2 & vec3);
    friend void SubVector2(tVector2 & out, const tVector2 & vec1, const tVector2 & vec2);
    /// out = scale * vec1
    friend void ScaleVector2(tVector2 & out, const tVector2 & vec1, float scale);
    /// out = vec1 + scale * vec2
    /// out can also be vec1/vec2
    friend void AddScaleVector2(tVector2 & out, const tVector2 & vec1, float scale, const tVector2 & vec2);
	
};

inline tVector2 operator+(const tVector2 & v1, const tVector2 & v2)
{
	return tVector2(v1.x + v2.x, v1.y + v2.y);
}

inline tVector2 operator-(const tVector2 & v1, const tVector2 & v2)
{
	return tVector2(v1.x - v2.x, v1.y - v2.y);
}

inline tVector2 operator*(const tVector2 & v1, float f)
{
	return tVector2(v1.x * f, v1.y * f);
}

inline tVector2 operator*(float f, const tVector2 & v1)
{
	return tVector2(v1.x * f, v1.y * f);
}

inline tVector2 operator/(const tVector2 & v1, float f)
{
	return tVector2(v1.x / f, v1.y / f);
}

inline float Dot(const tVector2 & v1, const tVector2 & v2)
{
	return v1.x * v2.x + v1.y * v2.y;
}

inline void AddVector2(tVector2 & out, const tVector2 & vec1, const tVector2 & vec2)
{
	out.x = vec1.x + vec2.x;
	out.y = vec1.y + vec2.y;
}

inline void AddVector2(tVector2 & out, const tVector2 & vec1, const tVector2 & vec2, const tVector2 & vec3)
{
	out.x = vec1.x + vec2.x + vec3.x;
	out.y = vec1.y + vec2.y + vec3.y;
}

inline void SubVector2(tVector2 & out, const tVector2 & vec1, const tVector2 & vec2)
{
	out.x = vec1.x - vec2.x;
	out.y = vec1.y - vec2.y;
}

inline void ScaleVector2(tVector2 & out, const tVector2 & vec1, float scale)
{
	out.x = vec1.x * scale;
	out.y = vec1.y * scale;
}

inline void AddScaleVector2(tVector2 & out, const tVector2 & vec1, float scale, const tVector2 & vec2)
{
	out.x = vec1.x + scale * vec2.x;
	out.y = vec1.y + scale * vec2.y;
}

/*
inline void tVector2::Show(const char * str) const
{
    TRACE("%s tVector2::this = 0x%p \n", str, this);
    TRACE("%4f %4f", x, y);
    TRACE("\n");
}
*/
//inline float Min(const tVector2& vec) {return min(vec.x, vec.y);}
//inline float Max(const tVector2& vec) {return max(vec.x, vec.y);}


#endif
