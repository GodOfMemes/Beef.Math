using System;
using System.Globalization;
namespace BeefMath;

struct Quaternion<T> : IEquatable<Self>, IFormattable, IEquatable
	where T : IFormattable
{
	public T X;
	public T Y;
	public T Z;
	public T W;

	public static Self Identity => .(Scalar<T>.Zero,Scalar<T>.Zero,Scalar<T>.Zero,Scalar<T>.One);

	public T Length =>  Scalar.Sqrt(LengthSquared);
	public T LengthSquared => Quaternion.DotProduct(this,this);

	public this(T x, T y, T z, T w)
	{
	    X = x;
	    Y = y;
	    Z = z;
	    W = w;
	}

	public this(Vector3<T> vectorPart, T scalarPart)
	{
	    X = vectorPart.X;
	    Y = vectorPart.Y;
	    Z = vectorPart.Z;
	    W = scalarPart;
	}

	public static Quaternion<T> operator *(Quaternion<T> value1, Quaternion<T> value2)
	{
	    Quaternion<T> ans;

	    T q1x = value1.X;
	    T q1y = value1.Y;
	    T q1z = value1.Z;
	    T q1w = value1.W;

	    T q2x = value2.X;
	    T q2y = value2.Y;
	    T q2z = value2.Z;
	    T q2w = value2.W;

	    T cx = Scalar.Subtract(Scalar.Multiply(q1y, q2z), Scalar.Multiply(q1z, q2y));
	    T cy = Scalar.Subtract(Scalar.Multiply(q1z, q2x), Scalar.Multiply(q1x, q2z));
	    T cz = Scalar.Subtract(Scalar.Multiply(q1x, q2y), Scalar.Multiply(q1y, q2x));

	    T dot = Scalar.Add(Scalar.Add(Scalar.Multiply(q1x, q2x), Scalar.Multiply(q1y, q2y)),Scalar.Multiply(q1z, q2z));

	    ans.X = Scalar.Add(Scalar.Add(Scalar.Multiply(q1x, q2w), Scalar.Multiply(q2x, q1w)), cx);
	    ans.Y = Scalar.Add(Scalar.Add(Scalar.Multiply(q1y, q2w), Scalar.Multiply(q2y, q1w)), cy);
	    ans.Z = Scalar.Add(Scalar.Add(Scalar.Multiply(q1z, q2w), Scalar.Multiply(q2z, q1w)), cz);
	    ans.W = Scalar.Subtract(Scalar.Multiply(q1w, q2w), dot);

	    return ans;
	}

	public static Quaternion<T> operator +(Quaternion<T> value1, Quaternion<T> value2)
	{
	    Quaternion<T> ans;

	    ans.X = Scalar.Add(value1.X, value2.X);
	    ans.Y = Scalar.Add(value1.Y, value2.Y);
	    ans.Z = Scalar.Add(value1.Z, value2.Z);
	    ans.W = Scalar.Add(value1.W, value2.W);

	    return ans;
	}

	public static Quaternion<T> operator /(Quaternion<T> value1, Quaternion<T> value2)
	{
	    Quaternion<T> ans;

	    T q1x = value1.X;
	    T q1y = value1.Y;
	    T q1z = value1.Z;
	    T q1w = value1.W;

	    T ls = Scalar.Add(Scalar.Add(Scalar.Add(Scalar.Multiply(value2.X, value2.X), Scalar.Multiply(value2.Y, value2.Y)),
	            						Scalar.Multiply(value2.Z, value2.Z)), Scalar.Multiply(value2.W, value2.W));
	    T invNorm = Scalar.Reciprocal(ls);

	    T q2x = Scalar.Negate(Scalar.Multiply(value2.X, invNorm));
	    T q2y = Scalar.Negate(Scalar.Multiply(value2.Y, invNorm));
	    T q2z = Scalar.Negate(Scalar.Multiply(value2.Z, invNorm));
	    T q2w = Scalar.Multiply(value2.W, invNorm);

	    T cx = Scalar.Subtract(Scalar.Multiply(q1y, q2z), Scalar.Multiply(q1z, q2y));
	    T cy = Scalar.Subtract(Scalar.Multiply(q1z, q2x), Scalar.Multiply(q1x, q2z));
	    T cz = Scalar.Subtract(Scalar.Multiply(q1x, q2y), Scalar.Multiply(q1y, q2x));

	    T dot = Scalar.Add(Scalar.Add(Scalar.Multiply(q1x, q2x), Scalar.Multiply(q1y, q2y)),
	        Scalar.Multiply(q1z, q2z));

	    ans.X = Scalar.Add(Scalar.Add(Scalar.Multiply(q1x, q2w), Scalar.Multiply(q2x, q1w)), cx);
	    ans.Y = Scalar.Add(Scalar.Add(Scalar.Multiply(q1y, q2w), Scalar.Multiply(q2y, q1w)), cy);
	    ans.Z = Scalar.Add(Scalar.Add(Scalar.Multiply(q1z, q2w), Scalar.Multiply(q2z, q1w)), cz);
	    ans.W = Scalar.Subtract(Scalar.Multiply(q1w, q2w), dot);

	    return ans;
	}

	[Commutable]
	public static Quaternion<T> operator *(Quaternion<T> value1, T value2)
	{
	    Quaternion<T> ans;

	    ans.X = Scalar.Multiply(value1.X, value2);
	    ans.Y = Scalar.Multiply(value1.Y, value2);
	    ans.Z = Scalar.Multiply(value1.Z, value2);
	    ans.W = Scalar.Multiply(value1.W, value2);

	    return ans;
	}

	public static Quaternion<T> operator -(Quaternion<T> value1, Quaternion<T> value2)
	{
	    Quaternion<T> ans;

	    ans.X = Scalar.Subtract(value1.X, value2.X);
	    ans.Y = Scalar.Subtract(value1.Y, value2.Y);
	    ans.Z = Scalar.Subtract(value1.Z, value2.Z);
	    ans.W = Scalar.Subtract(value1.W, value2.W);

	    return ans;
	}

	public static Quaternion<T> operator -(Quaternion<T> value)
	{
	    Quaternion<T> ans;

	    ans.X = Scalar.Negate(value.X);
	    ans.Y = Scalar.Negate(value.Y);
	    ans.Z = Scalar.Negate(value.Z);
	    ans.W = Scalar.Negate(value.W);

	    return ans;
	}

	public static bool operator ==(Self l, Self r) => Scalar.Equal(l.X,r.X) && Scalar.Equal(l.Y,r.Y) && Scalar.Equal(l.Z,r.Z) && Scalar.Equal(l.W,r.W);
	public static bool operator !=(Self l, Self r) => !(l == r);

	public bool Equals(Self other) => this == other;
	public bool Equals(Object val) => (val is Quaternion<T>) && (Quaternion<T>)val == this;

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
}


