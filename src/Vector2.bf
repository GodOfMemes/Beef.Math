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

	public static Self One => .(Scalar<T>.One);
	public static Self UnitX => .(Scalar<T>.One,Scalar<T>.Zero);
	public static Self UnitY => .(Scalar<T>.Zero,Scalar<T>.One);
	public static Self Zero => default;

	//public T Length => Scalar<T>.Sqrt(LengthSquared);
	//public T LengthSquared => Dot(this,this);

	public static Self operator +(Self l, Self r) => .(Scalar<T>.Add(l.X,r.X),Scalar<T>.Add(l.Y,r.Y));
	public static Self operator +(Self l, T s) => .(Scalar<T>.Add(l.X,s),Scalar<T>.Add(l.Y,s));

	public static Self operator -(Self l, Self r) => .(Scalar<T>.Subtract(l.X,r.X),Scalar<T>.Subtract(l.Y,r.Y));
	public static Self operator -(Self l, T s) => .(Scalar<T>.Subtract(l.X,s),Scalar<T>.Subtract(l.Y,s));
	public static Self operator -(Self v) => Zero - v;

	public static Self operator *(Self l, T v) => .(Scalar<T>.Multiply(l.X,v),Scalar<T>.Multiply(l.Y,v));
	public static Self operator *(Self l, Self r) => .(Scalar<T>.Multiply(l.X,r.X),Scalar<T>.Multiply(l.Y,r.Y));

	public static Self operator /(Self l, T v) => .(Scalar<T>.Divide(l.X,v),Scalar<T>.Divide(l.Y,v));
	public static Self operator /(Self l, Self r) => .(Scalar<T>.Divide(l.X,r.X),Scalar<T>.Divide(l.Y,r.Y));

	public static bool operator ==(Self l, Self r) => Scalar<T>.Equal(l.X,r.X) && Scalar<T>.Equal(l.Y,r.Y);
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

	// TODO Conversion
}