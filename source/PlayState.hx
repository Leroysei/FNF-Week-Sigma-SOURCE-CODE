package;

import Alphabet.AlphaCharacter;
import Movement.Effect;
import Movement.EffectParams;
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.animation.FlxBaseAnimation;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.FlxGraphic;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxAssets;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.app.Application;
import lime.graphics.Image;
import lime.media.AudioContext;
import lime.media.AudioManager;
import lime.utils.Assets;
import openfl.Lib;
import openfl.display.BitmapData;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;
import openfl.geom.Matrix;
import openfl.utils.AssetLibrary;
import openfl.utils.AssetManifest;
import openfl.utils.AssetType;

using StringTools;

#if windows
import Discord.DiscordClient;
#end

class PlayState extends MusicBeatState
{
	public static var curStage:String = '';
	public static var SONG:SwagSong;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;
	public static var weekSong:Int = 0;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;

	public static var songPosBG:FlxSprite;
	public static var songPosBar:FlxBar;

	public static var rep:Replay;
	public static var loadRep:Bool = false;

	public static var noteBools:Array<Bool> = [false, false, false, false];

	public var shakingNotes:Bool = false;

	var halloweenLevel:Bool = false;

	var songLength:Float = 0;

	#if windows
	// Discord RPC variables
	var storyDifficultyText:String = "";
	var iconRPC:String = "";
	var detailsText:String = "";
	var detailsPausedText:String = "";
	#end

	private var vocals:FlxSound;

	private var dad:Character;
	private var gf:Character;
	private var boyfriend:Boyfriend;

	var background1:FlxSprite;
	var crowd:FlxSprite;
	var clouds:FlxSprite;
	var homes1:FlxSprite;
	var homes2:FlxSprite;
	var stage1:FlxSprite;
	var background2:FlxSprite;
	var sigmastatic:FlxSprite;
	var creepy1:FlxSprite;
	var creepy2:FlxSprite;
	var creepy3:FlxSprite;
	var homes3:FlxSprite;
	var homes4:FlxSprite;
	var background3:FlxSprite;
	var raysfinal:FlxSprite;
	var flyingstage:FlxSprite;
	var background4:FlxSprite;
	var gfimpact:FlxSprite;
	var background5:FlxSprite;
	var clouds2:FlxSprite;

	public var gfSpeak:FlxSprite;

