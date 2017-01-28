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

	public class Stage2 extends GameStage {
		public var arenaStartFrame:int;
		public var arenaGuy:*;
		public function Stage2() {}
			
		protected override function init2():void {
			levelNum = 3;
			//useBodiesArr = true;
			allowInk = true;
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
			attackingRangersCircleSize = 2;
			setCirclesSize(3, 3, 10);
			//addOcto(NO_DIR_Y, LEFT, 0, 0, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, null);
			addPurpleOcto(NO_DIR_Y, LEFT, 90, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null).recharge();
			addPurpleOcto(NO_DIR_Y, LEFT, 100, 30, getMeetPoint("point6").x , getMeetPoint("point6").y, RIGHT, null).recharge();
			Main.instance.collectGarbage();
		}
		public function meet1_event1():Boolean {
			if (deathCount >= 1) {
				
				return true;
			}
			return false;
		}
			
		public function meet1_event2():Boolean {
			if (deathCount == 2) {
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
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			//setCirclesSize(1, 2, 10);
			attackingRangersCircleSize = 2;
			addOcto(NO_DIR_Y, LEFT, 60, 45, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null).recharge();
			addPurpleOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "jumpIntro").recharge();
			addPurpleOcto(NO_DIR_Y, RIGHT, 60, 43, getMeetPoint("point11").x , getMeetPoint("point11").y, LEFT, "jumpIntro").recharge();
			Main.instance.collectGarbage();
		}
		
		public function meet2_event1():Boolean {
			if (deathCount >= 2) {
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "jumpIntro").recharge();
			addPurpleOcto(NO_DIR_Y, RIGHT, 60, 43, getMeetPoint("point11").x , getMeetPoint("point11").y, LEFT, "jumpIntro").recharge();
					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meet2_event2():Boolean {
			if (deathCount >= 3) {
				addOcto(NO_DIR_Y, LEFT, 60, 45, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null).recharge();
					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function meet2_event3():Boolean {
			if (deathCount == 6) {
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
			 ///////////////////////////////
		///////Start Meet: meet3///////
		
		public function meet3preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function meet3start():void {Main.instance.hideGo();
			resetBloodContainer();
			F98m.visible = false;
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			//setCirclesSize(2, 2, 10);
			attackingRangersCircleSize = 2;
			//addOcto(NO_DIR_Y, LEFT, 50, 45, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null).recharge();
			addPurpleOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "inkIntro").recharge();
			addPurpleOcto(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "inkIntro").recharge();
			Main.instance.collectGarbage();
		}
		
		public function meet3_event1():Boolean {
			if (deathCount >= 1) {
			addOcto(NO_DIR_Y, LEFT, 60, 2, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "inkIntro").recharge();
			addPurpleOcto(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point10").x , getMeetPoint("point10").y, LEFT, "inkIntro").recharge();
					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meet3_event2():Boolean {
			if (deathCount >= 3) {
				addPurpleOcto(NO_DIR_Y, RIGHT, 60, 3, getMeetPoint("point10").x , getMeetPoint("point10").y, LEFT, "inkIntro").recharge();
				//addPurpleOcto(NO_DIR_Y, LEFT, 40, 22, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "inkIntro").recharge();
				addOcto(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "inkIntro");
					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function meet3_event3():Boolean {
			if (deathCount >= 4) {
				//addOcto(NO_DIR_Y, RIGHT, 40, 1, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "inkIntro");
				//addOcto(NO_DIR_Y, RIGHT, 40, 10, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT);
				addOcto(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point9").x , getMeetPoint("point9").y, LEFT, "inkIntro");
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function meet3_event4():Boolean {
			if (deathCount == 7) {
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
		 //////meet3 END////////////////
		///////////////////////////////
		
		
		 ///////////////////////////////
		///////Start Meet: meet4///////
		
		public function meet4preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
			addKidOcto(NO_DIR_Y, LEFT, 0, 0, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, null);
		}
		
		public function meet4start():void {Main.instance.hideGo();
			resetBloodContainer();
			F98m.visible = false;
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			//setCirclesSize(2, 2, 10);
			attackingRangersCircleSize = 2;
			//addOcto(NO_DIR_Y, LEFT, 50, 45, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null).recharge();
			//addPurpleOcto(NO_DIR_Y, RIGHT, 40, 1, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "inkIntro").recharge();
			Main.instance.collectGarbage();
		}
		
		public function meet4_event1():Boolean {
			if (deathCount >= 1) {
				Main.instance.unlockNgMedal("Too Expensive!");
			addOcto(NO_DIR_Y, RIGHT, 60, 1, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 55, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meet4_event2():Boolean {
			if (deathCount >= 2) {
				addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function meet4_event3():Boolean {
			if (deathCount >= 5) {
				//addOcto(NO_DIR_Y, RIGHT, 40, 1, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "inkIntro");
				//addOcto(NO_DIR_Y, RIGHT, 40, 10, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT);
				addOcto(NO_DIR_Y, RIGHT, 60, 1, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function meet4_event4():Boolean {
			if (deathCount >= 6) {
				//addOcto(NO_DIR_Y, RIGHT, 40, 1, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "inkIntro");
				//addOcto(NO_DIR_Y, RIGHT, 40, 10, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT);
				addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function meet4_event5():Boolean {
			if (deathCount >= 7) {
				//addOcto(NO_DIR_Y, RIGHT, 40, 1, getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT, "inkIntro");
				//addOcto(NO_DIR_Y, RIGHT, 40, 10, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT);
				addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
				addOcto(NO_DIR_Y, LEFT, 60, 55, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function meet4_event6():Boolean {
			if (deathCount == 9) {
				currentMeet().end();
				Main.instance.showGo();
				
				return true;
			}
			return false;
		}
		
		public function meet4update():void {genericMeetUpdate();}
		
		public function meet4end():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meet4 END///////////////
		///////////////////////////////			inkRecharge();

			 ///////////////////////////////
		///////Start Meet: meet4///////
		
		public function firstInk_preload():void {
			inkRecharge();
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function firstInk_start():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			//setCirclesSize(2, 2, 10);
			attackingRangersCircleSize = 2;
			addPurpleOcto(NO_DIR_Y, RIGHT, 60, 1, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null).recharge();
			addPurpleOcto(NO_DIR_Y, LEFT, 60, 55, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null).recharge();
			
			Main.instance.collectGarbage();
		}
		public function firstInk__event1():Boolean {
			if (deathCount >= 1) {
				addPurpleOcto(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null).recharge();
				//addPurpleOcto(NO_DIR_Y, LEFT, 40, 22, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "inkIntro").recharge();
					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function firstInk__event2():Boolean {
			if (deathCount >= 2) {
				addPurpleOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null).recharge();
				//addPurpleOcto(NO_DIR_Y, LEFT, 40, 22, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "inkIntro").recharge();
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function firstInk__event3():Boolean {
			if (deathCount >= 4) {
				addOcto(NO_DIR_Y, RIGHT, 60, 1, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
				addOcto(NO_DIR_Y, RIGHT, 60, 44, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT, null);

				addPurpleOcto(NO_DIR_Y, LEFT, 50, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null).recharge();
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function firstInk__event4():Boolean {
			if (deathCount >= 6) {
				addOcto(NO_DIR_Y, RIGHT, 60, 100, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
				addPurpleOcto(NO_DIR_Y, RIGHT, 60, 50, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function firstInk__event5():Boolean {
			if (deathCount == 9) {
				currentMeet().end();
				Main.instance.showGo();
				
				return true;
			}
			return false;
		}
		
		public function firstInk_update():void {genericMeetUpdate();}
		
		public function firstInk_end():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meet4 END///////////////
		///////////////////////////////			inkRecharge();

		
			 ///////////////////////////////
		///////Start Meet: meet4///////
		
		public function ink2preload():void {
			inkRecharge();
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function ink2start():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			//setCirclesSize(2, 2, 10);
			attackingRangersCircleSize = 1;
			addPurpleOcto(NO_DIR_Y, RIGHT, 60, 1, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null).recharge();
			addPurpleOcto(NO_DIR_Y, LEFT, 60, 55, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null).recharge();
			
			Main.instance.collectGarbage();
		}
		public function ink2_event1():Boolean {
			if (deathCount >= 1) {
				addPurpleOcto(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null).recharge();
				//addPurpleOcto(NO_DIR_Y, LEFT, 40, 22, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "inkIntro").recharge();
					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function ink2_event2():Boolean {
			if (deathCount >= 2) {
				addPurpleOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null).recharge();
				//addPurpleOcto(NO_DIR_Y, LEFT, 40, 22, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "inkIntro").recharge();
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function ink2_event3():Boolean {
			if (deathCount >= 4) {
				addOcto(NO_DIR_Y, RIGHT, 60, 1, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
				addOcto(NO_DIR_Y, RIGHT, 60, 44, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT, null);

				addPurpleOcto(NO_DIR_Y, LEFT, 50, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null).recharge();
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function ink2_event4():Boolean {
			if (deathCount >= 6) {
				addOcto(NO_DIR_Y, RIGHT, 60, 100, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
				addPurpleOcto(NO_DIR_Y, RIGHT, 60, 50, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function ink2_event5():Boolean {
			if (deathCount == 9) {
				currentMeet().end();
				Main.instance.showGo();
				
				return true;
			}
			return false;
		}
		
		public function ink2update():void {genericMeetUpdate();}
		
		public function ink2end():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meet4 END///////////////
		///////////////////////////////			inkRecharge();

			 ///////////////////////////////
		///////Start Meet: meet4///////
		
		public function ink3preload():void {
			inkRecharge();
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function ink3start():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			//setCirclesSize(2, 2, 10);
			attackingRangersCircleSize = 1;
			//addFatOcto(NO_DIR_Y, LEFT, 120, 1, getMeetPoint("point5").x + 40 , getMeetPoint("point5").y, NO_DIR_X);
			addPurpleOcto(NO_DIR_Y, RIGHT, 60, 22, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null).recharge();
			addPurpleOcto(NO_DIR_Y, LEFT, 60, 55, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null).recharge();
			
			Main.instance.collectGarbage();
		}
		public function ink3_event1():Boolean {
			if (deathCount >= 1) {
				addFatOcto(NO_DIR_Y, RIGHT, 120, 33, getMeetPoint("point2").x, getMeetPoint("point2").y, NO_DIR_X);
				//addPurpleOcto(NO_DIR_Y, LEFT, 40, 22, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "inkIntro").recharge();
					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function ink3_event2():Boolean {
			if (deathCount >= 2) {
				addPurpleOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null).recharge();
				//addPurpleOcto(NO_DIR_Y, LEFT, 40, 22, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "inkIntro").recharge();
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function ink3_event3():Boolean {
			if (deathCount >= 4) {
				addOcto(NO_DIR_Y, RIGHT, 60, 1, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
				//addOcto(NO_DIR_Y, RIGHT, 60, 44, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT, null);
addFatOcto(NO_DIR_Y, LEFT, 120, 1, getMeetPoint("point5").x + 40 , getMeetPoint("point5").y, NO_DIR_X);
				addPurpleOcto(NO_DIR_Y, LEFT, 50, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null).recharge();
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function ink3_event4():Boolean {
			if (deathCount >= 6) {
				addOcto(NO_DIR_Y, RIGHT, 60, 100, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
				addPurpleOcto(NO_DIR_Y, RIGHT, 60, 50, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}	
		public function ink3_event5():Boolean {
			if (deathCount == 9) {
				currentMeet().end();
				Main.instance.showGo();
				
				return true;
			}
			return false;
		}
		
		public function ink3update():void {genericMeetUpdate();}
		
		public function ink3end():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meet4 END///////////////
		///////////////////////////////			inkRecharge();

		
		
		
		
		 ///////////////////////////////
		///////Start Meet: meet2///////
	
		
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
			if ( Math.random() < 0.54 ||  overAllDeathCount == 1)
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
