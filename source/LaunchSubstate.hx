import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;

class LaunchSubstate extends FlxSubState
{
	override public function create()
	{
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.7;
		add(bg);

		super.create();

		var versionHistory:GameData = Main.requestWebData("versionHistory.json", function(err)
		{
			openError(err);
		});
		trace("DATA: " + versionHistory);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function openError(errorCode:Dynamic)
	{
		trace('ERROR $errorCode');
		closeSubState();
		// openSubState
	}
}

typedef GameData =
{
	var games:Array<GameVersion>;
	var mods:Array<ModVersion>;
}

typedef GameVersion =
{
	var name:String;
	var latest:String;
	var history:Array<String>;
}

typedef ModVersion =
{
	var name:String;
	var latest:String;
	var history:Array<String>;
}
