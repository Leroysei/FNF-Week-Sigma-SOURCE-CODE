package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public var Scale = 150;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('bf-old', [14, 15], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.add('bftext', [0, 1], 0, false, isPlayer);
		animation.add('bfsoulless', [0, 1], 0, false, isPlayer);
		animation.add('gftext', [16], 0, false, isPlayer);
		animation.add('gfsoulless', [16], 0, false, isPlayer);
		animation.add('sigma', [24, 25], 0, false, isPlayer);
		animation.add('sigmastonks', [26, 26], 0, false, isPlayer);
		animation.add('stonks', [26, 26], 0, false, isPlayer);
		animation.add('soullesssigma', [27, 27], 0, false, isPlayer);
		animation.add('soullesssigmainjured', [27, 27], 0, false, isPlayer);
		animation.add('enigma', [0, 1], 0, false, isPlayer);
		animation.add('nope', [0, 1], 0, false, isPlayer);
		animation.play(char);
		switch (char)
		{
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
				{}
			default:
				{
					antialiasing = true;
				}
		}
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
