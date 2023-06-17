import flixel.FlxSprite;
import flixel.util.FlxColor;

class GoofyButton extends FlxSprite
{
	public var task:Void->Void;

	var curColor:FlxColor = FlxColor.WHITE;

	public function new(x:Float, y:Float, id:String, task:Void->Void)
	{
		super(x, y);
		this.task = task;

		loadGraphic('assets/images/buttons/$id.png');
		setGraphicSize(Math.floor(width / 2));
		updateHitbox();
	}

	public function swapColor(swapColor:FlxColor, newColor:FlxColor)
	{
		if (newColor != curColor)
		{
			this.replaceColor(swapColor, newColor);
			curColor = newColor;
		}
	}
}
