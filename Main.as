package  {
	import soundManager.SoundAS;
	import soundManager.SoundManager;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.StageQuality;
	import flash.system.*;
	import flash.events.TouchEvent;
	import com.greensock.TweenLite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.ui.Multitouch;
	import flash.ui.ContextMenu;
	import flash.ui.MultitouchInputMode;
	import flash.net.SharedObject;
	//import org.hamcrest.collection.InArrayMatcher;
	import com.newgrounds.*;
import flash.net.URLRequest;
import flash.net.navigateToURL;

	public class Main extends MovieClip {
		//public var android:Boolean = true;
		public var android:Boolean = false;
		
		
		public var FisDown:Boolean = false;
		public var IisDown:Boolean = false;
		public var NisDown:Boolean = false;
		public var SisDown:Boolean = false;
		public var HisDown:Boolean = false;
		
		public const stage05Width:int = stage.stageWidth * 0.5;
		public const stage075Width:int = stage.stageWidth * 0.75;
		public const stage01Height:int = stage.stageHeight * 0.1;

		//Sound vars
		public var music:SoundManager = SoundAS.group("music");
		public var fx:SoundManager = SoundAS.group("fx");
		//Game state vars
		public var isPaused:Boolean = false;
		public var isInGame:Boolean = false;
		public var isMuted:Boolean = false;
		public var originalFrameRate:uint = stage.frameRate; 
		//Keys vars
		public static const KEY_MUTE:int = Keyboard.M;
		public static const KEY_PAUSE:int = Keyboard.P;
		//
		public static var instance:Main;
		public var _gameStageMC:MovieClip;
		public var screenOutFunction:Function = null;
		public var screenOutFunction2:Function = null;
		
		public var hearthAnimations:Array = [];
		
		var shake:int = 0;
		var originalInkX:int;
		var originalInkY:int;
		private var heartMc:*;
		public var virtualJoystick:VirtualJoystick;

		public var graphicLevel:int = 2;

		public var fxOption:Boolean = true;
		public var musicOption:Boolean = true;
		public var gotSavedGame:Boolean = false;
		
		public var introMovie:MovieClip = null;
		
		public var controlsScreenVar:MovieClip;public var creditsScreenVar:MovieClip;
		public var medalsScreenVar:MovieClip;
		public var victoryScreenVar:MovieClip;
		
		public var currentLevel:int = 0;
		public var pauseScreen:MovieClip = null;
		var saveDataObject:SharedObject;
		var choosenLevel:int = 1;
		
		public var medalsArr:Array = [];
		public var newRecord:Boolean = false;
		//Saved data
		public var seenControlsScreen:Boolean = false;
		public var gotMedalsArr:Array = [];
		public var bestTimesArray:Array = [];
		public var totalKills:int = 0;
		public var totalFramesInLevel:int = 0;
		public var totalDeaths:int = 0;
		
		public var finalScreen:MovieClip;
		//////////
		
		public function Main() {
			
		}
		public function randomNumber (low:Number=0, high:Number=1):int {
			//return a random number between "low" and "high" including both
 			return Math.floor(Math.random() * (1+high-low)) + low;
		}
		public function doRandomButtonClickSound():void {
			fx.playFx("buttonClick1", 8);
		}
		public function init(e:Event = null):void {	
			preloaderForeground.visible = false;
			preloaderBackground.visible = false;
			trace("Main init");
			removeEventListener(Event.ADDED_TO_STAGE, init); 
			instance = this;
			gotoAndStop(4);
			//Add sounds
			
			//music.addSound("opener", new music_opener());
			music.addSound("CompleteIntro", new CompleteIntro());
			music.addSound("IntroMusic", new IntroMusic());
			music.addSound("MenuMusic", new MenuMusic());
			music.addSound("VictoryMusic", new VictoryMusic());
			music.addSound("inkMusic", new inkMusic());
			music.addSound("creditsMusic", new _1());
			
			music.addSound("starsMusic", new starsMusic());
			music.addSound("octopusMusic1", new OctopusMusic1()).loopTo = 10000;
			music.addSound("worldMap", new worldMapMusic()).loopTo = 2050;
			music.addSound("wildWest", new wildWest()).loopTo = 8100;
			music.addSound("boss1Music", new boss1Music()).loopTo = 6750;
			music.addSound("shipMusic", new shipMusic());
			

			//Add hit sounds
			
			fx.addSound("Eggpoop", new Eggpoop());
			fx.addSound("BossChickenLaserNew", new BossChickenLaserNew());
			fx.addSound("BossChickenScream", new BossChickenScream());
			fx.addSound("EggFall", new EggFall());fx.addSound("EggCrash_1", new EggCrash_1());

			fx.addSound("ChickenScream2", new ChickenScream2());
			fx.addSound("ChickenScream1", new ChickenScream1());
			fx.addSound("hit1", new hit1());
			fx.addSound("hit2", new hit2());
			fx.addSound("hit3", new hit3());
			//Add whoosh sounds
			fx.addSound("whoosh1", new whoosh1());
			fx.addSound("whoosh2", new whoosh2());
			fx.addSound("whoosh3", new whoosh3());
			fx.addSound("whoosh4", new whoosh4());
			fx.addSound("whoosh5", new whoosh5());
			fx.addSound("whoosh6", new whoosh6());

			fx.addSound("waterJump1", new WaterJump1());
			fx.addSound("waterJump2", new WaterJump2());
			fx.addSound("waterJump3", new WaterJump3());
			
			fx.addSound("footSplash1", new FootSplash1());
			fx.addSound("footSplash2", new FootSplash2());
			fx.addSound("footSplash3", new FootSplash3());
			
			fx.addSound("GunSound1", new GunSound1());
			fx.addSound("GunSound2", new GunSound2());
			
			fx.addSound("CactusHitSound", new CactusHitSound());
			fx.addSound("buttonClick1", new ButtonClick1());
			fx.addSound("trainLoop", new TrainLoop());
			fx.addSound("trainWhistle", new TrainWhistle());
			fx.addSound("HealthSound", new HealthSound());
			fx.addSound("InkHitSound", new InkHitSound());
			
			if (!android) {
			fx.addSound("PlayerHurt1", new PlayerHurt1());
			fx.addSound("PlayerHurt2", new PlayerHurt2());
			fx.addSound("PlayerHurt3", new PlayerHurt3());
			fx.addSound("PlayerHurt4", new PlayerHurt4());

			fx.addSound("monsterCharge1", new monsterCharge1());
			fx.addSound("monsterCharge2", new monsterCharge2());
			fx.addSound("monsterCharge3", new monsterCharge3());
			fx.addSound("monsterCharge4", new monsterCharge4());
			fx.addSound("monsterCharge5", new monsterCharge5());
			fx.addSound("monsterCharge6", new monsterCharge6());
			fx.addSound("monsterCharge7", new monsterCharge7());
			
			fx.addSound("monsterHurt1", new monsterHurt1());
			fx.addSound("monsterHurt2", new monsterHurt2());
			fx.addSound("monsterHurt3", new monsterHurt3());
			fx.addSound("monsterHurt4", new monsterHurt4());
			fx.addSound("monsterHurt5", new squidhurt1());
			fx.addSound("monsterHurt6", new squidhurt2());
			fx.addSound("monsterHurt7", new squidhurt3());
			fx.addSound("monsterHurt8", new squidhurt4());
			fx.addSound("monsterHurt9", new squidhurt5());
			fx.addSound("monsterHurt10", new squidhurt6());
			fx.addSound("monsterHurt11", new squidhurt7());
			fx.addSound("monsterHurt12", new squidhurt8());
			
			fx.addSound("monsterAttack1", new monsterAttack1());
			fx.addSound("monsterAttack2", new monsterAttack2());
			fx.addSound("monsterAttack3", new monsterAttack3());
			fx.addSound("monsterAttack4", new monsterAttack4());
			fx.addSound("monsterAttack5", new monsterAttack5());
			fx.addSound("monsterAttack6", new monsterAttack6());
			
			fx.addSound("CrabClaw1", new CrabClaw1());
			fx.addSound("CrabClaw2", new CrabClaw2());
		}
			fx.addSound("Squidcrowd", new Squidcrowd());
			
			fx.addSound("explosionSound", new explosionSound());
			if (!android) {
			//Stars sound
			fx.addSound("star1", new star1());
			fx.addSound("star2", new star2());
			fx.addSound("star3", new star3());
			fx.addSound("star4", new star4());
			fx.addSound("star5", new star5());
			fx.addSound("star6", new star6());
			fx.addSound("star7", new star7());
			fx.addSound("star8", new star8());
			fx.addSound("star9", new star9());


			fx.addSound("starattack1", new starattack1());
			fx.addSound("starattack2", new starattack2());
			fx.addSound("starattack3", new starattack3());
			fx.addSound("starattack4", new starattack4());
			fx.addSound("starattack5", new starattack5());
			fx.addSound("starattack6", new starattack6());
			fx.addSound("starattack7", new starattack7());

			fx.addSound("starfall1", new starfall1());
			fx.addSound("starfall2", new starfall2());


			fx.addSound("starhurt1", new starhurt1());
			fx.addSound("starhurt2", new starhurt2());
			fx.addSound("starhurt3", new starhurt3());
			fx.addSound("starhurt4", new starhurt4());
			fx.addSound("starhurt5", new starhurt5());
			fx.addSound("starhurt6", new starhurt6());
			fx.addSound("starhurt7", new starhurt7());
			fx.addSound("starhurt8", new starhurt8());

			fx.addSound("ImpactSparkle1", new ImpactSparkle1());
			fx.addSound("ImpactSparkle2", new ImpactSparkle2());


			fx.addSound("Swish1", new Swish1());
			fx.addSound("Swish2", new Swish2());
		}
			fx.addSound("death1", new death1());
			fx.addSound("death2", new death2());

			//boss
			fx.addSound("bossHurt1", new smallhurt1());
			fx.addSound("bossHurt2", new smallhurt2());
			fx.addSound("bossHurt3", new smallhurt3());
			fx.addSound("bossHurt4", new smallhurt4());
			fx.addSound("bossHurt5", new smallhurt5());
			fx.addSound("bossHurt6", new smallhurt6());
			fx.addSound("bossHurt7", new smallhurt7());
			fx.addSound("bossHurt8", new smallhurt8());

			fx.addSound("bossAppearSound", new bossAppearSound());
			fx.addSound("bossDissapearSound", new bossDissapearSound());

			fx.addSound("fart1", new fart1());
			fx.addSound("fart2", new fart2());
			fx.addSound("fart3", new fart3());
			fx.addSound("fart4", new fart4());


			fx.addSound("BigStomp", new BigStomp());

			//createMedalArr();
			if ( !android )
				addKeyListeners();
			
			
			//deleteSave();
			saveDataObject = SharedObject.getLocal("chickenSave22");
			//if (true) {
			if(saveDataObject.data.currentLevel == null){
				trace("No saved data yet.");
				restInnerData();
				
				
				saveData();
			} else {
				trace("Save data found.");
				loadData();
			}
			screenOut.play();
			screenOutFunction = showMenu;
			stage.addEventListener ( Event.ACTIVATE, onActivate); 
			stage.addEventListener ( Event.DEACTIVATE, onDeactivate);
			
			var myMenu:ContextMenu = new ContextMenu();
			myMenu.hideBuiltInItems();
			this.contextMenu = myMenu;
			
		

		}
		public function putVictoryScreen(_totalKills:int, totalFramesTime:int, levelNum:int, lastLevel:Boolean):void {
			
			totalKills += _totalKills;
			totalFramesInLevel += totalFramesTime;
			newRecord = false;
			if (bestTimesArray[levelNum - 1] > totalFramesTime || bestTimesArray[levelNum - 1] == -1) {
				bestTimesArray[levelNum - 1] = totalFramesTime;
				newRecord = true;
			}
			if (levelNum == currentLevel && !lastLevel)
				currentLevel++;
			saveData();
			
			screenOut.play();
			screenOutFunction = removeGame;
			victoryScreenVar = new VictoryScreen(_totalKills, totalFramesTime, levelNum);
			screenOutFunction2 = victoryScreen;
		}
		public function showFinal():void {
			gotoAndStop("final");
			finalScreen = new creditsScreenfinal();
			
			addChild(finalScreen);
			this.setChildIndex(finalScreen, numChildren - 2);
			fx.stopAll();
			music.stopAll();
			music.playLoop("creditsMusic", 2, 1);
		}
		public function removeFinal():void {
			removeChild(finalScreen);
			finalScreen = null;
		}
		public function goFromFinalToMenu():void {
			unlockNgMedal("Through Hell and Back");
			screenOut.play();
			screenOutFunction = removeFinal;
			screenOutFunction2 = showMenu;
		}
		public function victoryScreen():void {
			gotoAndStop("map");
			addChild(victoryScreenVar);
			victoryScreenVar.play();
			this.setChildIndex(victoryScreenVar, numChildren - 1);
			
			fx.stopAll();
			music.stopAll();
			music.playFx("VictoryMusic", 3, 10);
			
		}
		public function removeVictoryScreen():void {
			removeChild(victoryScreenVar);
			victoryScreenVar = null;
		}
		public function addVictoryScreenListeners():void {
			addCommonMenuListeners(victoryScreenVar.continueFromVictoryButton.hitBox);
		}
		public function removeVictoryScreenListeners():void {
			removeCommonMenuListeners(victoryScreenVar.continueFromVictoryButton.hitBox);
		}
		public function createMedalArr():void {
			medalsArr.push(new Medal("First Kill", "I think this is the beginning of a beautiful mass murder"));
			medalsArr.push(new Medal("Mass murderer", "...."));
			medalsArr.push(new Medal("exterminator", "Dude, leave some nature to kill to the rest of us!"));
			for (var i:int = 0; i < medalsArr.length; ++i) {
				gotMedalsArr.push(false);
			}
		}
		public function restInnerData():void {
			seenControlsScreen = false;
			totalKills = 0;
			totalFramesInLevel = 0;
			totalDeaths = 0;
			currentLevel = 0;
			///
			//currentLevel = 7;
			//seenControlsScreen = false;
			/////
			for (var i:int = 0; i < medalsArr.length; ++i) {
				gotMedalsArr.push(false);
			}
			bestTimesArray = new Array(-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);
		}
		public function deleteSave():void {
			saveDataObject = SharedObject.getLocal("chickenSave22");
			delete saveDataObject.data.seenControlsScreen;
			delete saveDataObject.data.totalKills;
			delete saveDataObject.data.totalFramesInLevel;
			delete saveDataObject.data.totalDeaths;
			delete saveDataObject.data.gotMedalsArr;
			delete saveDataObject.data.bestTimesArray;
			delete saveDataObject.data.currentLevel;
			//delete saveDataObject.data.currentLevel;
			//delete saveDataObject.data.bestTimesArray;// = SharedObject.getLocal("chickenSave22");
			saveDataObject.flush();
		}
		function saveData():void{
			saveDataObject.data.seenControlsScreen = seenControlsScreen;
			saveDataObject.data.totalFramesInLevel = totalFramesInLevel;
			saveDataObject.data.totalDeaths = totalDeaths;
			saveDataObject.data.gotMedalsArr = gotMedalsArr;
			saveDataObject.data.totalKills = totalKills;
			saveDataObject.data.bestTimesArray = bestTimesArray;
			saveDataObject.data.currentLevel = currentLevel;

			trace("Data Saved!");
			saveDataObject.flush();
			trace(saveDataObject.size/1024);
			
			if (totalKills >= 100)
				Main.instance.unlockNgMedal("Mass Murderer");
			if (totalKills >= 250)
				Main.instance.unlockNgMedal("Exterminator");
			
			
		}
		function loadData():void {
			seenControlsScreen = saveDataObject.data.seenControlsScreen;
			totalKills = saveDataObject.data.totalKills;
			totalFramesInLevel = saveDataObject.data.totalFramesInLevel;
			totalDeaths = saveDataObject.data.totalDeaths;
			gotMedalsArr = saveDataObject.data.gotMedalsArr;
			bestTimesArray = saveDataObject.data.bestTimesArray;
			currentLevel = saveDataObject.data.currentLevel;
			trace("Data Loaded!");
			trace(saveDataObject.size/1024);
		}
		public function commonStartGame():void {
			isInGame = true;
			stage.quality = StageQuality.LOW;
			if (currentLabel == "map")
			map.visible = false;
			gotoAndStop("game");
			hideHearts();
			MovieClip(heartsContainer).bossBar.visible = false;
			MovieClip(heartsContainer).bossBar.gotoAndStop(1);
			inkScreen.gotoAndStop("invisible");
			inkScreen.visible = false;
			originalInkX = inkScreen.x;
			originalInkY = inkScreen.y;
			comboMc.gotoAndStop("invisible");
			//pauseScreen.visible = false;
			addCommonMenuListeners(MovieClip(this).pauseButton.hitBox);
			
			if (android) {
				virtualJoystick = new VirtualJoystick();
				addChild(virtualJoystick);
				virtualJoystick.x = stage.stageWidth * 0.1;
				virtualJoystick.y = stage.stageHeight * 0.85;
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd, false, 0 ,true);
				stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin, false, 0 ,true);
			}
			comboMc.gotoAndStop("invisible");
			showHearts();
			music.stopAll();
			_gameStageMC = null;
		}
		public function addMainMenuButtons():void {
			addCommonMenuListeners(mainMenu.fxButton.hitBox);
			addCommonMenuListeners(mainMenu.musicButton.hitBox);
			addCommonMenuListeners(mainMenu.controlsButton.hitBox);
			addCommonMenuListeners(mainMenu.creditsButton.hitBox);
			addCommonMenuListeners(mainMenu.newGameButton.hitBox);
			addCommonMenuListeners(mainMenu.continueButton.hitBox);
			addCommonMenuListeners(mainMenu.medalsButton.hitBox);
			addCommonMenuListeners(mainMenu.twitterButton.hitBox);
		}
		public function removeMainMenuButtons():void {
			removeCommonMenuListeners(mainMenu.fxButton.hitBox);
			removeCommonMenuListeners(mainMenu.musicButton.hitBox);
			removeCommonMenuListeners(mainMenu.controlsButton.hitBox);
			removeCommonMenuListeners(mainMenu.creditsButton.hitBox);
			removeCommonMenuListeners(mainMenu.newGameButton.hitBox);
			removeCommonMenuListeners(mainMenu.continueButton.hitBox);
			removeCommonMenuListeners(mainMenu.medalsButton.hitBox);
			removeCommonMenuListeners(mainMenu.twitterButton.hitBox);
		}
		public function addCommonMenuListeners( button:MovieClip ):void {
			button.addEventListener(MouseEvent.MOUSE_UP, mainMenuButtonUp, false, 0 ,true);
			button.addEventListener(MouseEvent.MOUSE_OVER, mainMenuButtonOver, false, 0 ,true);
			button.addEventListener(MouseEvent.MOUSE_DOWN, mainMenuButtonDown, false, 0 ,true);
			button.addEventListener(MouseEvent.MOUSE_OUT, mainMenuButtonOut, false, 0 ,true);
		}
		public function removeCommonMenuListeners( button:MovieClip ):void {
			button.removeEventListener(MouseEvent.MOUSE_UP, mainMenuButtonUp);
			button.removeEventListener(MouseEvent.MOUSE_OVER, mainMenuButtonOver);
			button.removeEventListener(MouseEvent.MOUSE_DOWN, mainMenuButtonDown);
			button.removeEventListener(MouseEvent.MOUSE_OUT, mainMenuButtonOut);
		}
		public function getButton(event:MouseEvent):MovieClip {
			return event.target.parent.button;
		}
		public function getMapButtonNumber(event:MouseEvent):int {
			var num1:int = int(event.target.parent.name.charAt(11));
			var num2:int = int(event.target.parent.name.charAt(12));
			
			if (num2 != 0)
				return num2 + num1*10;
			else
				return num1;
		}
		public function getButtonName(event:MouseEvent):String {
			return event.target.parent.name;
		}
		public function getButtonParent(event:MouseEvent):MovieClip {
			return event.target.parent;
		}
		
		
		public function setScale(object:MovieClip, scale:Number):void {
			if (object.parent is MedalButton) {trace(MovieClip(object.parent).originalScale);
			object.scaleX = scale * MovieClip(object.parent).originalScale;
			object.scaleY = scale * MovieClip(object.parent).originalScale; 
			}
			else {
				object.scaleX = scale;
				object.scaleY = scale;
			}
		}
		public function collectGarbage():void {
			//var _frameRate:int = stage.frameRate;
			//stage.frameRate = 1;
			return;System.pauseForGCIfCollectionImminent(0);
			
			if (_gameStageMC != null)
				_gameStageMC.collectBodiesArr();
						System.pauseForGCIfCollectionImminent(0);
						System.pauseForGCIfCollectionImminent(1);
						 System.gc();
			
			//stage.frameRate = _frameRate;
			//_frameRate = null;
		}
		public function unlockNgMedal(medalName:String):void {
			API.unlockMedal(medalName);
		}
		public function mainMenuButtonUp(event:MouseEvent):void {
			 doRandomButtonClickSound();
			setScale( getButton(event), 1 );
			if (getButtonName(event) == "musicButton") {
				changeMusicOption();
				getButton(event).gotoAndStop("refresh");
			}
			else if (getButtonName(event) == "fxButton") {
				changeFxOption();
				getButton(event).gotoAndStop("refresh");
			}
			else if (getButtonName(event) == "newGameButton") {
				removeMainMenuButtons();
				screenOut.play();
				screenOutFunction = startIntroMovie;
					unlockNgMedal("The Chase Begins!");
			}
			else if (getButtonName(event) == "continueButton") {
				if (currentLevel != 0) {
					removeMainMenuButtons();
					screenOut.play();
					screenOutFunction = showMap;
				}
			}
			else if (getButtonName(event) == "controlsButton") {
				removeMainMenuButtons();
				screenOut.play();
				screenOutFunction = showControls;
			}
			else if (getButtonName(event) == "creditsButton") {
				removeMainMenuButtons();
				screenOut.play();
				screenOutFunction = showCredits;
			}
			else if (getButtonName(event) == "twitterButton") {
			try {
				navigateToURL(new URLRequest("http://twitter.com/Eranburger"));
			} catch (e:Error) {
				trace(e.toString());
			}
}
			else if (getButtonName(event) == "medalsButton") {
    try {
        navigateToURL(new URLRequest("https://play.google.com/store/apps/details?id=air.eran.ChickenChaser"));
    } catch (e:Error) {
        trace(e.toString());
    }
				return;removeMainMenuButtons();
				screenOut.play();
				screenOutFunction = showMedalsScreen;
			}
			else if (getButtonName(event) == "gotItButton") {
				trace("LDD");
				if (currentLabel == "map" && !seenControlsScreen) {
					screenOut.play();seenControlsScreen = true;
					saveData();
					screenOutFunction = removeControls;
					screenOutFunction2 = this["startStage" + choosenLevel];
				} else if (currentLabel == "game") {
					trace("L2D3D");screenOut.play();
					screenOutFunction = removeControls;
					screenOutFunction2 = addPauseScreenListeners;
				} else {//menu
					trace("L2DD");screenOut.play();
					screenOutFunction = removeControls;
					screenOutFunction2 = addMainMenuButtons;
				}
			}
			else if (getButtonName(event) == "returnButton") {
					screenOut.play();
					screenOutFunction = removeCredits;
					music.stopAll();
			music.playLoop("MenuMusic", 2, 80);
					screenOutFunction2 = addMainMenuButtons;
			}
			
			else if (getButtonName(event) == "skipButton") {
				removeMovie();
			}
			else if (getButtonName(event) == "goButton") {
				//start level
				if (currentLevel >= choosenLevel) {
				screenOut.play();
				screenOutFunction = removeMap;
				screenOutFunction2 = this["startStage" + choosenLevel];
				}
			}
			else if (getButtonName(event) == "backButton") {
				screenOut.play();
				screenOutFunction = removeMap;
				screenOutFunction2 = showMenu;
			}
			else if (getButtonName(event) == "pauseButton") {
				screenOut.play();
				screenOutFunction = showPauseScreen;
				collectGarbage();
				//screenOutFunction2 = showMenu;
				pausedKeyPressedHandler();
			}
			else if (getButtonName(event) == "pauseScreenControlsButton") {
				screenOut.play();
				removePauseScreenListeners();
				screenOutFunction = showControls;
			}
			else if (getButtonName(event) == "exitButton") {
				
				try {
			totalKills += _gameStageMC.overAllDeathCount;
			totalFramesInLevel += _gameStageMC.frameTimer.currentFrameCount;
			saveData();
				}
				catch (error:Error) {trace("exit save error");}
				
				screenOut.play();
				removePauseScreenListeners();
				screenOutFunction = removePauseMenu;
				removeGame();
				screenOutFunction2 = showMap;
			}
			else if (getButtonName(event) == "resumeGameButton") {
				screenOut.play();
				removePauseScreenListeners();
				screenOutFunction = removePauseMenu;
				screenOutFunction2 = unpauseGame;
			}
			else if (getButtonName(event) == "continueFromVictoryButton") {
				if (currentLevel == 8 && (choosenLevel == 7 || choosenLevel == 8)) {
					screenOut.play();
					removeVictoryScreenListeners();
					screenOutFunction = removeVictoryScreen;
					screenOutFunction2 = showFinal;
					return;
				}
				screenOut.play();
				removeVictoryScreenListeners();
				screenOutFunction = removeVictoryScreen;
				screenOutFunction2 = showMap;
			}
			
			else if (getButtonParent(event) is MedalButton) {
				updateMedalInfoTo(getButtonParent(event).medalNum);
			}
		}
		///Pause screen functions
		public function showPauseScreen():void {
			stage.quality = StageQuality.HIGH;
			pauseScreen = new PauseScreen();
			addChild(pauseScreen);
			this.setChildIndex(pauseScreen, numChildren - 4);
			if (virtualJoystick != null)
				virtualJoystick.visible = false;
			pauseButton.visible = false;
			pauseGame();
			addPauseScreenListeners();
		}
		public function addPauseScreenListeners():void {
			addCommonMenuListeners(pauseScreen.pauseScreenControlsButton.hitBox);
			addCommonMenuListeners(pauseScreen.musicButton.hitBox);
			addCommonMenuListeners(pauseScreen.fxButton.hitBox);
			addCommonMenuListeners(pauseScreen.exitButton.hitBox);
			addCommonMenuListeners(pauseScreen.resumeGameButton.hitBox);
		}
		public function removePauseScreenListeners():void {
			removeCommonMenuListeners(pauseScreen.pauseScreenControlsButton.hitBox);
			removeCommonMenuListeners(pauseScreen.musicButton.hitBox);
			removeCommonMenuListeners(pauseScreen.fxButton.hitBox);
			removeCommonMenuListeners(pauseScreen.exitButton.hitBox);
			removeCommonMenuListeners(pauseScreen.resumeGameButton.hitBox);
		}
		public function removePauseMenu():void {
			stage.quality = StageQuality.LOW;
			removeChild(pauseScreen);
			pauseScreen = null;
			if (virtualJoystick != null)
				virtualJoystick.visible = true;
			pauseButton.visible = true;
			unpauseGame();
		}
		////
		public function startIntroMovie():void {
			//
			music.stopAll();
			music.play("CompleteIntro", 1, 0);
			music.play("IntroMusic", 0.7, 0);
			
			introMovie = new IntoMovie();
			addChild(introMovie);
			introMovie.x = 43;
			introMovie.y = 17;
			this.setChildIndex(introMovie, 1);
			introMovie.addEventListener(MouseEvent.MOUSE_UP, showSkipButton, false, 0 ,true);
			addCommonMenuListeners(introMovie.skipButton.hitBox);
			introMovie.skipButton.visible = false;
			stage.frameRate = 60;
		}
		public function showSkipButton(event:MouseEvent = null):void {
			introMovie.skipButton.visible = true;
		}
		public function removeMovie(event:MouseEvent = null):void {
			stage.frameRate = originalFrameRate;
			screenOut.play();
			screenOutFunction = deleteMovie;
			screenOutFunction2 = showMap;
			removeCommonMenuListeners(introMovie.skipButton.hitBox);
			
			restInnerData();
			deleteSave();
		}
		public function deleteMovie():void {
			introMovie.stop();
			introMovie.removeEventListener(MouseEvent.MOUSE_UP, showSkipButton);
			removeChild(MovieClip(introMovie));
			introMovie = null;
		}
		public function showMap():void {
			stage.quality = StageQuality.HIGH;
			music.stopAll();fx.stopAll();
			music.playLoop("worldMap", 0.8);

						
			if (currentLevel == 0) {
				currentLevel = 1;
				saveData();
			}
			choosenLevel = currentLevel;
			gotoAndStop("map");		
			
			map.visible = true;
			for (var i:int = 0; i < 30; ++i) {
				if (map.getChildByName("levelButton" + i) != null) {
					setMapButton( map.getChildByName("levelButton" + i), i );
					//if (i > currentLevel )
						//map.getChildByName("levelButton" + i).visible = false;
				}
			}
			map.lines.gotoAndStop(currentLevel);
			updateMapLabelTo(currentLevel, map.getChildByName("levelButton" + currentLevel));
		}
		public function setMapButton( button:*, buttonNum:int ):void {
			if ( currentLevel == buttonNum ) {
				button.button.gotoAndStop("current");
				button.hand.visible = false;
			} else if (currentLevel > buttonNum) {	//lcoked
				button.button.gotoAndStop("open");
				button.hand.visible = false;
			} else {	//open
				button.button.gotoAndStop("locked");
				button.hand.visible = false;
			}
			addMapButtonEventListener(button.hitBox);
			addCommonMenuListeners(map.goButton);
			addCommonMenuListeners(map.backButton);
			
		}
		public function removeMapButtonListeners():void {
			for (var i:int = 0; i < 30; ++i) {
				if (map.getChildByName("levelButton" + i) != null)
					removeMapButtonEventListener( MovieClip(map.getChildByName("levelButton" + i)).hitBox );
				}
			removeCommonMenuListeners(map.goButton);
			removeCommonMenuListeners(map.backButton);
		}
		public function addMapButtonEventListener(button:*):void {
			button.addEventListener(MouseEvent.MOUSE_UP, onMapButtonUp, false, 0 ,true);
			button.addEventListener(MouseEvent.MOUSE_OVER, onMapButtonOver, false, 0 ,true);
			button.addEventListener(MouseEvent.MOUSE_DOWN, onMapButtonDown, false, 0 ,true);
			button.addEventListener(MouseEvent.MOUSE_OUT, onMapButtonOut, false, 0 ,true);
		}
		public function removeMapButtonEventListener( button:* ):void {
			button.removeEventListener(MouseEvent.MOUSE_UP, onMapButtonUp);
			button.removeEventListener(MouseEvent.MOUSE_OVER, onMapButtonOver);
			button.removeEventListener(MouseEvent.MOUSE_DOWN, onMapButtonDown);
			button.removeEventListener(MouseEvent.MOUSE_OUT, onMapButtonOut);
		}
		public function onMapButtonDown(event:MouseEvent):void {
			getButton(event).down.visible = true;
			getButton(event).up.visible = false;
			setScale( getButton(event), 0.8 );
		}
		public function onMapButtonUp(event:MouseEvent):void {
			doRandomButtonClickSound();
			getButton(event).down.visible = false;
			getButton(event).up.visible = false;
			setScale( getButton(event), 1 );
			
			updateMapLabelTo(getMapButtonNumber(event), getButton(event));
			
			/*if (currentLevel >= getMapButtonNumber(event)) {
				screenOut.play();
				screenOutFunction = removeMap;
				screenOutFunction2 = this["startStage" + getMapButtonNumber(event)];
			}*/
		}
		public function hideAllOtherHands():void {
			for (var i:int = 0; i < 30; ++i) {
				if (map.getChildByName("levelButton" + i) != null)
					MovieClip(map.getChildByName("levelButton" + i)).hand.visible = false;
				}
		}
		public function updateMapLabelTo(level:int, button:*):void {
			choosenLevel = level;
			
			if (currentLevel < level) {
				map.levelText.text = "???";
			}
			else {
				if (level == 1)
					map.levelText.text = "#1- The Chase Begins";
				else if (level == 2)
					map.levelText.text = "#2- Octopus Garden";
				else if (level == 3)
					map.levelText.text = "#3- Land of Goo";
				else if (level == 4)
					map.levelText.text = "#4- Tentacle Hell";
				else if (level == 5)
					map.levelText.text = "#5- The Frontier";
				else if (level == 6)
					map.levelText.text = "#6- On Starstruck Land";
				else if (level == 7 || level == 8)
					map.levelText.text = "#7- The Moon is Not Yellow";
			}
			hideAllOtherHands();
			if (level != 8)
				MovieClip(map.getChildByName("levelButton" + level)).hand.visible = true;
			if (level == 8)
				MovieClip(map.getChildByName("levelButton" + 7)).hand.visible = true;
			if (currentLevel >= level) {
				map.goButton.visible = true;
			} else {
				map.goButton.visible = false;
			}
			if (level != 8) {
				if (bestTimesArray[level-1] != -1)
					updateMapTimeTo(bestTimesArray[level-1]);
				else
					map.timerText.text = "NONE";
			}
			else if (level == 8) {
				if (bestTimesArray[7-1] != -1)
					updateMapTimeTo(bestTimesArray[7-1]);
				else
					map.timerText.text = "NONE";
			}	
			updateMapTotalTimeTo(totalFramesInLevel);
			map.totalKillsText.text = totalKills;
		}
		public function updateMapTotalTimeTo(framesNum:int):void {
			framesNum/=originalFrameRate;
			var minutes:int = framesNum/60;
			var seconds:int = framesNum%60;
			if (seconds <= 9 )
				map.totalTimerText.text =  " "+minutes +":0"+seconds;
			else
				map.totalTimerText.text =  minutes +":"+seconds;			
		}
		public function updateMapTimeTo(framesNum:int):void {
			framesNum/=originalFrameRate;
			var minutes:int = framesNum/60;
			var seconds:int = framesNum%60;
			if (seconds <= 9 )
				map.timerText.text =  " "+minutes +":0"+seconds;
			else
				map.timerText.text =  minutes +":"+seconds;
		}
		public function removeMap():void {
			removeMapButtonListeners();
		}
		
		
		public function startStage1():void {
			if (!seenControlsScreen) {	showControls();	return;	}
				commonStartGame();
				music.playLoop("octopusMusic1", 0.85);
				_gameStageMC = new firstStage();
				addChild(_gameStageMC);
				this.setChildIndex(_gameStageMC, 1);	
		}
		
		public function startStage2():void {if (!seenControlsScreen) {	showControls();	return;	}
			commonStartGame();
			music.playLoop("octopusMusic1", 0.85);
			_gameStageMC = new stage3();//Stage1();
			addChild(_gameStageMC);
			this.setChildIndex(_gameStageMC, 1);			
		}
		public function startStage3():void {if (!seenControlsScreen) {	showControls();	return;	}
			commonStartGame();
			music.playLoop("inkMusic", 0.85);
			_gameStageMC = new Stage2();//Stage1();
			addChild(_gameStageMC);
			this.setChildIndex(_gameStageMC, 1);
		}		
		public function startStage4():void {if (!seenControlsScreen) {	showControls();	return;	}
			commonStartGame();
			music.playLoop("boss1Music", 1);
			_gameStageMC = new bossStage();//firstStage()();
			addChild(_gameStageMC);
			this.setChildIndex(_gameStageMC, 1);
		}
		public function startStage5():void {if (!seenControlsScreen) {	showControls();	return;	}
			commonStartGame();
			music.playLoop("wildWest", 0.9);
			_gameStageMC = new westStage();//Stage1();
			addChild(_gameStageMC);
			this.setChildIndex(_gameStageMC, 1);
		}
		public function startStage6():void {if (!seenControlsScreen) {	showControls();	return;	}
			commonStartGame();
			music.playLoop("starsMusic", 0.6);
			_gameStageMC = new starsStages();//Stage1();
			addChild(_gameStageMC);
			this.setChildIndex(_gameStageMC, 1);
		}
		public function startStage7():void {if (!seenControlsScreen) {	showControls();	return;	}
			commonStartGame();
			music.playLoop("shipMusic", 0.6);
			_gameStageMC = new finalBossStage();//Stage1();
			addChild(_gameStageMC);
			this.setChildIndex(_gameStageMC, 1);
		}
		public function startStage8():void {
			startStage7();
		}
		public function onMapButtonOver(event:MouseEvent):void {
			getButton(event).
			down.visible = false;
			getButton(event).
			up.visible = true;
			setScale( getButton(event), 1.2 );
		}
		public function onMapButtonOut(event:MouseEvent):void {
			getButton(event).down.visible = false;
			getButton(event).up.visible = false;
			setScale( getButton(event), 1 );
		}
		public function addControlsEventListener():void {
			addCommonMenuListeners(controlsScreenVar.gotItButton.hitBox);
		}
		public function addCreditsEventListener():void {
			addCommonMenuListeners(creditsScreenVar.returnButton.hitBox);
		}
		public function showControls():void {
			controlsScreenVar = new controlsScreen();
			addChild(controlsScreenVar);
			if (currentLabel == "game")
				this.setChildIndex(controlsScreenVar, numChildren - 4);	
			else if (currentLabel == "map")//first time enetering level
				this.setChildIndex(controlsScreenVar, numChildren - 2	);	
			else
				this.setChildIndex(controlsScreenVar, 1);
			controlsScreenVar.gotoAndPlay("start");
		}
		public function showCredits():void {
			creditsScreenVar = new creditsScreen();
			addChild(creditsScreenVar);
			this.setChildIndex(creditsScreenVar, 1);
			music.stopAll();
			music.playLoop("creditsMusic", 2, 1);
			//controlsScreenVar.gotoAndPlay("start");
		}
		
		public function showMedalsScreen():void {
			medalsScreenVar = new medalsScreen();
			addChild(medalsScreenVar);
			this.setChildIndex(medalsScreenVar, 1);
			createMedalButtons();
			//controlsScreenVar.gotoAndPlay("start");
		}
		public function updateMedalInfoTo(num:int):void {
			medalsScreenVar.medalNameText.text = medalsArr[num].medalName;
			if (medalsArr[num].secret)
				medalsScreenVar.medalDescText.text = "";
			else
				medalsScreenVar.medalDescText.text = medalsArr[num].text;
		}
		public function unlockMedal(medalName:String):void {
			for (var i:int = 0; i < medalsArr.length; ++i) {
				if (medalsArr[i].medalName == medalName)
					gotMedalsArr[i] = true;
			}
		}
		public function playUnlockAnimation(medalName:String):void {
			trace("ANIMATION MEDAL");
			//addChild(new MedalUnlocked());
		}
		public function createMedalButtons():void {
			var temp:*;
			var xPlace:int = 100;
			var yPlace:int = 150;
			var xSpace:int = 15 + 75;
			var ySpace:int = 15;
			var xSize:int = 8;
			
			for (var i:int = 0; i < medalsArr.length; ++i) {
				temp = new MedalButton();
				medalsScreenVar.addChild(temp);
				temp.x = xPlace + (int (i%xSize) * xSpace);
				temp.y = yPlace + ySpace * (int(i/xSize)+1);
				temp.name = "medal" + i;
				addCommonMenuListeners(temp.hitBox);
				temp.medalNum = i;
				temp.button.width = 75;
				temp.button.height = 75;
				temp.originalScale = temp.button.scaleX;
				try {
				temp.button.gotoAndStop(medalsArr[i].medalName);
				}
				catch (error:Error) {
					temp.button.gotoAndStop("secret");
				}
				if (gotMedalsArr[i] == false) {
					temp.button.locked.alpha = 0.9;
				}
				else
					temp.button.locked.visible = false;
					
			}
		}
		public function removeMedalsScreen():void {
			//removeCommonMenuListeners(controlsScreenVar.gotItButton.hitBox);
			removeChild(medalsScreenVar);
			medalsScreenVar = null;
		}
		public function removeControls():void {
			removeCommonMenuListeners(controlsScreenVar.gotItButton.hitBox);
			removeChild(controlsScreenVar);
			controlsScreenVar = null;
		}
		public function removeCredits():void {
			removeCommonMenuListeners(creditsScreenVar.returnButton.hitBox);
			removeChild(creditsScreenVar);
			creditsScreenVar = null;
		}
		
		public function mainMenuButtonOver(event:MouseEvent):void {
			setScale( getButton(event), 1.1 );
		}
		public function mainMenuButtonDown(event:MouseEvent):void {
			setScale( getButton(event), 0.9 );
		}
		public function mainMenuButtonOut(event:MouseEvent):void {
			setScale( getButton(event), 1 );
		}
		
		public function addKeyListeners():void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 10, true);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp , false, 9, true);
		}
		public function onKeyDown(e:KeyboardEvent):void	{
			if ( isInGame ) {
				if (! isPaused )
					gameStageMC.player.onKeyDown( e );
			}
			else
			{
				if (e.keyCode == Keyboard.F)
					FisDown = true;
				if (e.keyCode == Keyboard.I)
					IisDown = true;
				if (e.keyCode == Keyboard.N)
					NisDown = true;
				if (e.keyCode == Keyboard.S)
					SisDown = true;
				if (e.keyCode == Keyboard.H)
					HisDown = true;
				
				if (FisDown && IisDown && NisDown && SisDown && HisDown)
				{
					currentLevel = 7;
					saveData();
				}
					
					
			}
			
		}
		public function onKeyUp(e:KeyboardEvent):void {
			
			
			/*switch(e.keyCode)
			{
				case KEY_PAUSE:
					pausedKeyPressedHandler();
					break;
				case KEY_MUTE:
					muteKeyPressedHandler();
					break;
			}*/
			
			if ( isInGame ) {

				/*if (e.keyCode == Keyboard.N)
					startInk();
				if (e.keyCode == Keyboard.I)
					shakeInk();
				*/
				if (! isPaused )
					gameStageMC.player.onKeyUp( e );
			}
			else
			{
				if (e.keyCode == Keyboard.F)
					FisDown = false;
				if (e.keyCode == Keyboard.I)
					IisDown = false;
				if (e.keyCode == Keyboard.N)
					NisDown = false;
				if (e.keyCode == Keyboard.S)
					SisDown = false;
				if (e.keyCode == Keyboard.H)
					HisDown = false;
					
			}
		}
		
		
		public function startInk():void	{
			if (_gameStageMC.inkOnScreen == false) {
				inkScreen.visible = true;
				inkScreen.gotoAndPlay("splash");
				_gameStageMC.inkOnScreen = true;
				shake = 42;
				_gameStageMC.player.goInked();
			}
		}
		public function shakeInk():void {
			if (inkScreen.currentLabel == "visible") {
				shake = 44;
			}
		}
		public function endInk():void {
			inkScreen.visible = false;
			_gameStageMC.player.goUnInked();
			_gameStageMC.inkOnScreen = false;
			
		}
		public function inkEnterFrame():void
		{
			inkScreen.x = originalInkX;
			inkScreen.y = originalInkY;
			if (shake != 0)	{
				if (shake == 44) {
					inkScreen.nextFrame();
					if (inkScreen.currentLabel == "invisible") {
						endInk();
					}
				}
				inkScreen.x += Math.random() * shake - shake/2;
				inkScreen.y += Math.random() * shake - shake/2;
				shake -= 2;
			}
		}
		
		public function onClickLeft(event:MouseEvent):void
		{
			gameStageMC.player.pressDir(2);
		}public function onClickUp(event:MouseEvent):void
		{
			gameStageMC.player.pressDir(0);
		}public function onClickDown(event:MouseEvent):void
		{
			gameStageMC.player.pressDir(1);
		}public function onClickRight(event:MouseEvent):void
		{
			gameStageMC.player.pressDir(3);
		}
		public function finishGame():void
		{
			removeGame();
			gotoAndStop("gameFinish");
		}
		public function putScreenOutOnTop():void {
			//setChildIndex(screenOut, numChildren - 2 );
		}
		public function getStageWidth():int	{
			return _gameStageMC.width;
		}
		
		public function showReadyGo():void {
			trace(readyGoMC);
			trace(MovieClip(readyGoMC));
			readyGoMC.gotoAndPlay(1);
		}
		public function showGo():void {
			readyGoMC.gotoAndPlay("go");
		}
		public function hideGo():void {
			readyGoMC.gotoAndPlay("dissapear");
		}
		public function removeGo():void {
			readyGoMC.gotoAndStop(1);
		}
		public function setMaxHP(hp:Number):void
		{
			for (var i:int = hp; i <= 10; i++)
			{
				 MovieClip(heartsContainer).getChildByName("h" + i).visible = false;
			}
		}
		public function doBossBarFill():void {
			MovieClip(heartsContainer).bossBar.visible = true;
			MovieClip(heartsContainer).bossBar.gotoAndPlay("fill");
		}
		public function updateBossHp(hpVar:int, maxHp:int):void {
			MovieClip(heartsContainer).bossBar.updateHp(hpVar, maxHp);
		}
		public function hideHearts():void {
			for (var i:int = 0; i <= 10; ++i)
				MovieClip(heartsContainer).getChildByName("h" + i).visible = false;
		}
		public function showHearts():void {
			for (var i:int = 0; i <= 10; i++)
				MovieClip(heartsContainer).getChildByName("h" + i).visible = true;
		}
		public function updateHearts(hp:Number):void
		{	
			for (var i:int = 0; i <= 10; i++)
			{
				heartMc = MovieClip(heartsContainer).getChildByName("h" + i);
				heartMc.scaleX = 1;
				heartMc.scaleY = 1;
				if (i + 1 == hp || i + 0.5 == hp) {
					heartMc.scaleX = 1.4;
					heartMc.scaleY = 1.4;
					MovieClip(heartsContainer).setChildIndex(heartMc, MovieClip(heartsContainer).numChildren - 1 );
				}
				if (i + 0.5 == hp) {
					heartMc.gotoAndStop("half");
				}
				else if (Math.floor(hp - 1) >= i) {
					heartMc.gotoAndStop("full");
				}
				else
					heartMc.gotoAndStop("empty");
			}
		}
		public function updateHearts2(hp:Number):void
		{	
			for (var i:int = 0; i <= 10; i++)
			{
				heartMc = MovieClip(heartsContainer).getChildByName("h" + i);
				if (i + 0.5 == hp) {
					heartMc.gotoAndStop("half");
				}
				else if (Math.floor(hp - 1) >= i) {
					heartMc.gotoAndStop("full");
				}
				else
					heartMc.gotoAndStop("empty");
			}
		}
		public function askForBackground(backgroundName:String):void {
			backgrounds.gotoAndStop(backgroundName);
			this.setChildIndex(backgrounds, 0 );
		}
	
		public function addPlus1Animation(fromX:int, fromY:int):void
		{
			var temp:MovieClip = new plus1Animation();
			addChild(temp);
			temp.x = fromX;
			temp.y = fromY;
			hearthAnimations.push(temp);
			TweenLite.to(temp,70, {x:150, y:30, alpha: 0.2, overwrite:false, useFrames:true, onComplete: removeHearthAnimation});		
		}
		public function removeHearthAnimation():void
		{
			removeChild(hearthAnimations[0]);
			hearthAnimations.shift();
		}
		public function doScreenOutFunction():void {
			if (screenOutFunction != null)
				screenOutFunction();
			screenOutFunction = null;
			if (screenOutFunction2 != null)
				screenOutFunction2();
			screenOutFunction2 = null;
		}
		public function onTouchEnd(e:TouchEvent):void
		{	
			if (! isPaused )
				if (e.stageX >= stage05Width)	{
					if (e.stageX >= stage075Width && e.stageY > stage01Height)
						_gameStageMC.player.tryAttack();	
					else
						_gameStageMC.player.tryAttackHeavy();
					} else {
					virtualJoystick.on_mouseUp(e);
					}
		}
		public function onTouchBegin(e:TouchEvent):void
		{
			if (! isPaused )
				if (e.stageY > stage01Height)
				if (e.stageX < stage05Width)
				{
					virtualJoystick.on_mouseDownTouch(e);
				}
		}
		public function removeGame():void
		{
			if (pauseScreen != null && screenOutFunction != removePauseMenu &&	screenOutFunction2 != unpauseGame)
			{
				removePauseScreenListeners();
				removePauseMenu();
			}
			MovieClip(heartsContainer).bossBar.visible = false;
			MovieClip(heartsContainer).bossBar.gotoAndStop(1);
			isInGame = false;
			endInk();
			stage.quality = StageQuality.HIGH;
			if (android)
			removeChild(virtualJoystick);
			TweenLite.killTweensOf(_gameStageMC);
			_gameStageMC.killStage();
			removeChild(_gameStageMC);
			removeCommonMenuListeners(MovieClip(this).pauseButton.hitBox);
			fx.stopAll();
			music.stopAll();
			_gameStageMC = null;
			//hideGo();
			hideHearts();
			comboMc.gotoAndStop("invisible");
			collectGarbage();
		}
		public function resumGame():void {
			collectGarbage();
			collectGarbage();
		}
		public function showMenu():void {trace("SHOWINGMENU");
			stage.quality = StageQuality.HIGH;
			gotoAndStop("menu");
			
			fx.stopAll();
			music.stopAll();
			music.playLoop("MenuMusic", 2, 80);
		}
		public function showMenuWithoutIntro():void {
			stage.quality = StageQuality.HIGH;
			gotoAndStop("menu");
			mainMenu.gotoAndStop("end");
		}
		public function hideMenu():void
		{stage.quality = StageQuality.LOW;
		}
		
		
		
		public  function pausedKeyPressedHandler():void {
			if (! isPaused)
				pauseGame();
			else
				unpauseGame();
		}
		
		public function pauseGameNow():void {
			pauseGame();
			showPauseScreen();
		}
		public function pauseGame():void {
			if (! isPaused) {
				isPaused = true;
				music.pauseAll();
				fx.pauseAll();
				if (_gameStageMC != null) {
					_gameStageMC.pauseObjects();
					_gameStageMC.isPaused = true;
				}
				collectGarbage();
			}
		}
		public function unpauseGame():void {
			if (isPaused) {
				isPaused = false;
				music.resumeAll();
				fx.resumeAll();
				if (_gameStageMC != null) {
					_gameStageMC.resumeObjects();
					_gameStageMC.isPaused = false;				
				}
				collectGarbage();
			}
		}
		function onActivate ( e:Event ):void {			
			if ( !isInGame ) {
				music.volume = 1;
				fx.volume = 1;
			}
			stage.frameRate = originalFrameRate;
		} 
		function onDeactivate ( e:Event ):void {
			if ( isInGame ) {
				if (!isPaused)
					pauseGameNow();
			} else {
				music.volume = 0;
				fx.volume = 0;
			}
			collectGarbage();
			if (android)
				stage.frameRate = 0;
		}
		public function muteKeyPressedHandler():void {
			if (! isMuted)
				muteGame();
			else
				unmuteGame();
		}
		public function muteGame():void {
			music.mute = true;
			fx.mute = true;
			isMuted = true;
		}
		public function unmuteGame():void {
			music.mute = false;
			fx.mute = false;
			isMuted = false;
		}
		public function changeMusicOption() {
			changeMusicOptionTo(!musicOption);
		}
		public function changeMusicOptionTo(option:Boolean) {
			if (option == true) {
				musicOption = true;
				music.mute = false;
			} else {
				musicOption = false;
				music.mute = true;
			}
		}
		public function changeFxOption() {
			changeFxOptionTo(!fxOption);
		}
		public function changeFxOptionTo(option:Boolean) {
			if (option == true) {
				fxOption = true;
				fx.mute = false;
			} else {
				fxOption = false;
				fx.mute = true;
			}
		}
		
		public function gameOver(_totalKills:int = 0, totalFramesTime:int = 0):void
		{
			totalKills += _totalKills;
			totalFramesInLevel += totalFramesTime;
			saveData();
			screenOut.play();
			screenOutFunction = removeGame;
			screenOutFunction2 = this["startStage" + choosenLevel];
		}
		public function updateCombo(num:int):void
		{
			if (num <= 1)
			{
				if (comboMc.currentLabel == "visible")
					comboMc.gotoAndPlay("disappear");
				else if (comboMc.currentLabel == "show")
					comboMc.gotoAndStop("invisible");
			}
			else
			{
				updateNumbers(num);
				if (comboMc.currentLabel == "invisible" || comboMc.currentLabel == "disappear")
					comboMc.gotoAndPlay("show");
			}
		}
		public function updateNumbers(num):void
		{
			var units:int = num % 10;
			var tens:int = num / 10;
			if (units >= 1 && units <= 9)
				comboMc.unitsNumber.gotoAndStop(units);
			else if (units == 0)
				comboMc.unitsNumber.gotoAndStop(10);
			else
				comboMc.unitsNumber.gotoAndStop(11);
				
			if (tens >= 1 && tens <= 9)
				comboMc.tensNumber.gotoAndStop(tens);
			else
				comboMc.tensNumber.gotoAndStop(11);
		}
		public function set gameStageMC(temp:MovieClip):void
		{
			this._gameStageMC = temp;
		}
		public function get gameStageMC():MovieClip
		{
			return this._gameStageMC;
		}
		
	}
	
}   