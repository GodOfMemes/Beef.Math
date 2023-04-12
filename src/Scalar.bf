using System;
namespace BeefMath;

class Scalar<T>
{
	public static readonly T Epsilion;
	public static readonly T MinValue;
	public static readonly T MaxValue;

	public static readonly T PositiveInfinity;
	public static readonly T NegativeInfinity;
	public static readonly T NaN;

	public static readonly T Zero = default;
	public static readonly T One;
	public static readonly T Two;
	public static readonly T MinusOne;
	public static readonly T MinusTwo;

	public static readonly T Pi;
	public static readonly T PiOver2;

	static this()
	{
		if(typeof(T) == typeof(float))
		{
			MinusOne = (.)(Object)(-1f);
			MinusTwo = (.)(Object)(-2f);
			One = (.)(Object)1f;
			Two = (.)(Object)2f;
			Epsilion = (.)(Object)float.Epsilon;
			MaxValue = (.)(Object)float.MaxValue;
			MinValue = (.)(Object)float.MinValue;
			PositiveInfinity = (.)(Object)float.PositiveInfinity;
			NegativeInfinity = (.)(Object)float.NegativeInfinity;
			NaN = (.)(Object)float.NaN;

			Pi = (.)(Object)Math.PI_f;
			PiOver2 = (.)(Object)(Math.PI_f / 2);
		}
		else if(typeof(T) == typeof(double))
		{
			MinusOne = (.)(Object)(-1d);
			MinusTwo = (.)(Object)(-2d);
			One = (.)(Object)1d;
			Two = (.)(Object)2d;
			Epsilion = (.)(Object)double.Epsilon;
			MaxValue = (.)(Object)double.MaxValue;
			MinValue = (.)(Object)double.MinValue;
			PositiveInfinity = (.)(Object)double.PositiveInfinity;
			NegativeInfinity = (.)(Object)double.NegativeInfinity;
			NaN = (.)(Object)double.NaN;

			Pi = (.)(Object)Math.PI_d;
			PiOver2 = (.)(Object)(Math.PI_d / 2);
		}
		else if(typeof(T) == typeof(int))
		{
			MinusOne = (.)(Object)(-1);
			MinusTwo = (.)(Object)(-2);
			One = (.)(Object)1;
			Two = (.)(Object)2;
			Epsilion = default;
			MaxValue = (.)(Object)int.MaxValue;
			MinValue = (.)(Object)int.MinValue;
			PositiveInfinity = default;
			NegativeInfinity = default;
			NaN = default;

			Pi = (.)(Object)(int)Math.PI_f;
			PiOver2 = (.)(Object)(int)(Math.PI_f / 2);
		}
		else if(typeof(T) == typeof(uint))
		{
			MinusOne = default;
			MinusTwo = default;
			One = (.)(Object)1u;
			Two = (.)(Object)2u;
			Epsilion = default;
			MaxValue = (.)(Object)uint.MaxValue;
			MinValue = (.)(Object)uint.MinValue;
			PositiveInfinity = default;
			NegativeInfinity = default;
			NaN = default;

			Pi = (.)(Object)(uint)Math.PI_f;
			PiOver2 = (.)(Object)(uint)(Math.PI_f / 2);
		}
	}
}