public static class Quaternion
{

	public static T DotProduct<T>(Quaternion<T> a, Quaternion<T> b)
		where T : IFormattable
	{
		T v1 = Scalar.Add(Scalar.Multiply(a.X,b.X),Scalar.Multiply(a.Y,b.Y));
		T v2 = Scalar.Add(Scalar.Multiply(a.Z,b.Z),Scalar.Multiply(a.W,b.W));

		return Scalar.Add(v1,v2);
	}

	public static Quaternion<T> ToNormalized<T>(Quaternion<T> quat)
		where T : IFormattable
	{
		 var ls = Scalar.Add(Scalar.Add(Scalar.Multiply(quat.X,quat.X),Scalar.Multiply(quat.Y,quat.Y)),Scalar.Add(Scalar.Multiply(quat.Z,quat.Z),Scalar.Multiply(quat.W,quat.W)));

		T invNorm = Scalar.Divide(Scalar<T>.One,Scalar.Sqrt(ls));

		return .(Scalar.Multiply(quat.X,invNorm),
				 Scalar.Multiply(quat.Y,invNorm),
				 Scalar.Multiply(quat.Z,invNorm),
				 Scalar.Multiply(quat.W,invNorm));
	}

	public static Quaternion<T> Inverse<T>(Quaternion<T> quat)
		where T : IFormattable
	{
		 var ls = Scalar.Add(Scalar.Add(Scalar.Multiply(quat.X,quat.X),Scalar.Multiply(quat.Y,quat.Y)),Scalar.Add(Scalar.Multiply(quat.Z,quat.Z),Scalar.Multiply(quat.W,quat.W)));

		T invNorm = Scalar.Divide(Scalar<T>.One,ls);

		return .(Scalar.Multiply(Scalar.Negate(quat.X),invNorm),
				 Scalar.Multiply(Scalar.Negate(quat.Y),invNorm),
				 Scalar.Multiply(Scalar.Negate(quat.Z),invNorm),
				 Scalar.Multiply(quat.W,invNorm));
	}

