using System;

namespace BeefMath;

struct Rect
{
	public const Rect Zero = default;
	public const Rect SizeOne = Rect(0, 0, 1, 1);
	public const Rect PosOne = Rect(1, 1, 0, 0);

	public int32 X;
	public int32 Y;
	public int32 Width;
	public int32 Height;

	public this()
	{
		this = default;
	}

	public this(int32 x, int32 y, int32 width, int32 height)
	{
		X = x;
		Y = y;
		Width = width;
		Height = height;
	}

	public this(Point2 position, Point2 size)
	{
		X = position.X;
		Y = position.Y;
		Width = size.X;
		Height = size.Y;
	}

	public this(int32 x, int32 y, uint width, uint height)
	{
		X = x;
		Y = y;
		Width = (.)width;
		Height = (.)height;
	}

	public this(Point2 position, UPoint2 size)
	{
		X = position.X;
		Y = position.Y;
		Width = (.)size.X;
		Height = (.)size.Y;
	}

	public Point2 Position
	{
		get => .(X, Y);
		set mut
		{
			X = value.X;
			Y = value.Y;
		}
	}

	public Point2 Size
	{
		get => .(Width, Height);
		set mut
		{
			Width = value.X;
			Height = value.Y;
		}
	}

	public Point2 Center
	{
	    get => Point2(X + Width / 2, Y + Height / 2);
	    set mut
	    {
	        X = value.X - Width / 2;
	        Y = value.Y - Height / 2;
	    }
	}

	public int32 Left
	{
		get => X;
		set	mut
		{
			let prevX = X;
			X = value;
			Width = Math.Max(Width + prevX - X, 0);
		}
	}

	public int32 Right
	{
		get => X + Width;
		set	mut
		{
			Width = value - X;
			X = Math.Min(X, X + Width);
		}
	}

	public int32 Top
	{
		get => Y;
		set mut
		{
			let prevY = Y;
			Y = value;
			Height = Math.Max(Height + prevY - Y, 0);
		}
	}

	public int32 Bottom
	{
		get => Y + Height;
		set mut
		{
			Height = value - Y;
			Y = Math.Min(Y, Y + Height);
		}
	}
	
	public int32 Area => Width * Height;
	
	public bool Overlaps(Rect rect)
	{
		return (X + Width) > rect.X && (rect.X + rect.Width) > X && (Y + Height) > rect.Y && (rect.Y + rect.Height) > Y;
	}

	
	public bool Contains(Rect rect)
	{
	    return (Left < rect.Left && Top < rect.Top && Bottom > rect.Bottom && Right > rect.Right);
	}

	
	public bool Contains(Point2 point)
	{
		return point.X >= X && point.X < X + Width && point.Y >= Y && point.Y < Y + Height;
	}

	public override void ToString(String strBuffer)
	{
		strBuffer.Append("Rect < ");
		X.ToString(strBuffer);
		strBuffer.Append(", ");
		Y.ToString(strBuffer);
		strBuffer.Append(", ");
		Width.ToString(strBuffer);
		strBuffer.Append(", ");
		Height.ToString(strBuffer);
		strBuffer.Append(" >");
	}
	
	public static bool operator==(Rect a, Rect b) => a.X == b.X && a.Y == b.Y && a.Width == b.Width && a.Height == b.Height;

	public static Rect operator+(Rect a, Point2 b) => Rect(a.X + b.X, a.Y + b.Y, a.Width, a.Height);
	public static Rect operator-(Rect a, Point2 b) => Rect(a.X - b.X, a.Y - b.Y, a.Width, a.Height);
}
