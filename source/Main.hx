package;

import flixel.FlxGame;
import haxe.io.Path;
import lime.system.System;
import openfl.display.Sprite;
import sys.FileSystem;
import sys.io.File;

class Main extends Sprite
{
	public static var launcherDirectory:String = "";
	public static var serverPath:String = "https://raw.githubusercontent.com/SpunBlue/Magma-Launcher/main/server";

	var folderPath:String = "Magma-Launcher";

	public function new()
	{
		super();

		launcherDirectory = Path.normalize(System.documentsDirectory + '/$folderPath/');
		if (FileSystem.isDirectory(launcherDirectory) == false)
			FileSystem.createDirectory(launcherDirectory);

		trace(launcherDirectory);

		addChild(new FlxGame(0, 0, PlayState, 60, 60, true));
	}

	public static function requestWebData(path, ?onError:Dynamic->Void):Dynamic
	{
		var http = new haxe.Http(Main.serverPath + '/$path');
		http.onStatus = s ->
		{
			switch (s)
			{
				default:
					trace('ERROR: $s');

					if (onError != null)
						onError(s);

					return;
				case 200:
					// do nothing
			}
		};

		http.onError = s ->
		{
			trace('ERROR: $s');

			if (onError != null)
				onError(s);

			return;
		};

		http.request();

		return http.responseData;
	}
}