	public static Vector3<T> ToEulerAngles<T>(Quaternion<T> quat)
		where T : IFormattable
	{
		let sqx = Scalar.Multiply(quat.X,quat.X);
		let sqy = Scalar.Multiply(quat.Y,quat.Y);
		let sqz = Scalar.Multiply(quat.Z,quat.Z);
		let sqw = Scalar.Multiply(quat.W,quat.W);

		let unit = Scalar.Add(Scalar.Add(sqx,sqy),Scalar.Add(sqz,sqw));
		let test = Scalar.Add(Scalar.Multiply(quat.X,quat.Y),Scalar.Multiply(quat.Z,quat.W));

		if(Scalar.GreaterThan(test,Scalar.Multiply(unit,Scalar.As<double, T>(0.499))))
			return .(Scalar<T>.Zero,Scalar.Multiply(Scalar<T>.Two,Scalar.Atan2(quat.X,quat.W)),Scalar<T>.PiOver2);
		else if(Scalar.LessThanOrEqual(test,Scalar.Multiply(unit,Scalar.As<double, T>(-0.499))))
			return .(Scalar<T>.Zero,Scalar.Negate(Scalar<T>.PiOver2),Scalar.Multiply(Scalar<T>.MinusTwo,Scalar.Atan2(quat.X,quat.W)));

		var xx = Scalar.Multiply(Scalar.Subtract(Scalar.Multiply(Scalar.Multiply(Scalar<T>.Two,quat.X),quat.W),Scalar<T>.Two),Scalar.Multiply(quat.Y,quat.Z));
		var yy = Scalar.Subtract(Scalar.Add(Scalar.Negate(sqx),sqy),Scalar.Add(sqz,sqw));

		var x2 = Scalar.Multiply(Scalar.Subtract(Scalar.Multiply(Scalar.Multiply(Scalar<T>.Two,quat.Y),quat.W),Scalar<T>.Two),Scalar.Multiply(quat.X,quat.Z));
		var y2 = Scalar.Subtract(Scalar.Subtract(sqx,sqy),Scalar.Add(sqz,sqw));

		return .(Scalar.Atan2(xx,yy),
				Scalar.Asin(Scalar.Divide(Scalar.Multiply(Scalar<T>.Two,test),unit)),
				Scalar.Atan2(x2,y2)
				);
	}

	public static Quaternion<T> Conjugate<T>(Quaternion<T> quat)
		where T : IFormattable
		=> .(Scalar.Negate(quat.X),Scalar.Negate(quat.Y),Scalar.Negate(quat.Z),Scalar.Negate(quat.W));

