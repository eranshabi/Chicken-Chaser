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

	public class westStage extends GameStage {
		public var arenaStartFrame:int;
		public var arenaGuy:*;
				var trainAttackStats:Attack = new Attack("punch1", 1, false, 4, -24, true, 67, 30, true, false);

		public function westStage() {}
			
		protected override function init2():void {
			levelNum = 5;
			useBodiesArr = false;
				Main.instance.askForBackground("sun");
			addPlayer(-500);
			Main.instance.showReadyGo();
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0 ,true);
			fxManager.createPool("train", train, 1);

			
		}
		public function checkTrainHit(train:MovieClip):void {
				//if (player != null)
				//
var len:int = characterObjects.length;
			//if (!aggresor.enemy)
			for ( var i:int = 0; i < len; ++i )	{
				object = characterObjects[i];
				if (object != null)
					if (object.damageable)
						if (object.visible)
					if (sameGround(object, train) && train.hitPlace.hitTestObject(object._bodyBox) )//Check hit
			if (object.currentLabel != "down" && object.currentLabel != "hit_no_head" && object.currentLabel != "death" && object.currentLabel != "death_no_head")
if (object.hp > 0)				
			{
					playRandomAttackSound();
					onHit(train, object, trainAttackStats);
					//frameTimer.removeTimer("bossTimerAttack");
					//frameTimer.addTimer( "bossTimerAttack", gameFrameRate * 1.5, FrameTimer.CALL_IN_INTERVALS, this, null, "updateBossAttackAndReturnToNormal" );
				}
			}
		}
		public override function startCamera():void {
			cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.player, -1, 10) );			
			cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.player, 170, 70, 0, true, true) );					
			cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.point2, 5, 1, 0, true, true) );
		}
		/*public override function remove(mc:MovieClip):void {
			var toBeRemove:MovieClip = MovieClip(getChildByName(mc.name));
			toBeRemove.parent.removeChild(toBeRemove);
		}*/
		
		
		public function finishLevel():void {Main.instance.unlockNgMedal("Sheriff");
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
			addCowboy(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			addCowboy(NO_DIR_Y, LEFT, 60, 44, getMeetPoint("point4").x , getMeetPoint("point4").y, LEFT, null);
			//addGunner(NO_DIR_Y, LEFT, 60, 30, getMeetPoint("point6").x , getMeetPoint("point6").y, RIGHT, null);
			Main.instance.collectGarbage();
		}
		public function meet1_event1():Boolean {
			if (deathCount >= 1) {
				addCowboy(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, LEFT, null);
				return true;
			}
			return false;
		}
			
		public function meet1_event2():Boolean {
			if (deathCount >= 3) {
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
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			setCirclesSize(1, 2, 10);
			addCowboy(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
			addCowboy(NO_DIR_Y, RIGHT, 60, 33, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT, null);
				Main.instance.collectGarbage();
			frameTimer.addTimer("trainTimer", gameFrameRate * 5, FrameTimer.CALL_IN_INTERVALS, this, null, "updateTrainAttack" );
			
		}
		public function updateTrainAttack():void {
			putFxOnPoint("train",getMeetPoint("point3")).scaleX = 1;;
			doTrainWhistle();
			frameTimer.removeTimer("trainTimer");
			frameTimer.addTimer("trainTimer", gameFrameRate * 5, FrameTimer.CALL_IN_INTERVALS, this, null, "updateTrainAttackOppositeDir" );

		}
		public function updateTrainAttackOppositeDir():void {
			putFxOnPoint("train",getMeetPoint("point4")).scaleX = -1;
			doTrainWhistle();
			frameTimer.removeTimer("trainTimer");
			frameTimer.addTimer("trainTimer", gameFrameRate * 8, FrameTimer.CALL_IN_INTERVALS, this, null, "updateTrainAttack" );

		}
		
		
		public function meet2_event1():Boolean {

			if (deathCount >= 1) {
						addCowboy(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);

					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meet2_event2():Boolean {

			if (deathCount >= 2) {
			addCowboy(NO_DIR_Y, RIGHT, 60, 1, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT, null);
			addCowboy(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT, null);

					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function meet2_event3():Boolean {
			if (deathCount == 5) {
				currentMeet().end();
				Main.instance.showGo();
				frameTimer.removeTimer("trainTimer");
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
		
		public function meet3preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function meet3start():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			setCirclesSize(3, 2, 10);
			addCowboy(NO_DIR_Y, RIGHT, 60, 11, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
			addGunner(NO_DIR_Y, LEFT, 60, 44, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			addCowboy(NO_DIR_Y, LEFT, 60, 11, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
			Main.instance.collectGarbage();
		}
		
		public function meet3_event1():Boolean {
			if (deathCount >= 1) {
				addGunner(NO_DIR_Y, LEFT, 60, 44, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet3_event2():Boolean {
			if (deathCount == 4) {
				currentMeet().end();
				Main.instance.showGo();				
				return true;
			}
			return false;
		}
		
		public function meet3update():void {genericMeetUpdate();}
		
		public function meet3end():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meet3 END///////////////
		///////////////////////////////
		///////////////////////////////
		///////Start Meet: meet2///////
		
		public function meet4preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function meet4start():void {Main.instance.hideGo();
			frameTimer.addTimer("trainTimer", gameFrameRate * 4, FrameTimer.CALL_IN_INTERVALS, this, null, "updateTrainAttackDual" );
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			setCirclesSize(3, 2, 10);
			addCowboy(NO_DIR_Y, RIGHT, 60, 11, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
			addCowboy(NO_DIR_Y, LEFT, 60, 44, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			addCowboy(NO_DIR_Y, LEFT, 60, 11, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
			Main.instance.collectGarbage();
		}
		
		public function meet4_event1():Boolean {
			if (deathCount >= 1) {
				addCowboy(NO_DIR_Y, LEFT, 60, 44, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet4_event2():Boolean {
			if (deathCount == 4) {
				currentMeet().end();
				Main.instance.showGo();				
				return true;
			}
			return false;
		}
		
		public function meet4update():void {genericMeetUpdate();}
		
		public function meet4end():void {
			frameTimer.removeTimer("trainTimer");
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		
		public function updateTrainAttackDual():void {
			putFxOnPoint("train",getMeetPoint("point3")).scaleX = 1;;
			doTrainWhistle();
			frameTimer.removeTimer("trainTimer");
			frameTimer.addTimer("trainTimer", gameFrameRate * 4, FrameTimer.CALL_IN_INTERVALS, this, null, "updateTrainAttackOppositeDirDual" );

		}
		public function updateTrainAttackOppositeDirDual():void {
			putFxOnPoint("train",getMeetPoint("point4")).scaleX = -1;
			doTrainWhistle();
			frameTimer.removeTimer("trainTimer");
			frameTimer.addTimer("trainTimer", gameFrameRate * 4, FrameTimer.CALL_IN_INTERVALS, this, null, "updateTrainAttackDualDual" );

		}
		public function updateTrainAttackDualDual():void {
			putFxOnPoint("train",getMeetPoint("point4")).scaleX = -1;
			putFxOnPoint("train",getMeetPoint("point3")).scaleX = 1;;
			doTrainWhistle();
			frameTimer.removeTimer("trainTimer");
			frameTimer.addTimer("trainTimer", gameFrameRate * 6, FrameTimer.CALL_IN_INTERVALS, this, null, "updateTrainAttackDual" );

		}
		////////meet3 END///////////////
		///////////////////////////////
		public function meet5preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function meet5start():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			setCirclesSize(3, 2, 10);
			//addCowboy(NO_DIR_Y, RIGHT, 60, 11, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
			addGunner(NO_DIR_Y, LEFT, 60, 44, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			addGunner(NO_DIR_Y, LEFT, 60, 11, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
			Main.instance.collectGarbage();
		}
		
		public function meet5_event1():Boolean {
			if (deathCount >= 1) {
				addCowboy(NO_DIR_Y, LEFT, 60, 11, getMeetPoint("point5").x , getMeetPoint("point5").y, LEFT, null);
				addGunner(NO_DIR_Y, LEFT, 60, 44, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			public function meet5_event2():Boolean {
			if (deathCount >= 3) {
				addCowboy(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, LEFT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet5_event3():Boolean {
			if (deathCount == 5) {
				currentMeet().end();
				Main.instance.showGo();				
				return true;
			}
			return false;
		}
		
		public function meet5update():void {genericMeetUpdate();}
		
		public function meet5end():void {
			frameTimer.removeTimer("trainTimer");
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		//////////////
		///////////
		/////////
		//
			
			public function meet6preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function meet6start():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			setCirclesSize(3, 2, 10);
			//addCowboy(NO_DIR_Y, RIGHT, 60, 11, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
			addCowboy(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			addGunner(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT, null);
			Main.instance.collectGarbage();
		}
		
		public function meet6_event1():Boolean {
			if (deathCount >= 1) {
				addGunner(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT, null);
				addCowboy(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			public function meet6_event2():Boolean {
			if (deathCount >= 3) {
				addBullyAI(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, "cowboy", "octo", "octo", "octo", LEFT,null).setHp(20);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet6_event3():Boolean {
			if (deathCount == 5) {
				currentMeet().end();
				Main.instance.showGo();				
				return true;
			}
			return false;
		}
		
		public function meet6update():void {genericMeetUpdate();}
		
		public function meet6end():void {
			frameTimer.removeTimer("trainTimer");
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		
		 ///////////////////////////////
		///////Start Meet: meet2///////
		
		public function surprisepreload():void {Main.instance.music.fadeAllTo(0.0001, 2000);
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		public function surprisestart():void {
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			setCirclesSize(3, 2, 10);
			Main.instance.music.fadeAllTo(1, 500);
			addCowboy(NO_DIR_Y, LEFT, 50, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, NO_DIR_X, null).recharge();
				
		}
		public function surprise_event1():Boolean {trace(deathCount + "SUR");
			if (deathCount == 1) {
				currentMeet().end();
				Main.instance.showGo();		
				return true;
			}
			return false;
		}
		
		public function surpriseupdate():void {genericMeetUpdate();}
		
		public function surpriseend():void {
			frameTimer.removeTimer("trainTimer");
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		 ///////////////////////////////
		///////Start Meet: VICTORY///////
		
		public function victorypreload():void {
			Main.instance.music.fadeAllTo(0, 2000);

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
			if ( Math.random() < 0.05 ||  overAllDeathCount == 1  || character is Heavy )
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