public static class Scalar
{
	public static T Sqrt<T>(T x)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)Math.Sqrt((float)(Object)x);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)Math.Sqrt((double)(Object)x);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)Math.Sqrt((int)(Object)x);
		}
		else if(typeof(T) == typeof(uint))
		{
			return (.)(Object)Math.Sqrt((uint)(Object)x);
		}

		return default;
	}

	public static T Abs<T>(T x)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)Math.Abs((float)(Object)x);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)Math.Abs((double)(Object)x);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)Math.Abs((int)(Object)x);
		}
		else if(typeof(T) == typeof(uint))
		{
			return x;
		}

		return default;
	}

	public static T Add<T>(T a, T b)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)((float)(Object)a + (float)(Object)b);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)((double)(Object)a + (double)(Object)b);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)((int)(Object)a + (int)(Object)b);
		}
		else if(typeof(T) == typeof(uint))
		{
			return (.)(Object)((uint)(Object)a + (uint)(Object)b);
		}

		return default;
	}

	public static T Subtract<T>(T a, T b)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)((float)(Object)a - (float)(Object)b);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)((double)(Object)a - (double)(Object)b);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)((int)(Object)a - (int)(Object)b);
		}
		else if(typeof(T) == typeof(uint))
		{
			return (.)(Object)((uint)(Object)a - (uint)(Object)b);
		}

		return default;
	}

	public static T Multiply<T>(T a, T b)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)((float)(Object)a * (float)(Object)b);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)((double)(Object)a * (double)(Object)b);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)((int)(Object)a * (int)(Object)b);
		}
		else if(typeof(T) == typeof(uint))
		{
			return (.)(Object)((uint)(Object)a * (uint)(Object)b);
		}

		return default;
	}

	public static T Divide<T>(T a, T b)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)((float)(Object)a / (float)(Object)b);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)((double)(Object)a / (double)(Object)b);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)((int)(Object)a / (int)(Object)b);
		}
		else if(typeof(T) == typeof(uint))
		{
			return (.)(Object)((uint)(Object)a / (uint)(Object)b);
		}

		return default;
	}

	public static bool Equal<T>(T a, T b)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)((float)(Object)a == (float)(Object)b);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)((double)(Object)a == (double)(Object)b);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)((int)(Object)a == (int)(Object)b);
		}
		else if(typeof(T) == typeof(uint))
		{
			return (.)(Object)((uint)(Object)a == (uint)(Object)b);
		}

		return false;
	}

	
	public static bool LessThan<T>(T a, T b)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)((float)(Object)a < (float)(Object)b);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)((double)(Object)a > (double)(Object)b);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)((int)(Object)a < (int)(Object)b);
		}
		else if(typeof(T) == typeof(uint))
		{
			return (.)(Object)((uint)(Object)a < (uint)(Object)b);
		}

		return default;
	}

	public static bool GreaterThan<T>(T a, T b)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)((float)(Object)a > (float)(Object)b);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)((double)(Object)a > (double)(Object)b);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)((int)(Object)a > (int)(Object)b);
		}
		else if(typeof(T) == typeof(uint))
		{
			return (.)(Object)((uint)(Object)a > (uint)(Object)b);
		}

		return default;
	}

	public static bool LessThanOrEqual<T>(T a, T b)
	{
		return LessThan(a,b) || Equal(a,b);
	}

	public static bool GreaterThanOrEqual<T>(T a, T b)
	{
		return GreaterThan(a,b) || Equal(a,b);
	}

	public static T Negate<T>(T value)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)(-(float)(Object)value);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)(-(double)(Object)value);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)(-(int)(Object)value);
		}

		return default;
	}

	public static T Reciprocal<T>(T v)
	{
		if(Equal(v,Scalar<T>.Zero)) return default;
		return Multiply(Scalar<T>.One,v);
	}

	public static bool IsPositiveInfinity<T>(T v)
	{
		if(typeof(T) == typeof(float) || typeof(T) == typeof(double))
		{
			return Scalar.Equal(Scalar<T>.PositiveInfinity,v);
		}

		return false;
	}

	public static bool IsNegitveInfinity<T>(T v)
	{
		if(typeof(T) == typeof(float) || typeof(T) == typeof(double))
		{
			return Scalar.Equal(Scalar<T>.NegativeInfinity,v);
		}

		return false;
	}

	public static T Sin<T>(T x)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)Math.Sin((float)(Object)x);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)Math.Sin((double)(Object)x);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)Math.Sin((int)(Object)x);
		}
		else if(typeof(T) == typeof(uint))
		{
			return (.)(Object)Math.Sin((uint)(Object)x);
		}

		return default;
	}

	public static T Tan<T>(T x)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)Math.Tan((float)(Object)x);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)Math.Tan((double)(Object)x);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)Math.Tan((int)(Object)x);
		}
		else if(typeof(T) == typeof(uint))
		{
			return (.)(Object)Math.Tan((uint)(Object)x);
		}

		return default;
	}

	public static T Cos<T>(T x)
	{
		if(typeof(T) == typeof(float))
		{
			return (.)(Object)Math.Cos((float)(Object)x);
		}
		else if(typeof(T) == typeof(double))
		{
			return (.)(Object)Math.Cos((double)(Object)x);
		}
		else if(typeof(T) == typeof(int))
		{
			return (.)(Object)Math.Cos((int)(Object)x);
		}
		else if(typeof(T) == typeof(uint))
		{
			return (.)(Object)Math.Cos((uint)(Object)x);
		}

		return default;
	}
}