	public static Quaternion<T> CreateFromAxisAngle<T>(Vector3<T> axis, T angle)
		where T : IFormattable
	{
		Quaternion<T> result;

		var halfAngle = Scalar.Multiply(angle,Scalar.As<double,T>(0.5));
		var s = Scalar.Sin(halfAngle);
		var c = Scalar.Cos(halfAngle);

		result.X = (T)Scalar.Multiply(axis.X,s);
		result.Y = (T)Scalar.Multiply(axis.Y,s);
		result.Z = (T)Scalar.Multiply(axis.Z,s);
		result.W = (T)c;

		return result;
	}

	public static Quaternion<T> CreateFromYawPitchRoll<T>(T yaw, T pitch, T roll)
		where T : IFormattable
	{
		T sr, cr, sp, cp, sy, cy;

		T halfRoll = Scalar.Divide(roll, Scalar<T>.Two);
		sr = Scalar.Sin(halfRoll);
		cr = Scalar.Cos(halfRoll);

		T halfPitch = Scalar.Divide(pitch, Scalar<T>.Two);
		sp = Scalar.Sin(halfPitch);
		cp = Scalar.Cos(halfPitch);

		T halfYaw = Scalar.Divide(yaw, Scalar<T>.Two);
		sy = Scalar.Sin(halfYaw);
		cy = Scalar.Cos(halfYaw);

		Quaternion<T> result;

		result.X = Scalar.Add(Scalar.Multiply(Scalar.Multiply(cy, sp), cr), Scalar.Multiply(Scalar.Multiply(sy, cp), sr));
		result.Y = Scalar.Subtract(Scalar.Multiply(Scalar.Multiply(sy, cp), cr), Scalar.Multiply(Scalar.Multiply(cy, sp), sr));
		result.Z = Scalar.Subtract(Scalar.Multiply(Scalar.Multiply(cy, cp), sr), Scalar.Multiply(Scalar.Multiply(sy, sp), cr));
		result.W = Scalar.Add(Scalar.Multiply(Scalar.Multiply(cy, cp), cr), Scalar.Multiply(Scalar.Multiply(sy, sp), sr));

		return result;
	}

	public static Quaternion<T> Slerp<T>(Quaternion<T> a, Quaternion<T> b, T amount)
		where T : IFormattable
	{
		const float epsilon = 1e-6f;
		var t = amount;

		T cosOmega = Scalar.Add(Scalar.Add(Scalar.Add(Scalar.Multiply(a.X, b.X), Scalar.Multiply(a.Y, b.Y)), Scalar.Multiply(a.Z, b.Z)), Scalar.Multiply(a.W, b.W));

		bool flip = false;

		if (!Scalar.GreaterThanOrEqual(cosOmega, Scalar<T>.Zero))
		{
		    flip = true;
		    cosOmega = Scalar.Negate(cosOmega);
		}

		T s1, s2;

		if (Scalar.GreaterThan(cosOmega, Scalar.Subtract(Scalar<T>.One, Scalar.As<float, T>(epsilon))))
		{
		    s1 = Scalar.Subtract(Scalar<T>.One, t);
		    s2 = flip ? Scalar.Negate(t) : t;
		}
		else
		{
		    T omega = Scalar.Acos(cosOmega);
		    T invSinOmega = Scalar.Reciprocal(Scalar.Sin(omega));

		    s1 = Scalar.Multiply(Scalar.Sin(Scalar.Multiply(Scalar.Subtract(Scalar<T>.One, t), omega)), invSinOmega);
		    s2 = (flip) ? Scalar.Negate(Scalar.Multiply(Scalar.Sin(Scalar.Multiply(t, omega)), invSinOmega))
						: Scalar.Multiply(Scalar.Sin(Scalar.Multiply(t, omega)), invSinOmega);
		}

		Quaternion<T> ans;

		ans.X = Scalar.Add(Scalar.Multiply(s1, a.X), Scalar.Multiply(s2, b.X));
		ans.Y = Scalar.Add(Scalar.Multiply(s1, a.Y), Scalar.Multiply(s2, b.Y));
		ans.Z = Scalar.Add(Scalar.Multiply(s1, a.Z), Scalar.Multiply(s2, b.Z));
		ans.W = Scalar.Add(Scalar.Multiply(s1, a.W), Scalar.Multiply(s2, b.W));

		return ans;
	}

