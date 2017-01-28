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

	public class starsStages extends GameStage {
		var starAttackStats:Attack = new Attack("punch1", 1, false, 34, -24, true, 67, 40, true, true);
		var starAttackScaleX = -1;
		public var changeSwishDirEverytime:Boolean = false;
		public function starsStages() {}
			
		protected override function init2():void {
			levelNum = 6;
			useBodiesArr = false;
			Main.instance.askForBackground("night");
			addPlayer(-200);
			Main.instance.showReadyGo();
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0 ,true);
			fxManager.createPool("swishAttack", SwishAttack, 3);
			fxManager.createPool("preswish", preswish, 2);
		}
		
		public function checkStarHit(star:MovieClip):void {
			var len:int = characterObjects.length;
			if (player != null)
			if (player.damageable)
			if (player.visible)
			if (sameGround(player, star) && star.hitPlace.hitTestObject(player._bodyBox) )//Check hit
			if (player.currentLabel != "down" && player.currentLabel != "hit_no_head" && player.currentLabel != "death" && player.currentLabel != "death_no_head" && player.currentLabel != "pushed")
			if (player.hp > 0) {
					playRandomAttackSound();
					onHit(star, player, starAttackStats);
			}
		}
		
		
		public function doStarPreAttack():void {
			if (changeSwishDirEverytime)
				starAttackScaleX *= -1;
			putFxOnPoint("preswish", new Point(getGroundX(player), 590), true ).scaleX = starAttackScaleX;
			frameTimer.addTimer( "doStarAttackTimer", gameFrameRate * 1.5, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "doStarAttack");
		}
		public function doStarAttack():void {
			putFxOnPoint("swishAttack", getGlobalPoint(player),true ).scaleX = starAttackScaleX * -1;
			frameTimer.removeTimer( "doStarAttackTimer");
		}
		
		public function finishLevel():void {Main.instance.unlockNgMedal("The force is strong with this one");
			Main.instance.putVictoryScreen(overAllDeathCount, frameTimer.currentFrameCount, levelNum, lastLevel);
		}
		
		
		 ////////////////////////////////
		///////Start Meet: meet1////////
		
		public function meet1update():void {genericMeetUpdate();}

		public function meet1preload():void {
			expectingEvents = true;
			setFreeRoam();
			
		}
		public function meet1start():void {Main.instance.hideGo();
			setToCurrentMeetLimitsAndStickTo(LEFT);
								
			
			
			
			//setToCurrentMeetLimits();
			didntDoEvents();
			setCirclesSize(1, 2, 10);
			addStar(NO_DIR_Y, LEFT, 60, 55, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "meteorIntro");
			addStar(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "meteorIntro");
			//doStarPreAttack();
			//frameTimer.addTimer( "starTimerAttack", gameFrameRate * 6, FrameTimer.CALL_IN_INTERVALS, this, null, "doStarPreAttack");
			Main.instance.collectGarbage();
		}
		public function meet1_event1():Boolean {
			if (deathCount >= 1) {
				addStar(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "meteorIntro");
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet1_event2():Boolean {
			if (deathCount >= 3) {
				currentMeet().end();
				Main.instance.showGo();
				doStarPreAttack();
				frameTimer.addTimer( "starTimerAttack", gameFrameRate * 4, FrameTimer.CALL_IN_INTERVALS, this, null, "doStarPreAttack");
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
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			setCirclesSize(1, 2, 10);
			addStar(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, "meteorIntro");
			addStar(NO_DIR_Y, LEFT, 60, 45, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "meteorIntro");
			addStar(NO_DIR_Y, RIGHT, 60, 80, getMeetPoint("point7").x , getMeetPoint("point7").y, LEFT, "meteorIntro");
			frameTimer.removeTimer( "starTimerAttack");
			Main.instance.collectGarbage();
		}
		
		
		
		public function meet2_event1():Boolean {
			if (deathCount >= 2) {
			addStar(NO_DIR_Y, LEFT, 60, 22, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "meteorIntro");
			addStar(NO_DIR_Y, RIGHT, 60, 80, getMeetPoint("point7").x , getMeetPoint("point7").y, RIGHT, "meteorIntro");
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
			changeSwishDirEverytime = true;
			doStarPreAttack();
			frameTimer.addTimer( "starTimerAttack", gameFrameRate * 3.5, FrameTimer.CALL_IN_INTERVALS, this, null, "doStarPreAttack");
		}
		////////Meet2 END///////////////
		//////////////////////////////
		
			 ///////////////////////////////
		///////Start Meet: meet3///////
		
		public function meet3preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
			
		}
		
		public function meet3start():void {Main.instance.hideGo();
			resetBloodContainer();
			frameTimer.removeTimer( "starTimerAttack");
			frameTimer.addTimer( "starTimerAttack", gameFrameRate * 7, FrameTimer.CALL_IN_INTERVALS, this, null, "doStarPreAttack");
			
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			setCirclesSize(2, 2, 10);
			addStar(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, "meteorIntro");
			addStar(NO_DIR_Y, LEFT, 60, 45, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "meteorIntro");
			addStar(NO_DIR_Y, RIGHT, 60, 100, getMeetPoint("point7").x , getMeetPoint("point7").y, LEFT, "meteorIntro");
			
				Main.instance.collectGarbage();
		}
		
		public function meet3_event1():Boolean {
			if (deathCount >= 1) {	
			addStar(NO_DIR_Y, RIGHT, 60, 100, getMeetPoint("point7").x , getMeetPoint("point7").y, LEFT, "meteorIntro");
			addStar(NO_DIR_Y, RIGHT, 60, 50, getMeetPoint("point10").x , getMeetPoint("point10").y, LEFT, "meteorIntro");

				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meet3_event2():Boolean {
			if (deathCount >= 4) {
			addStar(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "meteorIntro");
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet3_event3():Boolean {
			if (deathCount == 6) {
				currentMeet().end();
				Main.instance.showGo();
				
				
				return true;
			}
			return false;
		}
		
		public function meet3update():void {genericMeetUpdate();}
		
		public function meet3end():void {
			frameTimer.removeTimer( "starTimerAttack");
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meet3 END///////////////
		///////////////////////////////
		
		
		
			
			 ///////////////////////////////
		///////Start Meet: meet3///////
		
		public function meet4preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
			
		}
		
		public function meet4start():void {Main.instance.hideGo();
			resetBloodContainer();
			frameTimer.removeTimer( "starTimerAttack");			
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			setCirclesSize(2, 2, 10);
			
			
			
			var star1:* = addMoon(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, "meteorIntro");
			var star2:* = addStar(NO_DIR_Y, RIGHT, 60, 30, getMeetPoint("point10").x , getMeetPoint("point10").y, LEFT, "meteorIntro");

			star1.topPriorityTarget = star2;star1.target = star2;
			star1.canHitEverybody = true;
			star2.topPriorityTarget = star1;star2.target = star1;
			star2.canHitEverybody = true;
			
			
			
			
			
			
				Main.instance.collectGarbage();
		}
		
		public function meet4_event1():Boolean {
			if (deathCount >= 1) {	
			
			var bully1:* = addBullyAI(DOWN, LEFT, 30, 30, getMeetPoint("point4").x , getMeetPoint("point4").y, "moon", "moon", "moon", "moon", RIGHT);
			bully1.canHitEverybody = true;
			var bully2:* = addBullyAI(DOWN, RIGHT, 30, 30, getMeetPoint("point1").x , getMeetPoint("point1").y, "star", "star", "star", "star", LEFT);
			bully1.canHitEverybody = true;
			bully2.canHitEverybody = true;
			bully1.topPriorityTarget = bully2;
			bully1.target = bully2;
			bully2.target = bully1;
			bully2.topPriorityTarget = bully1;			
				
				
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meet4_event2():Boolean {
			if (deathCount >= 3) {
			var star3:* = addMoon(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, "meteorIntro");
			var star4:* = addStar(NO_DIR_Y, RIGHT, 60, 30, getMeetPoint("point10").x , getMeetPoint("point10").y, LEFT, "meteorIntro");

			star3.topPriorityTarget = star4;
			star3.target = star4;
			star3.canHitEverybody = true;
			star4.topPriorityTarget = star3;
			star4.target = star3;
			star4.canHitEverybody = true;
				
				
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet4_event3():Boolean {
			if (deathCount == 6) {
				currentMeet().end();
				Main.instance.showGo();
				///3 minuets
				
				return true;
			}
			return false;
		}
		
		public function meet4update():void {genericMeetUpdate();}
		
		public function meet4end():void {
			frameTimer.removeTimer( "starTimerAttack");
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meet4 END///////////////
		///////////////////////////////
		
		
		
		
		
		
		
			 ///////////////////////////////
		///////Start Meet: meet3///////
		
		public function meet5preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
			
		}
		
		public function meet5start():void {Main.instance.hideGo();
			resetBloodContainer();
			frameTimer.removeTimer( "starTimerAttack");			
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			setCirclesSize(2, 2, 10);
			addStar(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, "meteorIntro");
			addStar(NO_DIR_Y, LEFT, 60, 45, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "meteorIntro");
			addStar(NO_DIR_Y, RIGHT, 60, 100, getMeetPoint("point7").x , getMeetPoint("point7").y, LEFT, "meteorIntro");
			
				Main.instance.collectGarbage();
		}
		
		public function meet5_event1():Boolean {
			if (deathCount >= 1) {	
			addBullyAI(NO_DIR_Y, LEFT, 120, 1, getMeetPoint("point5").x + 50, getMeetPoint("point5").y, "star", "star", "star", "star", LEFT,null);
			addStar(NO_DIR_Y, RIGHT, 60, 50, getMeetPoint("point10").x , getMeetPoint("point10").y, LEFT, "meteorIntro");

				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meet5_event2():Boolean {
			if (deathCount >= 4) {
			addStar(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "meteorIntro");
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet5_event3():Boolean {
			if (deathCount == 6) {
				currentMeet().end();
				Main.instance.showGo();
				///3 minuets
				
				return true;
			}
			return false;
		}
		
		public function meet5update():void {genericMeetUpdate();}
		
		public function meet5end():void {
			frameTimer.removeTimer( "starTimerAttack");
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meet5 END///////////////
		///////////////////////////////
		////meet 6
		public function meet6preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
			
		}
			public function meet6start():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			setCirclesSize(3, 2, 10);
			addMoon(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, "meteorIntro");
			addMoon(NO_DIR_Y, LEFT, 60, 45, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "meteorIntro");
			addMoon(NO_DIR_Y, RIGHT, 60, 100, getMeetPoint("point7").x , getMeetPoint("point7").y, LEFT, "meteorIntro");
			
				Main.instance.collectGarbage();
		}
		
		public function meet6_event1():Boolean {
			if (deathCount >= 1) {	
			addBullyAI(NO_DIR_Y, LEFT, 120, 1, getMeetPoint("point5").x + 50, getMeetPoint("point5").y, "moon", "moon", "moon", "moon", LEFT,null);
			addMoon(NO_DIR_Y, RIGHT, 60, 50, getMeetPoint("point10").x , getMeetPoint("point10").y, LEFT, "meteorIntro");

				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meet6_event2():Boolean {
			if (deathCount >= 4) {
			addMoon(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "meteorIntro");
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet6_event3():Boolean {
			if (deathCount == 6) {
				currentMeet().end();
				Main.instance.showGo();
				///3 minuets
				
				return true;
			}
			return false;
		}
		
		public function meet6update():void {genericMeetUpdate();}
		
		public function meet6end():void {
			frameTimer.removeTimer( "starTimerAttack");
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meet5 END///////////////
		///////////////////////////////
		
		
		////meet 6
		public function meet7preload():void {Main.instance.music.fadeAllTo(0, 2000);
			expectingEvents = true;
		//	lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
			
		}
			public function meet7start():void {
			Main.instance.hideGo();
			resetBloodContainer();didntDoEvents();
				
				setUnmoveable();
				player.stopForAMoment();
										cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.point5, -1, 55) );		
				story.gotoAndStop(2);
				frameTimer.addTimer("startStoryTimer", 55, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "startStory");
				frameTimer.addTimer("startStoryTimer2", 620, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "victorystart");

			/*setToCurrentMeetLimitsAndStickTo(RIGHT);
			
			setCirclesSize(3, 2, 10);
			addMoon(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, "meteorIntro");
			addMoon(NO_DIR_Y, LEFT, 60, 45, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "meteorIntro");
			addMoon(NO_DIR_Y, RIGHT, 60, 100, getMeetPoint("point7").x , getMeetPoint("point7").y, LEFT, "meteorIntro");
			
				Main.instance.collectGarbage();*/
		}
		public function startStory():void {
			story.visible = true;
			story.play();
		}
		public function meet7_event1():Boolean {
			if (deathCount >= 1) {	
			addBullyAI(NO_DIR_Y, LEFT, 120, 1, getMeetPoint("point5").x + 50, getMeetPoint("point5").y, "moon", "moon", "moon", "moon", LEFT,null);
			addMoon(NO_DIR_Y, RIGHT, 60, 50, getMeetPoint("point10").x , getMeetPoint("point10").y, LEFT, "meteorIntro");

				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meet7_event2():Boolean {
			if (deathCount >= 4) {
			addMoon(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "meteorIntro");
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet7_event3():Boolean {
			if (deathCount == 6) {
				currentMeet().end();
				Main.instance.showGo();
				///3 minuets
				
				return true;
			}
			return false;
		}
		
		public function meet7update():void {genericMeetUpdate();}
		
		public function meet7end():void {
			frameTimer.removeTimer( "starTimerAttack");
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meet5 END///////////////
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
			if ( Math.random() < 0.7 ||  overAllDeathCount == 1 )
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
