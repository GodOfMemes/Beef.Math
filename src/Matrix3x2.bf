using System;
using System.Globalization;
namespace BeefMath;

struct Matrix3x2<T> : IEquatable<Self>/*, IFormattable*/
	where T : IFormattable
{
	public static Self Identity = .
	(
	    Scalar<T>.One, Scalar<T>.Zero,
		Scalar<T>.Zero, Scalar<T>.One,
		Scalar<T>.Zero, Scalar<T>.Zero
	);


	public this(Vector2<T> row1, Vector2<T> row2, Vector2<T> row3) => (Row1,Row2,Row3) = (row1,row2,row3);
	public this(T m11, T m12,
				T m21, T m22,
				T m31, T m32)
	{
	    Row1 = .(m11, m12);
	    Row2 = .(m21, m22);
	    Row3 = .(m31, m32);
	}

	public Vector2<T> Row1;
	public Vector2<T> Row2;
	public Vector2<T> Row3;

	public Vector3<T> Column1 => .(Row1.X, Row2.X, Row3.X);
	public Vector3<T> Column2 => .(Row1.Y, Row2.Y, Row3.Y);

	public T M11
	{
	    get => Row1.X;
	    set mut => Row1.X = value;
	}

	public T M12
	{
	    get => Row1.Y;
	    set mut => Row1.Y = value;
	}

	public T M21
	{
	    get => Row2.X;
	    set mut => Row2.X = value;
	}

	public T M22
	{
	    get => Row2.Y;
	    set mut => Row2.Y = value;
	}

	public T M31
	{
	    get => Row3.X;
	    set mut => Row3.X = value;
	}

	public T M32
	{
	    get => Row3.Y;
	    set mut => Row3.Y = value;
	}


	public static Self operator +(Self a, Self b) => .(a.Row1 + b.Row1, a.Row2 + b.Row2, a.Row3 + b.Row3);


	public static Self operator -(Self a, Self b) => .(a.Row1 - b.Row1, a.Row2 - b.Row2, a.Row3 - b.Row3);

	public static Self operator -(Self value) => .(-value.Row1, -value.Row2, -value.Row3);


	public static Self operator *(Self a, Self b)
	{
	    return .(
	            a.M11 * b.Row1 + a.M12 * b.Row2,
	            a.M21 * b.Row1 + a.M22 * b.Row2,
	            a.M31 * b.Row1 + a.M32 * b.Row2
	        );
	}

	[Commutable]
	public static Vector2<T> operator *(Vector3<T> a, Self b)
	{
	    return a.X * b.Row1 + a.Y * b.Row2 + a.Z * b.Row3;
	}

	public static bool operator ==(Self a, Self b)
	{
	    return 	(Scalar.Equal(a.M11, b.M11)
                 && Scalar.Equal(a.M22, b.M22)
                 && Scalar.Equal(a.M12, b.M12)
                 && Scalar.Equal(a.M21, b.M21)
                 && Scalar.Equal(a.M31, b.M31)
                 && Scalar.Equal(a.M32, b.M32));
	}

	public static bool operator !=(Self a, Self b) => !(a == b);

	public bool Equals(Self other) => this == other;

	public T GetDeterminant()
	{
		return Scalar.Subtract(Scalar.Multiply(M11, M22), Scalar.Multiply(M21, M12));
	}


	public override void ToString(String strBuffer)
	{
		strBuffer.AppendF(CultureInfo.CurrentCulture,"{{ {{M11:{0} M12:{1}}} {{M21:{2} M22:{3}}} {{M31:{4} M32:{5}}} }}",
                                 M11, M12,
                                 M21, M22,
                                 M31, M32);
	}
}

public static class Matrix3x2
{
	public static Matrix3x2<T> CreateTranslation<T>(Vector2<T> position)
	    where T : IFormattable
	{
	    Matrix3x2<T> result = .Identity;
	    result.M31 = position.X;
		result.M32 = position.Y;
	    return result;
	}

	public static Matrix3x2<T> CreateTranslation<T>(T x,T y)
	    where T : IFormattable
	{
	    Matrix3x2<T> result = .Identity;
	   	result.M31 = x;
		result.M32 = y;
	    return result;
	}

	public static Matrix3x2<T> CreateScale<T>(Vector2<T> scale)
	    where T : IFormattable
	{
	    Matrix3x2<T> result = .Identity;
	    result.M11 = scale.X;
		result.M22 = scale.Y;
	    return result;
	}

	public static Matrix3x2<T> CreateScale<T>(T x,T y)
	    where T : IFormattable
	{
	    Matrix3x2<T> result = .Identity;
	    result.M11 = x;
		result.M22 = y;
	    return result;
	}

	public static Matrix3x2<T> CreateRotation<T>(T radians)
	    where T : IFormattable
	{
		let RotationEpsilon = 0.001f * ((float) Math.PI_d) / 180f;

 		var radians;
	    radians = Scalar.IEEERemainder(radians, Scalar<T>.Tau);

	    T c, s;

	    if (Scalar.GreaterThan(radians, Scalar.As<float, T>(-RotationEpsilon)) && !Scalar.GreaterThanOrEqual(radians, Scalar.As<float, T>(RotationEpsilon)))
	    {
	        // Exact case for zero rotation.
	        c = Scalar<T>.One;
	        s = Scalar<T>.Zero;
	    }
	    else if (Scalar.GreaterThan(radians, Scalar.As<float, T>((Math.PI_f) / 2 - RotationEpsilon)) && !Scalar.GreaterThanOrEqual(radians, Scalar.As<float, T>((Math.PI_f) / 2 + RotationEpsilon)))
	    {
	        // Exact case for 90 degree rotation.
	        c = Scalar<T>.Zero;
	        s = Scalar<T>.One;
	    }
	    else if (!Scalar.GreaterThanOrEqual(radians, Scalar.As<float, T>(-(Math.PI_f) + RotationEpsilon)) || Scalar.GreaterThan(radians, Scalar.As<float, T>((Math.PI_f) - RotationEpsilon)))
	    {
	        // Exact case for 180 degree rotation.
	        c = Scalar<T>.MinusOne;
	        s = Scalar<T>.Zero;
	    }
	    else if (Scalar.GreaterThan(radians, Scalar.As<float, T>(-(Math.PI_f) / 2 - RotationEpsilon)) && !Scalar.GreaterThanOrEqual(radians, Scalar.As<float, T>(-(Math.PI_f) / 2 + RotationEpsilon)))
	    {
	        // Exact case for 270 degree rotation.
	        c = Scalar<T>.Zero;
	        s = Scalar<T>.MinusOne;
	    }
	    else
	    {
	        c = Scalar.Cos(radians);
	        s = Scalar.Sin(radians);
	    }

	    Matrix3x2<T> result = Matrix3x2<T>.Identity;

	    result.M11 = c;
	    result.M12 = s;
	    result.M21 = Scalar.Negate(s);
	    result.M22 = c;

	    return result;
	}

	public static Matrix3x2<T> CreateTransform<T>(Vector2<T> translation,T radians, Vector2<T> scale)
		where T : IFormattable
		=> .Identity * CreateTranslation(translation) * CreateRotation(radians) * CreateScale(scale);
}