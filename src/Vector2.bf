using System;
using System.Globalization;
namespace BeefMath;

struct Vector2<T> : IEquatable<Self>, IFormattable, IEquatable
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
	public bool Equals(Object val) => (val is Self) && (Self)val == this;

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

	public static T DistanceTo<T>(Vector2<T> a, Vector2<T> b)
		where T : IFormattable
		=> (a - b).Length;

	public static T DistanceToSquared<T>(Vector2<T> a, Vector2<T> b)
		where T : IFormattable
		=> (a - b).LengthSquared;

	public static Vector2<T> ToNormalized<T>(Vector2<T> v)
		where T : IFormattable
		=> v / v.Length;

	public static T ToAngle<T>(Vector2<T> v)
		where T : IFormattable
		=> Scalar.Atan2(v.Y,v.X);

	public static T Angle<T>(Vector2<T> from, Vector2<T> to)
		where T : IFormattable
	{
		var v = to - from;

		return Scalar.Atan2(v.Y,v.X);
	}

	public static Vector2<T> AngleToVector<T>(T angle, T length = Scalar<T>.One)
		where T : IFormattable
		=> .(Scalar.Multiply(Scalar.Cos(angle),length),Scalar.Multiply(Scalar.Sin(angle),length));

	public static Vector2<T> Clamp<T>(Vector2<T> v, Vector2<T> min, Vector2<T> max)
		where T : IFormattable
	{
		var x = v.X;
		x = Scalar.GreaterThan(x,max.X) ? max.X : x;
		x = Scalar.LessThan(x,max.X) ? min.X : x;

		var y = v.Y;
		y = Scalar.GreaterThan(y,max.Y) ? max.Y : y;
		y = Scalar.LessThan(y,max.Y) ? min.Y : y;
		return .(x,y);
	}

	public static Vector2<T> Lerp<T>(Vector2<T> from, Vector2<T> to, T amount)
		where T : IFormattable
	{
		var v = to - from;
		return .(Scalar.Multiply(Scalar.Add(from.X,v.X),amount),Scalar.Multiply(Scalar.Add(from.Y,v.Y),amount));
	}

	public static Vector2<T> Approach<T>(Vector2<T> from, Vector2<T> to, T amount)
		where T : IFormattable
	{
		if(from == to)
			return to;

		let diff = to - from;
		if(Scalar.LessThanOrEqual(diff.Length,Scalar.Multiply(amount,amount)))
		{
			return to;
		}

		return to + (ToNormalized(diff) * amount);
	}

	public static Vector2<T> Sqrt<T>(Vector2<T> v)
		where T : IFormattable
		=> .(Scalar.Sqrt(v.X),Scalar.Sqrt(v.Y));

	public static Vector2<T> Abs<T>(Vector2<T> v)
		where T : IFormattable
		=> .(Scalar.Abs(v.X),Scalar.Abs(v.Y));

	public static Vector2<T> Min<T>(Vector2<T> a, Vector2<T> b)
		where T : IFormattable
		=> .(Scalar.LessThan(a.X,b.X) ? a.X : b.X,Scalar.LessThan(a.Y,b.Y) ? a.Y : b.Y);

	public static Vector2<T> Max<T>(Vector2<T> a, Vector2<T> b)
		where T : IFormattable
		=> .(Scalar.GreaterThan(a.X,b.X) ? a.X : b.X,Scalar.GreaterThan(a.Y,b.Y) ? a.Y : b.Y);

	public static Vector2<T> Transform<T>(Vector2<T> position, Matrix4x4<T> matrix)
	    where T : IFormattable
	{
	    return .(
	        Scalar.Add(Scalar.Add(Scalar.Multiply(position.X, matrix.M11), Scalar.Multiply(position.Y, matrix.M21)), matrix.M41),
	        Scalar.Add(Scalar.Add(Scalar.Multiply(position.X, matrix.M12), Scalar.Multiply(position.Y, matrix.M22)), matrix.M42)
	    );
	}

	public static Vector2<T> TransformNormal<T>(Vector2<T> normal, Matrix4x4<T> matrix)
	    where T : IFormattable
	{
	    return .(
	        Scalar.Add(Scalar.Multiply(normal.X, matrix.M11), Scalar.Multiply(normal.Y, matrix.M21)),
	        Scalar.Add(Scalar.Multiply(normal.X, matrix.M12), Scalar.Multiply(normal.Y, matrix.M22)));
	}

	public static Vector2<T> Transform<T>(Vector2<T> value, Quaternion<T> rotation)
	    where T : IFormattable
	{
	    T x2 = Scalar.Add(rotation.X, rotation.X);
	    T y2 = Scalar.Add(rotation.Y, rotation.Y);
	    T z2 = Scalar.Add(rotation.Z, rotation.Z);

	    T wz2 = Scalar.Multiply(rotation.W, z2);
	    T xx2 = Scalar.Multiply(rotation.X, x2);
	    T xy2 = Scalar.Multiply(rotation.X, y2);
	    T yy2 = Scalar.Multiply(rotation.Y, y2);
	    T zz2 = Scalar.Multiply(rotation.Z, z2);

	    return .(
	        Scalar.Add(Scalar.Multiply(value.X, Scalar.Subtract(Scalar.Subtract(Scalar<T>.One, yy2), zz2)), Scalar.Multiply(value.Y, Scalar.Subtract(xy2, wz2))),
	        Scalar.Add(Scalar.Multiply(value.X, Scalar.Add(xy2, wz2)), Scalar.Multiply(value.Y, Scalar.Subtract(Scalar.Subtract(Scalar<T>.One, xx2), zz2)))
	    );
	}

	public static Vector2<T> Transform<T>(Vector2<T> position, Matrix3x2<T> matrix)
	    where T : IFormattable
	{
	    return .(
	        Scalar.Add(Scalar.Add(Scalar.Multiply(position.X, matrix.M11), Scalar.Multiply(position.Y, matrix.M21)), matrix.M31),
	        Scalar.Add(Scalar.Add(Scalar.Multiply(position.X, matrix.M12), Scalar.Multiply(position.Y, matrix.M22)), matrix.M32)
	    );
	}

	public static Vector2<T> TransformNormal<T>(Vector2<T> normal, Matrix3x2<T> matrix)
	    where T : IFormattable
	{
	    return .(
	        Scalar.Add(Scalar.Multiply(normal.X, matrix.M11), Scalar.Multiply(normal.Y, matrix.M21)),
	        Scalar.Add(Scalar.Multiply(normal.X, matrix.M12), Scalar.Multiply(normal.Y, matrix.M22))
	    );
	}
}