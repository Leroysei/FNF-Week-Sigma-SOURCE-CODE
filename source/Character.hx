package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'gf-sigma':
				tex = Paths.getSparrowAtlas('characters/GF_ass_sets_grey');
				frames = tex;
				animation.addByPrefix('singLEFT', 'GF grey left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF grey Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF grey Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF grey Down Note', 24, false);
				animation.addByPrefix('idle', 'gf idle sad', 24, false);
				animation.addByPrefix('freed', 'GF_preTrolling', 24);
				animation.addByPrefix('trolling', 'GF_trolling', 24);

				addOffset('idle', 0, -9);
				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('freed', -2, -17);
				addOffset('trolling', -2, -17);

				playAnim('idle');

			case 'gf-skeleton':
				tex = Paths.getSparrowAtlas('characters/GF_ass_sets_grey');
				frames = tex;
				animation.addByPrefix('singLEFT', 'SKELETON_GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'SKELETON_GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'SKELETON_GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'SKELETON_GF Down Note', 24, false);
				animation.addByPrefix('idle', 'SKELETON_GF Dancing Beat', 24, false);
				addOffset('idle', 0, -9);
				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);

				playAnim('idle');

			case 'gfsoulless':
				var tex = Paths.getSparrowAtlas('characters/GF_ass_sets_soulless');
				frames = tex;
				animation.addByPrefix('idle', 'GF Dancing Beat', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByPrefix('singUPmiss', 'MISSGF Up Note', 24, false);
				animation.addByPrefix('singLEFTmiss', 'MISSGF left note', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'MISSGF Right Note', 24, false);
				animation.addByPrefix('singDOWNmiss', 'MISSGF Down Note', 24, false);
				animation.addByPrefix('hey', 'GF_trolling', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -6, 14);
				addOffset("singRIGHT", -4, -10);
				addOffset("singLEFT", -4, -9);
				addOffset("singDOWN", -6, -9);
				addOffset("singUPmiss", -5, 38);
				addOffset("singRIGHTmiss", -6, 14);
				addOffset("singLEFTmiss", -6, 13);
				addOffset("singDOWNmiss", -4, 10);
				addOffset("hey", -7, -6);

				playAnim('idle');
				flipX = true;

			case 'bfsoullessgf':
				var tex = Paths.getSparrowAtlas('characters/BoyFriend_Assets1');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle shaking instance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP instance', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT instance', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT instance', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN instance', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS instance', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS instance', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS instance', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS instance', 24, false);
				animation.addByPrefix('hey', 'BF HEY!! instance', 24, false);
				animation.addByPrefix('firstDeath', "BF dies instance", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop instance", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm instance", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking instance', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", 12, 24);
				addOffset("singRIGHTmiss", 12, 24);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", 12, 24);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

			case 'bfsoulless':
				var tex = Paths.getSparrowAtlas('characters/BoyFriend_Assets1');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle shaking instance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP instance', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT instance', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT instance', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN instance', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS instance', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS instance', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS instance', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS instance', 24, false);
				animation.addByPrefix('hey', 'BF HEY!! instance', 24, false);
				animation.addByPrefix('firstDeath', "BF dies instance", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop instance", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm instance", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking instance', 24, false);
				animation.addByPrefix('dropthemic', 'BF rage instance', 24, false);
				animation.addByPrefix('nomic', 'BF idle rage instance', 24, false);
				addOffset('idle', -5);

				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", 12, 24);
				addOffset("singRIGHTmiss", 12, 24);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", 12, 24);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);
				addOffset('dropthemic', 34);
				addOffset('nomic');

				playAnim('idle');
				flipX = true;
			case 'bfmicdrop':
				var tex = Paths.getSparrowAtlas('characters/BoyFriend_Assets1');
				frames = tex;
				animation.addByPrefix('idle', 'BF rage instance', 24, false);
				addOffset('idle', 34);

				playAnim('idle');
				flipX = true;
			case 'bfangered':
				var tex = Paths.getSparrowAtlas('characters/BoyFriend_Assets1');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle rage instance', 24, false);
				addOffset('idle');

				playAnim('idle');
			case 'gftext':
				var tex = Paths.getSparrowAtlas('characters/GF_ass_sets_success');
				frames = tex;
				animation.addByPrefix('say', 'GF_textbox', 24, false);
				animation.addByPrefix('idle', 'GF Dancing Beat', 24, false);

				addOffset('say', 107, 155);
				addOffset('idle', 0, -9);

				playAnim('idle');
			case 'bftext':
				var tex = Paths.getSparrowAtlas('characters/BoyFriend_Assets1');
				frames = tex;
				animation.addByPrefix('idle', 'BF_textbox instance', 24, false);
				animation.addByPrefix('test', 'BF idle dance instance', 24, false);

				addOffset('idle', 125, -2);
				addOffset('test', -5);

				playAnim('idle');
				flipX = true;

			case 'bfgfsoulless':
				var tex = Paths.getSparrowAtlas('characters/GF_ass_sets_soulless');
				frames = tex;
				animation.addByPrefix('idle', 'GF Dancing Beat', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByPrefix('singUPmiss', 'MISSGF Up Note', 24, false);
				animation.addByPrefix('singLEFTmiss', 'MISSGF left note', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'MISSGF Right Note', 24, false);
				animation.addByPrefix('singDOWNmiss', 'MISSGF Down Note', 24, false);
				animation.addByPrefix('hey', 'GF_trolling', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -6, 14);
				addOffset("singRIGHT", -4, -10);
				addOffset("singLEFT", -4, -9);
				addOffset("singDOWN", -6, -9);
				addOffset("singUPmiss", -5, 38);
				addOffset("singRIGHTmiss", -6, 14);
				addOffset("singLEFTmiss", -6, 13);
				addOffset("singDOWNmiss", -4, 10);
				addOffset("hey", -7, -6);

				playAnim('idle');
			case 'bf-skeleton':
				var tex = Paths.getSparrowAtlas('characters/BoyFriend_Assets1');
				frames = tex;
				animation.addByPrefix('idle', 'BF_Skeleton idle', 24, false);
				animation.addByPrefix('singUP', 'BF_Skeleton NOTE UP', 24, false);
				animation.addByPrefix('singLEFT', 'BF_Skeleton NOTE LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'BF_Skeleton NOTE RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'BF_Skeleton NOTE DOWN', 24, false);
				animation.addByPrefix('singUPmiss', 'BF_Skeleton MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF_Skeleton MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF_Skeleton MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF_Skeleton MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", 12, 24);
				addOffset("singRIGHTmiss", 12, 24);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", 12, 24);

				playAnim('idle');
				flipX = true;
			case 'sigma':
				tex = Paths.getSparrowAtlas('characters/Sigma_assets');
				frames = tex;
				animation.addByPrefix('idle', 'survey_idle', 24, true);
				animation.addByPrefix('singUP', 'survey_up', 24, false);
				animation.addByPrefix('singRIGHT', 'survey_right', 24, false);
				animation.addByPrefix('singDOWN', 'survey_down', 24, false);
				animation.addByPrefix('singLEFT', 'survey_left', 24, false);

				addOffset('idle');
				addOffset("singUP", -2, 25);
				addOffset("singRIGHT", 0, 14);
				addOffset("singLEFT", -3, 0);
				addOffset("singDOWN");

				playAnim('idle');
			case 'sigmastonks':
				tex = Paths.getSparrowAtlas('characters/Sigma_assets');
				frames = tex;
				animation.addByPrefix('idle', 'survey_idle', 24, true);
				animation.addByPrefix('singUP', 'survey_up', 24, false);
				animation.addByPrefix('singRIGHT', 'survey_right', 24, false);
				animation.addByPrefix('singDOWN', 'survey_down', 24, false);
				animation.addByPrefix('singLEFT', 'survey_left', 24, false);

				addOffset('idle');
				addOffset("singUP", -2, 25);
				addOffset("singRIGHT", 0, 14);
				addOffset("singLEFT", -3, 0);
				addOffset("singDOWN");

				playAnim('idle');
			case 'stonks':
				tex = Paths.getSparrowAtlas('characters/Sigma_assets');
				frames = tex;
				animation.addByPrefix('idle', 'TRUE_STONKS_idle', 24, true);
				animation.addByPrefix('singUP', 'TRUE_STONKS_up', 24, false);
				animation.addByPrefix('singRIGHT', 'TRUE_STONKS_right', 24, false);
				animation.addByPrefix('singDOWN', 'TRUE_STONKS_down', 24, false);
				animation.addByPrefix('singLEFT', 'TRUE_STONKS_left', 24, false);
				animation.addByPrefix('defeated', 'TRUE_STONKS_defeated', 24, false);

				addOffset('idle', 65, -51);
				addOffset("singUP", 22, 19);
				addOffset("singRIGHT", 80, -10);
				addOffset("singLEFT", 319, -50);
				addOffset("singDOWN", 159, 0);
				addOffset('defeated', 217, 61);

				playAnim('idle');
			case 'stonksbeaten':
				tex = Paths.getSparrowAtlas('characters/Sigma_assets');
				frames = tex;
				animation.addByPrefix('idle', 'TRUE_STONKS_defeated', 24, false);
				addOffset('idle', 217, 61);

				playAnim('idle');
			case 'soullesssigma':
				frames = Paths.getSparrowAtlas('characters/SoullessAssets');
				animation.addByPrefix('idle', 'SOULLESS_idleF', 24, true);
				animation.addByPrefix('singUP', 'SOULLESS_upF', 24, false);
				animation.addByPrefix('singDOWN', 'SOULLESS_downF', 24, false);
				animation.addByPrefix('singLEFT', 'SOULLESS_leftF', 24, false);
				animation.addByPrefix('singRIGHT', 'SOULLESS_rightF', 24, false);
				animation.addByPrefix('damaged', 'SOULLESS_damagedF', 24, true);

				addOffset('idle');
				addOffset("singUP", -22, -47);
				addOffset("singRIGHT", 108, -18);
				addOffset("singLEFT", -30, 3);
				addOffset("singDOWN", -31, -29);
				addOffset('damaged');

				playAnim('idle');
			case 'soullesssigmainjured':
				frames = Paths.getSparrowAtlas('characters/SoullessAssets');
				animation.addByPrefix('idle', 'SOULLESS_idle_mini', 24, false);
				animation.addByPrefix('singUP', 'SigmaTankman_up', 24, false);
				animation.addByPrefix('singDOWN', 'SigmaMadness_down', 24, false);
				animation.addByPrefix('singLEFT', 'SigmaMom_Left', 24, false);
				animation.addByPrefix('singRIGHT', 'SigmaCassette_right', 24, false);
				animation.addByPrefix('singUP-alt', 'SigmaDad_UP', 24, false);
				animation.addByPrefix('singDOWN-alt', 'SigmaSempai_down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'SigmaMom_Left', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'SigmaPico_Right', 24, false);

				addOffset('idle', -124, -2);
				addOffset("singUP", -262, -148);
				addOffset("singRIGHT", -339, -109);
				addOffset("singLEFT", -333, 54);
				addOffset("singDOWN", -381, -274);
				addOffset("singUP-alt", -331, 88);
				addOffset("singRIGHT-alt", -220, -244);
				addOffset("singLEFT-alt", -333, 54);
				addOffset("singDOWN-alt", -297, 17);

				playAnim('idle');
			case 'enigma':
				frames = Paths.getSparrowAtlas('characters/EmbryoBF');
				animation.addByPrefix('idle', 'Embryo instance', 24, true);
				animation.addByPrefix('singUP', 'Embryo instance', 24, false);
				animation.addByPrefix('singDOWN', 'Embryo instance', 24, false);
				animation.addByPrefix('singLEFT', 'Embryo instance', 24, false);
				animation.addByPrefix('singRIGHT', 'Embryo instance', 24, false);

				addOffset('idle');
				addOffset('singUP');
				addOffset('singDOWN');
				addOffset('singLEFT');
				addOffset('singRIGHT');

				playAnim('idle');

			case 'nope':
				frames = Paths.getSparrowAtlas('characters/TOBECONTINUED');
				animation.addByPrefix('idle', 'TOBECONTINUED idle', 24, true);

				addOffset('idle');
				playAnim('idle');
			case 'bf':
				var tex = Paths.getSparrowAtlas('BOYFRIEND', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('Pre attack', 'bf pre attack', 24, true);
				animation.addByPrefix('Attack', 'boyfriend attack', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);
				addOffset('Pre attack', -20. - 38);
				addOffset('Attack', 282, 275);

				playAnim('idle');

				flipX = true;
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!isPlayer && animation.curAnim != null)
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/*
	 *
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
