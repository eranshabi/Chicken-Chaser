package  {	
	import flash.system.*;
	import pathfinding.Pathfinder;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.StageQuality;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.sensors.Accelerometer;
	import flash.display.Stage;
	import flash.display.DisplayObject;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.greensock.TweenLite;

	public class firstStage extends GameStage {
		public var arenaStartFrame:int;
		public var arenaGuy:*;
		public function firstStage() {}
			
		protected override function init2():void {
			levelNum = 1;
			useBodiesArr = false;
			if (Main.instance.android)
				Main.instance.askForBackground("cloudsStopped");
			else
				Main.instance.askForBackground("clouds");
			addPlayer(-200);
			Main.instance.showReadyGo();
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0 ,true);
		}
		/*public override function remove(mc:MovieClip):void {
			var toBeRemove:MovieClip = MovieClip(getChildByName(mc.name));
			toBeRemove.parent.removeChild(toBeRemove);
		}*/
		
		
		public function finishLevel():void {
			Main.instance.putVictoryScreen(overAllDeathCount, frameTimer.currentFrameCount, levelNum, lastLevel);
		}
		
		
		 ////////////////////////////////
		///////Start Meet: meet1////////
		
		public function meet1update():void {genericMeetUpdate();}

		public function meet1preload():void {
			expectingEvents = true;
			setFreeRoam();
			/*projectileManager.createLaser(250, 700, LEFT);
			projectileManager.createLaser(550, 800, RIGHT);
			projectileManager.createLaser(550, 750, LEFT);*/
		}
		public function creatLaser():void {
			projectileManager.createInk(550, 800, RIGHT).setDelayedCollision();
			
		}
		public function meet1start():void {Main.instance.hideGo();
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			setCirclesSize(1, 2, 10);
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 30, getMeetPoint("point6").x , getMeetPoint("point6").y, RIGHT, null);
			Main.instance.collectGarbage();
		}
		public function meet1_event1():Boolean {
			if (deathCount >= 1) {
				//Main.instance.unlockMedal("First Kill");
				//Main.instance.playUnlockAnimation("First Kill");
				Main.instance.unlockNgMedal("First Blood");				
				return true;
			}
			return false;
		}
			
		public function meet1_event2():Boolean {
			if (deathCount >= 2) {
				currentMeet().end();
				Main.instance.showGo();
				return true;
			}
			return false;
		}
			
		public function meet1end():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		 //////End Meet: meet1////////
		/////////////////////////////
			//meetArena
		
		 ///////////////////////////////
		///////Start Meet: meet2///////
		
		public function meet2preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function meet2start():void {Main.instance.hideGo();
			resetBloodContainer();
			F98m.visible = false;
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			setCirclesSize(2, 2, 10);
			addOcto(NO_DIR_Y, LEFT, 60, 66, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "jumpIntro");
			addOcto(NO_DIR_Y, RIGHT, 60, 23, getMeetPoint("point11").x , getMeetPoint("point11").y, LEFT, "jumpIntro");
				Main.instance.collectGarbage();
		}
		
		
		
		public function meet2_event1():Boolean {
			if (deathCount >= 2) {
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "jumpIntro");
			addOcto(NO_DIR_Y, RIGHT, 60, 23, getMeetPoint("point11").x , getMeetPoint("point11").y, LEFT, "jumpIntro");
					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet2_event2():Boolean {
			if (deathCount == 5) {
				currentMeet().end();
				Main.instance.showGo();
				
				
				return true;
			}
			return false;
		}
		
		public function meet2update():void {genericMeetUpdate();}
		
		public function meet2end():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////Meet2 END///////////////
		///////////////////////////////
		
		///
		
		 ///////////////////////////////
		///////Start Meet: meet2///////
		
		public function meetPreArenapreload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function meetPreArenastart():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			setCirclesSize(3, 2, 10);
			addOcto(NO_DIR_Y, RIGHT, 60, 11, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 44, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 11, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
			Main.instance.collectGarbage();
		}
		
		public function meetPreArena_event1():Boolean {
			if (deathCount >= 1) {
				addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, "jumpIntro");
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meetPreArena_event2():Boolean {
			if (deathCount == 4) {
				currentMeet().end();
				Main.instance.showGo();				
				return true;
			}
			return false;
		}
		
		public function meetPreArenaupdate():void {genericMeetUpdate();}
		
		public function meetPreArenaend():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meetPreArena END///////////////
		///////////////////////////////
		
			
		 ///////////////////////////////
		///////Start Meet: meet2///////
		
		public function meetPond1preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function meetPond1start():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			setCirclesSize(3, 2, 10);
			addOcto(NO_DIR_Y, RIGHT, 60, 1, getMeetPoint("point9").x , getMeetPoint("point9").y, LEFT, "jumpIntro");
			addOcto(NO_DIR_Y, LEFT, 60, 22, getMeetPoint("point8").x , getMeetPoint("point8").y, NO_DIR_X, "jumpIntro");
			addOcto(NO_DIR_Y, LEFT, 60, 44, getMeetPoint("point7").x , getMeetPoint("point7").y, RIGHT, "jumpIntro");
			Main.instance.collectGarbage();
		}		
		
		public function meetPond1_event1():Boolean {
			if (deathCount >= 2) {
				addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, "jumpIntro");
				addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meetPond1_event2():Boolean {
			if (deathCount == 5) {
				currentMeet().end();
				Main.instance.showGo();				
				return true;
			}
			return false;
		}
		
		public function meetPond1update():void {genericMeetUpdate();}
		
		public function meetPond1end():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meetPond1 END///////////////
		///////////////////////////////
		
		
		
		 ///////////////////////////////
		///////Start Meet: meetArena///////
		public function meetArenapreload():void {
			expectingEvents = true;
			arenaFence.gotoAndStop("cheer");
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		public function meetArenastart():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();		
			setCirclesSize(3, 2, 10);
			arenaStartFrame = frameTimer.currentFrameCount;
			frameTimer.addTimer( "arenaShake1", 30, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "arenaShake");
			frameTimer.addTimer( "arenaShake2", 30 + 40 + 55, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "arenaShake2");
			frameTimer.addTimer( "arenaShake3", 210, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "arenaShake3");
			arenaGuy = addBullyAI(NO_DIR_Y, LEFT, 80, 230, getMeetPoint("point5").x + 40 , getMeetPoint("point5").y, "octo", "octo", "octo", "octo", LEFT,null);
		//	arenaGuy = addFatOcto(NO_DIR_Y, LEFT, 120, 230, getMeetPoint("point5").x + 40 , getMeetPoint("point5").y, NO_DIR_X);
			Main.instance.collectGarbage();
		}
		public function arenaShake():void {
			playStomp();
			trace("arenaShake");
			setShake(40);
		}
		public function arenaShake2():void {
playStomp();			setShake(50);
		}
		public function arenaShake3():void {
playStomp();			setShake(60);
		}
		public function meetArena_event1():Boolean {
			if (arenaGuy.hp == arenaGuy.maxHp)
				if (frameTimer.currentFrameCount - arenaStartFrame >= gameFrameRate * 17) {
					arenaFence.helper.play();
				return true;
			}
			return false;
		}
		public function meetArena_event2():Boolean {
			if (arenaGuy.hp == arenaGuy.maxHp)
				if (frameTimer.currentFrameCount - arenaStartFrame >= gameFrameRate * 32) {
					arenaFence.helper.play();
				return true;
			}
			return false;
		}
		public function meetArena_event3():Boolean {trace("YO YO YO " + deathCount);
			if (deathCount >= 1) {
				Main.instance.unlockNgMedal("Giants Slayer");
				//arenaGuy = null;
				didEvent2 = true;
				didEvent1 = true;
				_main.fx.play("Squidcrowd");
				arenaFence.gotoAndPlay("moveOut");
				trace("YO YO");
				//Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function arenaLinch():void {
			setCirclesSize(2, 1, 10);
			addOcto(NO_DIR_Y, RIGHT, 60, 50, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
			addOcto(NO_DIR_Y, RIGHT, 60, 100, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 45, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 90, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
			Main.instance.collectGarbage();
		}
		public function meetArena_event4():Boolean {
			if (deathCount >=3) {
				addOcto(NO_DIR_Y, RIGHT, 60, 100, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
				addOcto(NO_DIR_Y, LEFT, 60, 45, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
				addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meetArena_event5():Boolean {
			if (deathCount == 8) {
				Main.instance.unlockNgMedal("Arena Master");
				currentMeet().end();
				Main.instance.showGo();
				return true;
			}
			return false;
		}
		
		public function meetArenaupdate():void {genericMeetUpdate();}
		
		public function meetArenaend():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			//frameTimer.addTimer( "victoryTimer", 80, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "finishLevel");
			//cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////MeetArena END///////////////
		///////////////////////////////
		
		 ///////////////////////////////
		///////Start Meet: VICTORY///////
		
		public function victorypreload():void {Main.instance.music.fadeAllTo(0, 2000);

			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		public function victorystart():void {Main.instance.hideGo();
			
			finishLevel();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			
			freeAllNodesFromLimit();
			setLimits(currentMeet().leftLimit, currentMeet().rightLimit + 111);
		}
		
		public function victory_event1():Boolean {
			if (currentMeet().rightLimit) {
				currentMeet().end();
				return true;
			}
			return false;
		}
			
		public function victoryupdate():void {genericMeetUpdate();}
		
		public function victoryend():void {
			
		}
		////////VICTORY END///////////////
		///////////////////////////////
		
		
		
		public override function checkPopItem(character:MovieClip):void
		{
			//Hearth poping manager
			if ( Math.random() < 0.5 ||  overAllDeathCount == 1  || character is Bully )
			//if (player.hp <= 2 || character is Heavy || overAllDeathCount == 1 || true)
			{
				popItem("hearth", character.x, character.y);
			}
		}
		public override function getTarget():MovieClip
		{
			return player;
		}
		
		/*public override function updateFrames():void
		{
			
			//checkIfDecoShakeByDeco();
			//checkIfSlowdown(player);
		}*/
		
		
	}
	
}
