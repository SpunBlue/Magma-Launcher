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
}