	public static Quaternion<T> Lerp<T>(Quaternion<T> quaternion1, Quaternion<T> quaternion2, T amount)
		where T : IFormattable
	{
	    T t = amount;
	    T t1 = Scalar.Subtract(Scalar<T>.One, t);

	    Quaternion<T> r = default;

	    T dot = DotProduct(quaternion1,quaternion2);

	    if (Scalar.GreaterThanOrEqual(dot, Scalar<T>.Zero))
	    {
	        r.X = Scalar.Add(Scalar.Multiply(t1, quaternion1.X), Scalar.Multiply(t, quaternion2.X));
	        r.Y = Scalar.Add(Scalar.Multiply(t1, quaternion1.Y), Scalar.Multiply(t, quaternion2.Y));
	        r.Z = Scalar.Add(Scalar.Multiply(t1, quaternion1.Z), Scalar.Multiply(t, quaternion2.Z));
	        r.W = Scalar.Add(Scalar.Multiply(t1, quaternion1.W), Scalar.Multiply(t, quaternion2.W));
	    }
	    else
	    {
	        r.X = Scalar.Subtract(Scalar.Multiply(t1, quaternion1.X), Scalar.Multiply(t, quaternion2.X));
	        r.Y = Scalar.Subtract(Scalar.Multiply(t1, quaternion1.Y), Scalar.Multiply(t, quaternion2.Y));
	        r.Z = Scalar.Subtract(Scalar.Multiply(t1, quaternion1.Z), Scalar.Multiply(t, quaternion2.Z));
	        r.W = Scalar.Subtract(Scalar.Multiply(t1, quaternion1.W), Scalar.Multiply(t, quaternion2.W));
	    }

	    T ls = Scalar.Add(Scalar.Add(Scalar.Add(Scalar.Multiply(r.X, r.X), Scalar.Multiply(r.Y, r.Y)), Scalar.Multiply(r.Z, r.Z)), Scalar.Multiply(r.W, r.W));
	    T invNorm = Scalar.Reciprocal(Scalar.Sqrt(ls));

	    r.X = Scalar.Multiply(r.X, invNorm);
	    r.Y = Scalar.Multiply(r.Y, invNorm);
	    r.Z = Scalar.Multiply(r.Z, invNorm);
	    r.W = Scalar.Multiply(r.W, invNorm);

	    return r;
	}

