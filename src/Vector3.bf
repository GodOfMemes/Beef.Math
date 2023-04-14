using System;
using System.Globalization;
namespace BeefMath;

struct Vector3<T> : IEquatable<Self>, IFormattable, IEquatable
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
	public bool Equals(Object val) => (val is Self) && (Self)val == this;

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

	public static T DistanceTo<T>(Vector3<T> a, Vector3<T> b)
		where T : IFormattable
		=> (a - b).Length;

	public static T DistanceToSquared<T>(Vector3<T> a, Vector3<T> b)
		where T : IFormattable
		=> (a - b).LengthSquared;

	public static Vector3<T> ToNormalized<T>(Vector3<T> v)
		where T : IFormattable
		=> v == .Zero ? .Zero : v / v.Length;

	public static Vector3<T> Clamp<T>(Vector3<T> v, Vector3<T> min, Vector3<T> max)
		where T : IFormattable
	{
		var x = v.X;
		x = Scalar.GreaterThan(x,max.X) ? max.X : x;
		x = Scalar.LessThan(x,max.X) ? min.X : x;

		var y = v.Y;
		y = Scalar.GreaterThan(y,max.Y) ? max.Y : y;
		y = Scalar.LessThan(y,max.Y) ? min.Y : y;

		var z = v.Y;
		z = Scalar.GreaterThan(z,max.Z) ? max.Z : z;
		z = Scalar.LessThan(z,max.Z) ? min.Z : z;
		return .(x,y,z);
	}

	public static Vector3<T> Lerp<T>(Vector3<T> from, Vector3<T> to, T amount)
		where T : IFormattable
	{
		var v = to - from;
		return .(Scalar.Multiply(Scalar.Add(from.X,v.X),amount),Scalar.Multiply(Scalar.Add(from.Y,v.Y),amount),Scalar.Multiply(Scalar.Add(from.Z,v.Z),amount));
	}

	public static Vector3<T> Approach<T>(Vector3<T> from, Vector3<T> to, T amount)
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


	public static Vector3<T> Sqrt<T>(Vector3<T> v)
		where T : IFormattable
		=> .(Scalar.Sqrt(v.X),Scalar.Sqrt(v.Y),Scalar.Sqrt(v.Z));

	public static Vector3<T> Abs<T>(Vector3<T> v)
		where T : IFormattable
		=> .(Scalar.Abs(v.X),Scalar.Abs(v.Y),Scalar.Abs(v.Z));

	public static Vector3<T> Min<T>(Vector3<T> a, Vector3<T> b)
		where T : IFormattable
		=> .(Scalar.LessThan(a.X,b.X) ? a.X : b.X,Scalar.LessThan(a.Y,b.Y) ? a.Y : b.Y,Scalar.LessThan(a.Z,b.Z) ? a.Z : b.Z);

	public static Vector3<T> Max<T>(Vector3<T> a, Vector3<T> b)
		where T : IFormattable
		=> .(Scalar.GreaterThan(a.X,b.X) ? a.X : b.X,Scalar.GreaterThan(a.Y,b.Y) ? a.Y : b.Y,Scalar.GreaterThan(a.Z,b.Z) ? a.Z : b.Z);

	public static Vector3<T> Transform<T>(Vector3<T> position, Matrix4x4<T> matrix) where T : IFormattable
	{
	    return .(
	        Scalar.Add(Scalar.Add(Scalar.Add(Scalar.Multiply(position.X,matrix.M11),Scalar.Multiply(position.Y,matrix.M21)),Scalar.Multiply(position.Z,matrix.M31)),matrix.M41),
	        Scalar.Add(Scalar.Add(Scalar.Add(Scalar.Multiply(position.X,matrix.M12),Scalar.Multiply(position.Y,matrix.M22)),Scalar.Multiply(position.Z,matrix.M32)),matrix.M42),
	        Scalar.Add(Scalar.Add(Scalar.Add(Scalar.Multiply(position.X,matrix.M13),Scalar.Multiply(position.Y,matrix.M23)),Scalar.Multiply(position.Z,matrix.M33)),matrix.M43));
	}

	public static Vector3<T> TransformNormal<T>(Vector3<T> normal, Matrix4x4<T> matrix) where T : IFormattable
	{
	    return .(
			Scalar.Add(Scalar.Add(Scalar.Add(Scalar.Multiply(normal.X,matrix.M11),Scalar.Multiply(normal.Y,matrix.M21)),Scalar.Multiply(normal.Z,matrix.M31)),matrix.M41),
			Scalar.Add(Scalar.Add(Scalar.Add(Scalar.Multiply(normal.X,matrix.M12),Scalar.Multiply(normal.Y,matrix.M22)),Scalar.Multiply(normal.Z,matrix.M32)),matrix.M42),
			Scalar.Add(Scalar.Add(Scalar.Add(Scalar.Multiply(normal.X,matrix.M13),Scalar.Multiply(normal.Y,matrix.M23)),Scalar.Multiply(normal.Z,matrix.M33)),matrix.M43));
	}

	public static Vector3<T> Transform<T>(Vector3<T> value, Quaternion<T> rotation) where T : IFormattable
	{
	    T x2 = Scalar.Add(rotation.X,rotation.X);
	    T y2 = Scalar.Add(rotation.Y,rotation.Y);
	    T z2 = Scalar.Add(rotation.Z,rotation.Z);

	    T wx2 = Scalar.Multiply(rotation.W,x2);
	    T wy2 = Scalar.Multiply(rotation.W,y2);
	    T wz2 = Scalar.Multiply(rotation.W,z2);
	    T xx2 = Scalar.Multiply(rotation.W,x2);
	    T xy2 = Scalar.Multiply(rotation.W,y2);
	    T xz2 = Scalar.Multiply(rotation.W,z2);
	    T yy2 = Scalar.Multiply(rotation.W,x2);
	    T yz2 = Scalar.Multiply(rotation.W,y2);
	    T zz2 = Scalar.Multiply(rotation.W,z2);

	    return .(
		    Scalar.Add(Scalar.Add(Scalar.Multiply(value.X, Scalar.Subtract(Scalar.Subtract(Scalar<T>.One, yy2), zz2)), Scalar.Multiply(value.Y, Scalar.Subtract(xy2, wz2))), Scalar.Multiply(value.Z, Scalar.Add(xz2, wy2))),
		    Scalar.Add(Scalar.Add(Scalar.Multiply(value.X, Scalar.Add(xy2, wz2)), Scalar.Multiply(value.Y, Scalar.Subtract(Scalar.Subtract(Scalar<T>.One, xx2), zz2))), Scalar.Multiply(value.Z, Scalar.Subtract(yz2, wx2))),
		    Scalar.Add(Scalar.Add(Scalar.Multiply(value.X, Scalar.Subtract(xz2, wy2)), Scalar.Multiply(value.Y, Scalar.Add(yz2, wx2))), Scalar.Multiply(value.Z, Scalar.Subtract(Scalar.Subtract(Scalar<T>.One, xx2), yy2)))
			);
	}
}