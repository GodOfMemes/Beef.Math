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

	static this()
	{
		if(typeof(T) == typeof(float))
		{
			One = (.)(Object)1f;
			Epsilion = (.)(Object)float.Epsilon;
			MaxValue = (.)(Object)float.MaxValue;
			MinValue = (.)(Object)float.MinValue;
			PositiveInfinity = (.)(Object)float.PositiveInfinity;
			NegativeInfinity = (.)(Object)float.NegativeInfinity;
			NaN = (.)(Object)float.NaN;
		}
		else if(typeof(T) == typeof(double))
		{
			One = (.)(Object)1d;
			Epsilion = (.)(Object)double.Epsilon;
			MaxValue = (.)(Object)double.MaxValue;
			MinValue = (.)(Object)double.MinValue;
			PositiveInfinity = (.)(Object)double.PositiveInfinity;
			NegativeInfinity = (.)(Object)double.NegativeInfinity;
			NaN = (.)(Object)double.NaN;
		}
		else if(typeof(T) == typeof(int))
		{
			One = (.)(Object)1;
			Epsilion = default;
			MaxValue = (.)(Object)int.MaxValue;
			MinValue = (.)(Object)int.MinValue;
			PositiveInfinity = default;
			NegativeInfinity = default;
			NaN = default;
		}
		else if(typeof(T) == typeof(uint))
		{
			One = (.)(Object)1u;
			Epsilion = default;
			MaxValue = (.)(Object)uint.MaxValue;
			MinValue = (.)(Object)uint.MinValue;
			PositiveInfinity = default;
			NegativeInfinity = default;
			NaN = default;
		}
	}

	public static T Sqrt(T x)
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

	public static T Add(T a, T b)
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

	public static T Subtract(T a, T b)
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

	public static T Multiply(T a, T b)
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

	public static T Divide(T a, T b)
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

	public static bool Equal(T a, T b)
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
}