	public static Quaternion<T> CreateFromRotationMatrix<T>(Matrix4x4<T> matrix)
		where T : IFormattable
	{
	    T trace = Scalar.Add(Scalar.Add(matrix.M11, matrix.M22), matrix.M33);

	    Quaternion<T> q = default;

	    if (Scalar.GreaterThan(trace, Scalar<T>.Zero))
	    {
	        T s = Scalar.Sqrt(Scalar.Add(trace, Scalar<T>.One));
	        q.W = Scalar.Divide(s, Scalar<T>.Two);
	        s = Scalar.Reciprocal(Scalar.Multiply(Scalar<T>.Two, s));
	        q.X = Scalar.Multiply(Scalar.Subtract(matrix.M23, matrix.M32), s);
	        q.Y = Scalar.Multiply(Scalar.Subtract(matrix.M31, matrix.M13), s);
	        q.Z = Scalar.Multiply(Scalar.Subtract(matrix.M12, matrix.M21), s);
	    }
	    else
	    {
	        if (Scalar.GreaterThanOrEqual(matrix.M11, matrix.M22) && Scalar.GreaterThanOrEqual(matrix.M11, matrix.M33))
	        {
	            T s = Scalar.Sqrt(Scalar.Subtract(Scalar.Subtract(Scalar.Add(Scalar<T>.One, matrix.M11), matrix.M22), matrix.M33));
	            T invS = Scalar.Reciprocal(Scalar.Multiply(Scalar<T>.Two, s));
	            q.X = Scalar.Divide(s, Scalar<T>.Two);
	            q.Y = Scalar.Multiply(Scalar.Add(matrix.M12, matrix.M21), invS);
	            q.Z = Scalar.Multiply(Scalar.Add(matrix.M13, matrix.M31), invS);
	            q.W = Scalar.Multiply(Scalar.Subtract(matrix.M23, matrix.M32), invS);
	        }
	        else if (Scalar.GreaterThan(matrix.M22, matrix.M33))
	        {
	            T s = Scalar.Sqrt(Scalar.Subtract(Scalar.Subtract(Scalar.Add(Scalar<T>.One, matrix.M22), matrix.M11), matrix.M33));
	            T invS = Scalar.Reciprocal(Scalar.Multiply(Scalar<T>.Two, s));
	            q.X = Scalar.Multiply(Scalar.Add(matrix.M21, matrix.M12), invS);
	            q.Y = Scalar.Divide(s, Scalar<T>.Two);
	            q.Z = Scalar.Multiply(Scalar.Add(matrix.M32, matrix.M23), invS);
	            q.W = Scalar.Multiply(Scalar.Subtract(matrix.M31, matrix.M13), invS);
	        }
	        else
	        {
	            T s = Scalar.Sqrt(Scalar.Subtract(Scalar.Subtract(Scalar.Add(Scalar<T>.One, matrix.M33), matrix.M11), matrix.M22));
	            T invS = Scalar.Reciprocal(Scalar.Multiply(Scalar<T>.Two, s));
	            q.X = Scalar.Multiply(Scalar.Add(matrix.M31, matrix.M13), invS);
	            q.Y = Scalar.Multiply(Scalar.Add(matrix.M32, matrix.M23), invS);
	            q.Z = Scalar.Divide(s, Scalar<T>.Two);
	            q.W = Scalar.Multiply(Scalar.Subtract(matrix.M12, matrix.M21), invS);
	        }
	    }

	    return q;
	}

	public static Quaternion<T> Concatenate<T>(Quaternion<T> value1, Quaternion<T> value2)
		where T : IFormattable
	{
	    Quaternion<T> ans;

	    T q1x = value2.X;
	    T q1y = value2.Y;
	    T q1z = value2.Z;
	    T q1w = value2.W;

	    T q2x = value1.X;
	    T q2y = value1.Y;
	    T q2z = value1.Z;
	    T q2w = value1.W;
		
	    T cx = Scalar.Subtract(Scalar.Multiply(q1y, q2z), Scalar.Multiply(q1z, q2y));
	    T cy = Scalar.Subtract(Scalar.Multiply(q1z, q2x), Scalar.Multiply(q1x, q2z));
	    T cz = Scalar.Subtract(Scalar.Multiply(q1x, q2y), Scalar.Multiply(q1y, q2x));

	    T dot = Scalar.Add(Scalar.Add(Scalar.Multiply(q1x, q2x), Scalar.Multiply(q1y, q2y)),
	        Scalar.Multiply(q1z, q2z));

	    ans.X = Scalar.Add(Scalar.Add(Scalar.Multiply(q1x, q2w), Scalar.Multiply(q2x, q1w)), cx);
	    ans.Y = Scalar.Add(Scalar.Add(Scalar.Multiply(q1y, q2w), Scalar.Multiply(q2y, q1w)), cy);
	    ans.Z = Scalar.Add(Scalar.Add(Scalar.Multiply(q1z, q2w), Scalar.Multiply(q2z, q1w)), cz);
	    ans.W = Scalar.Subtract(Scalar.Multiply(q1w, q2w), dot);

	    return ans;
	}
}