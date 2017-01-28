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

	public class stage3 extends GameStage {
		public function stage3() {}
			
		protected override function init2():void {
			levelNum = 2;
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
			
		}
		public function meet1start():void {Main.instance.hideGo();
//			setToCurrentMeetLimitsAndStickTo(RIGHT);
			setToCurrentMeetLimits();
			didntDoEvents();
			setCirclesSize(1, 2, 10);
			addUnderCover(getMeetPoint("point8").x , getMeetPoint("point8").y, LEFT);
			//addUnderCover(getMeetPoint("point11").x , getMeetPoint("point11").y);
			//addUnderCover(getMeetPoint("point12").x , getMeetPoint("point12").y);
			Main.instance.collectGarbage();
		}
		public function meet1_event1():Boolean {
			if (deathCount >= 1) {
				
				return true;
			}
			return false;
		}
			
		public function meet1_event2():Boolean {
			if (deathCount >= 1) {
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
			expectingEvents = true;MAX_BLOODS_ON_LAND = 0;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
			addUnderCover(getMeetPoint("point7").x , getMeetPoint("point7").y, LEFT);
			addUnderCover(getMeetPoint("point9").x , getMeetPoint("point9").y);
		}
		
		public function meet2start():void {Main.instance.hideGo();
			resetBloodContainer();
			F98m.visible = false;
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			setCirclesSize(1, 2, 10);
			//addOcto(NO_DIR_Y, LEFT, 60, 66, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			//addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "jumpIntro");
			//addOcto(NO_DIR_Y, RIGHT, 60, 23, getMeetPoint("point11").x , getMeetPoint("point11").y, LEFT, "jumpIntro");
				Main.instance.collectGarbage();
		}
		
		
		
		public function meet2_event1():Boolean {
			if (deathCount >= 2) {
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point10").x , getMeetPoint("point10").y, RIGHT, "jumpIntro");
			addOcto(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point11").x , getMeetPoint("point11").y, LEFT, "jumpIntro");
					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet2_event2():Boolean {
			if (deathCount == 4) {
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
			addStupidOcto(NO_DIR_Y, RIGHT, 1, 1, getMeetPoint("point8").x , getMeetPoint("point8").y, LEFT);
			addUnderCover(getMeetPoint("point7").x , getMeetPoint("point7").y, RIGHT);
			addUnderCover(getMeetPoint("point9").x , getMeetPoint("point9").y, LEFT);
			addUnderCover(getMeetPoint("point12").x , getMeetPoint("point12").y, LEFT);
		}
		
		public function meetPond1start():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			setCirclesSize(3, 2, 10);
			Main.instance.collectGarbage();
		}		
		public function meetPond1_event1():Boolean {
			if (deathCount == 4) {
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
		///////Start Meet: meet3///////
		
		public function meet3preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
			
		}
		
		public function meet3start():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			setCirclesSize(2, 2, 10);
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point7").x , getMeetPoint("point7").y, RIGHT, "jumpIntro");
			addOcto(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point8").x , getMeetPoint("point8").y, LEFT, "jumpIntro");
				Main.instance.collectGarbage();
		}
		
		
		
		public function meet3_event1():Boolean {
			if (deathCount >= 1) {	
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point7").x , getMeetPoint("point7").y, RIGHT, "jumpIntro");
				
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meet3_event2():Boolean {
			if (deathCount >= 2) {
				addBullyAI(DOWN, LEFT, 30, 30, getMeetPoint("point7").x , getMeetPoint("point7").y, "octo", "octo", "octo", "octo", LEFT, "jumpIntro");
			
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet3_event3():Boolean {
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
		///////Start Meet: meet4///////
		
		public function meet4preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
			
		}
		
		public function meet4start():void {
			Main.instance.hideGo();
			resetBloodContainer();
			F98m.visible = false;
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			setCirclesSize(2, 2, 10);
			addOcto(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT);
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT);
			Main.instance.collectGarbage();
		}
		
		
		
		public function meet4_event1():Boolean {
			if (deathCount >= 1) {	
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT);
				
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meet4_event2():Boolean {
			if (deathCount >= 2) {
				addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT);
				addFatOcto(NO_DIR_Y, RIGHT, 120, 33, getMeetPoint("point2").x + 40 , getMeetPoint("point2").y, NO_DIR_X);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet4_event3():Boolean {
			if (deathCount == 5) {
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
		///////////////////////////////
		
				 ///////////////////////////////
		///////Start Meet: meet5///////
		
		public function meet5preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
			
		}
		
		public function meet5start():void {
			Main.instance.hideGo();
			resetBloodContainer();
			inkRecharge();
			allowInk = true;
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			setCirclesSize(2, 2, 10);
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT);
			addPurpleOcto(NO_DIR_Y, RIGHT, 60, 55, getMeetPoint("point1").x , getMeetPoint("point1").y, LEFT);
			Main.instance.collectGarbage();
		}
		
		
		public function meet5_event1():Boolean {
			if (deathCount >= 1) {	
				addOcto(NO_DIR_Y, RIGHT, 60, 1, getMeetPoint("point1").x , getMeetPoint("point1").y, RIGHT);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meet5_event2():Boolean {
			if (deathCount >= 2) {
				addOcto(NO_DIR_Y, RIGHT, 60, 1, getMeetPoint("point1").x , getMeetPoint("point1").y, RIGHT);
				addFatOcto(NO_DIR_Y, RIGHT, 120, 55, getMeetPoint("point1").x + 40 , getMeetPoint("point1").y, NO_DIR_X);
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
			if ( Math.random() < 0.5 ||  overAllDeathCount == 1  || character is Heavy )
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
