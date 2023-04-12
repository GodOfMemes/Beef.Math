using System;
using System.Globalization;
namespace BeefMath;

struct Vector3<T> : IEquatable<Self>, IFormattable
	where T : IFormattable
{
	public T X;
	public T Y;
	public T Z;

	public this(T val) => (X,Y,Z) = (val,val,val);
	public this(Vector2<T> v) : this(v.X,v.Y) {}
	public this(T x,T y) => (X,Y,Z) = (x,y,default);
	public this(T x,T y,T z) => (X,Y,Z) = (x,y,z);

	public static Self One => .(Scalar<T>.One);
	public static Self UnitX => .(Scalar<T>.One,Scalar<T>.Zero);
	public static Self UnitY => .(Scalar<T>.Zero,Scalar<T>.One);
	public static Self UnitZ => .(Scalar<T>.Zero,Scalar<T>.Zero,Scalar<T>.One);
	public static Self Zero => default;

	public T Length => Scalar.Sqrt(LengthSquared);
	public T LengthSquared => Dot(this);

	public static Self operator +(Self l, Self r) => .(Scalar.Add(l.X,r.X),Scalar.Add(l.Y,r.Y),Scalar.Add(l.Z,r.Z));
	[Commutable] public static Self operator +(Self l, T s) => .(Scalar.Add(l.X,s),Scalar.Add(l.Y,s),Scalar.Add(l.Z,s));

	public static Self operator -(Self l, Self r) => .(Scalar.Subtract(l.X,r.X),Scalar.Subtract(l.Y,r.Y),Scalar.Subtract(l.Z,r.Z));
	[Commutable] public static Self operator -(Self l, T s) => .(Scalar.Subtract(l.X,s),Scalar.Subtract(l.Y,s),Scalar.Subtract(l.Z,s));
	public static Self operator -(Self v) => Zero - v;

	[Commutable] public static Self operator *(Self l, T v) => .(Scalar.Multiply(l.X,v),Scalar.Multiply(l.Y,v),Scalar.Multiply(l.Z,v));
	public static Self operator *(Self l, Self r) => .(Scalar.Multiply(l.X,r.X),Scalar.Multiply(l.Y,r.Y),Scalar.Multiply(l.Z,r.Z));

	[Commutable] public static Self operator /(Self l, T v) => .(Scalar.Divide(l.X,v),Scalar.Divide(l.Y,v),Scalar.Divide(l.Z,v));
	public static Self operator /(Self l, Self r) => .(Scalar.Divide(l.X,r.X),Scalar.Divide(l.Y,r.Y),Scalar.Divide(l.Z,r.Z));

	public static bool operator ==(Self l, Self r) => Scalar.Equal(l.X,r.X) && Scalar.Equal(l.Y,r.Y) && Scalar.Equal(l.Z,r.Z);
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
		outString.Append(">");
	}

	public T Dot(Self b) => Vector3.Dot(this,b);

	
	// TODO Conversion
}


// TODO This for all types
public static class Vector3
{
	public static Vector3<T> Normalize<T>(Vector3<T> v)
		where T : IFormattable
	{
		return v / v.Length;
	}

	public static Vector3<T> Cross<T>(Vector3<T> a, Vector3<T> b)
		where T : IFormattable
	{
		return .(
                Scalar.Subtract(Scalar.Multiply(a.Y, b.Z),
                    Scalar.Multiply(a.Z, b.Y)),
                Scalar.Subtract(Scalar.Multiply(a.Z, b.X),
                    Scalar.Multiply(a.X, b.Z)),
                Scalar.Subtract(Scalar.Multiply(a.X, b.Y),
                    Scalar.Multiply(a.Y, b.X)));
	}

	public static T Dot<T>(Vector3<T> a,Vector3<T> b)
		where T : IFormattable
		 => Scalar.Add(Scalar.Add(Scalar.Multiply(a.X,b.X),Scalar.Multiply(a.Y,b.Y)),Scalar.Multiply(a.Z,b.Z));
}