	private var notes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];
	private var unspawnEffects:Array<EffectParams> = [];

	private var strumLine:FlxSprite;
	private var curSection:Int = 0;

	private var camFollow:FlxObject;

	private static var prevCamFollow:FlxObject;

	private var strumLineNotes:FlxTypedGroup<FlxSprite>;
	private var playerStrums:FlxTypedGroup<FlxSprite>;
	private var enemyStrums:FlxTypedGroup<FlxSprite>;

	private var camZooming:Bool = false;
	private var curSong:String = "";

	private var gfSpeed:Int = 1;
	private var health:Float = 1;
	private var lerphealth:Float = 0;
	private var combo:Int = 0;

	public static var dismisses:Int = 0;
	public static var misses:Int = 0;

	private var accuracy:Float = 0.00;
	private var accuracyDefault:Float = 0.00;
	private var totalNotesHit:Float = 0;
	private var totalNotesHitDefault:Float = 0;
	private var totalPlayed:Int = 0;
	private var ss:Bool = false;

	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;
	private var songPositionBar:Float = 0;

	private var generatedMusic:Bool = false;
	private var startingSong:Bool = false;

	private var iconP1:HealthIcon;
	private var iconP2:HealthIcon;
	private var addPulse:Float;

	private var camHUD:FlxCamera;
	private var camGame:FlxCamera;

	public static var offsetTesting:Bool = false;
	public static var auto:Bool = false;
	public static var daddance:Bool = true;
	public static var playerdance:Bool = true;

	public static var dadstartdancin:FlxTimer;
	public static var bfstartdancin:FlxTimer;

	public static var dadUnpressTime:FlxTimer;
	public static var bfUnpressTime:FlxTimer;

	var notesHitArray:Array<Date> = [];
	var currentFrames:Int = 0;

	var dialogue:Array<String> = ['blah blah blah', 'coolswag'];

	var halloweenBG:FlxSprite;
	var isHalloween:Bool = false;

	var phillyCityLights:FlxTypedGroup<FlxSprite>;
	var phillyTrain:FlxSprite;
	var trainSound:FlxSound;

	var limo:FlxSprite;
	var fastCar:FlxSprite;
	var songName:FlxText;
	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var santa:FlxSprite;

	var fc:Bool = true;

	var wiggleShit:WiggleEffect = new WiggleEffect();

	var talking:Bool = true;
	var songScore:Int = 0;
	var songScoreDef:Int = 0;
	var scoreTxt:FlxText;
	var replayTxt:FlxText;

	public static var campaignScore:Int = 0;

	var defaultCamZoom:Float = 1.05;

	public static var daPixelZoom:Float = 6;

	var initialPositionX:Array<Float> = [0, 0];

	public static var currentPositionX:Array<Float> = [0, 0, 0, 0, 0, 0, 0, 0];

	var initialPositionY:Array<Float> = [50, 50];

	public static var currentPositionY:Array<Float> = [50, 50, 50, 50, 50, 50, 50, 50];

	var noteWidth:Float;

	public static var holdNoteHieght:Float;

	public static var theFunne:Bool = true;

	var funneEffect:FlxSprite;

	public static var repPresses:Int = 0;

	var inCutscene:Bool = false;

	public static var repReleases:Int = 0;

	public static var timeCurrently:Float = 0;
	public static var timeCurrentlyR:Float = 0;

	// Will fire once to prevent debug spam messages and broken animations
	private var triggeredAlready:Bool = false;

	// Will decide if she's even allowed to headbang at all depending on the song
	private var allowedToHeadbang:Bool = false;
	private var Offset:Float = 13;

	public static var angle:Array<Float> = [0, 0, 0, 0, 0, 0, 0, 0]; // rotation of the sprite of the gray arrows
	public static var angleC:Array<Float> = [0, 0, 0, 0, 0, 0, 0, 0]; // rotation of the incoming arrows

	public static var angleD:Array<Float> = [180, 180, 0, 0, 180, 180, 0, 0]; // angle of rotation of the pivot of gray arrows
	public static var orbit:Array<Float> = [168, 56, 56, 168, 168, 56, 56, 168]; // orbit of the arrow, distance from the pivot

	public static var alpha:Array<Float> = [1, 1, 1, 1, 1, 1, 1, 1]; // the alpha of the arrows

	// first 4 for enemy arrows, last 4 for player's
	private var autoTxt:Alphabet;

	public static var percentage:Int;

	public var focus = false;

	public var lerpSpawn:Float = 0;

	public static var dadUnpress:Bool;

	public static var bfUnpress:Bool;

	var Dif:Array<String> = ["Baby", "Classic", "Permissive", "Geometry dash"];

	override public function create()
	{
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		sicks = 0;
		bads = 0;
		shits = 0;
		goods = 0;

		misses = 0;
		dismisses = 0;

		repPresses = 0;
		repReleases = 0;

		playerdance = true;
		daddance = true;

		lerpSpawn = 2000;

		if (FlxG.save.data.scrollSpeed != 1)
		{
			SONG.speed = FlxG.save.data.scrollSpeed;
		}

		currentPositionY = [50, 50, 50, 50, 50, 50, 50, 50];

		angle = [0, 0, 0, 0, 0, 0, 0, 0]; // rotation of the sprite of the gray arrows
		angleC = [0, 0, 0, 0, 0, 0, 0, 0]; // rotation of the incoming arrows

		angleD = [180, 180, 0, 0, 180, 180, 0, 0]; // angle of rotation of the pivot of gray arrows
		orbit = [168, 56, 56, 168, 168, 56, 56, 168]; // orbit of the arrow, distance from the pivot

		alpha = [1, 1, 1, 1, 1, 1, 1, 1]; // the alpha of the arrows

		#if windows
		// Making difficulty text for Discord Rich Presence.

		switch (storyDifficulty)
		{
			case 0:
				storyDifficultyText = "Easy";
			case 1:
				storyDifficultyText = "Normal";
			case 2:
				storyDifficultyText = "Hard";
		}

		iconRPC = SONG.player2;

		// To avoid having duplicate images in Discord assets
		switch (iconRPC)
		{
			case 'senpai-angry':
				iconRPC = 'senpai';
			case 'monster-christmas':
				iconRPC = 'monster';
			case 'mom-car':
				iconRPC = 'mom';
		}

		// String that contains the mode defined here so it isn't necessary to call changePresence for each mode
		if (isStoryMode)
		{
			detailsText = "Story Mode: Week " + storyWeek;
		}
		else
		{
			detailsText = "Freeplay";
		}

		// String for when the game is paused
		detailsPausedText = "Paused - " + detailsText;

		// Updating Discord Rich Presence.
		DiscordClient.changePresence((!auto ? Dif[FlxG.save.data.dif] : "Auto")
			+ " "
			+ detailsText
			+ " "
			+ SONG.song
			+ " ("
			+ storyDifficultyText
			+ ") "
			+ generateRanking(),
			"\n"
			+ (FlxG.save.data.dif != 0 ? "Acc: " + truncateFloat(accuracy, 2) + "% | " : "")
			+ (!FlxG.save.data.practice ? "Score: " + songScore : "Practice Mode")
			+ (FlxG.save.data.dif != 3 ? " | Misses: " + misses : "")
			+ (FlxG.save.data.dif == 1 ? " | Miss Clicks: " + dismisses : "")
			+ (FlxG.save.data.dif == 3 ? " | Percentage: 0%" : ""),
			iconRPC);
		#end

		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		FlxG.mouse.visible = false;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);

		FlxCamera.defaultCameras = [camGame];

		persistentUpdate = true;
		persistentDraw = true;

		if (SONG == null)
			SONG = Song.loadFromJson('tutorial');

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);

		trace('INFORMATION ABOUT WHAT U PLAYIN WIT:\nFRAMES: ' + Conductor.safeFrames + '\nZONE: ' + Conductor.safeZoneOffset + '\nTS: ' + Conductor.timeScale);

		switch (SONG.song.toLowerCase())
		{
			case 'survey':
				dialogue = CoolUtil.coolTextFile(Paths.txt('survey/dialog'));
			case 'stonks':
				dialogue = CoolUtil.coolTextFile(Paths.txt('stonks/dialog'));
			case 'soulless':
				dialogue = CoolUtil.coolTextFile(Paths.txt('soulless/dialog'));
			case 'sentimental':
				dialogue = CoolUtil.coolTextFile(Paths.txt('sentimental/dialog'));
		}

		switch (SONG.song.toLowerCase())
		{
			case 'survey':
				defaultCamZoom = 0.75;
				curStage = 'sigma-stage';
				background1 = new FlxSprite(-750, -200).loadGraphic(Paths.image('business/sigmastage/bg1_1', 'sigma'));
				background1.antialiasing = true;
				background1.scrollFactor.set(0.9, 0.9);
				background1.active = true;
				background1.setGraphicSize(Std.int(background1.width * 2));
				add(background1);
				background1.updateHitbox();

				clouds = new FlxSprite(-10).loadGraphic(Paths.image('business/sigmastage/clouds', 'sigma'));
				clouds.scrollFactor.set(0.3, 0.3);
				clouds.setGraphicSize(Std.int(clouds.width * 0.85));
				clouds.updateHitbox();
				add(clouds);

				homes1 = new FlxSprite(-850, -300).loadGraphic(Paths.image('business/sigmastage/homes1', 'sigma'));
				homes1.scrollFactor.set(0.3, 0.3);
				homes1.updateHitbox();
				add(homes1);

				homes2 = new FlxSprite(-800, 200).loadGraphic(Paths.image('business/sigmastage/homes2_1', 'sigma'));
				homes2.scrollFactor.set(0.3, 0.3);
				homes2.updateHitbox();
				add(homes2);

				crowd = new FlxSprite(-250, 500);
				crowd.frames = Paths.getSparrowAtlas('business/sigmastage/Crowd', 'sigma');
				crowd.scrollFactor.set(0.3, 0.3);
				crowd.updateHitbox();
				crowd.animation.addByPrefix('idle', 'Crowd_Cheer', true);
				crowd.animation.play('idle');
				add(crowd);

				stage1 = new FlxSprite(-1050, 600).loadGraphic(Paths.image('business/sigmastage/stage', 'sigma'));
				stage1.setGraphicSize(Std.int(stage1.width * 1.5));
				stage1.updateHitbox();
				stage1.antialiasing = true;
				stage1.scrollFactor.set(0.9, 0.9);
				stage1.active = false;
				add(stage1);
			case 'stonks':
				defaultCamZoom = 0.75;
				curStage = 'stonks-stage';
				background2 = new FlxSprite(-500, -150).loadGraphic(Paths.image('business/stonks/bg2', 'sigma'));
				background2.antialiasing = true;
				background2.scrollFactor.set(0.9, 0.9);
				background2.active = true;
				background2.setGraphicSize(Std.int(background2.width * 2));
				add(background2);

				homes4 = new FlxSprite(-600, -200).loadGraphic(Paths.image('business/stonks/homes4', 'sigma'));
				homes4.scrollFactor.set(0.3, 0.3);
				homes4.updateHitbox();
				add(homes4);

				homes3 = new FlxSprite(-800, 100).loadGraphic(Paths.image('business/stonks/homes3', 'sigma'));
				homes3.scrollFactor.set(0.3, 0.3);
				homes3.updateHitbox();
				add(homes3);

				creepy1 = new FlxSprite(-250, -200);
				creepy1.frames = Paths.getSparrowAtlas('business/stonks/Creepy1', 'sigma');
				creepy1.setGraphicSize(Std.int(creepy1.width * 1));
				creepy1.scrollFactor.set(0.3, 0.3);
				creepy1.updateHitbox();
				creepy1.animation.addByPrefix('idle', 'TheHell', true);
				creepy1.animation.play('idle');
				add(creepy1);

				creepy2 = new FlxSprite(-200, -500);
				creepy2.frames = Paths.getSparrowAtlas('business/stonks/Creepy2', 'sigma');
				creepy2.setGraphicSize(Std.int(creepy2.width * 1));
				creepy2.scrollFactor.set(0.3, 0.3);
				creepy2.updateHitbox();
				creepy2.animation.addByPrefix('idle', 'TheSecondHell', true);
				creepy2.animation.play('idle');
				add(creepy2);

				creepy3 = new FlxSprite(-600, -500).loadGraphic(Paths.image('business/stonks/Creepy3', 'sigma'));
				creepy3.antialiasing = true;
				creepy3.scrollFactor.set(0.9, 0.9);
				creepy3.active = true;
				creepy3.setGraphicSize(Std.int(creepy3.width * 2));
				add(creepy3);
				creepy3.updateHitbox();

				sigmastatic = new FlxSprite(-400, -200);
				sigmastatic.frames = Paths.getSparrowAtlas('business/stonks/static1', 'sigma');
				sigmastatic.setGraphicSize(Std.int(sigmastatic.width * 2));
				sigmastatic.scrollFactor.set(0.3, 0.3);
				sigmastatic.updateHitbox();
				sigmastatic.animation.addByPrefix('idle', 'sigmastatic', true);
				sigmastatic.animation.play('idle');
				add(sigmastatic);

				background1 = new FlxSprite(-750, -200).loadGraphic(Paths.image('business/sigmastage/bg1_1', 'sigma'));
				background1.antialiasing = true;
				background1.scrollFactor.set(0.9, 0.9);
				background1.active = true;
				background1.setGraphicSize(Std.int(background1.width * 2));
				add(background1);
				background1.updateHitbox();

				clouds = new FlxSprite(-10).loadGraphic(Paths.image('business/sigmastage/clouds', 'sigma'));
				clouds.scrollFactor.set(0.3, 0.3);
				clouds.setGraphicSize(Std.int(clouds.width * 0.85));
				clouds.updateHitbox();
				add(clouds);

				homes1 = new FlxSprite(-850, -300).loadGraphic(Paths.image('business/sigmastage/homes1', 'sigma'));
				homes1.scrollFactor.set(0.3, 0.3);
				homes1.updateHitbox();
				add(homes1);

				homes2 = new FlxSprite(-800, 200).loadGraphic(Paths.image('business/sigmastage/homes2_1', 'sigma'));
				homes2.scrollFactor.set(0.3, 0.3);
				homes2.updateHitbox();
				add(homes2);

				stage1 = new FlxSprite(-1050, 600).loadGraphic(Paths.image('business/sigmastage/stage', 'sigma'));
				stage1.setGraphicSize(Std.int(stage1.width * 1.5));
				stage1.updateHitbox();
				stage1.antialiasing = true;
				stage1.scrollFactor.set(0.9, 0.9);
				stage1.active = false;
				add(stage1);
			case 'soulless':
				defaultCamZoom = 0.73;
				curStage = 'flying-stage';
				background5 = new FlxSprite(-250, -500).loadGraphic(Paths.image('business/success/backgroundthesequel', 'sigma'));
				background5.setGraphicSize(Std.int(background5.width * 1.5));
				add(background5);

				clouds2 = new FlxSprite(-250, -50).loadGraphic(Paths.image('business/success/wayupintheclouds', 'sigma'));
				add(clouds2);
				background4 = new FlxSprite(200, -350);
				background4.frames = Paths.getSparrowAtlas('business/soulless/soulless_bg1', 'sigma');
				background4.setGraphicSize(Std.int(background4.width * 2));
				background4.antialiasing = true;
				background4.scrollFactor.set(0.9, 0.9);
				background4.active = true;
				background4.animation.addByPrefix('idle', 'soulles2_bg', true);
				background4.animation.play('idle');
				add(background4);

				gfimpact = new FlxSprite(1100, -350);
				gfimpact.frames = Paths.getSparrowAtlas('business/soulless/gf_impact', 'sigma');
				gfimpact.setGraphicSize(Std.int(gfimpact.width * 2));
				gfimpact.antialiasing = true;
				gfimpact.scrollFactor.set(0.9, 0.9);
				gfimpact.active = true;
				gfimpact.animation.addByPrefix('idle', 'Gf_Impact instance', true);
				gfimpact.animation.play('idle');
				add(gfimpact);

				raysfinal = new FlxSprite(-500, -200);
				raysfinal.frames = Paths.getSparrowAtlas('business/soulless/raysFinal', 'sigma');
				raysfinal.setGraphicSize(Std.int(raysfinal.width * 1.5));
				raysfinal.scrollFactor.set(0.3, 0.3);
				raysfinal.updateHitbox();
				raysfinal.animation.addByPrefix('idle', 'RaysFinal', true);
				raysfinal.animation.play('idle');
				add(raysfinal);

				background3 = new FlxSprite(-250, -500).loadGraphic(Paths.image('business/soulless/background3', 'sigma'));
				background3.setGraphicSize(Std.int(background3.width * 1.5));
				background3.antialiasing = true;
				background3.scrollFactor.set(0.9, 0.9);
				background3.active = true;
				add(background3);
				background3.updateHitbox();

				flyingstage = new FlxSprite(-650, 600).loadGraphic(Paths.image('business/soulless/flyingstage', 'sigma'));
				flyingstage.setGraphicSize(Std.int(flyingstage.width * 1.5));
				flyingstage.updateHitbox();
				flyingstage.antialiasing = true;
				flyingstage.scrollFactor.set(0.9, 0.9);
				flyingstage.active = false;
				add(flyingstage);
			case 'sentimental':
				defaultCamZoom = 0.73;
				curStage = 'floating-stage';
				background5 = new FlxSprite(-250, -500).loadGraphic(Paths.image('business/success/backgroundthesequel', 'sigma'));
				background5.setGraphicSize(Std.int(background5.width * 1.5));
				add(background5);

				clouds2 = new FlxSprite(-250, -50).loadGraphic(Paths.image('business/success/wayupintheclouds', 'sigma'));
				add(clouds2);

				flyingstage = new FlxSprite(-650, 600).loadGraphic(Paths.image('business/soulless/flyingstage', 'sigma'));
				flyingstage.setGraphicSize(Std.int(flyingstage.width * 1.5));
				flyingstage.updateHitbox();
				flyingstage.antialiasing = true;
				flyingstage.scrollFactor.set(0.9, 0.9);
				flyingstage.active = false;
				add(flyingstage);

			default:
				{
					defaultCamZoom = 1.05;
					curStage = 'stage';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);

					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = true;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;

					add(stageCurtains);
				}
		}

		var gfVersion:String = 'gf';

		switch (curStage)
		{
			case 'sigma-stage':
				gfVersion = 'gf-sigma';
			case 'stonks-stage':
				gfVersion = 'gf-sigma';
			case 'flying-stage':
				gfVersion = 'gfsoulless';
		}
		switch (curStage)
		{
			case 'sigma-stage':
				gf = new Character(500, 130, gfVersion);
				gf.scrollFactor.set(0.95, 0.95);
				add(gf);
				dad = new Character(-100, 100, SONG.player2);
				add(dad);
				boyfriend = new Boyfriend(1170, 450, SONG.player1);
				add(boyfriend);
			case 'stonks-stage':
				gf = new Character(500, 130, gfVersion);
				gf.scrollFactor.set(0.95, 0.95);
				add(gf);
				dad = new Character(-100, 100, SONG.player2);
				add(dad);
				boyfriend = new Boyfriend(1170, 450, SONG.player1);
				add(boyfriend);
			case 'flying-stage':
				gf = new Character(1250, 130, gfVersion);
				gf.scrollFactor.set(0.95, 0.95);
				add(gf);
				dad = new Character(-300, -200, SONG.player2);
				add(dad);
				boyfriend = new Boyfriend(2020, 450, SONG.player1);
				add(boyfriend);
			case 'floating-stage':
				gf = new Character(1250, 130, gfVersion);
				gf.scrollFactor.set(0.95, 0.95);
				add(gf);

				dad = new Character(1250, 130, SONG.player2);
				dad.alpha = 0;
				add(dad);

				boyfriend = new Boyfriend(2020, 450, SONG.player1);
				add(boyfriend);

				gfSpeak = new FlxSprite(gf.x - 100, gf.y - 145).loadGraphic(Paths.image('characters/GF_ass_sets_text', 'shared'));
				gfSpeak.scrollFactor.set(0.95, 0.95);
				gfSpeak.antialiasing = true;
				gfSpeak.alpha = 0;
				add(gfSpeak);
			case 'stage':
				gf = new Character(400, 130, gfVersion);
				gf.scrollFactor.set(0.95, 0.95);
				add(gf);
				dad = new Character(100, 100, SONG.player2);
				add(dad);
				boyfriend = new Boyfriend(770, 450, SONG.player1);
				add(boyfriend);
		}
		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

		if (!SONG.player1.startsWith('bf'))
		{
			boyfriend.x += boyfriend.width / 2;
		}
		add(gf);
		// Shitty layering but whatev it works LOL
		if (curStage == 'limo')
			add(limo);
		add(dad);
		add(boyfriend);
		auto = false;
		autoTxt = new Alphabet(0, 0, "Auto", true, false);
		autoTxt.x = FlxG.width - autoTxt.width - 20;
		autoTxt.y = FlxG.height - autoTxt.height - 10;
		autoTxt.alpha = 0;
		add(autoTxt);
		dadstartdancin = new FlxTimer();
		bfstartdancin = new FlxTimer();
		dadUnpressTime = new FlxTimer();
		bfUnpressTime = new FlxTimer();
		var doof:DialogueBox = new DialogueBox(false, dialogue);

		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;
		Conductor.songPosition = -5000;
		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();
		strumLineNotes = new FlxTypedGroup<FlxSprite>();
		add(strumLineNotes);
		playerStrums = new FlxTypedGroup<FlxSprite>();
		enemyStrums = new FlxTypedGroup<FlxSprite>();
		// startCountdown();
		generateSong(SONG.song);
		// add(strumLine);
		camFollow = new FlxObject(0, 0, 1, 1);
		camFollow.setPosition(camPos.x, camPos.y);
		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}
		add(camFollow);
		FlxG.camera.follow(camFollow, LOCKON, 0.04 * (30 / (cast(Lib.current.getChildAt(0), Main)).getFPS()));
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());
		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);
		FlxG.fixedTimestep = false;
		if (FlxG.save.data.songPosition) // I dont wanna talk about this code :(
		{
			songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
			songPosBG.screenCenter(X);
			songPosBG.scrollFactor.set();
			add(songPosBG);
			songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
				'songPositionBar', 0, 90000);
			songPosBar.scrollFactor.set();
			if (SONG.song.toLowerCase() == 'soulless')
			{
				songPosBar.createFilledBar(0xFF400000, 0xFF0E73AA);
				add(songPosBar);
			}
			else
			{
				songPosBar.createFilledBar(0xFF000000, 0xFFBFFF00);
				add(songPosBar);
			}
			var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - 20, songPosBG.y, 0, SONG.song, 16);

			songName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			songName.scrollFactor.set();
			add(songName);
			songName.cameras = [camHUD];
		}
		healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('healthBar'));
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);
		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'lerphealth', 0, 2);
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(0xFFFF0000, 0xFF0E73AA);
		add(healthBar);
		// Add Kade Engine watermark
		scoreTxt = new FlxText(FlxG.width / 2, healthBarBG.y + 50, 0, "", 20); // - 235
		scoreTxt.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.scrollFactor.set();
		add(scoreTxt);
		replayTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + 100, 0, "REPLAY", 20);
		replayTxt.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		replayTxt.scrollFactor.set();
		if (loadRep)
		{
			add(replayTxt);
		}
		iconP1 = new HealthIcon(SONG.player1, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);
		add(iconP1);
		if (SONG.song.toLowerCase() == 'soulless')
		{
			iconP2 = new HealthIcon(SONG.player2, false);
			iconP2.y = healthBar.y - (iconP2.height / 1.5);
			add(iconP2);
		}
		else
		{
			iconP2 = new HealthIcon(SONG.player2, false);
			iconP2.y = healthBar.y - (iconP2.height / 2);
			add(iconP2);
		}
		autoTxt.cameras = [camHUD];
		strumLineNotes.cameras = [camHUD];
		notes.cameras = [camHUD];
		healthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		scoreTxt.cameras = [camHUD];
		doof.cameras = [camHUD];
		if (FlxG.save.data.songPosition)
		{
			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
		}
		if (loadRep)
			replayTxt.cameras = [camHUD];
		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;
		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;
		if (isStoryMode)
		{
			switch (curSong.toLowerCase())
			{
				case "winter-horrorland":
					var blackScreen:FlxSprite = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);

					add(blackScreen);
					blackScreen.scrollFactor.set();
					camHUD.visible = false;
					new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						remove(blackScreen);
						FlxG.sound.play(Paths.sound('Lights_Turn_On'));
						camFollow.y = -2050;
						camFollow.x += 200;
						FlxG.camera.focusOn(camFollow.getPosition());
						FlxG.camera.zoom = 1.05;
						new FlxTimer().start(0.8, function(tmr:FlxTimer)
						{
							camHUD.visible = true;
							remove(blackScreen);
							FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 2.5, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									startCountdown();
								}
							});
						});
					});
				case 'survey':
					schoolIntro(doof);
				case 'stonks':
					schoolIntro(doof);
				case 'soulless':
					schoolIntro(doof);
				case 'sentimental':
					schoolIntro(doof);
				case 'senpai':
					schoolIntro(doof);
				case 'roses':
					FlxG.sound.play(Paths.sound('ANGRY'));
					schoolIntro(doof);
				case 'thorns':
					schoolIntro(doof);
				default:
					startCountdown();
			}
		}
		else
		{
			switch (curSong.toLowerCase())
			{
				default:
					startCountdown();
			}
		}
		if (!loadRep)
			rep = new Replay("na");
		super.create();
	}

	function schoolIntro(?dialogueBox:DialogueBox):Void
	{
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		add(black);

		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
		red.scrollFactor.set();

		var senpaiEvil:FlxSprite = new FlxSprite();
		senpaiEvil.frames = Paths.getSparrowAtlas('weeb/senpaiCrazy');
		senpaiEvil.animation.addByPrefix('idle', 'Senpai Pre Explosion', 24, false);
		senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * 6));
		senpaiEvil.scrollFactor.set();
		senpaiEvil.updateHitbox();
		senpaiEvil.screenCenter();

		if (SONG.song.toLowerCase() == 'roses' || SONG.song.toLowerCase() == 'thorns')
		{
			remove(black);

			if (SONG.song.toLowerCase() == 'thorns')
			{
				add(red);
			}
		}

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			black.alpha -= 0.15;

			if (black.alpha > 0)
			{
				tmr.reset(0.3);
			}
			else
			{
				if (dialogueBox != null)
				{
					inCutscene = true;

					if (SONG.song.toLowerCase() == 'thorns')
					{
						add(senpaiEvil);
						senpaiEvil.alpha = 0;
						new FlxTimer().start(0.3, function(swagTimer:FlxTimer)
						{
							senpaiEvil.alpha += 0.15;
							if (senpaiEvil.alpha < 1)
							{
								swagTimer.reset();
							}
							else
							{
								senpaiEvil.animation.play('idle');
								FlxG.sound.play(Paths.sound('Senpai_Dies'), 1, false, null, true, function()
								{
									remove(senpaiEvil);
									remove(red);
									FlxG.camera.fade(FlxColor.WHITE, 0.01, true, function()
									{
										add(dialogueBox);
									}, true);
								});
								new FlxTimer().start(3.2, function(deadTime:FlxTimer)
								{
									FlxG.camera.fade(FlxColor.WHITE, 1.6, false);
								});
							}
						});
					}
					else
					{
						add(dialogueBox);
					}
				}
				else
					startCountdown();

				remove(black);
			}
		});
	}

	var startTimer:FlxTimer;
	var perfectMode:Bool = false;

	function startCountdown():Void
	{
		inCutscene = false;

		generateStaticArrows(0);
		generateStaticArrows(1);

		talking = false;
		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;

		var swagCounter:Int = 0;

		startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			dad.dance();
			gf.dance();
			boyfriend.playAnim('idle');

			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ready', "set", "go"]);
			introAssets.set('school', ['weeb/pixelUI/ready-pixel', 'weeb/pixelUI/set-pixel', 'weeb/pixelUI/date-pixel']);
			introAssets.set('schoolEvil', ['weeb/pixelUI/ready-pixel', 'weeb/pixelUI/set-pixel', 'weeb/pixelUI/date-pixel']);

			var introAlts:Array<String> = introAssets.get('default');
			var altSuffix:String = "";

			for (value in introAssets.keys())
			{
				if (value == curStage)
				{
					introAlts = introAssets.get(value);
					altSuffix = '-pixel';
				}
			}

			switch (swagCounter)

			{
				case 0:
					FlxG.sound.play(Paths.sound('intro3' + altSuffix), 0.6);
				case 1:
					var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
					ready.scrollFactor.set();
					ready.updateHitbox();

					if (curStage.startsWith('school'))
						ready.setGraphicSize(Std.int(ready.width * daPixelZoom));

					ready.screenCenter();
					add(ready);
					FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							ready.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro2' + altSuffix), 0.6);
				case 2:
					var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
					set.scrollFactor.set();

					if (curStage.startsWith('school'))
						set.setGraphicSize(Std.int(set.width * daPixelZoom));

					set.screenCenter();
					add(set);
					FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							set.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro1' + altSuffix), 0.6);
				case 3:
					var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
					go.scrollFactor.set();

					if (curStage.startsWith('school'))
						go.setGraphicSize(Std.int(go.width * daPixelZoom));

					go.updateHitbox();

					go.screenCenter();
					add(go);
					FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							go.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('introGo' + altSuffix), 0.6);
				case 4:
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);
	}

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;

	function startSong():Void
	{
		startingSong = false;

		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;

		if (!paused)
		{
			FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		}

		FlxG.sound.music.onComplete = endSong;
		vocals.play();

		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		if (FlxG.save.data.songPosition)
		{
			remove(songPosBG);
			remove(songPosBar);
			remove(songName);

			songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
			songPosBG.screenCenter(X);
			songPosBG.scrollFactor.set();
			add(songPosBG);

			songPosBar = new FlxBar(songPosBG.x
				+ 4, songPosBG.y
				+ 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
				'songPositionBar', 0, songLength
				- 1000);
			songPosBar.numDivisions = 1000;
			songPosBar.scrollFactor.set();
			if (SONG.song.toLowerCase() == 'soulless')
			{
				songPosBar.createFilledBar(0xFF400000, 0xFF0E73AA);
				add(songPosBar);
			}
			else
			{
				songPosBar.createFilledBar(0xFF000000, 0xFFBFFF00);
				add(songPosBar);
			}

			var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - 20, songPosBG.y, 0, SONG.song, 16);
			songName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			songName.scrollFactor.set();
			add(songName);

			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
			songName.cameras = [camHUD];
		}

		// Song check real quick
		switch (curSong)
		{
			case 'Bopeebo' | 'Philly' | 'Blammed' | 'Cocoa' | 'Eggnog':
				allowedToHeadbang = true;
			default:
				allowedToHeadbang = false;
		}

		#if windows
		// Updating Discord Rich Presence (with Time Left)

		DiscordClient.changePresence((!auto ? Dif[FlxG.save.data.dif] : "Auto")
			+ " "
			+ detailsText
			+ " "
			+ SONG.song
			+ " ("
			+ storyDifficultyText
			+ ") "
			+ generateRanking(),
			"\n"
			+ (FlxG.save.data.dif != 0 ? "Acc: " + truncateFloat(accuracy, 2) + "% | " : "")
			+ (!FlxG.save.data.practice ? "Score: " + songScore : "Practice Mode")
			+ (FlxG.save.data.dif != 3 ? " | Misses: " + misses : "")
			+ (FlxG.save.data.dif == 1 ? " | Miss Clicks: " + dismisses : "")
			+ (FlxG.save.data.dif == 3 ? " | Percentage: 0%" : ""),
			iconRPC);
		#end
	}

	var debugNum:Int = 0;

	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());

		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		if (SONG.needsVoices)
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		FlxG.sound.list.add(vocals);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped
		for (section in noteData)
		{
			if (section.effects != null && FlxG.save.data.effects)
			{
				for (songEffects in section.effects)
				{
					var daStrumTime:Float = songEffects.time + FlxG.save.data.offset;
					if (daStrumTime < 0)
						daStrumTime = 0;

					var daQuantity:Float = songEffects.quantity;

					var duration:Float = songEffects.duration;

					if (duration < 0)
					{
						duration = 0;
					}

					var target:String = songEffects.target;

					var targetInt:Int = songEffects.targetInt;

					if (targetInt < 0)
					{
						targetInt = 0;
					}
					else if (targetInt > 6)
					{
						targetInt = 5;
					}

					var way:String = songEffects.way;

					var player:Bool = songEffects.player;

					var set:Bool = songEffects.set;

					var all:Bool = songEffects.all;

					var swagEffect:EffectParams = {
						time: daStrumTime,
						quantity: daQuantity,
						duration: duration,
						target: target,
						targetInt: targetInt,
						way: way,
						player: player,
						set: set,
						all: all
					};

					unspawnEffects.push(swagEffect);
				}
			}

			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0] + FlxG.save.data.offset;
				if (daStrumTime < 0)
					daStrumTime = 0;
				var daNoteData:Int = Std.int(songNotes[1] % 4);

				var gottaHitNote:Bool = section.mustHitSection;

				if (songNotes[1] > 3)
				{
					gottaHitNote = !section.mustHitSection;
				}

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote);
				swagNote.sustainLength = songNotes[2];
				swagNote.scrollFactor.set(0, 0);

				var susLength:Float = swagNote.sustainLength;

				susLength = susLength / (Conductor.stepCrochet);
				unspawnNotes.push(swagNote);

				for (susNote in 0...Math.floor(susLength))
				{
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

					var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + 2 * (Conductor.stepCrochet), daNoteData, oldNote, true);
					sustainNote.scrollFactor.set();
					unspawnNotes.push(sustainNote);

					sustainNote.mustPress = gottaHitNote;
				}

				swagNote.mustPress = gottaHitNote;
			}
			daBeats += 1;
		}

		trace(unspawnNotes.length);
		trace(unspawnEffects.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);
		unspawnEffects.sort(sortByShitTime);

		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	function sortByShitTime(Obj1:EffectParams, Obj2:EffectParams):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.time, Obj2.time);
	}

	private function generateStaticArrows(player:Int):Void
	{
		for (i in 0...4)
		{
			// FlxG.log.add(i);
			var babyArrow:FlxSprite = new FlxSprite(0, strumLine.y);

			switch (curStage)
			{
				case 'flying-stage':
					babyArrow.frames = Paths.getSparrowAtlas('business/sigmaUI/NOTE_assets', 'sigma');
					babyArrow.animation.addByPrefix('green', 'arrow static instance 1');
					babyArrow.animation.addByPrefix('blue', 'arrow static instance 2');
					babyArrow.animation.addByPrefix('purple', 'arrow static instance 3');
					babyArrow.animation.addByPrefix('red', 'arrow static instance 4');

					babyArrow.antialiasing = true;
					babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));

					switch (Math.abs(i))
					{
						case 0:
							babyArrow.x += Note.swagWidth * 0;
							babyArrow.animation.addByPrefix('static', 'arrow static instance 1');
							babyArrow.animation.addByPrefix('pressed', 'left press instance 1', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'left confirm instance 1', 24, false);
						case 1:
							babyArrow.x += Note.swagWidth * 1;
							babyArrow.animation.addByPrefix('static', 'arrow static instance 2');
							babyArrow.animation.addByPrefix('pressed', 'down press instance 1', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'down confirm instance 1', 24, false);
						case 2:
							babyArrow.x += Note.swagWidth * 2;
							babyArrow.animation.addByPrefix('static', 'arrow static instance 4');
							babyArrow.animation.addByPrefix('pressed', 'up press instance 1', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'up confirm instance 1', 24, false);
						case 3:
							babyArrow.x += Note.swagWidth * 3;
							babyArrow.animation.addByPrefix('static', 'arrow static instance 3');
							babyArrow.animation.addByPrefix('pressed', 'right press instance 1', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'right confirm instance 1', 24, false);
					}
				case 'school' | 'schoolEvil':
					Offset = 0;
					babyArrow.loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
					babyArrow.animation.add('green', [6]);
					babyArrow.animation.add('red', [7]);
					babyArrow.animation.add('blue', [5]);
					babyArrow.animation.add('purplel', [4]);

					babyArrow.setGraphicSize(Std.int(babyArrow.width * daPixelZoom));
					babyArrow.updateHitbox();
					babyArrow.antialiasing = false;

					switch (Math.abs(i))
					{
						case 0:
							babyArrow.x += Note.swagWidth * 0;
							babyArrow.animation.add('static', [0]);
							babyArrow.animation.add('pressed', [4, 8], 12, false);
							babyArrow.animation.add('confirm', [12, 16], 24, false);
						case 1:
							babyArrow.x += Note.swagWidth * 1;
							babyArrow.animation.add('static', [1]);
							babyArrow.animation.add('pressed', [5, 9], 12, false);
							babyArrow.animation.add('confirm', [13, 17], 24, false);
						case 2:
							babyArrow.x += Note.swagWidth * 2;
							babyArrow.animation.add('static', [2]);
							babyArrow.animation.add('pressed', [6, 10], 12, false);
							babyArrow.animation.add('confirm', [14, 18], 12, false);
						case 3:
							babyArrow.x += Note.swagWidth * 3;
							babyArrow.animation.add('static', [3]);
							babyArrow.animation.add('pressed', [7, 11], 12, false);
							babyArrow.animation.add('confirm', [15, 19], 24, false);
					}

				default:
					babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets');
					babyArrow.animation.addByPrefix('green', 'arrowUP');
					babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
					babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
					babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

					babyArrow.antialiasing = true;
					babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));

					switch (Math.abs(i))
					{
						case 0:
							babyArrow.x += Note.swagWidth * 0;
							babyArrow.animation.addByPrefix('static', 'arrowLEFT');
							babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);

						case 1:
							babyArrow.x += Note.swagWidth * 1;
							babyArrow.animation.addByPrefix('static', 'arrowDOWN');
							babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);

						case 2:
							babyArrow.x += Note.swagWidth * 2;
							babyArrow.animation.addByPrefix('static', 'arrowUP');
							babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);

						case 3:
							babyArrow.x += Note.swagWidth * 3;
							babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
							babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
					}
			}

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			if (!isStoryMode)
			{
				babyArrow.y -= 10;
				babyArrow.alpha = 0;
				// FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}

			babyArrow.ID = i;

			if (player == 1)
			{
				playerStrums.add(babyArrow);
				initialPositionX[player] = ((FlxG.width / 16) * 11);
				babyArrow.x = ((FlxG.width / 16)) * 11 + (Note.swagWidth * Math.abs(i)) - Note.swagWidth * 2.5;

				for (i in 0...4)
				{
					currentPositionX[i + 4] = initialPositionX[player];
				}

				// FlxTween.num(angleC[i + 4], angleC[i + 4] + 360, 3, {ease: FlxEase.linear, type: PINGPONG}, function(s:Float){angleC[i + 4]=s;});
			}

			if (player == 0)
			{
				enemyStrums.add(babyArrow);
				initialPositionX[player] = ((FlxG.width / 16) * 3);
				babyArrow.x = ((FlxG.width / 16) * 3) + (Note.swagWidth * Math.abs(i)) - Note.swagWidth * 2.5;

				for (i in 0...4)
				{
					currentPositionX[i] = initialPositionX[player];
				}

				// FlxTween.num(angleC[i], angleC[i] + 360, 3, {ease: FlxEase.linear, type: PINGPONG}, function(s:Float){angleC[i]=s;});
			}

			babyArrow.animation.play('static');

			noteWidth = babyArrow.width;

			strumLineNotes.add(babyArrow);
		}
	}

	function tweenCamIn():Void
	{
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}
			// DiscordClient.changePresence((!auto ? Dif[FlxG.save.data.dif] : "Auto" ) + " " + detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + generateRanking(), "\n" + (FlxG.save.data.dif!=0 ? "Acc: " + truncateFloat(accuracy, 2) + "% | " : "") + (!FlxG.save.data.practice ?  "Score: " + songScore : "Practice Mode") + (FlxG.save.data.dif!=3 ? " | Misses: " + misses : "") + (FlxG.save.data.dif==1 ? " | Miss Clicks: " + dismisses : "") + (FlxG.save.data.dif==3 ? " | Percentage: " + truncateFloat((songTime/songLength)*100, 0) + "%" : ""), iconRPC);
			#if windows
			DiscordClient.changePresence("PAUSED on "
				+ SONG.song
				+ " ("
				+ storyDifficultyText
				+ " "
				+ (!auto ? Dif[FlxG.save.data.dif] : "Auto")
				+ ") "
				+ generateRanking(),
				(FlxG.save.data.dif != 0 ? "Acc: " + truncateFloat(accuracy, 2) + "% | " : "")
				+ (!FlxG.save.data.practice ? "Score: " + songScore : "Practice Mode")
				+ (FlxG.save.data.dif != 3 ? " | Misses: " + misses : "")
				+ (FlxG.save.data.dif == 3 ? " | Percentage: " + truncateFloat((songTime / songLength) * 100, 0) + "%" : "")
				+ (FlxG.save.data.dif == 1 ? " | Missclick: " + dismisses : ""),
				iconRPC);
			#end
			if (!startTimer.finished)
				startTimer.active = false;
		}
		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (!startTimer.finished)
				startTimer.active = true;
			paused = false;

			#if windows
			if (startTimer.finished)
			{
				DiscordClient.changePresence((!auto ? Dif[FlxG.save.data.dif] : "Auto")
					+ " "
					+ detailsText
					+ " "
					+ SONG.song
					+ " ("
					+ storyDifficultyText
					+ ") "
					+ generateRanking(),
					"\n"
					+ (FlxG.save.data.dif != 0 ? "Acc: " + truncateFloat(accuracy, 2) + "% | " : "")
					+ (!FlxG.save.data.practice ? "Score: " + songScore : "Practice Mode")
					+ (FlxG.save.data.dif != 3 ? " | Misses: " + misses : "")
					+ (FlxG.save.data.dif == 1 ? " | Miss Clicks: " + dismisses : "")
					+ (FlxG.save.data.dif == 3 ? " | Percentage: " + truncateFloat((songTime / songLength) * 100, 0) + "%" : ""),
					iconRPC, true, songLength
					- Conductor.songPosition);
			}
			else
			{
				DiscordClient.changePresence((!auto ? Dif[FlxG.save.data.dif] : "Auto")
					+ " "
					+ detailsText
					+ " "
					+ SONG.song
					+ " ("
					+ storyDifficultyText
					+ ") "
					+ generateRanking(),
					"\n"
					+ (FlxG.save.data.dif != 0 ? "Acc: " + truncateFloat(accuracy, 2) + "% | " : "")
					+ (!FlxG.save.data.practice ? "Score: " + songScore : "Practice Mode")
					+ (FlxG.save.data.dif != 3 ? " | Misses: " + misses : "")
					+ (FlxG.save.data.dif == 1 ? " | Miss Clicks: " + dismisses : "")
					+ (FlxG.save.data.dif == 3 ? " | Percentage: " + truncateFloat((songTime / songLength) * 100, 0) + "%" : ""),
					iconRPC);
			}
			#end
		}

		super.closeSubState();
	}

	function resyncVocals():Void
	{
		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();

		#if windows
		DiscordClient.changePresence((!auto ? Dif[FlxG.save.data.dif] : "Auto")
			+ " "
			+ detailsText
			+ " "
			+ SONG.song
			+ " ("
			+ storyDifficultyText
			+ ") "
			+ generateRanking(),
			"\n"
			+ (FlxG.save.data.dif != 0 ? "Acc: " + truncateFloat(accuracy, 2) + "% | " : "")
			+ (!FlxG.save.data.practice ? "Score: " + songScore : "Practice Mode")
			+ (FlxG.save.data.dif != 3 ? " | Misses: " + misses : "")
			+ (FlxG.save.data.dif == 1 ? " | Miss Clicks: " + dismisses : "")
			+ (FlxG.save.data.dif == 3 ? " | Percentage: " + truncateFloat((songTime / songLength) * 100, 0) + "%" : ""),
			iconRPC);
		#end
	}

	private var paused:Bool = false;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;

	function truncateFloat(number:Float, precision:Int):Float
	{
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round(num) / Math.pow(10, precision);
		return num;
	}

	function generateRanking():String
	{
		var ranking:String = "N/A";

		if (misses == 0 && bads == 0 && shits == 0 && goods == 0) // Marvelous (SICK) Full Combo
			ranking = "(MFC)";
		else if (misses == 0 && bads == 0 && shits == 0 && goods >= 1) // Good Full Combo (Nothing but Goods & Sicks)
			ranking = "(GFC)";
		else if (misses == 0) // Regular FC
			ranking = "(FC)";
		else if (misses < 10) // Single Digit Combo Breaks
			ranking = "(SDCB)";
		else
			ranking = "(Clear)";

		// WIFE TIME :)))) (based on Wife3)

		var wifeConditions:Array<Bool> = [
			accuracy >= 99.9935, // AAAAA
			accuracy >= 99.980, // AAAA:
			accuracy >= 99.970, // AAAA.
			accuracy >= 99.955, // AAAA
			accuracy >= 99.90, // AAA:
			accuracy >= 99.80, // AAA.
			accuracy >= 99.70, // AAA
			accuracy >= 99, // AA:
			accuracy >= 96.50, // AA.
			accuracy >= 93, // AA
			accuracy >= 90, // A:
			accuracy >= 85, // A.
			accuracy >= 80, // A
			accuracy >= 70, // B
			accuracy >= 60, // C
			accuracy < 60 // D
		];

		for (i in 0...wifeConditions.length)
		{
			var b = wifeConditions[i];
			if (b)
			{
				switch (i)
				{
					case 0:
						ranking += " AAAAA";
					case 1:
						ranking += " AAAA:";
					case 2:
						ranking += " AAAA.";
					case 3:
						ranking += " AAAA";
					case 4:
						ranking += " AAA:";
					case 5:
						ranking += " AAA.";
					case 6:
						ranking += " AAA";
					case 7:
						ranking += " AA:";
					case 8:
						ranking += " AA.";
					case 9:
						ranking += " AA";
					case 10:
						ranking += " A:";
					case 11:
						ranking += " A.";
					case 12:
						ranking += " A";
					case 13:
						ranking += " B";
					case 14:
						ranking += " C";
					case 15:
						ranking += " D";
				}
				break;
			}
		}

		if (accuracy == 0)
			ranking = "N/A";

		return ranking;
	}

	public static var songRate = 1.5;

	override public function update(elapsed:Float)
	{
		#if !debug
		perfectMode = false;
		#end

		#if windows
		// Updating Discord Rich Presence (with Time Left)

		DiscordClient.changePresence((!auto ? Dif[FlxG.save.data.dif] : "Auto")
			+ " "
			+ detailsText
			+ " "
			+ SONG.song
			+ " ("
			+ storyDifficultyText
			+ ") "
			+ generateRanking(),
			"\n"
			+ (FlxG.save.data.dif != 0 ? "Acc: " + truncateFloat(accuracy, 2) + "% | " : "")
			+ (!FlxG.save.data.practice ? "Score: " + songScore : "Practice Mode")
			+ (FlxG.save.data.dif != 3 ? " | Misses: " + misses : "")
			+ (FlxG.save.data.dif == 1 ? " | Miss Clicks: " + dismisses : "")
			+ (FlxG.save.data.dif == 3 ? " | Percentage: " + truncateFloat((songTime / songLength) * 100, 0) + "%" : ""),
			iconRPC, true, songLength
			- Conductor.songPosition);
		#end

		if (!paused)
		{
			// angleinc(5, 4);

			// angledir(300);

			// anglecirc(500, 0);
			// anglecirc(500, 1);
			// anglecirc(500, 2);
			// anglecirc(500, 3);

			/*
				vibe(.63, -60, 0);
				vibe(.63, -60, 1);
			 */
		}
		/*setVar('songPos',Conductor.songPosition);
			setVar('hudZoom', camHUD.zoom);
			setVar('cameraZoom',FlxG.camera.zoom);
			callLua('update', [elapsed]);
		 */
		/*for (i in 0...strumLineNotes.length) {
			var member = strumLineNotes.members[i];
			member.x = getVar("strum" + i + "X", "float");
			member.y = getVar("strum" + i + "Y", "float");
			member.angle = getVar("strum" + i + "Angle", "float");
		}*/
		/*if (getVar("showOnlyStrums",'bool'))
			{
				healthBarBG.visible = false;
				kadeEngineWatermark.visible = false;
				healthBar.visible = false;
				iconP1.visible = false;
				iconP2.visible = false;
				scoreTxt.visible = false;
			}
			else
			{
				healthBarBG.visible = true;
				kadeEngineWatermark.visible = true;
				healthBar.visible = true;
				iconP1.visible = true;
				iconP2.visible = true;
				scoreTxt.visible = true;
		}*/
		/*var p1 = getVar("strumLine1Visible",'bool');
			var p2 = getVar("strumLine2Visible",'bool'); */
		/*for (i in 0...4)
			{
				strumLineNotes.members[i].visible = p1;
				if (i <= playerStrums.length)
					playerStrums.members[i].visible = p2;
		}*/

		if (currentFrames == FlxG.save.data.fpsCap)
		{
			for (i in 0...notesHitArray.length)
			{
				var cock:Date = notesHitArray[i];
				if (cock != null)
					if (cock.getTime() + 2000 < Date.now().getTime())
						notesHitArray.remove(cock);
			}
			nps = Math.floor(notesHitArray.length / 2);
			currentFrames = 0;
		}
		else
			currentFrames++;

		if (shakingNotes)
		{
			var currentBeat = (Conductor.songPosition / 1000) * (SONG.bpm / 60);
			for (i in 0...8)
			{
				strumLineNotes.members[i].x = strumLineNotes.members[i].x + 8 * Math.sin((currentBeat + i * 0.25) * Math.PI);
				strumLineNotes.members[i].y = strumLineNotes.members[i].y + 8 * Math.cos((currentBeat + i * 0.25) * Math.PI);
			}
		}

		if (FlxG.keys.justPressed.NINE)
		{
			if (iconP1.animation.curAnim.name == 'bf-old')
				iconP1.animation.play(SONG.player1);
			else
				iconP1.animation.play('bf-old');
		}

		switch (curStage)
		{
			case 'philly':
				if (trainMoving)
				{
					trainFrameTiming += elapsed;

					if (trainFrameTiming >= 1 / 24)
					{
						updateTrainPos();
						trainFrameTiming = 0;
					}
				}
				// phillyCityLights.members[curLight].alpha -= (Conductor.crochet / 1000) * FlxG.elapsed;
		}

		super.update(elapsed);

		if (!offsetTesting)
		{
			if (FlxG.save.data.accuracyDisplay)
			{
				switch (FlxG.save.data.dif)
				{
					case 1:
						scoreTxt.text = (FlxG.save.data.npsDisplay ? "NPS: " + nps + " | " : "")
							+ "Score:"
							+ (Conductor.safeFrames != 10 ? songScore + " (" + songScoreDef + ")" : "" + songScore)
							+ " | Combo Breaks:"
							+ misses
							+ " | Fails:"
							+ dismisses
							+ " | Accuracy:"
							+ truncateFloat(accuracy, 2)
							+ "% | "
							+ generateRanking();
					case 3:
						scoreTxt.text = (FlxG.save.data.npsDisplay ? "NPS: " + nps + " | " : "")
							+ "Score:"
							+ (Conductor.safeFrames != 10 ? songScore + " (" + songScoreDef + ")" : "" + songScore)
							+ " | Accuracy:"
							+ truncateFloat(accuracy, 2)
							+ "% | "
							+ generateRanking()
							+ " | Percentage:"
							+ truncateFloat((songTime / songLength) * 100, 0)
							+ "%";

					default:
						scoreTxt.text = (FlxG.save.data.npsDisplay ? "NPS: " + nps + " | " : "")
							+ "Score:"
							+ (Conductor.safeFrames != 10 ? songScore + " (" + songScoreDef + ")" : "" + songScore)
							+ " | Combo Breaks:"
							+ misses
							+ " | Accuracy:"
							+ truncateFloat(accuracy, 2)
							+ "% | "
							+ generateRanking();
				}
			}
			else
			{
				scoreTxt.text = (FlxG.save.data.npsDisplay ? "NPS: " + nps + " | " : "") + "Score:" + songScore;
			}
		}
		else
		{
			scoreTxt.text = "Suggested Offset: " + offsetTest;
		}

		if (scoreTxt.x != healthBarBG.x + healthBarBG.width / 2 - scoreTxt.width / 2)
		{
			scoreTxt.x = healthBarBG.x + healthBarBG.width / 2 - scoreTxt.width / 2;
		}

		if (FlxG.keys.pressed.SHIFT)
		{
			if (FlxG.keys.justPressed.TAB)
			{
				if (!auto)
				{
					auto = true;
					FlxTween.tween(autoTxt, {alpha: .4}, 1, {ease: FlxEase.quartInOut});
					trace("auto");
				}
				else
				{
					auto = false;
					FlxTween.tween(autoTxt, {alpha: 0}, 1, {ease: FlxEase.quartInOut});

					#if !debug
					FlxG.resetState();
					#end
				}
			}
		}

		/*if (FlxG.keys.justPressed.SPACE){
			new Effect(100, 1, 'y', 0, 'backInOut' , true, false, true);
			new Effect(100, 1, 'y', 0, 'backInOut' , false, false, true);

		} //*/

		if (FlxG.keys.justPressed.SEVEN)
		{
			#if windows
			DiscordClient.changePresence("Chart Editor", null, null, true);
			#end
			FlxG.switchState(new ChartingState());
		}

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);
		/*
			iconP1.setGraphicSize(Std.int(FlxMath.lerp(150, iconP1.width, 0.50)));
			iconP2.setGraphicSize(Std.int(FlxMath.lerp(150, iconP2.width, 0.50)));

			iconP1.updateHitbox();
			iconP2.updateHitbox();
		 */

		var iconOffset:Int = 26;

		if (lerphealth != health)
		{
			lerphealth = FlxMath.lerp(lerphealth, health, .2);
			if (Math.abs(lerphealth - health) < .01)
			{
				lerphealth = health;
			}
		}

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset) + .707 * addPulse;
		iconP2.x = healthBar.x
			+ (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01))
			- (iconP2.width - iconOffset)
			- Math.sin(.7853) * addPulse;

		iconP1.y = healthBar.y - (iconP1.height / 2) + .707 * addPulse;
		if (SONG.song.toLowerCase() == 'soulless')
		{
			iconP2.y = healthBar.y - (iconP2.height / 1.5) + .707 * addPulse;
		}
		else
		{
			iconP2.y = healthBar.y - (iconP2.height / 2) + .707 * addPulse;
		}

		if (health > 2)
			health = 2;

		if (healthBar.percent < 20)
			iconP1.animation.curAnim.curFrame = 1;
		else
			iconP1.animation.curAnim.curFrame = 0;

		if (healthBar.percent > 80)
			iconP2.animation.curAnim.curFrame = 1;
		else
			iconP2.animation.curAnim.curFrame = 0;

		/* if (FlxG.keys.justPressed.NINE)
			FlxG.switchState(new Charting()); */

		#if debug
		if (FlxG.keys.justPressed.EIGHT)
			FlxG.switchState(new AnimationDebug(SONG.player2));
		#end

		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}
		else
		{
			// Conductor.songPosition = FlxG.sound.music.time;
			Conductor.songPosition += FlxG.elapsed * 1000;
			/*@:privateAccess
				{
					FlxG.sound.music._channel.
			}*/
			songPositionBar = Conductor.songPosition;

			if (!paused)
			{
				songTime += FlxG.game.ticks - previousFrameTime;
				previousFrameTime = FlxG.game.ticks;

				// Interpolation type beat
				if (Conductor.lastSongPos != Conductor.songPosition)
				{
					songTime = (songTime + Conductor.songPosition) / 2;
					Conductor.lastSongPos = Conductor.songPosition;
					// Conductor.songPosition += FlxG.elapsed * 1000;
					// trace('MISSED FRAME');
				}
			}

			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null)
		{
			// Make sure Girlfriend cheers only for certain songs
			if (allowedToHeadbang)
			{
				// Don't animate GF if something else is already animating her (eg. train passing)
				if (gf.animation.curAnim.name == 'danceLeft'
					|| gf.animation.curAnim.name == 'danceRight'
					|| gf.animation.curAnim.name == 'idle')
				{
					// Per song treatment since some songs will only have the 'Hey' at certain times
					switch (curSong)
					{
						case 'Philly':
							{
								// General duration of the song
								if (curBeat < 250)
								{
									// Beats to skip or to stop GF from cheering
									if (curBeat != 184 && curBeat != 216)
									{
										if (curBeat % 16 == 8)
										{
											// Just a garantee that it'll trigger just once
											if (!triggeredAlready)
											{
												gf.playAnim('cheer');
												triggeredAlready = true;
											}
										}
										else
											triggeredAlready = false;
									}
								}
							}
						case 'Bopeebo':
							{
								// Where it starts || where it ends
								if (curBeat > 5 && curBeat < 130)
								{
									if (curBeat % 8 == 7)
									{
										if (!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}
									else
										triggeredAlready = false;
								}
							}
						case 'Blammed':
							{
								if (curBeat > 30 && curBeat < 190)
								{
									if (curBeat < 90 || curBeat > 128)
									{
										if (curBeat % 4 == 2)
										{
											if (!triggeredAlready)
											{
												gf.playAnim('cheer');
												triggeredAlready = true;
											}
										}
										else
											triggeredAlready = false;
									}
								}
							}
						case 'Cocoa':
							{
								if (curBeat < 170)
								{
									if (curBeat < 65 || curBeat > 130 && curBeat < 145)
									{
										if (curBeat % 16 == 15)
										{
											if (!triggeredAlready)
											{
												gf.playAnim('cheer');
												triggeredAlready = true;
											}
										}
										else
											triggeredAlready = false;
									}
								}
							}
						case 'Eggnog':
							{
								if (curBeat > 10 && curBeat != 111 && curBeat < 220)
								{
									if (curBeat % 8 == 7)
									{
										if (!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}
									else
										triggeredAlready = false;
								}
							}
					}
				}
			}

			if (camFollow.x != dad.getMidpoint().x + 150 && !PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
			{
				camFollow.setPosition(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
				// camFollow.setPosition(lucky.getMidpoint().x - 120, lucky.getMidpoint().y + 210);

				switch (dad.curCharacter)
				{
					case 'mom':
						camFollow.y = dad.getMidpoint().y;
					case 'senpai':
						camFollow.y = dad.getMidpoint().y - 430;
						camFollow.x = dad.getMidpoint().x - 100;
					case 'senpai-angry':
						camFollow.y = dad.getMidpoint().y - 430;
						camFollow.x = dad.getMidpoint().x - 100;
				}

				if (dad.curCharacter == 'mom')
					vocals.volume = 1;

				if (SONG.song.toLowerCase() == 'tutorial')
				{
					tweenCamIn();
				}
			}

			if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && camFollow.x != boyfriend.getMidpoint().x - 100)
			{
				camFollow.setPosition(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);

				switch (curStage)
				{
					case 'limo':
						camFollow.x = boyfriend.getMidpoint().x - 300;
					case 'mall':
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'school':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'schoolEvil':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 200;
				}

				if (SONG.song.toLowerCase() == 'tutorial')
				{
					FlxTween.tween(FlxG.camera, {zoom: 1}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
				}
			}
		}

		if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);
		}

		if (focus)
		{
			FlxG.camera.zoom = FlxMath.lerp(1.5, FlxG.camera.zoom, 0.75);
		}
		else
		{
			if (FlxG.camera.zoom != defaultCamZoom)
			{
				FlxG.camera.zoom = FlxMath.lerp(FlxG.camera.zoom, defaultCamZoom, 1.25);
			}
		}

		percentage = Std.int((songTime / songLength) * 100);

		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);
		if (loadRep) // rep debug
		{
			FlxG.watch.addQuick('rep rpesses', repPresses);
			FlxG.watch.addQuick('rep releases', repReleases);
			// FlxG.watch.addQuick('Queued',inputsQueued);
		}

		if (curSong == 'Fresh')
		{
			switch (curBeat)
			{
				case 16:
					camZooming = true;
					gfSpeed = 2;
				case 48:
					gfSpeed = 1;
				case 80:
					gfSpeed = 2;
				case 112:
					gfSpeed = 1;
				case 163:
					// FlxG.sound.music.stop();
					// FlxG.switchState(new TitleState());
			}
		}

		if (curSong == 'Bopeebo')
		{
			switch (curBeat)
			{
				case 128, 129, 130:
					vocals.volume = 0;
					// FlxG.sound.music.stop();
					// FlxG.switchState(new PlayState());
			}
		}

		if (health <= 0 && !FlxG.save.data.practice)
		{
			boyfriend.stunned = true;

			persistentUpdate = false;
			persistentDraw = false;
			paused = true;

			vocals.stop();
			FlxG.sound.music.stop();

			openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));

			#if windows
			// Game Over doesn't get his own variable because it's only used here

			DiscordClient.changePresence("GAME OVER -- "
				+ SONG.song
				+ " ("
				+ storyDifficultyText
				+ " "
				+ (!auto ? Dif[FlxG.save.data.dif] : "Auto")
				+ ") "
				+ generateRanking(),
				(FlxG.save.data.dif != 0 ? "Acc: " + truncateFloat(accuracy, 2) + "% | " : "")
				+ "Score: "
				+ songScore
				+ (FlxG.save.data.dif != 3 ? " | Misses: " + misses : "")
				+ (FlxG.save.data.dif == 3 ? " | Percentage: " + truncateFloat((songTime / songLength) * 100, 0) + "%" : "")
				+ (FlxG.save.data.dif == 1 ? " | Missclick: " + dismisses : ""),
				iconRPC);
			#end

			// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}

		if (SONG.notes[Std.int(curStep / 16)] != null)
		{
			lerpSpawn *= SONG.speed;

			lerpSpawn = FlxMath.lerp(lerpSpawn,
				(Std.isOfType(SONG.notes[Std.int(curStep / 16)].spawn, Float) ? SONG.notes[Std.int(curStep / 16)].spawn : 2000), .1);

			lerpSpawn /= SONG.speed;
		}

		if (unspawnNotes[0] != null)
		{
			if (unspawnNotes[0].strumTime - Conductor.songPosition < lerpSpawn)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.add(dunceNote);

				/*var index:Int = unspawnNotes.indexOf(dunceNote);
					trace(index); */
				unspawnNotes.splice(0, 1);
			}
		}

		if (unspawnEffects[0] != null)
		{
			if (unspawnEffects[0].time - Conductor.songPosition < 0)
			{
				var dunceEffect:EffectParams = unspawnEffects[0];

				new Effect(dunceEffect.quantity, dunceEffect.duration, dunceEffect.target, dunceEffect.targetInt, dunceEffect.way, dunceEffect.player,
					dunceEffect.set, dunceEffect.all);

				var index:Int = unspawnEffects.indexOf(dunceEffect);
				unspawnEffects.splice(index, 1);
			}
		}

		for (i in 0...8)
		{
			if (strumLineNotes.members[i] != null)
			{
				if (strumLineNotes.members[i].angle != angle[i] && strumLineNotes.members[i].animation.curAnim.name != "confirm")
				{
					strumLineNotes.members[i].angle = angle[i];
				}

				if (alpha[i] < 0)
				{
					strumLineNotes.members[i].alpha = 0;
				}
				else if (alpha[i] > 1)
				{
					strumLineNotes.members[i].alpha = 1;
				}
				else
				{
					strumLineNotes.members[i].alpha = alpha[i] * (strumLineNotes.members[i].animation.curAnim.name != 'static' ? 1 : .8);
				}

				if (strumLineNotes.members[i].animation.curAnim.name == "confirm"
					&& curStage != "school"
					&& curStage != "schoolEvil"
					&& strumLineNotes.members[i].angle != 0)
				{
					strumLineNotes.members[i].angle = 0;
				}

				// if(i < 4){
				strumLineNotes.members[i].x = currentPositionX[i] + Math.cos(angleD[i] * (Math.PI / 180)) * (orbit[i]);
				strumLineNotes.members[i].y = currentPositionY[i] + Math.sin(angleD[i] * (Math.PI / 180)) * (orbit[i]);

				// }else{
				//	strumLineNotes.members[i].x = currentPositionX[i] + Math.cos(angleD[i]*(Math.PI/180))*(orbit[i]);
				//	strumLineNotes.members[i].y = currentPositionY[i] + Math.sin(angleD[i]*(Math.PI/180))*(orbit[i]);

				// }
			}
		}

		if (generatedMusic)
		{
			notes.forEachAlive(function(daNote:Note)
			{
				if (curStage == "school" || curStage == "schoolEvil")
				{
					Offset = 0;
				}

				if (!daNote.tooLate)
				{
					daNote.visible = true;
					daNote.active = true;
				}
				else
				{
					daNote.visible = false;
					daNote.active = false;
				}

				if (daNote.mustPress)
				{
					if (!bfstartdancin.active && !auto)
					{
						bfstartdancin.start(1.1, function(bfstartdancin:FlxTimer)
						{
							playerdance = true;
						}, 1);
					}

					if (auto && daNote.wasGoodHit)
					{
						if (bfUnpressTime.active)
						{
							bfUnpressTime.active = false;
						}

						bfUnpress = false;

						daNote.wasGoodHit = false;
						if (!bfstartdancin.active)
						{
							bfstartdancin.start(.6, function(bfstartdancin:FlxTimer)
							{
								playerdance = true;
							}, 1);
						}
						goodNoteHit(daNote);
					}
				}

				if (!daNote.mustPress && daNote.wasGoodHit)
				{
					if (dadUnpressTime.active)
					{
						dadUnpressTime.active = false;
					}

					dadUnpress = false;

					if (!dadstartdancin.active)
					{
						dadstartdancin.start(.6, function(dadstartdancin:FlxTimer)
						{
							daddance = true;
						}, 1);
					}

					if (SONG.song != 'Tutorial')
						camZooming = true;

					var altAnim:String = "";

					if (SONG.notes[Math.floor(curStep / 16)] != null)
					{
						if (SONG.notes[Math.floor(curStep / 16)].altAnim)
							altAnim = '-alt';
					}

					/*trace(enemyStrums.members[0].offset.x-Offset*Math.cos( angle*(Math.PI/180) ), Offset*Math.cos(angle*(Math.PI/180) ), enemyStrums.members[0].offset.y-Offset*Math.cos(angle*(Math.PI/180) ), Offset*Math.cos(angle*(Math.PI/180) ));
						trace(enemyStrums.members[0].offset.x-Offset, Offset, enemyStrums.members[0].offset.y-Offset, Offset); */

					switch (Math.abs(daNote.noteData))
					{
						case 2:
							dad.playAnim('singUP' + altAnim, true);
							enemyStrums.members[2].animation.play('confirm');
							// enemyStrums.members[2].offset.set(-13, -13);

							enemyStrums.members[2].centerOffsets();
							enemyStrums.members[2].offset.set(enemyStrums.members[2].offset.x - Offset, enemyStrums.members[2].offset.y - Offset);

						// enemyStrums.members[2].offset.set(enemyStrums.members[2].offset.x - (Offset + (Math.cos(angle)*Math.cos(45)+Math.sin(angle)*Math.sin(45))*noteWidth/2 ), enemyStrums.members[2].offset.y - (Offset + (Math.sin(angle)*Math.cos(45) - Math.sin(45)*Math.cos(angle))*noteWidth/2 )   );

						case 3:
							dad.playAnim('singRIGHT' + altAnim, true);
							enemyStrums.members[3].animation.play('confirm');

							// enemyStrums.members[3].offset.x=-noteWidth;
							// enemyStrums.members[3].offset.y=-noteWidth;

							enemyStrums.members[3].centerOffsets();
							enemyStrums.members[3].offset.set(enemyStrums.members[3].offset.x - Offset, enemyStrums.members[3].offset.y - Offset);

						// enemyStrums.members[3].offset.set(enemyStrums.members[3].offset.x-Offset*Math.cos((angle+45)*(Math.PI/180) ), enemyStrums.members[3].offset.y-Offset*Math.sin((angle+45)*(Math.PI/180) ));

						case 1:
							dad.playAnim('singDOWN' + altAnim, true);
							enemyStrums.members[1].animation.play('confirm');
							// enemyStrums.members[1].offset.x=-noteWidth;
							// enemyStrums.members[1].offset.y=-noteWidth;

							enemyStrums.members[1].centerOffsets();
							enemyStrums.members[1].offset.set(enemyStrums.members[1].offset.x - Offset, enemyStrums.members[1].offset.y - Offset);

						// enemyStrums.members[1].offset.set(enemyStrums.members[1].offset.x-Offset*Math.cos((angle+45)*(Math.PI/180) ), enemyStrums.members[1].offset.y-Offset*Math.sin((angle+45)*(Math.PI/180) ));

						case 0:
							dad.playAnim('singLEFT' + altAnim, true);
							enemyStrums.members[0].animation.play('confirm');
							// enemyStrums.members[0].offset.x=-noteWidth;
							// enemyStrums.members[0].offset.y=-noteWidth;

							enemyStrums.members[0].centerOffsets();
							enemyStrums.members[0].offset.set(enemyStrums.members[0].offset.x - Offset, enemyStrums.members[0].offset.y - Offset);

							// enemyStrums.members[0].offset.set(enemyStrums.members[0].offset.x-Offset*Math.cos((angle+45)*(Math.PI/180) ), enemyStrums.members[0].offset.y-Offset*Math.sin((angle+45)*(Math.PI/180) ));
					}

					dad.holdTimer = 0;

					if (SONG.needsVoices)
						vocals.volume = 1;

					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}

				if (daNote.mustPress)
				{
					daNote.y = playerStrums.members[daNote.noteData].y
						- (Math.cos(angleC[daNote.noteData + 4] * Math.PI / 180) * ((Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(SONG.speed,
							2))));

					daNote.x = playerStrums.members[daNote.noteData].x
						- (Math.sin(angleC[daNote.noteData + 4] * Math.PI / 180) * ((Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(SONG.speed,
							2))));

					if (daNote.active)
					{
						if (!daNote.isDying)
						{
							if (!daNote.isSustainNote)
							{
								daNote.alpha = alpha[daNote.noteData + 4];
							}
							else
							{
								daNote.alpha = alpha[daNote.noteData + 4] * .6;
							}
						}

						if (daNote.animation != null)
						{
							if (!daNote.isSustainNote)
							{
								daNote.angle = angle[daNote.noteData + 4];
							}
							else
							{
								daNote.angle = -angleC[daNote.noteData + 4];
							}
						}
					}

					if (daNote.isSustainNote && curStage != 'school' && curStage != 'schoolEvil')
					{
						daNote.x += Math.cos(-angleC[daNote.noteData + 4] * (Math.PI / 180)) * noteWidth / 2;

						daNote.x -= Math.cos(-angleC[daNote.noteData + 4] * (Math.PI / 180)) * 17.34;

						daNote.y += Math.sin(-angleC[daNote.noteData + 4] * (Math.PI / 180)) * noteWidth / 2;

						daNote.y -= Math.sin(-angleC[daNote.noteData + 4] * (Math.PI / 180)) * 17.34;
					}
					else if (daNote.isSustainNote)
					{
						daNote.x += Math.abs(Math.cos(-angleC[daNote.noteData + 4] * (Math.PI / 180)) * noteWidth / 2);

						daNote.x -= Math.abs(Math.cos(-angleC[daNote.noteData + 4] * (Math.PI / 180)) * 19);

						daNote.y += Math.abs(Math.sin(-angleC[daNote.noteData + 4] * (Math.PI / 180)) * noteWidth / 2);

						daNote.y -= Math.abs(Math.sin(-angleC[daNote.noteData + 4] * (Math.PI / 180)) * 19);

						// daNote.x += Math.sin(-angleC[daNote.noteData + 4] * (Math.PI/180)) * (SONG.speed - 1) * ((44 * holdNoteHieght) - 33);
						// daNote.y -= Math.cos(-angleC[daNote.noteData + 4] * (Math.PI/180)) * (SONG.speed - 1) * ((44 * holdNoteHieght) - 33);
					}

					if (daNote.animation != null && curStage != 'school' && curStage != 'schoolEvil')
					{
						if (daNote.animation.curAnim.name.endsWith('end'))
						{
							daNote.x += Math.sin(-angleC[daNote.noteData + 4] * (Math.PI / 180)) * ((44 * holdNoteHieght) - 33);
							daNote.y -= Math.cos(-angleC[daNote.noteData + 4] * (Math.PI / 180)) * ((44 * holdNoteHieght) - 33);
						}
					}

					if (daNote.strumTime - Conductor.timeBpm > Conductor.songPosition
						&& daNote.strumTime - (100 + Conductor.timeBpm) < Conductor.songPosition && !daNote.isSustainNote && auto)
					{
						PlayState.bfUnpress = true;
					}

					// */
				}
				else
				{
					if (daNote.strumTime - Conductor.timeBpm > Conductor.songPosition
						&& daNote.strumTime - (100 + Conductor.timeBpm) < Conductor.songPosition && !daNote.isSustainNote)
					{
						PlayState.dadUnpress = true;
					}

					daNote.y = enemyStrums.members[daNote.noteData].y
						- (Math.cos(angleC[daNote.noteData] * Math.PI / 180) * ((Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(SONG.speed,
							2))));

					daNote.x = enemyStrums.members[daNote.noteData].x
						- (Math.sin(angleC[daNote.noteData] * Math.PI / 180) * ((Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(SONG.speed,
							2))));

					if (daNote.active)
					{
						// if(! daNote.tooLate){

						if (!daNote.isSustainNote)
						{
							daNote.alpha = alpha[daNote.noteData];
						}
						else
						{
							daNote.alpha = alpha[daNote.noteData] * .6;
						}

						// }

						if (daNote.animation != null)
						{
							if (!daNote.isSustainNote)
							{
								daNote.angle = angle[daNote.noteData];
							}
							else
							{
								daNote.angle = -angleC[daNote.noteData];
							}
						}
					}

					if (daNote.isSustainNote && curStage != 'school' && curStage != 'schoolEvil')
					{
						daNote.x += Math.cos(-angleC[daNote.noteData] * (Math.PI / 180)) * noteWidth / 2;

						daNote.x -= Math.cos(-angleC[daNote.noteData] * (Math.PI / 180)) * 17.34;

						daNote.y += Math.sin(-angleC[daNote.noteData] * (Math.PI / 180)) * noteWidth / 2;

						daNote.y -= Math.sin(-angleC[daNote.noteData] * (Math.PI / 180)) * 17.34;
					}
					else if (daNote.isSustainNote)
					{
						daNote.x += Math.abs(Math.cos(-angleC[daNote.noteData] * (Math.PI / 180)) * noteWidth / 2);

						daNote.x -= Math.abs(Math.cos(-angleC[daNote.noteData] * (Math.PI / 180)) * 19);

						daNote.y += Math.abs(Math.sin(-angleC[daNote.noteData] * (Math.PI / 180)) * noteWidth / 2);

						daNote.y -= Math.abs(Math.sin(-angleC[daNote.noteData] * (Math.PI / 180)) * 19);

						/*if ( (daNote.y <= enemyStrums.members[daNote.noteData].y + Note.swagWidth / 2) 
								&& (!daNote.mustPress || (daNote.wasGoodHit || (daNote.prevNote.wasGoodHit && !daNote.canBeHit))))
							{
								var swagRect = new FlxRect(0, strumLine.y + Note.swagWidth / 2 - daNote.y, daNote.width * 2, daNote.height * 2);
								/*if (Highscore.getDownscroll())
								{
									swagRect = new FlxRect(0, FlxG.height - (strumLine.y - Note.swagWidth / 2) - daNote.y, daNote.width * 2, daNote.height * 2);
						}*/
						// swagRect.y /= daNote.scale.y;
						/*if (Highscore.getDownscroll()) 
							{
								swagRect.height += swagRect.y;
						} else {*/
						//	swagRect.height -= swagRect.y;
						// }

						//	daNote.clipRect = swagRect;
						// }// */

						// daNote.x += Math.sin(-angleC[daNote.noteData] * (Math.PI/180)) * (SONG.speed - 1) * ((44 * holdNoteHieght) - 33);
						// daNote.y -= Math.cos(-angleC[daNote.noteData] * (Math.PI/180)) * (SONG.speed - 1) * ((44 * holdNoteHieght) - 33);
					}

					if (daNote.animation != null && curStage != 'school' && curStage != 'schoolEvil')
					{
						if (daNote.animation.curAnim.name.endsWith('end'))
						{
							daNote.x += Math.sin(-angleC[daNote.noteData] * (Math.PI / 180)) * ((44 * holdNoteHieght) - 33);
							daNote.y -= Math.cos(-angleC[daNote.noteData] * (Math.PI / 180)) * ((44 * holdNoteHieght) - 33);
						}
					}

					// */
				}

				if (daNote.tooLate && daNote.mustPress)
				{
					if (!daNote.isDying)
					{
						if (daNote.isSustainNote && daNote.wasGoodHit)
						{
							daNote.kill();
							notes.remove(daNote, true);
							daNote.destroy();
						}
						else
						{
							if (FlxG.save.data.dif != 0)
							{
								health -= 0.09;
							}

							if (FlxG.save.data.dif == 3)
							{
								health -= 2;
							}
							vocals.volume = 0;
							if (FlxG.save.data.dif != 1)
								noteMiss(daNote.noteData, daNote);
							else
								misses++;
						}

						FlxTween.tween(daNote, {alpha: 0}, .1, {
							ease: FlxEase.linear,
							onComplete: function(_)
							{
								daNote.kill();
								notes.remove(daNote, true);
								daNote.destroy();
								// trace('deleted mate');
							},
							/*onUpdate: function(_){trace(daNote.alpha);} */
						});

						daNote.isDying = true;
					}
				}

				if (daNote.strumTime - Conductor.songPosition > lerpSpawn)
				{
					/*

						Quick explanation to this shit over here:
						Basically the alpha is recalculated every frame (right above)
						And because ive added a feature where i mess with note spawning
						i cannot dispawn the note without generating error when it has been spawned 
						(and not being the last one on the list, it crashes on the sort of this group right in beathit)
						So instead of dispawning this note and sending back to the spawning list
						i just make it invisible.

						-Sincerererely Ghosty ghost, idk ive never mememorized his name

					 */

					daNote.visible = false;
				}
				else
				{
					daNote.visible = true;
				}
			});

			if (enemyStrums.members[0] != null && enemyStrums.members[1] != null && enemyStrums.members[2] != null && enemyStrums.members[3] != null)
			{
				if (dadUnpress && !dadUnpressTime.active)
				{
					dadUnpressTime.start(Conductor.timeBpm / 1000, function(dadUnpressTime:FlxTimer)
					{
						unpressDad();
					}, 1);
				}

				if (dad.animation != null && !dad.animation.curAnim.name.startsWith('sing'))
				{
					unpressDad();
				}
			}

			if (playerStrums.members[0] != null && playerStrums.members[1] != null && playerStrums.members[2] != null && playerStrums.members[3] != null)
			{
				if (auto)
				{
					if (bfUnpress && !bfUnpressTime.active)
					{
						bfUnpressTime.start(Conductor.timeBpm / 1000, function(bfUnpressTime:FlxTimer)
						{
							unpressBf();
						}, 1);
					}

					if (boyfriend.animation != null && !boyfriend.animation.curAnim.name.startsWith('sing'))
					{
						unpressBf();
					}
				}

				for (i in 0...playerStrums.length)
				{
					if (playerStrums.members[i].animation.curAnim.name == 'confirm' && playerdance && !auto)
					{
						playerStrums.members[i].animation.play('pressed');
					}
				}
			} // */
		}

		if (FlxG.save.data.practice && (health > 0 || songScore > 0))
		{
			health = 0;
			songScore = 0;
		}

		if (!inCutscene && !auto)
			keyShit();

		if (FlxG.keys.justPressed.ENTER && startedCountdown && canPause)
		{
			persistentUpdate = false;
			persistentDraw = true;
			paused = true;

			// 1 / 1000 chance for Gitaroo Man easter egg
			if (FlxG.random.bool(0.1))
			{
				// gitaroo man easter egg
				FlxG.switchState(new GitarooPause());
			}
			else
			{
				unpressBf();

				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			}
		}

		#if debug
		if (FlxG.keys.justPressed.ONE)
			endSong();
		#end
	}

	private function unpressDad():Void
	{
		enemyStrums.members[1].animation.play('static');
		enemyStrums.members[1].centerOffsets();

		enemyStrums.members[2].animation.play('static');
		enemyStrums.members[2].centerOffsets();

		enemyStrums.members[3].animation.play('static');
		enemyStrums.members[3].centerOffsets();

		enemyStrums.members[0].animation.play('static');
		enemyStrums.members[0].centerOffsets();
	}

	private function unpressBf():Void
	{
		playerStrums.members[1].animation.play('static');
		playerStrums.members[1].centerOffsets();

		playerStrums.members[2].animation.play('static');
		playerStrums.members[2].centerOffsets();

		playerStrums.members[3].animation.play('static');
		playerStrums.members[3].centerOffsets();

		playerStrums.members[0].animation.play('static');
		playerStrums.members[0].centerOffsets();
	}

	function UpdateFeatures(ang:Int, mod:Int, val:Int):Void
	{
		if (ang < 5)
		{
			switch (ang)
			{
			}
		}
	}

	function endSong():Void
	{
		if (!loadRep)
			rep.SaveReplay();

		canPause = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		if (SONG.validScore && !auto)
		{
			#if !switch
			Highscore.saveScore(SONG.song, Math.round(songScore), storyDifficulty);
			#end
		}

		if (offsetTesting)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			offsetTesting = false;
			LoadingState.loadAndSwitchState(new OptionsMenu());
			FlxG.save.data.offset = offsetTest;
		}
		else
		{
			if (isStoryMode)
			{
				campaignScore += Math.round(songScore);

				storyPlaylist.remove(storyPlaylist[0]);

				if (storyPlaylist.length <= 0)
				{
					FlxG.sound.playMusic(Paths.music('freakyMenu'));

					transIn = FlxTransitionableState.defaultTransIn;
					transOut = FlxTransitionableState.defaultTransOut;

					#if windows
					DiscordClient.changePresence("In the Menus", null);
					#end

					FlxG.switchState(new StoryMenuState());

					// if ()
					StoryMenuState.weekUnlocked[Std.int(Math.min(storyWeek + 1, StoryMenuState.weekUnlocked.length - 1))] = true;

					if (SONG.validScore)
					{
						NGio.unlockMedal(60961);
						Highscore.saveWeekScore(storyWeek, campaignScore, storyDifficulty);
					}

					FlxG.save.data.weekUnlocked = StoryMenuState.weekUnlocked;
					FlxG.save.flush();
				}
				else
				{
					var difficulty:String = "";

					if (storyDifficulty == 0)
						difficulty = '-easy';

					if (storyDifficulty == 2)
						difficulty = '-hard';

					trace('LOADING NEXT SONG');
					trace(PlayState.storyPlaylist[0].toLowerCase() + difficulty);

					if (SONG.song.toLowerCase() == 'eggnog')
					{
						var blackShit:FlxSprite = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
							-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
						blackShit.scrollFactor.set();
						add(blackShit);
						camHUD.visible = false;

						FlxG.sound.play(Paths.sound('Lights_Shut_off'));
					}

					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					prevCamFollow = camFollow;

					PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + difficulty, PlayState.storyPlaylist[0]);
					FlxG.sound.music.stop();

					if (SONG.song.toLowerCase() == 'soulless')
					{
						FlxG.switchState(new VideoState('assets/videos/SigmaGod.webm', new PlayState()));
					}
					else
					{
						LoadingState.loadAndSwitchState(new PlayState(), true);
					}
				}
			}
			else
			{
				trace('WENT BACK TO FREEPLAY??');
				#if windows
				DiscordClient.changePresence("In the Freeplay Menu", null);
				#end

				FlxG.switchState(new FreeplayState());
			}
		}
	}

	var endingSong:Bool = false;
	var hits:Array<Float> = [];
	var offsetTest:Float = 0;
	var timeShown = 0;
	var currentTimingShown:FlxText = null;

	private function popUpScore(daNote:Note):Void
	{
		var noteDiff:Float = Math.abs(Conductor.songPosition - daNote.strumTime);
		var wife:Float = EtternaFunctions.wife3(noteDiff, Conductor.timeScale);
		// boyfriend.playAnim('hey');
		vocals.volume = 1;

		var placement:String = Std.string(combo);

		var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
		coolText.screenCenter();
		coolText.x = FlxG.width * 0.55;
		coolText.y -= 350;
		coolText.cameras = [camHUD];
		//

		var rating:FlxSprite = new FlxSprite();
		var score:Float = 350;

		if (FlxG.save.data.accuracyMod == 1)
			totalNotesHit += wife;

		var daRating = daNote.rating;

		switch (daRating)
		{
			case 'shit':
				score = -300;
				combo = 0;
				if (FlxG.save.data.dif == 2)
				{
					misses++;
					health -= 0.3;
				}
				if (FlxG.save.data.dif == 3)
				{
					health -= 0.5;
				}

				ss = false;
				shits++;
				if (FlxG.save.data.accuracyMod == 0)
					totalNotesHit += 0.25;
			case 'bad':
				daRating = 'bad';
				score = 0;
				if (FlxG.save.data.dif == 2)
					health -= 0.1;

				if (FlxG.save.data.dif == 3)
				{
					health -= 0.3;
				}

				ss = false;
				bads++;
				if (FlxG.save.data.accuracyMod == 0)
					totalNotesHit += 0.50;
			case 'good':
				daRating = 'good';
				score = 200;
				ss = false;
				goods++;
				if (health < 2 && !FlxG.save.data.practice)
					health += 0.04;
				if (FlxG.save.data.accuracyMod == 0)
					totalNotesHit += 0.75;
			case 'sick':
				if (health < 2 && !FlxG.save.data.practice)
					health += 0.1;
				if (FlxG.save.data.accuracyMod == 0)
					totalNotesHit += 1;
				sicks++;
		}

		// trace('Wife accuracy loss: ' + wife + ' | Rating: ' + daRating + ' | Score: ' + score + ' | Weight: ' + (1 - wife));

		if (daRating != 'shit' || daRating != 'bad')
		{
			if (!FlxG.save.data.practice)
			{
				songScore += Math.round(score);
			}
			songScoreDef += Math.round(ConvertScore.convertScore(noteDiff));

			/* if (combo > 60)
					daRating = 'sick';
				else if (combo > 12)
					daRating = 'good'
				else if (combo > 4)
					daRating = 'bad';
			 */

			var pixelShitPart1:String = "";
			var pixelShitPart2:String = '';

			if (curStage.startsWith('school'))
			{
				pixelShitPart1 = 'weeb/pixelUI/';
				pixelShitPart2 = '-pixel';
			}

			rating.loadGraphic(Paths.image(pixelShitPart1 + daRating + pixelShitPart2));
			rating.screenCenter();
			rating.y -= 50;
			rating.x = coolText.x - 125;

			if (FlxG.save.data.changedHit)
			{
				rating.x = FlxG.save.data.changedHitX;
				rating.y = FlxG.save.data.changedHitY;
			}
			rating.acceleration.y = 550;
			rating.velocity.y -= FlxG.random.int(140, 175);
			rating.velocity.x -= FlxG.random.int(0, 10);

			var msTiming = truncateFloat(noteDiff, 3);

			if (currentTimingShown != null)
				remove(currentTimingShown);

			currentTimingShown = new FlxText(0, 0, 0, "0ms");
			timeShown = 0;
			switch (daRating)
			{
				case 'shit' | 'bad':
					currentTimingShown.color = FlxColor.RED;
				case 'good':
					currentTimingShown.color = FlxColor.GREEN;
				case 'sick':
					currentTimingShown.color = FlxColor.CYAN;
			}
			currentTimingShown.borderStyle = OUTLINE;
			currentTimingShown.borderSize = 1;
			currentTimingShown.borderColor = FlxColor.BLACK;
			currentTimingShown.text = msTiming + "ms";
			currentTimingShown.size = 20;

			if (msTiming >= 0.03 && offsetTesting)
			{
				// Remove Outliers
				hits.shift();
				hits.shift();
				hits.shift();
				hits.pop();
				hits.pop();
				hits.pop();
				hits.push(msTiming);

				var total = 0.0;

				for (i in hits)
					total += i;

				offsetTest = truncateFloat(total / hits.length, 2);
			}

			if (currentTimingShown.alpha != 1)
				currentTimingShown.alpha = 1;

			add(currentTimingShown);

			var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
			comboSpr.screenCenter();
			comboSpr.x = rating.x;
			comboSpr.y = rating.y + 100;
			comboSpr.acceleration.y = 600;
			comboSpr.velocity.y -= 150;

			currentTimingShown.screenCenter();
			currentTimingShown.x = comboSpr.x + 100;
			currentTimingShown.y = rating.y + 100;
			currentTimingShown.acceleration.y = 600;
			currentTimingShown.velocity.y -= 150;

			comboSpr.velocity.x += FlxG.random.int(1, 10);
			currentTimingShown.velocity.x += comboSpr.velocity.x;
			add(rating);

			if (!curStage.startsWith('school'))
			{
				rating.setGraphicSize(Std.int(rating.width * 0.7));
				rating.antialiasing = true;
				comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
				comboSpr.antialiasing = true;
			}
			else
			{
				rating.setGraphicSize(Std.int(rating.width * daPixelZoom * 0.7));
				comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * 0.7));
			}

			currentTimingShown.updateHitbox();
			comboSpr.updateHitbox();
			rating.updateHitbox();

			currentTimingShown.cameras = [camHUD];
			comboSpr.cameras = [camHUD];
			rating.cameras = [camHUD];

			var seperatedScore:Array<Int> = [];

			var comboSplit:Array<String> = (combo + "").split('');

			if (comboSplit.length == 2)
				seperatedScore.push(0); // make sure theres a 0 in front or it looks weird lol!

			for (i in 0...comboSplit.length)
			{
				var str:String = comboSplit[i];
				seperatedScore.push(Std.parseInt(str));
			}

			var daLoop:Int = 0;
			for (i in seperatedScore)
			{
				var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
				numScore.screenCenter();
				numScore.x = rating.x + (43 * daLoop) - 50;
				numScore.y = rating.y + 100;
				numScore.cameras = [camHUD];

				if (!curStage.startsWith('school'))
				{
					numScore.antialiasing = true;
					numScore.setGraphicSize(Std.int(numScore.width * 0.5));
				}
				else
				{
					numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
				}
				numScore.updateHitbox();

				numScore.acceleration.y = FlxG.random.int(200, 300);
				numScore.velocity.y -= FlxG.random.int(140, 160);
				numScore.velocity.x = FlxG.random.float(-5, 5);

				if (combo >= 10 || combo == 0)
					add(numScore);

				FlxTween.tween(numScore, {alpha: 0}, 0.2, {
					onComplete: function(tween:FlxTween)
					{
						numScore.destroy();
					},
					startDelay: Conductor.crochet * 0.002
				});

				daLoop++;
			}
			/* 
				trace(combo);
				trace(seperatedScore);
			 */

			coolText.text = Std.string(seperatedScore);
			// add(coolText);

			FlxTween.tween(rating, {alpha: 0}, 0.2, {
				startDelay: Conductor.crochet * 0.001,
				onUpdate: function(tween:FlxTween)
				{
					if (currentTimingShown != null)
						currentTimingShown.alpha -= 0.02;
					timeShown++;
				}
			});

			FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					coolText.destroy();
					comboSpr.destroy();
					if (currentTimingShown != null && timeShown >= 20)
					{
						remove(currentTimingShown);
						currentTimingShown = null;
					}
					rating.destroy();
				},
				startDelay: Conductor.crochet * 0.001
			});

			curSection += 1;
		}
	}

	public function NearlyEquals(value1:Float, value2:Float, unimportantDifference:Float = 10):Bool
	{
		return Math.abs(FlxMath.roundDecimal(value1, 1) - FlxMath.roundDecimal(value2, 1)) < unimportantDifference;
	}

	var upHold:Bool = false;
	var downHold:Bool = false;
	var rightHold:Bool = false;
	var leftHold:Bool = false;

	private function keyShit():Void
	{
		// HOLDING
		var up = controls.UP;
		var right = controls.RIGHT;
		var down = controls.DOWN;
		var left = controls.LEFT;

		var upP = controls.UP_P;
		var rightP = controls.RIGHT_P;
		var downP = controls.DOWN_P;
		var leftP = controls.LEFT_P;

		var upR = controls.UP_R;
		var rightR = controls.RIGHT_R;
		var downR = controls.DOWN_R;
		var leftR = controls.LEFT_R;

		if (loadRep) // replay code
		{
			// disable input
			up = false;
			down = false;
			right = false;
			left = false;

			// new input

			// if (rep.replay.keys[repPresses].time == Conductor.songPosition)
			//	trace('DO IT!!!!!');

			// timeCurrently = Math.abs(rep.replay.keyPresses[repPresses].time - Conductor.songPosition);
			// timeCurrentlyR = Math.abs(rep.replay.keyReleases[repReleases].time - Conductor.songPosition);

			if (repPresses < rep.replay.keyPresses.length && repReleases < rep.replay.keyReleases.length)
			{
				upP = rep.replay.keyPresses[repPresses].time + 1 <= Conductor.songPosition
					&& rep.replay.keyPresses[repPresses].key == "up";
				rightP = rep.replay.keyPresses[repPresses].time + 1 <= Conductor.songPosition
					&& rep.replay.keyPresses[repPresses].key == "right";
				downP = rep.replay.keyPresses[repPresses].time + 1 <= Conductor.songPosition
					&& rep.replay.keyPresses[repPresses].key == "down";
				leftP = rep.replay.keyPresses[repPresses].time + 1 <= Conductor.songPosition
					&& rep.replay.keyPresses[repPresses].key == "left";

				upR = rep.replay.keyPresses[repReleases].time - 1 <= Conductor.songPosition
					&& rep.replay.keyReleases[repReleases].key == "up";
				rightR = rep.replay.keyPresses[repReleases].time - 1 <= Conductor.songPosition
					&& rep.replay.keyReleases[repReleases].key == "right";
				downR = rep.replay.keyPresses[repReleases].time - 1 <= Conductor.songPosition
					&& rep.replay.keyReleases[repReleases].key == "down";
				leftR = rep.replay.keyPresses[repReleases].time - 1 <= Conductor.songPosition
					&& rep.replay.keyReleases[repReleases].key == "left";

				upHold = upP ? true : upR ? false : true;
				rightHold = rightP ? true : rightR ? false : true;
				downHold = downP ? true : downR ? false : true;
				leftHold = leftP ? true : leftR ? false : true;
			}
		}
		else if (!loadRep) // record replay code
		{
			if (upP)
				rep.replay.keyPresses.push({time: Conductor.songPosition, key: "up"});
			if (rightP)
				rep.replay.keyPresses.push({time: Conductor.songPosition, key: "right"});
			if (downP)
				rep.replay.keyPresses.push({time: Conductor.songPosition, key: "down"});
			if (leftP)
				rep.replay.keyPresses.push({time: Conductor.songPosition, key: "left"});

			if (upR)
				rep.replay.keyReleases.push({time: Conductor.songPosition, key: "up"});
			if (rightR)
				rep.replay.keyReleases.push({time: Conductor.songPosition, key: "right"});
			if (downR)
				rep.replay.keyReleases.push({time: Conductor.songPosition, key: "down"});
			if (leftR)
				rep.replay.keyReleases.push({time: Conductor.songPosition, key: "left"});
		}
		var controlArray:Array<Bool> = [leftP, downP, upP, rightP];

		// FlxG.watch.addQuick('asdfa', upP);
		if (((upP || rightP || downP || leftP) && !boyfriend.stunned && generatedMusic) || auto)
		{
			repPresses++;
			boyfriend.holdTimer = 0;

			var possibleNotes:Array<Note> = [];

			var ignoreList:Array<Int> = [];

			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate)
				{
					// the sorting probably doesn't need to be in here? who cares lol
					possibleNotes.push(daNote);
					possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

					ignoreList.push(daNote.noteData);
				}
			});

			if (possibleNotes.length > 0)
			{
				var daNote = possibleNotes[0];

				// Jump notes
				if (possibleNotes.length >= 2)
				{
					if (possibleNotes[0].strumTime == possibleNotes[1].strumTime)
					{
						for (coolNote in possibleNotes)
						{
							if (controlArray[coolNote.noteData])
							{
								goodNoteHit(coolNote);
							}
							else
							{
								var inIgnoreList:Bool = false;
								for (shit in 0...ignoreList.length)
								{
									if (controlArray[ignoreList[shit]])
										inIgnoreList = true;
								}
							}
						}
					}
					else if (possibleNotes[0].noteData == possibleNotes[1].noteData)
					{
						if (loadRep)
						{
							var noteDiff:Float = Math.abs(daNote.strumTime - Conductor.songPosition);

							daNote.rating = Ratings.CalculateRating(noteDiff);

							if (NearlyEquals(daNote.strumTime, rep.replay.keyPresses[repPresses].time, 30))
							{
								goodNoteHit(daNote);
								trace('force note hit');
							}
							else
								noteCheck(controlArray, daNote);
						}
						else
							noteCheck(controlArray, daNote);
					}
					else
					{
						for (coolNote in possibleNotes)
						{
							if (loadRep)
							{
								if (NearlyEquals(coolNote.strumTime, rep.replay.keyPresses[repPresses].time, 30))
								{
									var noteDiff:Float = Math.abs(coolNote.strumTime - Conductor.songPosition);

									if (noteDiff > Conductor.safeZoneOffset * 0.70 || noteDiff < Conductor.safeZoneOffset * -0.70)
										coolNote.rating = "shit";
									else if (noteDiff > Conductor.safeZoneOffset * 0.50 || noteDiff < Conductor.safeZoneOffset * -0.50)
										coolNote.rating = "bad";
									else if (noteDiff > Conductor.safeZoneOffset * 0.45 || noteDiff < Conductor.safeZoneOffset * -0.45)
										coolNote.rating = "good";
									else if (noteDiff < Conductor.safeZoneOffset * 0.44 && noteDiff > Conductor.safeZoneOffset * -0.44)
										coolNote.rating = "sick";
									goodNoteHit(coolNote);
									trace('force note hit');
								}
								else
									noteCheck(controlArray, daNote);
							}
							else
								noteCheck(controlArray, coolNote);
						}
					}
				}
				else // regular notes?
				{
					if (loadRep)
					{
						if (NearlyEquals(daNote.strumTime, rep.replay.keyPresses[repPresses].time, 30))
						{
							var noteDiff:Float = Math.abs(daNote.strumTime - Conductor.songPosition);

							daNote.rating = Ratings.CalculateRating(noteDiff);

							goodNoteHit(daNote);
							trace('force note hit');
						}
						else
							noteCheck(controlArray, daNote);
					}
					else
						noteCheck(controlArray, daNote);
				}
				/* 
					if (controlArray[daNote.noteData])
						goodNoteHit(daNote);
				 */
				// trace(daNote.noteData);
				/* 
					switch (daNote.noteData)
					{
						case 2: // NOTES YOU JUST PRESSED
							if (upP || rightP || downP || leftP)
								noteCheck(upP, daNote);
						case 3:
							if (upP || rightP || downP || leftP)
								noteCheck(rightP, daNote);
						case 1:
							if (upP || rightP || downP || leftP)
								noteCheck(downP, daNote);
						case 0:
							if (upP || rightP || downP || leftP)
								noteCheck(leftP, daNote);
					}
				 */
				if (daNote.wasGoodHit)
				{
					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}
			}
		}

		if ((up || right || down || left)
			&& generatedMusic
			|| (upHold || downHold || leftHold || rightHold)
			&& loadRep
			&& generatedMusic)
		{
			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.canBeHit && daNote.mustPress && daNote.isSustainNote)
				{
					switch (daNote.noteData)
					{
						// NOTES YOU ARE HOLDING

						case 2:
							if (up || upHold)
								goodNoteHit(daNote);
						case 3:
							if (right || rightHold)
								goodNoteHit(daNote);
						case 1:
							if (down || downHold)
								goodNoteHit(daNote);
						case 0:
							if (left || leftHold)
								goodNoteHit(daNote);
					}
				}
			});
		}

		if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && ((!up && !down && !right && !left) || playerdance))
		{
			if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss'))
			{
				if (bfstartdancin.active)
				{
					playerdance = true;
				}
				boyfriend.playAnim('idle');
			}
		}

		playerStrums.forEach(function(spr:FlxSprite)
		{
			switch (spr.ID)
			{
				case 2:
					if (loadRep)
					{
						/*if (upP)
							{
								spr.animation.play('pressed');
								new FlxTimer().start(Math.abs(rep.replay.keyPresses[repReleases].time - Conductor.songPosition) + 10, function(tmr:FlxTimer)
									{
										spr.animation.play('static');
										repReleases++;
									});
						}*/
					}
					else
					{
						if (upP && (spr.animation.curAnim.name != 'confirm') && !loadRep)
						{
							spr.animation.play('pressed');
							if (!playerdance)
							{
								if (FlxG.save.data.dif == 1)
								{
									clickMiss(2);
								}

								if (FlxG.save.data.dif == 3)
								{
									health -= 2;
								}
							}
						}
						if (upR)
						{
							spr.animation.play('static');
							repReleases++;
						}
					}
				case 3:
					if (loadRep)
					{
						/*if (upP)
							{
								spr.animation.play('pressed');
								new FlxTimer().start(Math.abs(rep.replay.keyPresses[repReleases].time - Conductor.songPosition) + 10, function(tmr:FlxTimer)
									{
										spr.animation.play('static');
										repReleases++;
									});
						}*/
					}
					else
					{
						if (rightP && (spr.animation.curAnim.name != 'confirm') && !loadRep)
						{
							spr.animation.play('pressed');
							if (!playerdance)
							{
								if (FlxG.save.data.dif == 1)
								{
									clickMiss(3);
								}

								if (FlxG.save.data.dif == 3)
								{
									health -= 2;
								}
							}
						}
						if (rightR)
						{
							spr.animation.play('static');
							repReleases++;
						}
					}
				case 1:
					if (loadRep)
					{
						/*if (upP)
							{
								spr.animation.play('pressed');
								new FlxTimer().start(Math.abs(rep.replay.keyPresses[repReleases].time - Conductor.songPosition) + 10, function(tmr:FlxTimer)
									{
										spr.animation.play('static');
										repReleases++;
									});
						}*/
					}
					else
					{
						if (downP && (spr.animation.curAnim.name != 'confirm') && !loadRep)
						{
							spr.animation.play('pressed');
							if (!playerdance)
							{
								if (FlxG.save.data.dif == 1)
								{
									clickMiss(1);
								}

								if (FlxG.save.data.dif == 3)
								{
									health -= 2;
								}
							}
						}
						if (downR)
						{
							spr.animation.play('static');
							repReleases++;
						}
					}
				case 0:
					if (loadRep)
					{
						/*if (upP)
							{
								spr.animation.play('pressed');
								new FlxTimer().start(Math.abs(rep.replay.keyPresses[repReleases].time - Conductor.songPosition) + 10, function(tmr:FlxTimer)
									{
										spr.animation.play('static');
										repReleases++;
									});
						}*/
					}
					else
					{
						if (leftP && (spr.animation.curAnim.name != 'confirm') && !loadRep)
						{
							spr.animation.play('pressed');
							if (!playerdance)
							{
								if (FlxG.save.data.dif == 1)
								{
									clickMiss(0);
								}

								if (FlxG.save.data.dif == 3)
								{
									health -= 2;
								}
							}
						}
						if (leftR)
						{
							spr.animation.play('static');
							repReleases++;
						}
					}
			}

			if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school'))
			{
				spr.centerOffsets();
				spr.offset.x -= 13;
				spr.offset.y -= 13;
			}
			else
				spr.centerOffsets();
		});
	}

	function noteMiss(direction:Int = 1, daNote:Note):Void
	{
		if (!boyfriend.stunned)
		{
			health -= 0.04;
			if (combo > 5 && gf.animOffsets.exists('sad'))
			{
				gf.playAnim('sad');
			}
			combo = 0;
			misses++;

			var noteDiff:Float = Math.abs(daNote.strumTime - Conductor.songPosition);
			var wife:Float = EtternaFunctions.wife3(noteDiff, FlxG.save.data.etternaMode ? 1 : 1.7);

			if (FlxG.save.data.accuracyMod == 1)
				totalNotesHit += wife;
			if (!FlxG.save.data.practice)
			{
				songScore -= 10;
			}

			FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
			// FlxG.sound.play(Paths.sound('missnote1'), 1, false);
			// FlxG.log.add('played imss note');

			switch (direction)
			{
				case 0:
					boyfriend.playAnim('singLEFTmiss', true);
					if (SONG.song.toLowerCase() == 'soulless' && curStep >= 1216)
						gf.playAnim('singLEFTmiss', true);
				case 1:
					boyfriend.playAnim('singDOWNmiss', true);
					if (SONG.song.toLowerCase() == 'soulless' && curStep >= 1216)
						gf.playAnim('singDOWNmiss', true);
				case 2:
					boyfriend.playAnim('singUPmiss', true);
					if (SONG.song.toLowerCase() == 'soulless' && curStep >= 1216)
						gf.playAnim('singUPmiss', true);
				case 3:
					boyfriend.playAnim('singRIGHTmiss', true);
					if (SONG.song.toLowerCase() == 'soulless' && curStep >= 1216)
						gf.playAnim('singRIGHTmiss', true);
			}

			updateAccuracy();
		}
	}

	function clickMiss(direction:Int = 1):Void
	{
		if (!boyfriend.stunned)
		{
			health -= 0.05;
			if (combo > 5 && gf.animOffsets.exists('sad'))
			{
				gf.playAnim('sad');
			}
			combo = 0;
			dismisses++;

			if (!FlxG.save.data.practice)
			{
				songScore -= 10;
			}

			FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
			// FlxG.sound.play(Paths.sound('missnote1'), 1, false);
			// FlxG.log.add('played imss note');

			switch (direction)
			{
				case 0:
					boyfriend.playAnim('singLEFTmiss', true);
					if (SONG.song.toLowerCase() == 'soulless' && curStep >= 1216)
						gf.playAnim('singLEFTmiss', true);
				case 1:
					boyfriend.playAnim('singDOWNmiss', true);
					if (SONG.song.toLowerCase() == 'soulless' && curStep >= 1216)
						gf.playAnim('singDOWNmiss', true);
				case 2:
					boyfriend.playAnim('singUPmiss', true);
					if (SONG.song.toLowerCase() == 'soulless' && curStep >= 1216)
						gf.playAnim('singUPmiss', true);
				case 3:
					boyfriend.playAnim('singRIGHTmiss', true);
					if (SONG.song.toLowerCase() == 'soulless' && curStep >= 1216)
						gf.playAnim('singRIGHTmiss', true);
			}

			updateAccuracy();
		}
	}

	/*function badNoteCheck()
		{
			// just double pasting this shit cuz fuk u
			// REDO THIS SYSTEM!
			var upP = controls.UP_P;
			var rightP = controls.RIGHT_P;
			var downP = controls.DOWN_P;
			var leftP = controls.LEFT_P;

			if (leftP)
				noteMiss(0);
			if (upP)
				noteMiss(2);
			if (rightP)
				noteMiss(3);
			if (downP)
				noteMiss(1);
			updateAccuracy();
		}
	 */
	function updateAccuracy()
	{
		totalPlayed += 1;
		accuracy = Math.max(0, totalNotesHit / totalPlayed * 100);
		accuracyDefault = Math.max(0, totalNotesHitDefault / totalPlayed * 100);
	}

	function getKeyPresses(note:Note):Int
	{
		var possibleNotes:Array<Note> = []; // copypasted but you already know that

		notes.forEachAlive(function(daNote:Note)
		{
			if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate)
			{
				possibleNotes.push(daNote);
				possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
			}
		});
		if (possibleNotes.length == 1)
			return possibleNotes.length + 1;
		return possibleNotes.length;
	}

	var mashing:Int = 0;
	var mashViolations:Int = 0;
	var etternaModeScore:Int = 0;

	function noteCheck(controlArray:Array<Bool>, note:Note):Void // sorry lol
	{
		var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition);

		if (noteDiff > Conductor.safeZoneOffset * 0.70 || noteDiff < Conductor.safeZoneOffset * -0.70)
			note.rating = "shit";
		else if (noteDiff > Conductor.safeZoneOffset * 0.50 || noteDiff < Conductor.safeZoneOffset * -0.50)
			note.rating = "bad";
		else if (noteDiff > Conductor.safeZoneOffset * 0.45 || noteDiff < Conductor.safeZoneOffset * -0.45)
			note.rating = "good";
		else if (noteDiff < Conductor.safeZoneOffset * 0.44 && noteDiff > Conductor.safeZoneOffset * -0.44)
			note.rating = "sick";

		if (loadRep)
		{
			if (controlArray[note.noteData])
				goodNoteHit(note);
			else if (rep.replay.keyPresses.length > repPresses && !controlArray[note.noteData])
			{
				if (NearlyEquals(note.strumTime, rep.replay.keyPresses[repPresses].time, 4))
				{
					goodNoteHit(note);
				}
			}
		}
		else if (controlArray[note.noteData])
		{
			for (b in controlArray)
			{
				if (b)
					mashing++;
			}

			// ANTI MASH CODE FOR THE BOYS

			if (mashing <= getKeyPresses(note) && mashViolations < 2)
			{
				mashViolations++;

				goodNoteHit(note, (mashing <= getKeyPresses(note)));
			}
			else
			{
				// this is bad but fuck you
				playerStrums.members[0].animation.play('static');
				playerStrums.members[1].animation.play('static');
				playerStrums.members[2].animation.play('static');
				playerStrums.members[3].animation.play('static');
				health -= 0.2;
				trace('mash ' + mashing);
			}

			if (mashing != 0)
				mashing = 0;
		}
	}

	var nps:Int = 0;

	public function goodNoteHit(note:Note, resetMashViolation = true):Void
	{
		var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition);

		note.rating = Ratings.CalculateRating(noteDiff);

		if (!note.isSustainNote)
			notesHitArray.push(Date.now());

		if (resetMashViolation)
			mashViolations--;

		if (!note.wasGoodHit)
		{
			if (!note.isSustainNote)
			{
				popUpScore(note);
				combo += 1;
			}
			else
				totalNotesHit += 1;

			switch (note.noteData)
			{
				case 2:
					boyfriend.playAnim('singUP', true);
					if (SONG.song.toLowerCase() == 'soulless' && curStep >= 1216)
						gf.playAnim('singUP', true);
				case 3:
					boyfriend.playAnim('singRIGHT', true);
					if (SONG.song.toLowerCase() == 'soulless' && curStep >= 1216)
						gf.playAnim('singRIGHT', true);
				case 1:
					boyfriend.playAnim('singDOWN', true);
					if (SONG.song.toLowerCase() == 'soulless' && curStep >= 1216)
						gf.playAnim('singDOWN', true);
				case 0:
					boyfriend.playAnim('singLEFT', true);
					if (SONG.song.toLowerCase() == 'soulless' && curStep >= 1216)
						gf.playAnim('singLEFT', true);
			}

			if (!loadRep)
				playerStrums.forEach(function(spr:FlxSprite)
				{
					if (Math.abs(note.noteData) == spr.ID)
					{
						spr.animation.play('confirm', true);

						if (auto && !curStage.startsWith('school'))
						{
							spr.centerOffsets();
							spr.offset.x -= 13;
							spr.offset.y -= 13;
						}
					}
				});

			note.wasGoodHit = true;
			vocals.volume = 1;

			note.kill();
			notes.remove(note, true);
			note.destroy();

			updateAccuracy();
		}
	}

	var fastCarCanDrive:Bool = true;

	function resetFastCar():Void
	{
		fastCar.x = -12600;
		fastCar.y = FlxG.random.int(140, 250);
		fastCar.velocity.x = 0;
		fastCarCanDrive = true;
	}

	function fastCarDrive()
	{
		FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

		fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
		fastCarCanDrive = false;
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			resetFastCar();
		});
	}

	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;
	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;

	function trainStart():Void
	{
		trainMoving = true;
		if (!trainSound.playing)
			trainSound.play(true);
	}

	var startedMoving:Bool = false;

	function updateTrainPos():Void
	{
		if (trainSound.time >= 4700)
		{
			startedMoving = true;
			gf.playAnim('hairBlow');
		}

		if (startedMoving)
		{
			phillyTrain.x -= 400;

			if (phillyTrain.x < -2000 && !trainFinishing)
			{
				phillyTrain.x = -1150;
				trainCars -= 1;

				if (trainCars <= 0)
					trainFinishing = true;
			}

			if (phillyTrain.x < -4000 && trainFinishing)
				trainReset();
		}
	}

	function trainReset():Void
	{
		gf.playAnim('hairFall');
		phillyTrain.x = FlxG.width + 200;
		trainMoving = false;
		// trainSound.stop();
		// trainSound.time = 0;
		trainCars = 8;
		trainFinishing = false;
		startedMoving = false;
	}

	function lightningStrikeShit():Void
	{
		FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
		halloweenBG.animation.play('lightning');

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);

		boyfriend.playAnim('scared', true);
		gf.playAnim('scared', true);
	}

	override function stepHit()
	{
		super.stepHit();
		if (FlxG.sound.music.time > Conductor.songPosition + 20 || FlxG.sound.music.time < Conductor.songPosition - 20)
		{
			resyncVocals();
		}

		if (dad.curCharacter == 'spooky' && curStep % 4 == 2)
		{
			// dad.dance();
		}

		// yes this updates every step.
		// yes this is bad
		// but i'm doing it to update misses and accuracy
		#if windows
		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		// Updating Discord Rich Presence (with Time Left)

		DiscordClient.changePresence((!auto ? Dif[FlxG.save.data.dif] : "Auto")
			+ " "
			+ detailsText
			+ " "
			+ SONG.song
			+ " ("
			+ storyDifficultyText
			+ ") "
			+ generateRanking(),
			"\n"
			+ (FlxG.save.data.dif != 0 ? "Acc: " + truncateFloat(accuracy, 2) + "% | " : "")
			+ (!FlxG.save.data.practice ? "Score: " + songScore : "Practice Mode")
			+ (FlxG.save.data.dif != 3 ? " | Misses: " + misses : "")
			+ (FlxG.save.data.dif == 1 ? " | Miss Clicks: " + dismisses : "")
			+ (FlxG.save.data.dif == 3 ? " | Percentage: " + truncateFloat((songTime / songLength) * 100, 0) + "%" : ""),
			iconRPC, true, songLength
			- Conductor.songPosition);
		#end

		if (SONG.song.toLowerCase() == 'survey')
			switch (curStep)
			{
				case 311:
					FlxTween.linearMotion(crowd, -250, 500, -250, 0, 7);
				case 805:
					FlxTween.linearMotion(crowd, -250, 0, -250, 500, 7);
			}
		if (SONG.song.toLowerCase() == 'stonks')
			switch (curStep)
			{
				case 1:
					creepy1.visible = false;
					creepy2.visible = false;
					creepy3.visible = false;
					sigmastatic.visible = false;
				case 59:
					FlxG.camera.flash(FlxColor.RED, 1);
					remove(dad);
					dad = new Character(-100, 100, 'stonks');
					add(dad);
					background1.visible = false;
					clouds.visible = false;
					homes1.visible = false;
					homes2.visible = false;
				case 310:
					remove(dad);
					dad = new Character(500, 130, 'gf-sigma');
					add(dad);
					remove(gf);
					gf = new Character(-100, 100, 'stonks');
					add(gf);
					sigmastatic.visible = true;
				case 313:
					sigmastatic.visible = false;
					creepy1.visible = true;
				case 319:
					sigmastatic.visible = true;
					creepy1.visible = false;
				case 322:
					sigmastatic.visible = false;
				case 388:
					remove(dad);
					dad = new Character(-100, 100, 'stonks');
					add(dad);
					remove(gf);
					gf = new Character(500, 130, 'gf-sigma');
					add(gf);
				case 496:
					remove(dad);
					dad = new Character(500, 130, 'gf-sigma');
					add(dad);
					remove(gf);
					gf = new Character(-100, 100, 'stonks');
					add(gf);
					sigmastatic.visible = true;
				case 499:
					sigmastatic.visible = false;
					creepy2.visible = true;
				case 505:
					sigmastatic.visible = true;
					creepy2.visible = false;
				case 508:
					sigmastatic.visible = false;
				case 515:
					remove(dad);
					dad = new Character(-100, 100, 'stonks');
					add(dad);
					remove(gf);
					gf = new Character(500, 130, 'gf-sigma');
					add(gf);
				case 546:
				// hi
				case 555:
				// bye
				case 575:
					remove(dad);
					dad = new Character(500, 130, 'gf-sigma');
					add(dad);
					remove(gf);
					gf = new Character(-100, 100, 'stonks');
					add(gf);
					sigmastatic.visible = true;
				case 578:
					sigmastatic.visible = false;
				case 585:
					remove(dad);
					dad = new Character(-100, 100, 'stonks');
					add(dad);
					remove(gf);
					gf = new Character(500, 130, 'gf-sigma');
					add(gf);
				case 586:
					sigmastatic.visible = true;
				case 587:
					sigmastatic.visible = false;
				case 639:
					remove(dad);
					dad = new Character(500, 130, 'gf-sigma');
					add(dad);
					remove(gf);
					gf = new Character(-100, 100, 'stonks');
					add(gf);
					sigmastatic.visible = true;
				case 642:
					sigmastatic.visible = false;
					creepy3.visible = true;
				case 644:
					sigmastatic.visible = true;
					creepy3.visible = false;
				case 647:
					sigmastatic.visible = false;
				case 654:
					remove(dad);
					dad = new Character(-100, 100, 'stonks');
					add(dad);
					remove(gf);
					gf = new Character(500, 130, 'gf-sigma');
					add(gf);
				case 731:
					remove(dad);
					dad = new Character(500, 130, 'gf-sigma');
					add(dad);
					remove(gf);
					gf = new Character(-100, 100, 'stonks');
					add(gf);
				case 748:
					FlxG.camera.flash(FlxColor.WHITE, 5);
					gf.visible = false;
					background2.visible = false;
					homes3.visible = false;
					homes4.visible = false;
					stage1.visible = false;
				case 749:
					remove(dad);
					dad = new Character(500, 130, 'gf-skeleton');
					add(dad);
					remove(boyfriend);
					boyfriend = new Boyfriend(1170, 450, 'bf-skeleton');
					add(boyfriend);
				case 1045:
					gf.visible = true;
					remove(boyfriend);
					boyfriend = new Boyfriend(1170, 450, 'bf');
					add(boyfriend);
					remove(dad);
					dad = new Character(-100, 100, 'stonks');
					add(dad);
					remove(gf);
					gf = new Character(500, 130, 'gf-sigma');
					add(gf);
					background2.visible = true;
					homes3.visible = true;
					homes4.visible = true;
					stage1.visible = true;
					FlxG.camera.flash(FlxColor.RED, 1);
				case 1075:
					boyfriend.playAnim('Pre attack');
				case 1076:
					boyfriend.playAnim('Attack');
					remove(dad);
					dad = new Character(-100, 100, 'stonksbeaten');
					add(dad);
				case 1107:
					gf.playAnim('freed', true);
				case 1108:
					gf.playAnim('freed', true);
				case 1109:
					gf.playAnim('freed', true);
				case 1110:
					gf.playAnim('freed', true);
				case 1111:
					gf.playAnim('freed', true);
				case 1112:
					gf.playAnim('freed', true);
				case 1113:
					gf.playAnim('freed', true);
				case 1114:
					gf.playAnim('freed', true);
				case 1115:
					gf.playAnim('freed', true);
				case 1116:
					gf.playAnim('freed', true);
				case 1117:
					gf.playAnim('trolling', true);
				case 1118:
					remove(gf);
					gf = new Character(500, 130, 'gf');
					add(gf);
			}
		if (SONG.song.toLowerCase() == 'soulless')
			switch (curStep)
			{
				case 1:
					background5.visible = false;
					clouds2.visible = false;
					background4.visible = false;
					gfimpact.visible = false;
				case 820:
					gf.playAnim('hey');
				case 822:
					FlxG.camera.flash(FlxColor.RED, 1);
					remove(dad);
					dad = new Character(100, 100, 'soullesssigmainjured');
					add(dad);
					raysfinal.visible = false;
					background3.visible = false;
					background4.visible = true;
					gfimpact.visible = true;
				case 1073:
					remove(boyfriend);
					boyfriend = new Boyfriend(1250, 130, 'bfgfsoulless');
					add(boyfriend);
					remove(gf);
					gf = new Character(2020, 450, 'bfsoullessgf');
					add(gf);
				case 1216:
					remove(boyfriend);
					boyfriend = new Boyfriend(2020, 450, 'bfsoulless');
					add(boyfriend);
					remove(gf);
					gf = new Character(1250, 130, 'gfsoulless');
					add(gf);
				case 1514:
					background5.visible = true;
					clouds2.visible = true;
					background4.visible = false;
					gfimpact.visible = false;
					remove(boyfriend);
					boyfriend = new Boyfriend(2020, 450, 'bfmicdrop');
					add(boyfriend);
				case 1535:
					remove(boyfriend);
					boyfriend = new Boyfriend(2020, 450, 'bfangered');
					add(boyfriend);
			}
		if (SONG.song.toLowerCase() == 'sentimental')
			switch (curStep)
			{
				case 52:
					gfSpeak.alpha = 1;
					gf.alpha = 0;
				case 80:
					gfSpeak.alpha = 0;
					gf.alpha = 1;
					remove(boyfriend);
					boyfriend = new Boyfriend(2020, 450, 'bftext');
					add(boyfriend);
				case 122:
					remove(boyfriend);
					boyfriend = new Boyfriend(2020, 450, 'bf');
					add(boyfriend);
					remove(dad);
					dad = new Character(700, 0, 'enigma');
					add(dad);
					remove(healthBar);
					remove(healthBarBG);
					remove(songPosBar);
					remove(songPosBG);
					gf.visible = true;
					remove(iconP1);
					remove(iconP2);
					FlxTween.tween(background5, {alpha: 0}, 10);
					FlxTween.tween(clouds2, {alpha: 0}, 10);
					FlxTween.tween(flyingstage, {alpha: 0}, 10);
					FlxTween.tween(gf, {alpha: 0}, 10);
					FlxTween.tween(dad, {alpha: 0}, 0.00000000000000000000001);
				case 123:
					FlxTween.tween(dad, {alpha: 1}, 10);
			}
	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	function icontween(addd:Float)
	{
		addPulse = addd; // i was feeling lazy when using this variable name, i didnt wanted to use this.add neither change the variable to something original
	}

	override function beatHit()
	{
		super.beatHit();

		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, FlxSort.DESCENDING);
		}

		FlxTween.num(0.0, 30.0, .04, {
			type: ONESHOT,
			ease: FlxEase.linear,
			onComplete: function(_)
			{
				FlxTween.num(30.0, 0.0, .04, {type: ONESHOT, ease: FlxEase.linear}, icontween.bind());
			}
		}, icontween.bind());

		// FlxTween.num( 40.0, 0.0, .1, {type: ONESHOT, ease: FlxEase.linear}, icontween.bind());

		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
				FlxG.log.add('CHANGED BPM!');
			}
			// else
			// Conductor.changeBPM(SONG.bpm);

			// Dad doesnt interupt his own notes
			if (daddance)
			{
				dad.dance();
				unpressDad();
			}

			if ((playerdance) && auto && !boyfriend.animation.curAnim.name.endsWith('miss'))
			{
				unpressBf();
				boyfriend.playAnim('idle');
			}
		}
		// FlxG.log.add('change bpm' + SONG.notes[Std.int(curStep / 16)].changeBPM);
		wiggleShit.update(Conductor.crochet);

		// HARDCODING FOR MILF ZOOMS!
		// I hAte HaRdCorE iTs DIfIculT -Ghost ((un)professional comedian)
		if (curSong.toLowerCase() == 'milf' && curBeat >= 168 && curBeat < 200 && camZooming && FlxG.camera.zoom < 1.35)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}

		if (camZooming && FlxG.camera.zoom < 1.35 && curBeat % 4 == 0)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}

		/*
			iconP1.setGraphicSize(Std.int(iconP1.width + 30));
			iconP2.setGraphicSize(Std.int(iconP2.width + 30));

			iconP1.updateHitbox();
			iconP2.updateHitbox();
		 */

		if (curBeat % gfSpeed == 0)
		{
			gf.dance();
		}

		if (!boyfriend.animation.curAnim.name.startsWith("sing"))
		{
			boyfriend.playAnim('idle');
		}

		if (curBeat % 8 == 7 && curSong == 'Bopeebo')
		{
			boyfriend.playAnim('hey', true);
		}

		if (curBeat % 16 == 15 && SONG.song == 'Tutorial' && dad.curCharacter == 'gf' && curBeat > 16 && curBeat < 48)
		{
			boyfriend.playAnim('hey', true);
			dad.playAnim('cheer', true);
		}

		if (curBeat == 206 && SONG.song.toLowerCase() == 'soulless')
			shakingNotes = true;

		switch (curStage)
		{
			case 'mall':
				upperBoppers.animation.play('bop', true);
				bottomBoppers.animation.play('bop', true);
				santa.animation.play('idle', true);

				if (FlxG.random.bool(10) && fastCarCanDrive)
					fastCarDrive();
			case "philly":
				if (!trainMoving)
					trainCooldown += 1;

				if (curBeat % 4 == 0)
				{
					phillyCityLights.forEach(function(light:FlxSprite)
					{
						light.visible = false;
					});

					curLight = FlxG.random.int(0, phillyCityLights.length - 1);

					phillyCityLights.members[curLight].visible = true;
					// phillyCityLights.members[curLight].alpha = 1;
				}

				if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
				{
					trainCooldown = FlxG.random.int(-4, 0);
					trainStart();
				}
		}

		if (isHalloween && FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
		{
			lightningStrikeShit();
		}
	}

	var curLight:Int = 0;
}
