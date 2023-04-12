using System;
using System.Globalization;
namespace BeefMath;

struct Quaternion<T> : IEquatable<Self>, IFormattable
	where T : IFormattable
{
	public T X;
	public T Y;
	public T Z;
	public T W;


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
}


public static class Quaternion
{
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
}