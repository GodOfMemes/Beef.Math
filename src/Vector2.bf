using System;
using System.Globalization;
namespace BeefMath;

struct Vector2<T> : IEquatable<Self>, IFormattable
	where T : IFormattable
{
	public T X;
	public T Y;

	public this(T val) => (X,Y) = (val,val);
	public this(T x,T y) => (X,Y) = (x,y);

	public static Self One => .( Scalar<T>.One);
	public static Self UnitX => .( Scalar<T>.One, Scalar<T>.Zero);
	public static Self UnitY => .( Scalar<T>.Zero, Scalar<T>.One);
	public static Self Zero => default;

	public T Length =>  Scalar.Sqrt(LengthSquared);
	public T LengthSquared => Dot(this);

	public static Self operator +(Self l, Self r) => .( Scalar.Add(l.X,r.X), Scalar.Add(l.Y,r.Y));
	[Commutable] public static Self operator +(Self l, T s) => .( Scalar.Add(l.X,s), Scalar.Add(l.Y,s));

	public static Self operator -(Self l, Self r) => .( Scalar.Subtract(l.X,r.X), Scalar.Subtract(l.Y,r.Y));
	[Commutable] public static Self operator -(Self l, T s) => .( Scalar.Subtract(l.X,s), Scalar.Subtract(l.Y,s));
	public static Self operator -(Self v) => Zero - v;

	[Commutable] public static Self operator *(Self l, T v) => .( Scalar.Multiply(l.X,v), Scalar.Multiply(l.Y,v));
	public static Self operator *(Self l, Self r) => .( Scalar.Multiply(l.X,r.X), Scalar.Multiply(l.Y,r.Y));

	[Commutable] public static Self operator /(Self l, T v) => .( Scalar.Divide(l.X,v), Scalar.Divide(l.Y,v));
	public static Self operator /(Self l, Self r) => .( Scalar.Divide(l.X,r.X), Scalar.Divide(l.Y,r.Y));

	public static bool operator ==(Self l, Self r) =>  Scalar.Equal(l.X,r.X) &&  Scalar.Equal(l.Y,r.Y);
	public static bool operator !=(Self l, Self r) => !(l == r);

	public bool Equals(Vector2<T> other) => this == other;

	public void ToString(String outString) => ToString(outString,"G",CultureInfo.CurrentCulture);
	public void ToString(String outString, String format) => ToString(outString,format,CultureInfo.CurrentCulture);
	public void ToString(String outString, String format, IFormatProvider formatProvider)
	{
		outString.Append("<");
		outString.Append(X.ToString(.. scope String(),format,formatProvider));
		outString.Append(",");
		outString.Append(Y.ToString(.. scope String(),format,formatProvider));
		outString.Append(">");
	}
	public T Dot(Self b) => Vector2.Dot(this,b);
	// TODO Conversion
}

public static class Vector2
{

	public static T Dot<T>(Vector2<T> a,Vector2<T> b)
		where T : IFormattable
		 => Scalar.Add( Scalar.Multiply(a.X,b.X), Scalar.Multiply(a.Y,b.Y));;
}