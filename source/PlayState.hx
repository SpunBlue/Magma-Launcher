package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var menuButtons:FlxTypedGroup<GoofyButton> = new FlxTypedGroup();

	var arrow:FlxSprite;

	var curSelected:Int = 0;

	override public function create()
	{
		FlxG.autoPause = false;

		var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic("assets/images/bg.png");
		bg.setGraphicSize(960, 610);
		bg.updateHitbox();
		add(bg);

		var sidebar:FlxSprite = new FlxSprite(0, 0).loadGraphic("assets/images/sidebar.png");
		sidebar.setGraphicSize(960, 610);
		sidebar.updateHitbox();
		add(sidebar);

		// add buttons
		var playbutt:GoofyButton = new GoofyButton(0, 0, "play", function()
		{
			openSubState(new LaunchSubstate());
		});
		playbutt.ID = 0;
		menuButtons.add(playbutt);

		var market:GoofyButton = new GoofyButton(0, playbutt.height + 16, "market", function()
		{
			trace("MARKET");
		});
		market.ID = 1;
		menuButtons.add(market);

		var settings:GoofyButton = new GoofyButton(0, market.y + market.height - 32, "settings", function()
		{
			trace("SETTINGS");
		});
		settings.ID = 2;

		menuButtons.add(settings);

		var website:GoofyButton = new GoofyButton(0, settings.y + settings.height - 56, "website", function()
		{
			trace("WEBSITE");
		});
		website.ID = 3;
		menuButtons.add(website);

		// arrow
		arrow = new FlxSprite(playbutt.width + 48, playbutt.height / 2).loadGraphic("assets/images/arrow.png");
		arrow.setGraphicSize(Math.floor(arrow.width / 2));
		arrow.updateHitbox();

		arrow.y = arrow.y - (arrow.height / 2);

		add(menuButtons);
		add(arrow);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([W, UP]))
			curSelected--;
		else if (FlxG.keys.anyJustPressed([S, DOWN]))
			curSelected++;

		if (curSelected < 0)
			curSelected = menuButtons.members.length - 1;
		else if (curSelected > menuButtons.members.length - 1)
			curSelected = 0;

		for (button in menuButtons.members)
		{
			if (button.ID == curSelected)
			{
				arrow.setPosition(button.width + 64, button.y + (button.height / 2 - arrow.height / 2));

				// button.swapColor(FlxColor.GRAY, FlxColor.WHITE);
				if (button.alpha < 1)
					button.alpha = 1;

				if (FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed)
					button.task();
			}
			else
			{
				// button.swapColor(FlxColor.WHITE, FlxColor.GRAY);
				if (button.alpha >= 1)
					button.alpha = 0.7;
			}

			if (FlxG.mouse.overlaps(button))
			{
				curSelected = button.ID;
			}
		}
	}
}
