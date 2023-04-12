using System;
using System.Globalization;
namespace BeefMath;

struct Matrix4x4<T> : IEquatable<Self>/*, IFormattable*/
	where T : IFormattable
{
	public static Self Identity = .
	(
	    Scalar<T>.One, Scalar<T>.Zero, Scalar<T>.Zero, Scalar<T>.Zero,
	    Scalar<T>.Zero, Scalar<T>.One, Scalar<T>.Zero, Scalar<T>.Zero,
	    Scalar<T>.Zero, Scalar<T>.Zero, Scalar<T>.One, Scalar<T>.Zero,
	    Scalar<T>.Zero, Scalar<T>.Zero, Scalar<T>.Zero, Scalar<T>.One
	);


	public this(Vector4<T> row1, Vector4<T> row2, Vector4<T> row3, Vector4<T> row4) => (Row1,Row2,Row3,Row4) = (row1,row2,row3,row4);
	public this(T m11, T m12, T m13, T m14,
				T m21, T m22, T m23, T m24,
				T m31, T m32, T m33, T m34,
				T m41, T m42, T m43, T m44)
	{
	    Row1 = .(m11, m12, m13, m14);
	    Row2 = .(m21, m22, m23, m24);
	    Row3 = .(m31, m32, m33, m34);
	    Row4 = .(m41, m42, m43, m44);
	}

	public Vector4<T> Row1;
	public Vector4<T> Row2;
	public Vector4<T> Row3;
	public Vector4<T> Row4;

	public Vector4<T> Column1 => .(Row1.X, Row2.X, Row3.X, Row4.X);
	public Vector4<T> Column2 => .(Row1.Y, Row2.Y, Row3.Y, Row4.Y);
	public Vector4<T> Column3 => .(Row1.Z, Row2.Z, Row3.Z, Row4.Z);
	public Vector4<T> Column4 => .(Row1.W, Row2.W, Row3.W, Row4.W);

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

	public T M13
	{
	    get => Row1.Z;
	    set mut => Row1.Z = value;
	}

	public T M14
	{
	    get => Row1.W;
	    set mut => Row1.W = value;
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

	public T M23
	{
	    get => Row2.Z;
	    set mut => Row2.Z = value;
	}

	public T M24
	{
	    get => Row2.W;
	    set mut => Row2.W = value;
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

	public T M33
	{
	    get => Row3.Z;
	    set mut => Row3.Z = value;
	}

	public T M34
	{
	    get => Row3.W;
	    set mut => Row3.W = value;
	}

	public T M41
	{
	    get => Row4.X;
	    set mut => Row4.X = value;
	}
	
	public T M42
	{
	    get => Row4.Y;
	    set mut => Row4.Y = value;
	}


	public T M43
	{
	   	get => Row4.Z;
	    set mut => Row4.Z = value;
	}

	public T M44
	{
	   get => Row4.W;
	    set mut => Row4.W = value;
	}


	public static Self operator +(Self a, Self b) => .( a.Row1 + b.Row1, a.Row2 + b.Row2, a.Row3 + b.Row3, a.Row4 + b.Row4);


	public static Self operator -(Self a, Self b) => .(a.Row1 - b.Row1, a.Row2 - b.Row2, a.Row3 - b.Row3, a.Row4 - b.Row4);

	public static Self operator -(Self value) => .(-value.Row1, -value.Row2, -value.Row3, -value.Row4);


	public static Self operator *(Self a, Self b)
	{
	    return .(
	            a.M11 * b.Row1 + a.M12 * b.Row2 + a.M13 * b.Row3 + a.M14 * b.Row4,
	            a.M21 * b.Row1 + a.M22 * b.Row2 + a.M23 * b.Row3 + a.M24 * b.Row4,
	            a.M31 * b.Row1 + a.M32 * b.Row2 + a.M33 * b.Row3 + a.M34 * b.Row4,
	            a.M41 * b.Row1 + a.M42 * b.Row2 + a.M43 * b.Row3 + a.M44 * b.Row4
	        );
	}

	[Commutable]
	public static Vector4<T> operator *(Vector4<T> a, Self b)
	{
	    return a.X * b.Row1 + a.Y * b.Row2 + a.Z * b.Row3 +
	           a.W * b.Row4;
	}

	public static bool operator ==(Self a, Self b)
	{
	    return Scalar.Equal(a.M11, b.M11) && Scalar.Equal(a.M22, b.M22) &&
	           Scalar.Equal(a.M33, b.M33) &&
	           Scalar.Equal(a.M44, b.M44) && 
	           Scalar.Equal(a.M12, b.M12) && Scalar.Equal(a.M13, b.M13) &&
	           Scalar.Equal(a.M14, b.M14) && Scalar.Equal(a.M21, b.M21) &&
	           Scalar.Equal(a.M23, b.M23) && Scalar.Equal(a.M24, b.M24) &&
	           Scalar.Equal(a.M31, b.M31) && Scalar.Equal(a.M32, b.M32) &&
	           Scalar.Equal(a.M34, b.M34) && Scalar.Equal(a.M41, b.M41) &&
	           Scalar.Equal(a.M42, b.M42) && Scalar.Equal(a.M43, b.M43);
	}

	public static bool operator !=(Self a, Self b) => !(a == b);

	public bool Equals(Self other) => this == other;

	public T GetDeterminant()
	{
		T a = M11, b = M12, c = M13, d = M14;
		T e = M21, f = M22, g = M23, h = M24;
		T i = M31, j = M32, k = M33, l = M34;
		T m = M41, n = M42, o = M43, p = M44;


		T kp_lo = Scalar.Subtract(Scalar.Multiply(k, p), Scalar.Multiply(l, o));
		T jp_ln = Scalar.Subtract(Scalar.Multiply(j, p), Scalar.Multiply(l, n));
		T jo_kn = Scalar.Subtract(Scalar.Multiply(j, o), Scalar.Multiply(k, n));
		T ip_lm = Scalar.Subtract(Scalar.Multiply(i, p), Scalar.Multiply(l, m));
		T io_km = Scalar.Subtract(Scalar.Multiply(i, o), Scalar.Multiply(k, m));
		T in_jm = Scalar.Subtract(Scalar.Multiply(i, n), Scalar.Multiply(j, m));


		return Scalar.Add(
			Scalar.Subtract(
			    Scalar.Multiply(a,
			        Scalar.Add(
			            Scalar.Subtract(Scalar.Multiply(f, kp_lo), Scalar.Multiply(g, jp_ln)),
			            Scalar.Multiply(h, jo_kn))),
			    Scalar.Multiply(b,
			        Scalar.Add(
			            Scalar.Subtract(Scalar.Multiply(e, kp_lo), Scalar.Multiply(g, ip_lm)),
			            Scalar.Multiply(h, io_km)))),
			Scalar.Subtract(
			    Scalar.Multiply(c,
			        Scalar.Add(
			            Scalar.Subtract(Scalar.Multiply(e, jp_ln), Scalar.Multiply(f, ip_lm)),
			            Scalar.Multiply(h, in_jm))),
			    Scalar.Multiply(d,
			        Scalar.Add(
			            Scalar.Subtract(Scalar.Multiply(e, jo_kn), Scalar.Multiply(f, io_km)),
			            Scalar.Multiply(g, in_jm)))));
	}


	public override void ToString(String strBuffer)
	{
		strBuffer.AppendF(CultureInfo.CurrentCulture,"{{ {{M11:{0} M12:{1} M13:{2} M14:{3}}} {{M21:{4} M22:{5} M23:{6} M24:{7}}} {{M31:{8} M32:{9} M33:{10} M34:{11}}} {{M41:{12} M42:{13} M43:{14} M44:{15}}} }}",
	                         M11, M12, M13, M14,
	                         M21, M22, M23, M24,
	                         M31, M32, M33, M34,
	                         M41, M42, M43, M44);
	}
}

public static class Matrix4x4
{
	public static Matrix4x4<T> CreateLookAt<T>(Vector3<T> position, Vector3<T> target, Vector3<T> up)
		where T : IFormattable
	{
	    Vector3<T> zaxis = Vector3.Normalize(position - target);
	    Vector3<T> xaxis = Vector3.Normalize(Vector3.Cross(up, zaxis));
	    Vector3<T> yaxis = Vector3.Cross(zaxis,xaxis);

	    Matrix4x4<T> result = .Identity;

	    result.M11 = xaxis.X;
	    result.M12 = yaxis.X;
	    result.M13 = zaxis.X;

	    result.M21 = xaxis.Y;
	    result.M22 = yaxis.Y;
	    result.M23 = zaxis.Y;

	    result.M31 = xaxis.Z;
	    result.M32 = yaxis.Z;
	    result.M33 = zaxis.Z;

	    result.M41 = Scalar.Negate(xaxis.Dot(position));
	    result.M42 = Scalar.Negate(yaxis.Dot(position));
	    result.M43 = Scalar.Negate(zaxis.Dot(position));

	    return result;
	}

	public static Matrix4x4<T> CreateOrthographic<T>(T width, T height, T zNearPlane, T zFarPlane)
		where T : IFormattable
	{
	    Matrix4x4<T> result = .Identity;

	    result.M11 = Scalar.Divide(Scalar<T>.Two, width);
	    result.M22 = Scalar.Divide(Scalar<T>.Two, height);
	    result.M33 = Scalar.Reciprocal(Scalar.Subtract(zNearPlane, zFarPlane));
	    result.M43 = Scalar.Divide(zNearPlane, Scalar.Subtract(zNearPlane, zFarPlane));

	    return result;
	}

	public static Matrix4x4<T> CreateOrthographicOffCenter<T>(T left, T right, T bottom, T top, T zNearPlane, T zFarPlane)
	    where T : IFormattable
	{
	    Matrix4x4<T> result = .Identity;

	    result.M11 = Scalar.Divide(Scalar<T>.Two, Scalar.Subtract(right, left));

	    result.M22 = Scalar.Divide(Scalar<T>.Two, Scalar.Subtract(top, bottom));

	    result.M33 = Scalar.Reciprocal(Scalar.Subtract(zNearPlane, zFarPlane));

	    result.M41 = Scalar.Divide(Scalar.Add(left, right), Scalar.Subtract(left, right));
	    result.M42 = Scalar.Divide(Scalar.Add(top, bottom), Scalar.Subtract(bottom, top));
	    result.M43 = Scalar.Divide(zNearPlane, Scalar.Subtract(zNearPlane, zFarPlane));

	    return result;
	}

	public static Result<Matrix4x4<T>> CreatePerspective<T>(T width, T height, T nearPlaneDistance, T farPlaneDistance)
	    where T : IFormattable
	{
	    if (!Scalar.GreaterThan(nearPlaneDistance, Scalar<T>.Zero))
	        return .Err(default);

	    if (!Scalar.GreaterThan(farPlaneDistance, Scalar<T>.Zero))
	        return .Err(default);

	    Matrix4x4<T> result = default;

	    result.M11 = Scalar.Divide(Scalar.Multiply(Scalar<T>.Two, nearPlaneDistance), width);
	    result.M12 = result.M13 = result.M14 = Scalar<T>.Zero;

	    result.M22 = Scalar.Divide(Scalar.Multiply(Scalar<T>.Two, nearPlaneDistance), height);
	    result.M21 = result.M23 = result.M24 = Scalar<T>.Zero;

	    T negFarRange = Scalar.IsPositiveInfinity(farPlaneDistance)
	        ? Scalar<T>.MinusOne
	        : Scalar.Divide(farPlaneDistance, Scalar.Subtract(nearPlaneDistance, farPlaneDistance));
	    result.M33 = negFarRange;
	    result.M31 = result.M32 = Scalar<T>.Zero;
	    result.M34 = Scalar<T>.MinusOne;

	    result.M41 = result.M42 = result.M44 = Scalar<T>.Zero;
	    result.M43 = Scalar.Multiply(nearPlaneDistance, negFarRange);

	    return .Ok(default);
	}

	public static Result<Matrix4x4<T>> CreatePerspectiveFieldOfView<T>(T fieldOfView, T aspectRatio, T nearPlaneDistance, T farPlaneDistance)
	   where T : IFormattable
	{
	    if (!Scalar.GreaterThan(fieldOfView, Scalar<T>.Zero) || Scalar.GreaterThanOrEqual(fieldOfView, Scalar<T>.Pi))
	        return .Err(default);

	    if (!Scalar.GreaterThan(nearPlaneDistance, Scalar<T>.Zero))
	        return .Err(default);

	    if (!Scalar.GreaterThan(farPlaneDistance, Scalar<T>.Zero))
	        return .Err(default);

	    T yScale = Scalar.Reciprocal(Scalar.Tan(Scalar.Divide(fieldOfView, Scalar<T>.Two)));
	    T xScale = Scalar.Divide(yScale, aspectRatio);

	    Matrix4x4<T> result = default;

	    result.M11 = xScale;
	    result.M12 = result.M13 = result.M14 = Scalar<T>.Zero;

	    result.M22 = yScale;
	    result.M21 = result.M23 = result.M24 = Scalar<T>.Zero;

	    result.M31 = result.M32 = Scalar<T>.Zero;
	    T negFarRange = Scalar.IsPositiveInfinity(farPlaneDistance) ? Scalar<T>.MinusOne : Scalar.Divide(farPlaneDistance, Scalar.Subtract(nearPlaneDistance, farPlaneDistance));
	    result.M33 = negFarRange;
	    result.M34 = Scalar<T>.MinusOne;

	    result.M41 = result.M42 = result.M44 = Scalar<T>.Zero;
	    result.M43 = Scalar.Multiply(nearPlaneDistance, negFarRange);

	    return .Ok(default);
	}

	public static Result<Matrix4x4<T>> CreatePerspectiveOffCenter<T>(T left, T right, T bottom, T top, T nearPlaneDistance, T farPlaneDistance)
	    where T : IFormattable
	{
	    if (!Scalar.GreaterThan(nearPlaneDistance, Scalar<T>.Zero))
	         return .Err(default);

	    if (!Scalar.GreaterThan(farPlaneDistance, Scalar<T>.Zero))
	         return .Err(default);

	    Matrix4x4<T> result = default;

	    result.M11 = Scalar.Divide(Scalar.Multiply(Scalar<T>.Two, nearPlaneDistance), Scalar.Subtract(right, left));
	    result.M12 = result.M13 = result.M14 = Scalar<T>.Zero;

	    result.M22 = Scalar.Divide(Scalar.Multiply(Scalar<T>.Two, nearPlaneDistance), Scalar.Subtract(top, bottom));
	    result.M21 = result.M23 = result.M24 = Scalar<T>.Zero;

	    result.M31 = Scalar.Divide(Scalar.Add(left, right), Scalar.Subtract(right, left));
	    result.M32 = Scalar.Divide(Scalar.Add(top, bottom), Scalar.Subtract(top, bottom));
	    T negFarRange = Scalar.IsPositiveInfinity(farPlaneDistance) ? Scalar<T>.MinusOne : Scalar.Divide(farPlaneDistance, Scalar.Subtract(nearPlaneDistance, farPlaneDistance));
	    result.M33 = negFarRange;
	    result.M34 = Scalar<T>.MinusOne;

	    result.M43 = Scalar.Multiply(nearPlaneDistance, negFarRange);
	    result.M41 = result.M42 = result.M44 = Scalar<T>.Zero;

	    return result;
	}

	public static Matrix4x4<T> CreateFromYawPitchRoll<T>(T yaw, T pitch, T roll)
		where T : IFormattable
	{
	   	Quaternion<T> q = Quaternion.CreateFromYawPitchRoll(yaw, pitch, roll);
	    return CreateFromQuaternion(q);
	}

	public static Matrix4x4<T> CreateFromQuaternion<T>(Quaternion<T> quaternion)
		where T : IFormattable
	{
	    Matrix4x4<T> result = .Identity;

	    T xx = Scalar.Multiply(quaternion.X, quaternion.X);
	    T yy = Scalar.Multiply(quaternion.Y, quaternion.Y);
	    T zz = Scalar.Multiply(quaternion.Z, quaternion.Z);

	    T xy = Scalar.Multiply(quaternion.X, quaternion.Y);
	    T wz = Scalar.Multiply(quaternion.Z, quaternion.W);
	    T xz = Scalar.Multiply(quaternion.Z, quaternion.X);
	    T wy = Scalar.Multiply(quaternion.Y, quaternion.W);
	    T yz = Scalar.Multiply(quaternion.Y, quaternion.Z);
	    T wx = Scalar.Multiply(quaternion.X, quaternion.W);

	    result.M11 = Scalar.Subtract(Scalar<T>.One, Scalar.Multiply(Scalar<T>.Two, Scalar.Add(yy, zz)));
	    result.M12 = Scalar.Multiply(Scalar<T>.Two, Scalar.Add(xy, wz));
	    result.M13 = Scalar.Multiply(Scalar<T>.Two, Scalar.Subtract(xz, wy));

	    result.M21 = Scalar.Multiply(Scalar<T>.Two, Scalar.Subtract(xy, wz));
	    result.M22 = Scalar.Subtract(Scalar<T>.One, Scalar.Multiply(Scalar<T>.Two, Scalar.Add(zz, xx)));
	    result.M23 = Scalar.Multiply(Scalar<T>.Two, Scalar.Add(yz, wx));

	    result.M31 = Scalar.Multiply(Scalar<T>.Two, Scalar.Add(xz, wy));
	    result.M32 = Scalar.Multiply(Scalar<T>.Two, Scalar.Subtract(yz, wx));
	    result.M33 = Scalar.Subtract(Scalar<T>.One, Scalar.Multiply(Scalar<T>.Two, Scalar.Add(yy, xx)));

	    return result;
	}

	public static Matrix4x4<T> CreateTranslation<T>(Vector3<T> position)
	    where T : IFormattable
	{
	    Matrix4x4<T> result = .Identity;
	    result.M41 = position.X;
	    result.M42 = position.Y;
	    result.M43 = position.Z;
	    return result;
	}

	public static Matrix4x4<T> CreateTranslation<T>(T x,T y, T z)
	    where T : IFormattable
	{
	    Matrix4x4<T> result = .Identity;
	    result.M41 = x;
	    result.M42 = y;
	    result.M43 = z;
	    return result;
	}

	public static Matrix4x4<T> CreateScale<T>(Vector3<T> scale)
	    where T : IFormattable
	{
	    Matrix4x4<T> result = .Identity;
	    result.M11 = scale.X;
	    result.M22 = scale.Y;
	    result.M33 = scale.Z;
	    return result;
	}

	public static Matrix4x4<T> CreateScale<T>(T x,T y, T z)
	    where T : IFormattable
	{
	    Matrix4x4<T> result = .Identity;
	    result.M11 = x;
	    result.M22 = y;
	    result.M33 = z;
	    return result;
	}
}