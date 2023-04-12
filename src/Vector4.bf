using System;
using System.Globalization;
namespace BeefMath;

struct Vector4<T> : IEquatable<Self>, IFormattable
	where T : IFormattable
{
	public T X;
	public T Y;
	public T Z;
	public T W;

	public this(T val) => (X,Y,Z,W) = (val,val,val,val);
	public this(Vector2<T> v) : this(v.X,v.Y) {}
	public this(T x,T y) => (X,Y,Z,W) = (x,y,default,default);
	public this(T x,T y,T z) => (X,Y,Z,W) = (x,y,z,default);
	public this(T x,T y,T z,T w) => (X,Y,Z,W) = (x,y,z,w);

	public static Self One => .(Scalar<T>.One);
	public static Self UnitX => .(Scalar<T>.One,Scalar<T>.Zero);
	public static Self UnitY => .(Scalar<T>.Zero,Scalar<T>.One);
	public static Self UnitZ => .(Scalar<T>.Zero,Scalar<T>.Zero,Scalar<T>.One);
	public static Self UnitW => .(Scalar<T>.Zero,Scalar<T>.Zero,Scalar<T>.Zero,Scalar<T>.One);

	public static Self Zero => default;

	public T Length => Scalar.Sqrt(LengthSquared);
	public T LengthSquared => Dot(this);

	public static Self operator +(Self l, Self r) => .(Scalar.Add(l.X,r.X),Scalar.Add(l.Y,r.Y),Scalar.Add(l.Z,r.Z),Scalar.Add(l.W,r.W));
	[Commutable] public static Self operator +(Self l, T s) => .(Scalar.Add(l.X,s),Scalar.Add(l.Y,s),Scalar.Add(l.Z,s),Scalar.Add(l.W,s));

	public static Self operator -(Self l, Self r) => .(Scalar.Subtract(l.X,r.X),Scalar.Subtract(l.Y,r.Y),Scalar.Subtract(l.Z,r.Z),Scalar.Subtract(l.W,r.W));
	[Commutable]  public static Self operator -(Self l, T s) => .(Scalar.Subtract(l.X,s),Scalar.Subtract(l.Y,s),Scalar.Subtract(l.Z,s),Scalar.Subtract(l.W,s));
	public static Self operator -(Self v) => Zero - v;

	[Commutable] public static Self operator *(Self l, T v) => .(Scalar.Multiply(l.X,v),Scalar.Multiply(l.Y,v),Scalar.Multiply(l.Z,v),Scalar.Multiply(l.Z,v));
	public static Self operator *(Self l, Self r) => .(Scalar.Multiply(l.X,r.X),Scalar.Multiply(l.Y,r.Y),Scalar.Multiply(l.Z,r.Z),Scalar.Multiply(l.W,r.W));

	[Commutable] public static Self operator /(Self l, T v) => .(Scalar.Divide(l.X,v),Scalar.Divide(l.Y,v),Scalar.Divide(l.Z,v),Scalar.Divide(l.W,v));
	public static Self operator /(Self l, Self r) => .(Scalar.Divide(l.X,r.X),Scalar.Divide(l.Y,r.Y),Scalar.Divide(l.Z,r.Z),Scalar.Divide(l.W,r.W));

	public static bool operator ==(Self l, Self r) => Scalar.Equal(l.X,r.X) && Scalar.Equal(l.Y,r.Y) && Scalar.Equal(l.Z,r.Z) && Scalar.Equal(l.W,r.W);
	public static bool operator !=(Self l, Self r) => !(l == r);

	public bool Equals(Self other) => this == other;

	public void ToString(String outString) => ToString(outString,"G",CultureInfo.CurrentCulture);
	public void ToString(String outString, String format) => ToString(outString,format,CultureInfo.CurrentCulture);
	public void ToString(String outString, String format, IFormatProvider formatProvider)
	{
		outString.Append("<");
		outString.Append(X.ToString(.. scope String(),format,formatProvider));
		outString.Append(",");
		outString.Append(Y.ToString(.. scope String(),format,formatProvider));
		outString.Append(",");
		outString.Append(Z.ToString(.. scope String(),format,formatProvider));
		outString.Append(",");
		outString.Append(W.ToString(.. scope String(),format,formatProvider));
		outString.Append(">");
	}
	public T Dot(Self b) => Vector4.DotProduct(this,b);

	// TODO Conversion
}

public static class Vector4
{
	public static T DotProduct<T>(Vector4<T> a, Vector4<T> b)
		where T : IFormattable
	{
		T v1 = Scalar.Add(Scalar.Multiply(a.X,b.X),Scalar.Multiply(a.Y,b.Y));
		T v2 = Scalar.Add(Scalar.Multiply(a.Z,b.Z),Scalar.Multiply(a.W,b.W));

		return Scalar.Add(v1,v2);
	}
}