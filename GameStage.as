package  {
	import flash.system.*;
	import Node;
	import pathfinding.Pathfinder;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.StageQuality;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.sensors.Accelerometer;
	import flash.display.DisplayObject;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Timer;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import flash.events.TimerEvent;

public class GameStage extends MovieClip {
protected var thisMC:* = MovieClip(this);
public var meetsArr:Array = [];
	public var allowInk:Boolean = false;
	public var inkRecharged:Boolean = false;
	public var INK_RECHARGE_DELAY:int = 7 * 50;
public var bodiesArr:Array = [];
	public var useBodiesArr:Boolean = false;
	public var android:Boolean = false;
		
///Ai vars
public var attckingCircleSize:int = 1;
public var innerCircleSize:int = 1;
public var outerCircleSize:int = 10;

	public var expectingEvents:Boolean = false;
	public var cameraManager:CameraManager = new CameraManager(thisMC);
	public var itemManager:ItemManager = new ItemManager(thisMC);
	public var projectileManager:ProjectileManager = new ProjectileManager(thisMC);
///Camera vars
public var centerForFrames:int = 0; //For how many frames should the camera center on?
public var centerForFramesOnPoint:int = 0; //For how many frames should the camera center on?
protected var DEPTH_SORT_FRAMES_DELAY:int = 3;
protected var CAMERA_UPDATE_DELAY:int = 6;
public var unmoveable:Boolean = false;
public var breakableObjects:Array = [];
public var hitFreezeTimer:Timer = null;	
		protected const NODE_WIDTH_CONST:int = 90;
public var attackingRangersCircleSize = 1;
//////////////
protected const gameFrameRate:uint = Main.instance.originalFrameRate;
		protected const NO_DIR_X:int = -1;
		protected const NO_DIR_Y:int = -2;
		protected const UP:int = 0;
		protected const DOWN:int = 1;
		protected const LEFT:int = 2;
		protected const RIGHT:int = 3;
		protected var MAX_BLOODS_ON_LAND:int = 50;
		protected var MAX_INK_ON_LAND:int = 40;
		public var stageHeight:int;// = 500;//stage.stageHeight;
		public var stageWidth:int;// = 500;//stage.stageWidth;
public var expectingEventStart:Boolean;
public var expectingEventEnd:Boolean;

public var goingFoward:Boolean = false;
public var expectingColEvent:Boolean = true;
public var didEvent1:Boolean = true;
public var didEvent2:Boolean = true;
public var didEvent3:Boolean = true;
public var didEvent4:Boolean = true;
public var didEvent5:Boolean = true;
public var didEvent6:Boolean = true;

public var breakHits:int = 0;
public var breaks:int = 0;
public var isPaused:Boolean = false;

public var overAllDeathCount:int = 0;
public var deathCount:int = 0;
public var deathCountDummy:int = 0;
public var deathCountRanger:int = 0;
public var deathCountHeavy:int = 0;

public var eventCounter:int;
public var lookingFowardToBit:int = -1;

		public var delY:int;
		public var delX:int;
		
		public var cameraX:int = 0;
		public var cameraY:int = 0;
		
		protected var GRID_WIDTH:int = 45;
		protected var GRID_HEIGHT:int;
		
		public var TOTAL_GRID_HEIGHT:int = 0;
		public var TOTAL_GRID_WIDTH:int = 0;
			
		//protected var GRID_SPACING:int = 0;
		
		protected var _gridHolder:Sprite;
		protected var _nodes:Array;
		
		protected var _startNode:Node;
		protected var _endNode:Node;
		
		public var nodeWidth:int;
		public var nodeHeight:int;
		public var nodeHalfWidth:int;
		public var nodeHalfHeight:int;
		public var levelHeight:int;
		public var levelWidth:int;
				
		public var leftBit:int;
		public var rightBit:int;
		
		public var colEventCounter:int = 0;
		public var popHearth:Boolean = false; //Pop hearth with no if
		public var _main:* = Main.instance;
		protected var characterObjects:Array = [];
		protected var breakeAbleObjects:Array = [];
		public var backParallaxObjects:Array = [];
		public var frontParallaxObjects:Array = [];

public var lastPlaceX:int = 0;
public var depthArr:Array = [];
public var shakeArr:Array = [];
public var breakArr:Array = [];

public var backgroundsArr:Array = [];

public var sortNow:Boolean = true;

		public var cameraPointX:int = 0;
		public var cameraPointY:int = 0;
		public var cameraSpeed:Number = 16;//22;
		public var costumCameraSpeed:Number = 100;

		public var frameTimer:FrameTimer;
		
		public var waterBlocks:Array = [];
		public var slowBlocks:Array = [];

		public var shootArr:Array = [];
		public var hillsArr:Array = [];

		public var eventsColsArr:Array = [];

		public var bloodContainer:MovieClip;
		public var bloodCounter:int = 0;
		public var bloodLandArr = [];
		public var inkLandArr = [];
			//A.I LEVELS
		
		protected const KEEP_YOUR_GROUND:int = 0;
		protected const ROAM_AROUND:int = 1;
		protected const KEEP_DISTANCE:int = 2;
		protected const CHARGE:int = 3;
		protected const DIRECT_ATTACK:int = 4;
		protected const GO_CLOSE:int = 5;
		protected const RETREAT:int = 6;
		protected const STOP_FOR_A_WHILE:int = 7;
		protected const GET_INTO_POSITION:int = 8;
		protected const SHOOT:int = 9;
		protected const RUN_AWAY:int = 10;
		protected const KEEP_COVER:int = 11;

		//Moods
		protected const DISTANCE:int = 3;

		protected const CLOSE:int = 4;
		protected const ATTACK:int = 5;
		protected const CASUAL:int = 6;
		protected const RANGED:int = 7;
		protected const UNDER_COVER:int = 8;
		
				
		public var dummiesArr:Array = [];
		public var rangersArr:Array = [];
		public var underCoverArr:Array = [];
		
		public var calmAI:Boolean = false;
		
		public var fxManager = new FxManager();
		public var playerStartX:int;
		//public var globalZeroPoint:Point = new Point(0,0);
		public var shake:int = 0;
		public var shakeX:int = 0;
		public var shakeY:int = 0;
		
		public var lastLevel:Boolean = false;

		public var levelNum:int = 0;
		public var inkOnScreen:Boolean = false;
		public function GameStage() {
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0 ,true);
		}
		public function pauseObjects():void
		{
			var i:int;
			var len:int = characterObjects.length;
			for (i = 0; i < len; i++)
				characterObjects[i].pause();
			fxManager.pauseAll();		
			projectileManager.pauseAll();
		}
		public function resumeObjects():void
		{
			var i:int;
			var len:int = characterObjects.length;
			for (i = 0; i < len; i++)
				characterObjects[i].resume();
			fxManager.resumeAll();
			projectileManager.resumeAll();
		}
		public function killStage():void
		{
			//Main.instance.removeGo();
			pauseObjects();
			stop();
			
			for (var i:int = 0; i<numChildren; i++)
			{
				//if (getChildAt(i) is MovieClip)
						getChildAt(i).stop();
			}
			
			FrameTimer.clearDic(frameTimer.timersForCheck);
			isPaused = true;
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			frameTimer.stop();
			frameTimer = null;
			
		}

		
		public function rangersAIManagerUpdate():void {
			var i:int;
			var len:int = rangersArr.length;
			for (i = 0; i < len; ++i) {
				if (i < attackingRangersCircleSize)
					rangersArr[i].startModd(RANGED);
				else
					rangersArr[i].startModd(10);
			}
		}
		public function iJustShoot(actor:MovieClip):void {
			//letting the next enemy attack
			var i:int;
			var len:int = rangersArr.length;
			for (i = 0; i < len; ++i) {
				if ( rangersArr[i] .name == actor.name )
				{
					var temp:* = actor;
					rangersArr.splice(i, 1);
					rangersArr.push(temp);
					i = len;
					rangersAIManagerUpdate();
				}
			}
		}
		
		public function AIManagerUpdate():void
		{
			var i:int;
			var len:int = dummiesArr.length;
			for (i = 0; i < len; ++i)
			{
				trace("AIManagerUpdate" + dummiesArr[i].name);
				if (i < attckingCircleSize)
					dummiesArr[i].startModd(ATTACK);
				else if (i < innerCircleSize + attckingCircleSize)
					dummiesArr[i].startModd(CLOSE);
				else
					dummiesArr[i].startModd(DISTANCE);
			}
		}
		public function iJustAttacked(actor:MovieClip):void
		{
			//letting the next enemy attack
			var i:int;
			var len:int = dummiesArr.length;
			for (i = 0; i < len; ++i) {
				if ( dummiesArr[i] .name == actor.name )
				{
					var temp:* = actor;
					dummiesArr.splice(i, 1);
					dummiesArr.push(temp);
					i = len;
					AIManagerUpdate();
				}
			}
			
		}
		public function askForFx(fxName:String):MovieClip {
			return fxManager.getFxFromPool(fxName);
		}
		
		
		protected function init(event:Event):void {	
			mouseEnabled = false;
			mouseChildren = false;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			if (Main.instance.android) {
				MAX_BLOODS_ON_LAND = 10;
				MAX_INK_ON_LAND = 10;
				DEPTH_SORT_FRAMES_DELAY = 5;
				android = true;
			}
			var i:int;
			//cameraManager.in1 = new CameraInstance(40, 0, thisMC.player);
			
			//cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.player, -1, 10) );
			/*
							
*/
			startCamera();
			
			frameTimer = FrameTimer.getInstance();
			FrameTimer.clearDic(frameTimer.timersForCheck);
			frameTimer.currentFrameCount = 0;
				
			frameTimer.addTimer( "depthSortTimer", DEPTH_SORT_FRAMES_DELAY, FrameTimer.CALL_IN_INTERVALS, this, null, "depthArrSort" );
			frameTimer.addTimer( "cameraManagerTimer", CAMERA_UPDATE_DELAY, FrameTimer.CALL_IN_INTERVALS, this, null, "updateCamera" );
			frameTimer.addTimer( "cameraManagerUpdateInstancesTimer", 2, FrameTimer.CALL_IN_INTERVALS, cameraManager, null, "updateInstances" );
			frameTimer.addTimer( "timerInstancesTimer", gameFrameRate, FrameTimer.CALL_IN_INTERVALS, this, null, "updateTime" );
			frameTimer.addTimer( "timerCollectTimer", 4, FrameTimer.CALL_IN_INTERVALS, this, null, "collect" );
			
			
			//Creating Fx Pools
			fxManager.createPool("fx_hit", FXhit, 5);
			fxManager.createPool("fx_blood_hit", FXbloodHit, 5);
			fxManager.createPool("fx_walk_dirt", WalkDirt, 10);
			fxManager.createPool("fx_walk_splash", WalkWaterFX, 14);
			fxManager.createPool("fx_ink_hit", FXinkHit, 4);
			fxManager.createPool("fx_ink_on_land", FXinkHitLand, 4);
			fxManager.createPool("fx_stomp_smoke", StompSmoke, 5);
			
			stageHeight = stage.stageHeight;
			stageWidth = stage.stageWidth;
			bloodContainer = new MovieClip();
			addChild(bloodContainer);
			//TweenLite.defaultEase = Sine.easeOut;
			
			expectingEventStart = true;
			expectingEventEnd = false;
			eventCounter = 0;

			
			levelWidth = thisMC.rightLimit.x;
			levelHeight = thisMC.rightLimit.y;
			removeChild(thisMC.rightLimit);
			nodeWidth = NODE_WIDTH_CONST;//int(widthVar/GRID_WIDTH);
			GRID_WIDTH = levelWidth / nodeWidth + 3;
			nodeHeight = nodeWidth * 0.5;
			nodeHalfWidth = nodeWidth * 0.5;
			nodeHalfHeight = nodeHeight * 0.5;
			GRID_HEIGHT = levelHeight / nodeHeight + 4;
				
			createNodes();
			
			TOTAL_GRID_HEIGHT = GRID_HEIGHT * nodeHeight;
			TOTAL_GRID_WIDTH = GRID_WIDTH * nodeWidth;
			
			updateConnectedNodes();
			
			for (i = 0; i < 10; ++i)
				{
					if (getChildByName("event" + i) != null)
					{
						eventsColsArr.push( getBitsCol (getBitsNode(getChildByName("event" + i).x)) );
						removeChild(getChildByName("event" + i));
					}
				}
			for (i = 0; i < 22; ++i)
				{
					if (getChildByName("point" + i) != null)
					{
						getChildByName("point" + i).visible = false;
					}
				}
			for (i = 0; i < 22; ++i)
				{
					if (getChildByName("bit" + i) != null)
					{
						getChildByName("bit" + i).visible = false;
					}
				}
				
				
				
			//Create Meets
				
			for(i = 0; i < this.numChildren-1; i++)	{
				var mc:* = this.getChildAt(i);
				if (MovieClip(getChildAt(i)).name.substring(0, 5) == "meet_") {	//Get all meets movieClips, which name starts with "meet_"
						meetsArr.push( createMeetClass(mc) );
				}
			}
			meetsArr.sortOn("xVar", Array.NUMERIC);
			preloadNextMeet();
			
			//Create Items pool
			itemManager.createItemPool(5);
			projectileManager.createProjectilePool(5);
				
			init2();
			//Main.instance.collectGarbage();
		}
		public function startCamera():void {
			cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.player, -1, 10) );			

			cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.player, 150, 40, 0, true, true) );						
			cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.point2, 5, 1, 0, true, true) );		
		}
		public function currentMeet():Meet {
			return meetsArr[0];
		}
		public function genericMeetUpdate():void {
			if (meetsArr[0].eventsArr.length != 0)
				if ( getBitsCol(thisMC.player.x) == meetsArr[0].eventsArr[0] )	{
					meetsArr[0].eventsArr.shift();
					currentMeet().start();	
				}
			//for (var i:int = 0; i < meetsArr[0].eventFunction.length; ++i)
			//	meetsArr[0].eventFunction[i]();
				
			var len:int = meetsArr[0].eventFunction.length;
			if (!didEvent1 && len >= 1) {
				if ( meetsArr[0].eventFunction[0]() )
					didEvent1 = true;
			}
			if (!didEvent2 && len >= 2) {
				if ( meetsArr[0].eventFunction[1]() )
					didEvent2 = true;
			}
			if (!didEvent3 && len >= 3) {
				if ( meetsArr[0].eventFunction[2]() )
					didEvent3 = true;
			}
			if (!didEvent4 && len >= 4) {
				if ( meetsArr[0].eventFunction[3]() )
					didEvent4 = true;
			}
			if (!didEvent5 && len >= 5) {
				if ( meetsArr[0].eventFunction[4]() )
					didEvent5 = true;
			}
			if (!didEvent6 && len >= 6) {
				if ( meetsArr[0].eventFunction[5]() )
					didEvent6 = true;
			}
		}
		public function endMeet():void {
			expectingEvents = false;
			meetsArr.shift();
		}
		public function setCirclesSize(_attckingCircleSize:int = 1, _innerCircleSize:int = 1, _outerCircleSize:int = 10):void {
			attckingCircleSize = _attckingCircleSize;
			innerCircleSize = _innerCircleSize;
			outerCircleSize = _outerCircleSize;
		}

		public function preloadNextMeet():void {
						
			if (meetsArr.length != 0)
				meetsArr[0].preload();
		}
		public function doNothing():void {}
		public function createMeetClass(meetMc:MovieClip):Meet {
			var tempMeet:Meet = new Meet( meetToLocal(meetMc, meetMc.leftLimit).x, meetToLocal(meetMc, meetMc.rightLimit).x, meetMc );
			meetMc.visible = false;
			var i;
			for (i = 0; i < 10; ++i)
			{
				if (tempMeet.mc.getChildByName("event" + i) != null)
				{
					var bitStageX:int = tempMeet.mc.getChildByName("event" + i).x + tempMeet.mc.x;
					tempMeet.eventsArr.push( getBitsCol (getBitsNode(bitStageX) ) );
					tempMeet.mc.removeChild(tempMeet.mc.getChildByName("event" + i));
				}
			}
			
			addFunctionToMeet(tempMeet, "start");
			addFunctionToMeet(tempMeet, "preload");
			addFunctionToMeet(tempMeet, "update");
			addFunctionToMeet(tempMeet, "end");
			
			for (i = 1; i <= 6; ++i)
				addEventFunctionToMeet(tempMeet,"_event" + i);
			
			trace("Meet created");
			return tempMeet;
		}
		public function addFunctionToMeet(meet:Meet, functionName:String):void {
			if (thisMC.hasOwnProperty(meet.meetName + functionName) )
				meet[functionName] = thisMC[ meet.meetName + functionName ];
			else
				meet[functionName] = thisMC[ "doNothing" ];
		}
		public function addEventFunctionToMeet(meet:Meet, functionName:String):void {
			if (thisMC.hasOwnProperty(meet.meetName + functionName) )
				meet.eventFunction.push( thisMC[ meet.meetName + functionName ] );
			//else
				//meet.eventFunction.push( thisMC[ "doNothing" ] );
		}
		public function getPoint(mc:MovieClip):Point {
			return new Point (mc.x, mc.y);
		}
		public function meetToLocal(meet:*, point:MovieClip):Point {
			trace(meet.x + "meet x");
			var p:Point = meet.localToGlobal( getPoint(point) );
			p = this.globalToLocal(p);
			return p;
		}
		public function getMeetPoint(pointName:String):Point{
			return meetToLocal( meetsArr[0].mc, meetsArr[0].mc[pointName] );
		}
		protected function init2():void {	
		}
		
	public function setScreenLimits(leftBitVar:MovieClip, rightBitVar:MovieClip):void
	{
		reupdateOnLimitNodesRight(getBitsCol(rightBit), (getBitsCol(getBitsNode(rightBitVar.x))));
		rightBit = getBitsNode(rightBitVar.x);
		setLeftBit (leftBitVar.x);
	}
	public function setScreenLimitsToCols(leftBitVar:int, rightBitVar:int):void
	{
		updateOnLimitNodesRight(rightBitVar);
		rightBit = rightBitVar;
		setLeftBit (leftBitVar);
	}	
public function getBitsNode(bit:int):int
{
	bit /= NODE_WIDTH_CONST;
	bit *= NODE_WIDTH_CONST;
	return bit;
}

public function freeCamera():void {
			setFreeRoam();
			freeAllNodesFromLimit();
			freeAllStickyBits();
	lookingFowardToBit = -1;
		}
public function setToCurrentMeetLimitsAndStickTo(dir:int):void {
	cameraManager.currentInstance.stayOnLeftBit = false;
	cameraManager.currentInstance.stayOnRightBit = false;
	if (dir == LEFT)
		cameraManager.currentInstance.stayOnLeftBit = true;
	else
		cameraManager.currentInstance.stayOnRightBit = true;
	setToCurrentMeetLimits();
}
public function setToCurrentMeetLimits():void {
			freeAllNodesFromLimit();
			setLimits(currentMeet().leftLimit, currentMeet().rightLimit);
}
public function setLimits(leftBit:int, rightBit:int):void {
	setLeftBit(leftBit);
	setRightBit(rightBit);
}
public function setLeftBit(bit:int):void
{
	leftBit = getBitsNode(bit);
	updateOnLimitNodesLeft(getBitsCol(leftBit));
	leftBit += NODE_WIDTH_CONST;
}
public function setRightBit(bit:int):void
{
	rightBit = getBitsNode(bit);
	updateOnLimitNodesRight(getBitsCol(rightBit));
}
public function getBitsCol(bit:int):int
{
	return getNodeAtPoint( new Point(bit, 0) )._col;
}
public function setFreeRoam():void {
	leftBit = NODE_WIDTH_CONST;
	rightBit = width;
}
public function freeAllStickyBits():void {
	cameraManager.currentInstance.stayOnRightBit = false;
	cameraManager.currentInstance.stayOnLeftBit = false;
}
public function freeAllNodesFromLimit():void {
	var len:int = _nodes.length;
	for ( var j:int = 0; j < len; ++j )
		_nodes[j].onLimit = false;
}
	public function updateOnLimitNodesRight(bit:int):void
	{
		var i:int;
		var c:int = bit;
		while (c < GRID_WIDTH)
		{
			for (i = 0; i < GRID_HEIGHT; ++i)
			{
				//_nodes[ i * GRID_WIDTH + c].highlight(3);
				_nodes[ i * GRID_WIDTH + c].onLimit = true;
			}
			++c;
		}
	}
	
	public function reupdateOnLimitNodesRight(oldBit:int, bit:int):void
	{
		var i:int;
		var c:int = oldBit - 1;
		//trace(bit + "YOOO");
		while (c < bit)
		{
			for (i = 0; i < GRID_HEIGHT; ++i)
			{//trace("YOOO");
				//_nodes[ i * GRID_WIDTH + c].highlight(0);
				_nodes[ i * GRID_WIDTH + c].onLimit = false;
			}
			++c;
		}
	}
	public function removeRightLimit():void {
		rightBit = getBitsNode(GRID_WIDTH - 1);
		reupdateOnLimitNodesRight(rightBit, GRID_WIDTH - 1);
	}
	public function updateOnLimitNodesLeft(bit:int):void
	{
		var i:int;	
		var c:int = bit;
		while (c >= 0)
		{		//trace("DSDSDS" + c);

			for (i = 0; i < GRID_HEIGHT; ++i)
			{
				//_nodes[ i * GRID_WIDTH + c].highlight(3);
				var temp:* = _nodes[ i * GRID_WIDTH + c];
				temp.onLimit = true;
				for each (var item:Object in itemManager.itemsOnGroundArr) 
					if ( item.itemNode._col == temp._col )
						if ( item.itemNode._row == temp._row ) {
							item.disappear();
						}
			}
			--c;
		}			
	}
	public function checkCollisionWithItems(actor:MovieClip, actorNode:Node) {
		for each (var item:Object in itemManager.itemsOnGroundArr) 
			if ( item.itemNode._col == actorNode._col )
				if ( item.itemNode._row == actorNode._row ) {
					item.disappear();
					Main.instance.addPlus1Animation( localToGlobal(new Point(item.x, item.y)).x,  localToGlobal(new Point(item.x, item.y)).y );
					actor.heal(1);
					playHealSound();
					actor.gotItemFx.play();
					return;
				}
	}
	public function addPlayer(position:int):void {
			setUnmoveable();
			characterObjects.push(thisMC.player);	
			depthArr.push(thisMC.player);
			playerStartX = thisMC.player.x;
			thisMC.player.x = position;
		}
	public function setUnmoveable():void
	{
		thisMC.player.moveable = false;
		if (Main.instance.android)
		_main.virtualJoystick.unmoveable = false;
	}
	public function reached():void {
		setMoveable();
	}
	public function setMoveable():void
	{	//cameraManager.startNextInstance();
		thisMC.player.moveable = true;
			if (Main.instance.android)
		_main.virtualJoystick.unmoveable = true;
	}
	public function addParallax(mc:MovieClip):void
	{	/*if (android)
		{
			mc.visible = false;
			return;
		}*/
		if (mc.paraDepth >= 0)
		{
			backParallaxObjects.push(mc);
			backParallaxObjects.sortOn("paraDepthX100", Array.NUMERIC);
			backParallaxObjects.reverse();
		}
		else
		{
			frontParallaxObjects.push(mc);
			frontParallaxObjects.sortOn("paraDepthX100", Array.NUMERIC);
		}			
	}
	public function addBackground(mc:MovieClip):void
	{
		backgroundsArr.push(mc);
		backgroundsArr.sortOn("place", Array.DESCENDING | Array.NUMERIC);
		backgroundsArr.reverse();
	}
		
		
		public function popItem( itemType:String, xVar:int, yVar:int ):void {
			itemManager.createItem( itemType, xVar, yVar );
		}
		/*public function playerGotItem(item:*):void
		{
			//itemsToUpdateArr.erase(temp.name);
		}
		public function checkIfOnWater(mc:MovieClip):Boolean
		{return false;
			for (var i:int = 0; i<waterBlocks.length; i++)
			{	//if ( waterBlocks[i].hitTestObject(MovieClip(mc)._groundFoot) )
				if ( waterBlocks[i].hitTestPoint(  mc.localToGlobal( new Point( mc.ground.x, 0 ) ).x + (mc.getGroundWidth() * 0.5) * mc.scaleX,  mc.localToGlobal(new Point(0, mc.ground.y)).y + mc.getGroundHeight() * 0.5 ) )
					return true;
			}
			return false;
		}
		public function checkIfPointOnWater(xVar:int, yVar:int):Boolean
		{return false;
			for (var i:int = 0; i<waterBlocks.length; i++)
			{	//if ( waterBlocks[i].hitTestObject(MovieClip(mc)._groundFoot) )
				if ( waterBlocks[i].hitTestPoint(  this.localToGlobal( new Point( xVar, 0 ) ).x ,  this.localToGlobal(new Point(0, yVar)).y ) )
					return true;
			}
			return false;
		}*/
		public function checkIfDecoShake(playerMC:MovieClip):void
		{
			if (playerMC.currentLabel == "walk" || playerMC.currentLabel == "pushed" || playerMC.currentLabel == "hit1")
			{
				var len:int = shakeArr.length;
				var globalPointX:int =  localToGlobal( new Point(shakeArr[i].x , 0)).x;
				var globalPointY:int =  localToGlobal( new Point(0 , shakeArr[i].y)).y;
				for (var i:int = 0; i < len; ++i)
				{
					if (playerMC.groundFoot.hitTestPoint( globalPointX ,globalPointY ))
						if (shakeArr[i].currentLabel != "shake")
							shakeArr[i].gotoAndPlay("shake");
				}
			}
		}
		public function shakeAll():void
		{
			var len:int = shakeArr.length;
			for (var i:int = 0; i < len; ++i)
			{
				if (shakeArr[i].currentLabel != "shake")
					shakeArr[i].gotoAndPlay("shake");
			}
		}
		public function checkIfDecoShakeByDeco():void
		{
			var globalPointX:int;
			var globalPointY:int;
			var len:int = shakeArr.length;
			var charLen:int = characterObjects.length;
			var j;
			var object:MovieClip;
			for (var i:int = 0; i < len; ++i)
			{
				globalPointX = localToGlobal( new Point(shakeArr[i].x , 0)).x;
				globalPointY = localToGlobal( new Point(0 , shakeArr[i].y)).y;
				for (j = 0; j < charLen; ++j)
				{
					object = characterObjects[j];
					if (object.currentLabel == "walk" || object.currentLabel == "pushed" || object.currentLabel == "hit1" || object.currentLabel == "hit2")
					{
						if (object.groundFoot.hitTestPoint( globalPointX ,globalPointY ))
						if (shakeArr[i].currentLabel != "shake")
							shakeArr[i].gotoAndPlay("shake");
					}
				}
			}
		}

		public function askForNewWalkFxAtPoint(xVar:int, yVar:int, scaleVar:int, water:Boolean = false):void
		{
			if (Main.instance.graphicLevel == 1)
				return;
			var temp:*;
			if (water)
				putFxOnPoint("fx_walk_splash", new Point(xVar, yVar), true);
			else {
				temp = askForFx("fx_walk_dirt");
				temp.playFxOnPoint(xVar + randomNumber(-5, 5), yVar + randomNumber(-5, 5) +7);
				
				temp.scaleX = scaleVar; //Direction of walking actor
				var rand:Number = Math.random();
				if (rand < 0.2) {
					temp.scaleX *= 1.1;
					temp.scaleY = 1.1;
				}
				else if (rand < 0.6) {
					temp.scaleX *= 0.8;
					temp.scaleY = 0.8;
				}
			}
				
		}
		
		public function addUnderCover(xVar:int, yVar:int, side:int = NO_DIR_X):void
		{
			var temp:MovieClip = addDummyAI(NO_DIR_Y, NO_DIR_X, 0, 0, xVar, yVar, "flowerOcto","octo","octo", "fish", side);
						dummiesArr.pop();
temp.rechargeInSeconds = 2 * gameFrameRate;
			temp.canMelee = true;
			temp.melee = new Attack("spinAttack", 0.5, true, 0, 0, false, 0, 0, false, true);
			temp.setSpeed(	2 ,2,
							2, 2,
							3, 3);
			temp.setHp(5);
			
			temp.startModd(UNDER_COVER);
			underCoverArr.push(temp);
			temp.tryAttackAlways = true;
			temp.alwaysGoToTarget = true;
			
			temp.doChargeSound = true;
			temp.doMonsterHurtSound = true;
			temp.doMonsterAttackSound = true;
		}
		
		public function addEnemy(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int, side:int = NO_DIR_X, jumpIntro:String = null):void {
			var temp:MovieClip  = new Fighter("star", "star", "star", "star");
			addChild(temp);
			temp.flip(side);
			temp.x = xVar;
			temp.y = yVar;
		
			if (jumpIntro != null)
				temp.setStartAnimation(jumpIntro, delay);
			else
				temp.setStartWalk(DIR_Y_VAR, dirXVar, space, delay, side);
			
			characterObjects.push(temp);
			depthArr.push(temp);			
		}
		public function setLook(object:*, headString:String, handString:String, bellyString:String, weaponString:String):void {
			object.headString = headString;
			object.handString = handString;
			object.bellyString = bellyString;// "flower";
			object.weaponString = weaponString;
			object.updateLook();
		}
		
		public function addDummy(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int, side:int = NO_DIR_X, jumpIntro:Boolean = false):void
		{

			var temp:MovieClip  = new Fighter("star", "star", "star", "star");
			addChild(temp);
			temp.flip(side);
			temp.x = xVar;
			temp.y = yVar;
			
			if (jumpIntro)
				temp.setStartAnimation("jumpIntro", delay);
			else
				temp.setStartWalk(DIR_Y_VAR, dirXVar, space, delay, side);
			
			temp.melee = new Attack("punch1", 0.5, true, 0, 0, false, 0, 0, false, true);
			
			characterObjects.push(temp);
			depthArr.push(temp);			
			temp.startModd(RANGED);//dummiesArr.push(temp);
			
		}
		public function addPurpleOcto(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int, side:int = NO_DIR_X, intro:String = null):MovieClip {
			var temp:MovieClip = addRangerAI(DIR_Y_VAR, dirXVar, space, delay, xVar, yVar, "purple","purple","purple", "empty", side, intro);
			temp.canRange = true;
			temp.ranged = new Attack("inkShoot", 0.5, true, 0, 0, false, 0, 0, false, true);
			temp.ranged.doInk = true;
			temp.setSpeed(	2, 2,
							2, 2,
							3, 2);
			temp.setHp(4);
			//temp.recharge();
			temp.rechargeInSeconds = 3 * gameFrameRate;
			temp.rangerDistanceX = 180;
			temp.rangerMaxRange = 280;
			temp.rangerMinRange = 1;
			temp.doChargeSound = true;
			temp.doMonsterHurtSound = true;
			temp.doMonsterAttackSound = true;
			temp.tryAttackAlways = true;	//try every frame to check if can attack
			return temp;
		}
		public function addRangerAI(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int,
								  headString:String, handString:String, bellyString:String, weaponString:String, side:int = NO_DIR_X, jumpIntro:String = null):MovieClip	{
			var temp:MovieClip = new Fighter(headString, handString, bellyString, weaponString);
			addChild(temp);
			temp.visible = false;
			temp.flip(side);
			temp.x = xVar;
			temp.y = yVar;

			//setLook(temp, headString, handString, bellyString, weaponString);
			if (jumpIntro != null)
				temp.setStartAnimation(jumpIntro, delay);
			else
				temp.setStartWalk(DIR_Y_VAR, dirXVar, space, delay, side);
			
			characterObjects.push(temp);
			depthArr.push(temp);		
			rangersArr.push(temp);
			temp.startModd(RANGED);
			rangersAIManagerUpdate();
			return temp;
		}
		
		public function addFatOcto(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int, side:int = NO_DIR_X):MovieClip {
			var temp:MovieClip  = new Heavy();
			addChild(temp);
			temp.x = xVar;
			temp.y = yVar;
			temp.flip(side);
			temp.setStartWalk(DIR_Y_VAR, dirXVar, space, delay, side);
			temp.doGuardAnimation = true;
			temp.rechargeInSeconds = 2 * gameFrameRate;
			temp.canMelee = true;
			temp.melee = new Attack("punch1", 1, false, 4, -22, false, 67, 40, true, true);
			temp.setSpeed(	2 ,1,
							2, 1,
							2, 2);
			temp.setHp(7);
			characterObjects.push(temp);
			depthArr.push(temp);
			temp.startModd(ATTACK);
			temp.doChargeSound = true;
			temp.doMonsterHurtSound = true;
			temp.doMonsterAttackSound = true;
			
			temp.tryAttackAlways = true;
			temp.alwaysGoToTarget = true;	//dont go to go close state, stay in attack state
			return temp;
		}
		public function addOcto(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int, side:int = NO_DIR_X, intro:String = null):MovieClip {
			var temp:MovieClip = addDummyAI(DIR_Y_VAR, dirXVar, space, delay, xVar, yVar, "octo","octo","octo", "fish", side, intro);
			temp.rechargeInSeconds = 2 * gameFrameRate;
			temp.canMelee = true;
			temp.melee = new Attack("punch1", 0.5, true, 0, 0, false, 0, 0, false, true);
			temp.setSpeed(	2 ,2,
							2, 2,
							4, 3);
			temp.setHp(5);
			temp.doChargeSound = true;
			temp.doMonsterHurtSound = true;
			temp.doMonsterAttackSound = true;
			return temp;
		}
		public function addStar(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int, side:int = NO_DIR_X, intro:String = null):MovieClip {
			var temp:MovieClip = addDummyAI(DIR_Y_VAR, dirXVar, space, delay, xVar, yVar, "star","star","star", "empty", side, intro);
			temp.rechargeInSeconds = 1.5 * gameFrameRate;
			temp.canMelee = true;
			temp.melee = new Attack("punch1", 1, true, 1, 1, false, 0, 10, false, true);
			temp.setSpeed(	3 ,2,
							3, 3,
							4, 3);
			temp.setHp(7);
			temp.doChargeSound = true;
			temp.doMonsterHurtSound = true;
			temp.doMonsterAttackSound = true;
			temp.isStar = true;
			return temp;
		}
		public function addMoon(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int, side:int = NO_DIR_X, intro:String = null):MovieClip {
			var temp:MovieClip = addDummyAI(DIR_Y_VAR, dirXVar, space, delay, xVar, yVar, "moon","moon","moon", "empty", side, intro);
			temp.rechargeInSeconds = 2 * gameFrameRate;
			temp.canMelee = true;
			temp.melee = new Attack("punch1", 1.5, true, 1, 1, false, 0, 10, false, true);
			temp.setSpeed(	3 ,2,
							3, 3,
							4, 3);
			temp.setHp(7);
			temp.isMoon = true;
			return temp;
		}
		public function addCowboy(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int, side:int = NO_DIR_X, intro:String = null):MovieClip {
			var temp:MovieClip = addDummyAI(DIR_Y_VAR, dirXVar, space, delay, xVar, yVar, "cowboy","cowboy","cowboy", "cactus", side, intro);
			temp.rechargeInSeconds = 3 * gameFrameRate;
			temp.canMelee = true;
			temp.melee = new Attack("punch1", 0.5, true, 0, 0, false, 0, 0, true, true);
			temp.setSpeed(	3 ,2,
							3, 2,
							4, 3);
			temp.setHp(6);
			temp.doChargeSound = true;
			temp.doMonsterHurtSound = true;
			temp.doMonsterAttackSound = true;
			return temp;
		}
		public function addGunner(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int, side:int = NO_DIR_X, intro:String = null):MovieClip {
			var temp:MovieClip = addRangerAI(DIR_Y_VAR, dirXVar, space, delay, xVar, yVar, "gunner","cowboy","cowboy", "gun", side, intro);
			temp.rechargeInSeconds = 3 * gameFrameRate;
			temp.canRange = true;
			temp.ranged = new Attack("gunShot", 0.5, true, 0, 0, false, 0, 0, false, true);
			temp.setSpeed(	2, 2,
							3, 2,
							3, 2);
			temp.setHp(5);
			//temp.recharge();
			temp.rechargeInSeconds = 4 * gameFrameRate;
			temp.rangerDistanceX = 240;
			temp.rangerMaxRange = 600;
			temp.rangerMinRange = 1;
			temp.doChargeSound = true;
			temp.doMonsterHurtSound = true;
			temp.doMonsterAttackSound = true;
			temp.tryAttackAlways = true;	//try every frame to check if can attack
			return temp;
		}
		public function addKidOcto(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int, side:int = NO_DIR_X, intro:String = null):MovieClip {
			var temp:MovieClip = new Fighter("kid", "octo", "octo", "empty");
			addChild(temp);
			temp.visible = false;
			temp.flip(side);
			temp.x = xVar;
			temp.y = yVar;
			//setLook(temp, headString, handString, bellyString, weaponString);
			if (intro != null)
				temp.setStartAnimation(intro, delay);
			else
				temp.setStartWalk(DIR_Y_VAR, dirXVar, space, delay, side);
			
			characterObjects.push(temp);
			depthArr.push(temp);		
			temp.setSpeed(	1 ,1,
							1, 1,
							1, 1);
			temp.setHp(3);
			temp.startModd(CASUAL);
			temp.doChargeSound = true;
			temp.doMonsterHurtSound = true;
			temp.doMonsterAttackSound = true;
			return temp;
		}
		public function addStupidOcto(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int, side:int = NO_DIR_X, intro:String = null):MovieClip {
			var temp:MovieClip = new Fighter("stupid", "octo", "octo", "empty");
			addChild(temp);
			temp.visible = false;
			temp.flip(side);
			temp.x = xVar;
			temp.y = yVar;
			temp.callAllStationsOnDeath = true;

			//setLook(temp, headString, handString, bellyString, weaponString);
			if (intro != null)
				temp.setStartAnimation(intro, delay);
			else
				temp.setStartWalk(DIR_Y_VAR, dirXVar, space, delay, side);
			
			characterObjects.push(temp);
			depthArr.push(temp);		
			temp.setSpeed(	1 ,1,
							1, 1,
							1, 1);
			temp.setHp(1);
			temp.doChargeSound = true;
			temp.doMonsterHurtSound = true;
			temp.doMonsterAttackSound = true;
			temp.startModd(CASUAL);
			return temp;
		}
		public function addDummyAI(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int,
								  headString:String, handString:String, bellyString:String, weaponString:String, side:int = NO_DIR_X, jumpIntro:String = null):MovieClip	{
			var temp:MovieClip = new Fighter(headString, handString, bellyString, weaponString);
			addChild(temp);
			temp.visible = false;
			temp.flip(side);
			temp.x = xVar;
			temp.y = yVar;

			//setLook(temp, headString, handString, bellyString, weaponString);
			if (jumpIntro != null)
				temp.setStartAnimation(jumpIntro, delay);
			else
				temp.setStartWalk(DIR_Y_VAR, dirXVar, space, delay, side);
			
			temp.rechargeInSeconds = 3 * gameFrameRate;
			temp.canMelee = true;
			temp.melee = new Attack("punch1", 0.5, true, 0, 0, false, 0, 0, false, true);
			temp.setSpeed(	1, 1,
							2, 2,
							2, 2);
			temp.setHp(3);
			
			characterObjects.push(temp);
			depthArr.push(temp);		
			dummiesArr.push(temp);
			AIManagerUpdate();
			return temp;
		}
		public function addBullyAI(DIR_Y_VAR:int, dirXVar:int, space:int, delay:int, xVar:int, yVar:int,
								  headString:String, handString:String, bellyString:String, weaponString:String, side:int = NO_DIR_X, jumpIntro:String = null):MovieClip	{
			var temp:MovieClip = new Bully(headString, handString, bellyString, weaponString, handString, handString, handString);
			addChild(temp);
			temp.visible = false;
			temp.flip(side);
			temp.x = xVar;
			temp.y = yVar;
									  temp.side = side;

			if (jumpIntro != null)
				temp.setStartAnimation(jumpIntro, delay);
			else
				temp.setStartWalk(DIR_Y_VAR, dirXVar, space, delay, side);
			
			temp.rechargeInSeconds = 2.5 * gameFrameRate;
			temp.canMelee = true;
			temp.melee = new Attack("punch1", 1.5, false, 15, -10, false, 60, 25, true, true);
			temp.setSpeed(	1, 1,
							1, 1,
							1, 1);
			temp.setHp(16);
			
			characterObjects.push(temp);
			depthArr.push(temp);		
			temp.startModd(ATTACK);
			temp.tryAttackAlways = true;
			temp.alwaysGoToTarget = true;	//dont go to go close state, stay in attack state
			return temp;
		}
		public function whereIsTargetComparedTo(mc:MovieClip, target:MovieClip):int
		{
			if ( getGroundX(target) > getGroundX(mc) )
				return RIGHT;
			else
				return LEFT;
		}
		public function resetDeathCount():void
		{
			deathCount = 0;
			deathCountDummy = 0;
			deathCountRanger = 0;
			deathCountHeavy = 0;
		}
		public function plusDummyDeath():void
		{	//overAllDeathCount++;
			deathCount += 1;
			deathCountDummy += 1;
		}
		public function plusRangerDeath():void
		{//overAllDeathCount++;
			deathCount += 1;
			deathCountRanger += 1;
		}
		public function plusHeavyDeath():void
		{//overAllDeathCount++;
			deathCount += 1;
			deathCountHeavy += 1;
		}
		public function didntDoEvents():void
		{
			didEvent1 = false;
			didEvent2 = false;
			didEvent3 = false;
			didEvent4 = false;
			didEvent5 = false;
			didEvent6 = false;
		}
		public function eventChecker():void {
			meetsArr[0].update();
		}
		public function updateTime():void {
			var numOfSecs:int = Math.ceil(frameTimer.currentFrameCount/gameFrameRate);
			var minutes:int = numOfSecs/60;
			var seconds:int = numOfSecs%60;
			trace("Time: " + minutes +":"+seconds);
			if (seconds <= 9 )
				Main.instance.timerText.text =  minutes +":0"+seconds;
			else
				Main.instance.timerText.text =  minutes +":"+seconds;
		}
		protected function onEnterFrame(event:Event = null):void
		{	
			trace(deathCount    + "    deathCount");trace(overAllDeathCount + "   overol deathCount");
			if (isPaused)
				return;
			//trace("count:  " + frameTimer.currentFrameCount);
			

			y = cameraY;
			x = cameraX;			
			
			removeShake();
			frameTimer.onTimerHandler();
			doShakeUpdate();
			
			if (expectingEvents)
				eventChecker();
			
			updateFrames();
			if ( inkOnScreen )
				_main.inkEnterFrame();
		}
		public function setShake(shakeVar:int):void {
			if (shake < shakeVar)
				shake = shakeVar;
		}
		public function doShake(shakeVar:int):void {
			if (shake < shakeVar)
				shake = shakeVar;
		}
		public function doShakeUpdate():void {
			if (shake != 0) {
				shakeX = Math.random() * shake - shake * 0.5;
				shakeY = Math.random() * shake - shake * 0.5;
				x += shakeX;
				y += shakeY;
				--shake;
			}
		}
		public function removeShake():void {
			x -= shakeX;
			y -= shakeY;
		}
		public function updateCamera():void {
			cameraManager.update();
		}
		public function checkPopItem(character:MovieClip):void
		{
				popItem("hearth", character.x, character.y);
		}
		
	/*	public function removeCharacterNew():void
		{
			var i:int;
			var len:int = characterObjects.length;
			
			var nameChaR:String = "";
			for (i = 0; i < len; i++)
			{//trace(characterObjects[i].name);
			//trace(character.name + "newFINDINT");
				if (characterObjects[i].death)
				{nameChaR = characterObjects[i].name;
					trace("newJUST DELETED CHAR");
					characterObjects.splice(i, 1);
					i = len;
								//deathCount++;
					var len2:int = dummiesArr.length;
					for (i = 0; i < len2; i++)
					{
						if (dummiesArr[i].death)
						{
							dummiesArr.splice(i, 1);
							i = len2;
						}
					}
					
					len2 = underCoverArr.length;
					for (i = 0; i < len2; i++)
					{
						if (underCoverArr[i].death)
						{
							underCoverArr.splice(i, 1);
							i = len2;
						}
					}
					len2 = rangersArr.length;
					for (i = 0; i < len2; i++)
					{
						if (rangersArr[i].death)
						{
							rangersArr.splice(i, 1);
							i = len2;
						}
					}
					var len3:int = depthArr.length;
					for (i = 0; i < len3; i++)
					{
						if (depthArr[i].death)
						{
							depthArr.splice(i, 1);
							i = len3;
						}
					}
			AIManagerUpdate();

			removeChild(getChildByName(nameChaR));	
					return;
			}
		}
			
		}*/
		public function removeFromArr(objectName:String, arr:Array):void {
			var len:int = arr.length;
			for ( var i:int = 0; i < len; i++ ) {
				if (arr[i].name == objectName) {
					arr.splice(i, 1);
					return;
				}
			}
			
		}
		
		public function reportDeath():void {
			
			deathCount++;
			overAllDeathCount++;
		}
		public function removeCharacter(character:MovieClip):void {
			checkPopItem(character);			
			removeFromArr( character.name, characterObjects );
			removeFromArr( character.name, dummiesArr );
			removeFromArr( character.name, underCoverArr );
			removeFromArr( character.name, depthArr );
			removeFromArr( character.name, rangersArr );
			AIManagerUpdate();
			rangersAIManagerUpdate();
			if(!character.alreadyReportedDeath) {
				reportDeath();
				}
			trace(character.name + "Removed froms arrs");
			var i:int;
				try {
			for (i = 0; i < characterObjects.length; ++i)
			{
				if (characterObjects[i].target != null)
				if (characterObjects[i].target.name == character.name)
					characterObjects[i].target = null;
				if (characterObjects[i].topPriorityTarget != null)
				if (characterObjects[i].topPriorityTarget.name == character.name)
					characterObjects[i].topPriorityTarget = null;
			}
			}
			catch (error:Error) {trace("error target deleting");}
			/*if (useBodiesArr) {
				bodiesArr.push(character);
				removeChild(getChildByName(character.name));
				character = null;
				
			}
			else*/
			trace("going to remove child");
				removeChildByMC(character);
		}
		public function removeChildByMC(child:MovieClip):void {
			try {
			removeChild(getChildByName(child.name));	
			child = null;}
			catch (error:Error) {trace("error killing the fellow");}
		}
		public function collectBodiesArr():void {
			trace(bodiesArr.length + "BODIES________________");
			while (bodiesArr.length != 0)
				bodiesArr.pop();
		}
		
		public function getTarget():MovieClip
		{
			return thisMC.player;
		}
		public function addToDepthArr(mc:MovieClip):void
		{trace(depthArr.length + "before");
			depthArr.push(mc);trace(depthArr.length + "after");
		}
		public function addToBreakhArr(mc:MovieClip):void
		{
			breakArr.push(mc);
		}
		
		public function addToShakehArr(mc:MovieClip):void
		{
			shakeArr.push(mc);
		}
		public function addToHillshArr(mc:MovieClip):void
		{
			hillsArr.push(mc);
		}
		public function remove(mc:MovieClip):void {
			removeChild(mc);
		}
		public function depthArrSort():void
		{/*
			BACK PARA
			BACK
			GAME
			FRONT PARALAX*/
			var i:int;
			var numOfChildren:int = this.numChildren;
			var len:int =  backParallaxObjects.length;
			var totalLen:int = 0;
			for ( i = 0; i < len; ++i )
				setChildIndex( backParallaxObjects[i], i );
			
			totalLen += len;
			len = backgroundsArr.length;
			for ( i = 0; i < len; ++i )
				setChildIndex( backgroundsArr[i], totalLen );
						
			totalLen += len;
			setChildIndex( bloodContainer, numOfChildren-totalLen-1 );
			len = depthArr.length;
			
			//var temp:int = frontParallaxObjects.length;
			for (i = 0; i < len; i++)
			{	
				//if (depthArr[i].visible)
				if (depthArr[i].getChildByName("groundFoot") != null)
				//	if (depthArr[i] is Fx)
						depthArr[i].globalGroundY = getGroundY( depthArr[i] );	
					else
						depthArr[i].globalGroundY = depthArr[i].y;	
			}
			depthArr.sortOn("globalGroundY", Array.DESCENDING | Array.NUMERIC);
			var frontLen:int = frontParallaxObjects.length;
			for ( i = 0; i < len; ++i )
				this.setChildIndex( depthArr[i], numOfChildren- frontLen - 1 - i );//this.numChildren - 1 - depthArr.length + i);
			totalLen += len;
			len = frontParallaxObjects.length;
			for ( i = 0; i < len; ++i )
				setChildIndex( frontParallaxObjects[i], numOfChildren - i - 1);//totalLen);//this.numChildren - i - 1 );			
		}
		public function setSlippyNodes ( area:MovieClip ):void {
			for ( var j:int = 0; j < _nodes.length; ++j )
				if ( _nodes[j].hitTestObject(area) )
					_nodes[j].slippy = true;
		area.visible = false;
				area.x = -10;
				area.y = 0;
				area.width = 1;
				area.height = 1;
		}
		public function setOuchNodes ( area:MovieClip ):void {
			for ( var j:int = 0; j < _nodes.length; ++j )
				if ( _nodes[j].hitTestObject(area) ) {
					_nodes[j].ouch = true;
					//_nodes[j].traversable = false;
				}
		area.visible = false;
				area.x = -10;
				area.y = 0;
				area.width = 1;
				area.height = 1;
		}
		public function setNoLandEffectsNodes ( area:MovieClip ):void {
			for ( var j:int = 0; j < _nodes.length; ++j )
				if ( _nodes[j].hitTestObject(area) ) {
					_nodes[j].noLandEffects = true;
					//_nodes[j].traversable = false;
				}
		area.visible = false;
				area.x = -10;
				area.y = 0;
				area.width = 1;
				area.height = 1;
		}
		
		public function addWaterBlock(area:MovieClip):void
		{
			for ( var j:int = 0; j < _nodes.length; ++j )
				if ( _nodes[j].hitTestObject(area) )
					_nodes[j].water = true;
				area.visible = false;
				area.x = -10;
				area.y = 0;
				area.width = 1;
				area.height = 1;
		}
		public function addSlowBlock(area:MovieClip):void
		{
			for ( var j:int = 0; j < _nodes.length; ++j )
				if ( _nodes[j].hitTestObject(area) )
					_nodes[j].slowdown = true;
			area.visible = false;
				area.x = -10;
				area.y = 0;
				area.width = 1;
				area.height = 1;
							//remove(area);

		}
		public function addCollisionBlock(area:MovieClip):void
		{
			for ( var j:int = 0; j < _nodes.length; ++j )
				if ( _nodes[j].hitTestObject(area) )
					_nodes[j].traversable = false;
			updateConnectedNodes();
			area.visible = false;
				area.x = -10;
				area.y = 0;
				area.width = 1;
				area.height = 1;
		}
		public function addStompFx(mc:MovieClip):void
		{
			var temp:* = askForFx("fx_stomp_smoke");
			temp.playFx();
			temp.x = getGroundX(mc);
			temp.y = getGroundY(mc);
		}

		/*public function checkCurve(mc:MovieClip):int
		{
			var i:int;
			var arrLength:int = hillsArr.length;
			for (i = 0; i < arrLength; ++i)
					{
						if ( hillsArr[i].hitTestObject(mc.groundFoot) )
							return hillsArr[i].curve;
					}
			return 0;
		}*/
		
		public function updateFrames():void
		{		
			var i:int;
			for (i = 0; i < characterObjects.length; ++i)
				characterObjects[i].onEnterFrame();
			for (i = 0; i < projectileManager.activeArr.length; ++i)
				projectileManager.activeArr[i].onEnterFrame();	
		}
		
		public function askForNewBomb( shooter:MovieClip ):void	{
			var side:int = RIGHT;
			if ( shooter.scaleX == -1 )
				side = LEFT;
			var projectile:* = projectileManager.createInk( getGroundX(shooter), getGroundY(shooter), side);
			projectile.enemy = shooter.enemy;
			projectile.melee = shooter.ranged;
		}		
		public function askForNewShot( shooter:MovieClip ):void	{
			playRandomGunShotSound();
			var side:int = RIGHT;
			if ( shooter.scaleX == -1 )
				side = LEFT;
			var projectile:* = projectileManager.createBullet( getGroundX(shooter), getGroundY(shooter), side);
			projectile.enemy = shooter.enemy;
			projectile.melee = shooter.ranged;
		}		
		
		/*public function getRandomPointAtDistance( distance:int ,target:MovieClip, side:int = NO_DIR_X, borderNode:Boolean = false):Point {	
			var arr:Array = getNodesAtDistance(distance, target, borderNode);			
			var node:Node;

			var targetCol:int = getBitsCol(target.x);
			var leftArr:Array = [];
			var rightArr:Array = [];
			
			if (side == NO_DIR_X)
			{
				node = arr[randomNumber(0, arr.length - 1)];
			}
			else
			{
				var i:int;
				for (i = 0; i < arr.length; i++)
				{
					if (arr[i]._col > targetCol)
						rightArr.push(arr[i]);
					if (arr[i]._col < targetCol)
						leftArr.push(arr[i]);
				}
				
				if (side == RIGHT && rightArr.length > 3)
					node = rightArr[randomNumber(0, rightArr.length - 1)];
				else if (side == LEFT && leftArr.length > 3)
					node = leftArr[randomNumber(0, leftArr.length - 1)];
				else
					node = arr[randomNumber(0, arr.length - 1)];
			}
			
			if (node == null)
				node = node = arr[randomNumber(0, arr.length - 1)];
			return new Point ( node.x + randomNumber(1, nodeWidth - 10), node.y + randomNumber(0, nodeHeight - 10) );
		}*/

		protected function createNodes():void
		{
			if ( _gridHolder && contains(_gridHolder) )
				removeChild(_gridHolder);
			
			_gridHolder = new MovieClip();
			_nodes = [];
			var node:Node;
			var r, c:int;
			
			for (r = 0; r < GRID_HEIGHT; r++) 
			{
				for (c = 0; c < GRID_WIDTH; c++) 
				{
					node = new Node(r, c, nodeWidth, nodeHeight);
					node.width = nodeWidth;
					node.height = nodeHeight;	
					node.x = c * (node.width);
					node.y = r * (node.height);				
					_gridHolder.addChild(node);
					_nodes.push( node );
					if ( r == 0 || r == GRID_HEIGHT - 1 || c == 0 || c == GRID_WIDTH - 1 )
					{
						node.traversable = false;
						//node.highlight( 2222222 );
					}
				}
			}
			_gridHolder.x = 0;
			_gridHolder.y = 0;
			addChild(_gridHolder);
			_gridHolder.visible = false;
			//_gridHolder.alpha = 0.5;
		}
		public function getRandomNodeAtDistanceFromTarget (target:MovieClip, distance:int, getEdgeNodes:Boolean = false, sideOfTarget:int = NO_DIR_X):Node
		{
			var arr:Array = getNodesAtDistanceFromNode (getNodeOfCharacter(target), distance, getEdgeNodes, sideOfTarget);
			return arr[ randomNumber(0, arr.length - 1) ];
		}
		public function getRandomPointAtDistanceFromTarget (target:MovieClip, distance:int, getEdgeNodes:Boolean = false, sideOfTarget:int = NO_DIR_X):Point
		{
			var randomNode:Node = getRandomNodeAtDistanceFromTarget(target, distance, getEdgeNodes, sideOfTarget);
			return new Point( randomNode.x + randomNumber(5, nodeWidth - 5), randomNode.y + randomNumber(5, nodeHeight - 5) );
		}
		public function getNodesAtDistanceFromNode (node:Node, distance:int , getEdgeNodes:Boolean = false, sideOfTarget:int = NO_DIR_X):Array
		{	//Return nodes at choosen distance from var node. distance of 2 are the connected nodes of var node.
			var array:Array = [];
			getEdgeNodes = true;
			var temp:*; //Used to store connected nodes array of node
			if (getEdgeNodes)
				var edgeNodes:Array = [];
			if (sideOfTarget != NO_DIR_X)
				var sideNodes:Array = []; //If was asked for specific side form target, those nodes will be in this arr
			if ((getEdgeNodes) && (sideOfTarget != NO_DIR_X))
				var sideEdgeNodes:Array = [];
			var i, j, len:int;	//var color:int = Math.random()*0xFFFFFF;
			
			node.wasHere = true;
			array.push(node);

			while (--distance) {
				len = array.length;
				for (i = 0; i < len; ++i) {	//Get connected Nodes
					temp = array[i].connectedNodes;
					for (j = 0; j < temp.length; ++j)
						if ( temp[j].wasHere == false && temp[j].traversable == true) {
							temp[j].wasHere = true;	//temp[j].highlight( color );highlight(  Math.random()*0xFFFFFF );
							array.push(temp[j]);	
							if (( array[0]._col > temp[j]._col && sideOfTarget == LEFT) ||
								( array[0]._col < temp[j]._col && sideOfTarget == RIGHT)) {
								sideNodes.push(temp[j]);
								if (distance == 1 && getEdgeNodes)
									sideEdgeNodes.push(temp[j]);
								}
							if (distance == 1 && getEdgeNodes){
								edgeNodes.push(temp[j]);									
							}
						}
				}
			}
			
			len = array.length;
			for (i = 0; i < len; ++i)
				array[i].wasHere = false;
			
			if ((getEdgeNodes) && (sideOfTarget != NO_DIR_X))	//both side and edge
				if (sideEdgeNodes.length >= 1)
					return sideEdgeNodes;
					trace ("NO!!");
			if (sideOfTarget != NO_DIR_X)
				if (sideNodes.length >= 1)
					return sideNodes;
			if (getEdgeNodes && edgeNodes.length >= 1)
				return edgeNodes;
			return array;
		}
		
		
		public function getNodesAtDistance( distance:int ,target:MovieClip, getEdgeNodes:Boolean = false ):Array
		{
			var point:Point = getGlobalPoint(target);					
			var array:Array = [];
			var temp:*;
			var edgeNodes:Array = [];

			var node:Node;
			var i, j, len:int;
			var color:int = Math.random()*0xFFFFFF;
			
			node = getNodeAtPoint( point, false ) ;
			node.wasHere = true;
			array.push(node);

			while (--distance) {
				len = array.length;
				for (i = 0; i < len; i++) {	//Get connected Nodes
					temp = array[i].connectedNodes;
					for (j = 0; j < temp.length; j++)
						if ( temp[j].wasHere == false && temp[j].traversable == true) {
							temp[j].wasHere = true;
							array.push(temp[j]);	temp[j].highlight( color );
							if (distance == 1 && getEdgeNodes)
								edgeNodes.push(temp[j]);
						}
				}
			}
			
			len = array.length;
			for (i = 0; i < len; ++i)
				array[i].wasHere = false;
			
			if (getEdgeNodes)
				return edgeNodes;
			return array;
		}
		
		public function getNodeOfCharacter(character:MovieClip):Node
		{
			if (getNodeAtPoint( getGlobalPoint(character)).traversable )
				return getNodeAtPoint( getGlobalPoint(character));

			var p:Point = getGlobalPoint(character, 0);
			
			if (getNodeAtPoint(p).traversable)
				return getNodeAtPoint(p);
			
			p.x += character.getGroundWidth();
			if (getNodeAtPoint(p).traversable )
				return getNodeAtPoint(p);
				
			p.y += character.getGroundHeight();
			if (getNodeAtPoint(p).traversable )
				return getNodeAtPoint(p);
			
			p.x -= character.getGroundWidth();
			if (getNodeAtPoint(p).traversable)
				return getNodeAtPoint(p);
				
			return getNodeAtPoint( getGlobalPoint(character));
		}
		public function getPathToPoint(startObject:MovieClip, targetPoint:Point):Array {
			try {
			var pointsArr:Array = getPathToNode( getNodeOfCharacter(startObject), getNodeAtPoint(targetPoint) );
			pointsArr.push( targetPoint );
			return ( pointsArr );
			}
			catch (error:Error) {
				startObject.overkilled();
			trace("path error");
		}
		}
		public function getPathToTarget(startObject:MovieClip, targetObject:MovieClip):Array
		{	
			var pointsArr:Array = getPathToNode(getNodeOfCharacter(startObject), getNodeOfCharacter(targetObject));
			pointsArr.push(getGlobalPoint(targetObject));
			return ( pointsArr );
		}
		public function getPathFromActorToNode(startObject:MovieClip, endNode:Node):Array
		{	
			var pointsArr:Array = getPathToNode(getNodeOfCharacter(startObject), endNode);
			pointsArr.push( new Point(endNode.x + nodeHalfWidth, endNode.y + nodeHalfHeight) );
			//pointsArr.push(pointsArr[pointsArr.length -1]);
			return ( pointsArr );
		}
		public function getPathToNode(startNode:Node, endNode:Node):Array
		{	var pointsArr:Array = pathfinding.Pathfinder.findPath( startNode, endNode );
			if (pointsArr != null && pointsArr.length > 2) {
				pointsArr.shift();
				pointsArr.pop();
			}
			return ( pointsArr );
		}
		
		public function updateConnectedNodes():void
		{
			for (var r:int = 0; r < GRID_HEIGHT; r++) 
			{
				for (var c:int = 0; c < GRID_WIDTH; c++) 
				{
					_nodes[ r * GRID_WIDTH + c].connectedNodes = findConnectedNodes( _nodes[ r * GRID_WIDTH + c] );
				}
			}
		}
		
		public function findConnectedNodes( node:Node ):Array
		{
			var connectedNodes:Array = [];
			if (node._col != 0)	//Left
				connectedNodes.push(_nodes[ node._row * GRID_WIDTH + node._col - 1 ]);
			if (node._col != GRID_WIDTH - 1) //Right
				connectedNodes.push(_nodes[ node._row * GRID_WIDTH + node._col + 1]);
			if (node._row != GRID_HEIGHT - 1) //Down
				connectedNodes.push(_nodes[ (node._row + 1) * GRID_WIDTH + node._col ]);
			if (node._row != 0)	//Up
				connectedNodes.push(_nodes[ (node._row - 1) * GRID_WIDTH + node._col ]);
			if (node._row != GRID_HEIGHT - 1 && node._col != 0)	//Down Left
				if ( _nodes[ (node._row) * GRID_WIDTH + node._col - 1].traversable )
					if ( _nodes[ (node._row + 1) * GRID_WIDTH + node._col].traversable )
						connectedNodes.push(_nodes[ (node._row + 1) * GRID_WIDTH + node._col -1 ]);
			if (node._row != 0 && node._col != 0) //Up Left
				if ( _nodes[ (node._row) * GRID_WIDTH + node._col -1].traversable )
					if ( _nodes[ (node._row - 1) * GRID_WIDTH + node._col].traversable )
						connectedNodes.push(_nodes[ (node._row - 1) * GRID_WIDTH + node._col -1 ]);						
			if (node._row != GRID_HEIGHT - 1 && node._col != GRID_WIDTH - 1)	//Down Right
				if ( _nodes[ (node._row) * GRID_WIDTH + node._col + 1].traversable )
					if ( _nodes[ (node._row + 1) * GRID_WIDTH + node._col].traversable )
						connectedNodes.push(_nodes[ (node._row + 1) * GRID_WIDTH + node._col + 1 ]);
			if (node._row != 0 && node._col != GRID_WIDTH - 1) //Up Right
				if ( _nodes[ (node._row) * GRID_WIDTH + node._col + 1].traversable )
					if ( _nodes[ (node._row - 1) * GRID_WIDTH + node._col].traversable )
						connectedNodes.push(_nodes[ (node._row - 1) * GRID_WIDTH + node._col + 1]);
		
			return connectedNodes;
		}
		
		public function getNodeAtPoint( point:Point, nearestTravelable:Boolean = false): Node
		{
			if ( point.x >= TOTAL_GRID_WIDTH )
				point.x = TOTAL_GRID_WIDTH - 1;
			else if ( point.x <= 0 )
				point.x = 1;
			if ( point.y >= TOTAL_GRID_HEIGHT )
				point.y = TOTAL_GRID_HEIGHT - 1;
			else if ( point.y <= 0 )
				point.y = 1;
		
			//var p:int = Math.floor( point.x / nodeWidth ) + GRID_WIDTH * Math.floor( point.y / nodeHeight );
			return _nodes[	int( point.x / nodeWidth ) + GRID_WIDTH * int( point.y / nodeHeight )	];
		}		
		
		public function doOuch(ouchNode, target):void {
			if (target.currentLabel != "hit1" && target.currentLabel != "hit2" &&target.currentLabel != "down" &&target.currentLabel != "death" ) {
				target.setKnockback( getRelativeNodeToTarget(ouchNode, target) );
				playBloodOn(target);
				setShake(12);
				_main.redScreenFlash.play();
				//playRandomAttackSound();
				target.takeDamage(1);
				playCactusHitSound();
			}
		}
		public function getRelativeToTarget(object:MovieClip, target:MovieClip):int
		{	//Moonwalk helper
			if ( getGroundX(object) - getGroundX(target) > 0 )
				return LEFT;
			return RIGHT;
		}
		public function getRelativeNodeToTarget(object:MovieClip, target:MovieClip):int
		{	//Moonwalk helper
			if ( object.x + object.width * 0.5 - getGroundX(target) > 4 )
				return LEFT;
			return RIGHT;
		}
		
		public function randomNumber (low:Number=0, high:Number=1):int {
			//return a random number between "low" and "high" including both
 			return Math.floor(Math.random() * (1+high-low)) + low;
		}
		
		public function fixPointFromTarget(deltaX:int, deltaY:int, target:MovieClip):Point {
			var point:Point = getGlobalPoint(target);
			point.x += deltaX;
			point.y += deltaY;
			
			var nodeAtPoint:Node = getNodeAtPoint (point);
			
			var temp:Node =  _nodes[	Math.floor( point.x / nodeWidth - 1 ) + GRID_WIDTH * Math.floor( point.y / nodeHeight )	];
			if (temp != null)
			if ( !temp.traversable ) {	//LEFT
				if (point.x - nodeAtPoint.x < 25)
					point.x = nodeAtPoint.x + 25;
			}
			
			temp =  _nodes[	Math.floor( point.x / nodeWidth + 1 ) + GRID_WIDTH * Math.floor( point.y / nodeHeight )	];
			if (temp != null)if ( !temp.traversable ) {	//RIGHT
				if (nodeAtPoint.x + nodeWidth - point.x < 25)
					point.x = nodeAtPoint.x + nodeWidth - 25;
			}
			
			temp =  _nodes[	Math.floor( point.x / nodeWidth ) + GRID_WIDTH * Math.floor( point.y / nodeHeight + 1 )	];
			if (temp != null)if ( !temp.traversable ) {	//DOWN
				if (nodeAtPoint.y + nodeHeight - point.y < 25)
					point.y = nodeAtPoint.y + nodeHeight - 25;
			}
			
			temp =  _nodes[	Math.floor( point.x / nodeWidth ) + GRID_WIDTH * Math.floor( point.y / nodeHeight - 1 )	];
			if (temp != null)if ( !temp.traversable ) {	//UP
				if (point.y - nodeAtPoint.y < 25)
					point.y = nodeAtPoint.y + 25;
			}
			//var temp =  _nodes[	Math.floor( point.x / nodeWidth + 1 ) + GRID_WIDTH * Math.floor( point.y / nodeHeight )	];
			
			return point;
		}
		/*public function checkDirectionToDeltaX(aggresor:MovieClip, deltaX:int, presicion:Boolean = false):int
		{
			var xVar:int = getGroundX(thisMC.player, 1) + deltaX;	//Player X place			
			return checkDirectionToX(aggresor, xVar, presicion);
		}
		public function checkDirectionToDeltaY(aggresor:MovieClip, deltaY:int, presicion:Boolean = false):int
		{
			var yVar:int = getGroundY(thisMC.player, 1) + deltaY; //Player Y place
			return checkDirectionToY(aggresor, yVar, presicion);
		}*/
		public function isYdistanceBiggerThan(distance:int, mc1:MovieClip, mc2:MovieClip):Boolean
		{
			if ( Math.abs(getGroundY(mc1) - getGroundY(mc2)) > distance )
				return true;
			return false;
		}
		public function isXdistanceBiggerThan(distance:int, mc1:MovieClip, mc2:MovieClip):Boolean
		{
			if ( Math.abs(getGroundX(mc1) - getGroundX(mc2)) > distance )
				return true;
			return false;
		}
		public function checkDirectionToX(mover:MovieClip, xVar:int, precision:Boolean = false):int
		{
			var moverX:int = getGroundX(mover, 1);
			if (  Math.floor(Math.abs(moverX - xVar)) <= mover.SPEED_LIMIT+1  )
			{	if (precision)
					mover.deltaToReachTargetX = Math.floor(moverX - xVar);
				return NO_DIR_X;
			}
			else
			{
				if (moverX  - xVar < 0)
					return RIGHT;
				else
					return LEFT;
			}
		}
		public function checkDirectionToY(aggresor:MovieClip, yVar:int, precision:Boolean = false):int
		{//precision = false;
			var landPlaceY:int = getGroundY(aggresor, 1);
			if ( Math.floor(Math.abs(landPlaceY - yVar)) <= aggresor.SPEED_LIMIT_Z+1  )
			{	if (precision)
					aggresor.deltaToReachTargetY = Math.floor(landPlaceY - yVar);
				return NO_DIR_Y;
			}
			else
			{
				if (landPlaceY - yVar < 0)
					return DOWN;
				else
					return UP;
			}
		}
		
		
		public function sameGround(mc1:MovieClip, mc2:MovieClip, helper:int = 13):Boolean
		{
			if (android)
				helper+=8;
			var temp1:int = (mc1.globalGroundY)+(mc1.groundFoot.height*0.5);
			var temp2:int = (mc2.globalGroundY)+(mc2.groundFoot.height*0.5);
			if ( Math.abs(temp1 - temp2) < Math.abs(mc2.groundFoot.height * 0.5 + mc1.groundFoot.height * 0.5 +  helper) )
				return true;
			return false;
		}
		public function checkAttackWorth(aggresor:MovieClip, target:MovieClip):Boolean
		{			
			if (aggresor.attackRecharged)
			if (sameGround(target, aggresor, -5) && aggresor.hitPlace.hitTestObject(target._bodyBox) )// && (target.currentLabel == "walk" || target.currentLabel == "stand"))//Check hit
				return true;
			return false;
		}
		public function checkRangedAttackWorth(aggresor:MovieClip, target:MovieClip, rangerMinRange:int, rangerMaxRange:int):Boolean
		{			
			if (aggresor.attackRecharged)
			if ( sameGround(target, aggresor, 2) ) {
				var distance:int = Math.abs( getGroundX(aggresor) - getGroundX(target) );
				if ( distance <= rangerMaxRange && distance >= rangerMinRange )
					return true;
			}
			return false;
		}
		public function resetBloodContainer():void {
			removeChild(bloodContainer);
			bloodContainer = null;
			bloodContainer = new MovieClip;
			addChild(bloodContainer);
		}
		public function putBloodOnLand(point:Point):void
		{
			if (android)
				return;
			var thisNode:Node = getNodeAtPoint( point );
			//Check if blood is not on water
			if (thisNode.water || thisNode.slippy || thisNode.noLandEffects)
				return;
				var temp2:BigBlood = new BigBlood();
				bloodContainer.addChild (temp2);
				temp2.x = point.x;
				temp2.y = point.y;//target.y + player.groundFoot.y;
				temp2.gotoAndStop(randomNumber(1, temp2.totalFrames));
				if (Math.random() < 0.5)
					temp2.scaleX  = -1;
				temp2.y += randomNumber(-10, 10);
				//temp2.rotation += Math.random()*5;
				bloodLandArr.push(temp2);
				if (bloodLandArr.length > MAX_BLOODS_ON_LAND)
				{
					bloodLandArr[0].sprite.play();
					bloodLandArr.shift();
				}
			//bloodContainer.cacheAsBitmapMa = true;
		}
		public function putInkOnLand(point:Point):void
		{
			if (android)
				return;
			var thisNode:Node = getNodeAtPoint( point );
			//Check if ink is not on water
			if (thisNode.water || thisNode.slippy || thisNode.noLandEffects)
				return;
			var temp2:BigInk = new BigInk();
			bloodContainer.addChild (temp2);
			temp2.x = point.x;
			temp2.y = point.y;//target.y + player.groundFoot.y;
			temp2.gotoAndStop(randomNumber(1, temp2.totalFrames));
			if (Math.random() < 0.5)
				temp2.scaleX  = -1;
			temp2.y += randomNumber(-10, 10);
			//temp2.rotation += Math.random()*5;
			inkLandArr.push(temp2);
			if (inkLandArr.length > MAX_INK_ON_LAND)
			{
				inkLandArr[0].sprite.play();
				inkLandArr.shift();
			}
			//bloodContainer.cacheAsBitmapMa = true;
		}
		public function killAll():void
		{	
			var object:MovieClip;
			var len:int = characterObjects.length;
			//if (!aggresor.enemy)
			for (var i:int = 0; i < len; i++)
			{
				object = characterObjects[i];
				if (object != null)
					if (object.enemy)//Check hit
						{
							object.takeDamage(100);object.setKnockback(LEFT);
							//onHit(aggresor, object, aggresor.attackShake, aggresor.attackDamage, aggresor.attackKnockback, aggresor.attackPushAccelerationX, aggresor.attackPushAccelerationZ, aggresor.slowMotion, aggresor.oppositeDirPush, aggresor.flashScreen);
						}
			}
		}
		public function coverWasDiscovered():void {
			var i:int;
			var len:int = underCoverArr.length;
			for (i = 0; i< len; ++i)
			{
				if (underCoverArr[i].state == KEEP_COVER && underCoverArr[i].currentLabel == "underCover")
					MovieClip(underCoverArr[i]).sprite.head.scary.visible = true;MovieClip(underCoverArr[i]).sprite.play();
				underCoverArr[i].scary = true;
			}
		}
		public function callingAllStations():void {
			for each (var actor:Object in underCoverArr) 
				if (actor.state == KEEP_COVER && actor.currentLabel == "underCover" && MovieClip(actor).sprite.currentLabel != "getOutOfCover")
					MovieClip(actor).sprite.gotoAndPlay("getOutOfCover");
		}
		public function startInk():void {
			if (thisMC.player.hp > 2)
			if (allowInk && inkRecharged) {
				Main.instance.unlockNgMedal("On your face!");
				inkRecharged = false;
				Main.instance.startInk();
				thisMC.player.inked = true;
				frameTimer.addTimer( "inkRechargeTimer", INK_RECHARGE_DELAY, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "inkRecharge" );
			}
		}
		public function inkRecharge():void {
			inkRecharged = true;
		}
		public function onHit(aggresor:MovieClip, target:MovieClip, attack:Attack, kill:Boolean = false):void
		{
			if (attack.doInk)
				startInk();
			//Set knockback
			if (kill) {
				target.takeDamage(10);
				Main.instance.unlockNgMedal("Ninja Slayer");
			}
			else
				target.takeDamage(attack.damage);
			
			if (target.hp <= 0 && target.canLoseHead && attack.noHeadChance != 0 && Math.random() <= attack.noHeadChance)
					target.setNoHeadKnockback();
			else if ( (attack.knockback || target.unpushable) && !target.unknockable )
					target.setKnockback( getRelativeToTarget(aggresor, target) );
			else if (!target.unpushable) //Set push
				target.pushTo(aggresor.getFlipSide(), attack.pushX, attack.pushZ, attack.oppositeDirPush);
			//Set hit FX
			playHitFxOn(aggresor);
			playBloodOn(target);
			//Set land blood
			putBloodOnLand( getGlobalPoint(target, 1) );
			//Set damage
			//target.takeDamage(attack.damage);
			if ( target.noHitAnimation )
				target.checkIfDeath();
			
			setShake(attack.shake);
			if (attack.redScreen)
				_main.redScreenFlash.play();
			if (attack.flashScreen)
				_main.whiteScreenFlash.play();
			if (!android)
			if (attack.hitFreeze != 0) {hitFreezeTimer = new Timer(80, 1);//60
				//hitFreezeTimer = new Timer(attack.hitFreeze, 1);//60
				hitFreezeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, hitFreezeEnd, false, 0 ,true);
				hitFreezeTimer.start();
				pauseObjects();			
				//stage.frameRate = 20;
			}		
		}
		public function flashScreen():void {
			_main.whiteScreenFlash.play();
		}
		public function hitFreezeEnd (e:TimerEvent):void {
			hitFreezeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, hitFreezeEnd);
			hitFreezeTimer.stop();
			resumeObjects();//Main.instance.originalFrameRate;
		}
		public function playBloodOn(actor:MovieClip):void {
			//Plays a blood fx on mc blood point
			if (actor.getChildByName("bloodPoint") != null)
				putFxOnPoint("fx_blood_hit", this.globalToLocal(actor.localToGlobal( new Point( actor.bloodPoint.x, actor.bloodPoint.y ))) , true);
		}
		public function playFxOn(actor:MovieClip, fxName:String):void {
			putFxOnPoint(fxName, new Point(actor.x, actor.y), true);
		}
		public function playHitFxOn(actor:MovieClip):void {
			//Plays a blood fx on mc blood point
			if (actor.getChildByName("FxPoint") != null)
				putFxOnPoint("fx_hit", this.globalToLocal(actor.localToGlobal( new Point( actor.FxPoint.x, actor.FxPoint.y ))) , true);
		}
		public function checkIfCanHit(aggresor:MovieClip):Boolean
		{var object:MovieClip;
			var len:int = characterObjects.length;
			for (var i:int = 0; i < len; i++)
			{
				object = characterObjects[i];
				if (object != null)
			//	if (object.currentLabel == "walk" || object.currentLabel == "stand" || object.currentLabel == "hit1" || object.currentLabel == "hit2" || object.currentLabel == "punch1" || object.currentLabel == "underCover")
					if (sameGround(object, aggresor) && aggresor.hitPlace.hitTestObject(object._bodyBox) && aggresor.name != object.name && object.enemy != aggresor.enemy)//Check hit
						if ( (object.invincibleFront && object.scaleX == aggresor.scaleX) || !object.invincibleFront ) //Check if attacking the back of enemy
							{
								return true;
							}
						}
			return false;			
		}
		public function addBreakable(object:MovieClip):void {
			breakableObjects.push(object);
		}
		
		public function checkProjectileHit ( aggresor:Projectile , canHitEverybody:Boolean = false):void {
			var breakableHitted:Boolean = false;
			var hits:int = 0;			
			var object:*;
			var len:int = characterObjects.length;
			//if (!aggresor.enemy)
			for ( var i:int = 0; i < len; ++i )	{
				object = characterObjects[i];
				if (object != null)
					//if (object.hp > 0)
				if (object.visible)
				if (sameGround(object, aggresor) && aggresor.hitPlace.hitTestObject(object._bodyBox) && aggresor.name != object.name )//Check hit
				if ( ( !canHitEverybody && ( object.enemy != aggresor.enemy ) ) || canHitEverybody )
				if (object.currentLabel != "pushed" && object.currentLabel != "down" && object.currentLabel != "hit_no_head" && object.currentLabel != "death" && object.currentLabel != "death_no_head")
				if (object.damageable)
				if ( (object.invincibleFront && object.scaleX == aggresor.scaleX) || !object.invincibleFront ) //Check if attacking the back of enemy
				{
					hits++;
					if (!object.oneHitKill)
						onHit(aggresor, object, aggresor.melee);
					else
						onHit(aggresor, object, aggresor.melee);
				}
			}
			len = breakableObjects.length;
			for ( i = 0; i < len; ++i ) {
				object = breakableObjects[i];
				if ( sameGround(object, aggresor) && aggresor.hitPlace.hitTestObject(object._bodyBox) )
					if ( object.currentLabel != "break" ) {
					breakableHitted = true;
					onBreakableHit(aggresor, object, aggresor.melee);
				}
			}
			if (hits != 0 || breakableHitted) {
				playRandomAttackSound();
				aggresor.onCollision();
			} 			
		}
		public function checkAttackHit(aggresor:MovieClip, canHitEverybody:Boolean = false, noSound:Boolean = false):int
		{
			var breakableHitted:Boolean = false;
			var hits:int = 0;
			var object:*;
			var len:int = characterObjects.length;
			//if (!aggresor.enemy)
			for ( var i:int = 0; i < len; ++i )
			{
				object = characterObjects[i];
				if (object != null)
				if (object.visible)
				//	if (object.hp > 0)
				if (sameGround(object, aggresor) && aggresor.hitPlace.hitTestObject(object._bodyBox) && aggresor.name != object.name )//Check hit
				if ( ( !canHitEverybody && ( object.enemy != aggresor.enemy ) ) || canHitEverybody )
				if (object.currentLabel != "down" && object.currentLabel != "death" && object.currentLabel != "death_no_head" && object.currentLabel != "hit_no_head")
				if (object.damageable)
				//if (object.hp > 0)
				if ( !object.invincibleFront || (object.invincibleFront && getRelativeToTarget(aggresor, object) == object.getFlipSide() && object.scaleX == aggresor.scaleX) ) //Check if attacking the back of enemy
				{
					hits++;
					if (!object.oneHitKill)
						onHit(aggresor, object, aggresor.melee);
					else
						onHit(aggresor, object, aggresor.melee, true);
				}
				else if ( object.doGuardAnimation && (object.invincibleFront && object.scaleX != aggresor.scaleX) ) {
					onGuard(aggresor, object);
				}
			}
			
			len = breakableObjects.length;
			for ( i = 0; i < len; ++i ) {
				object = breakableObjects[i];
				if ( sameGround(object, aggresor) && aggresor.hitPlace.hitTestObject(object._bodyBox) )
					if ( object.currentLabel != "break" ) {
					breakableHitted = true;
					onBreakableHit(aggresor, object, aggresor.melee);
				}
			}
			if (!noSound)
				if (hits != 0 || breakableHitted)
					playRandomAttackSound();
				else
					playRandomWhooshSound();

			return hits;
		}
		public function onGuard(aggresor:MovieClip, target:MovieClip):void {
			target.backwardAlittle();
			playHitFxOn(aggresor);
			target.gotoAndStop("guard");
			target.guarding = true;
			setShake(4);
		
		}
		public function justBreaked(object:MovieClip):void {
			removeFromArr(object.name, depthArr);
			removeFromArr(object.name, breakableObjects);
			removeChild(object);
		}

		public function onBreakableHit(aggresor:MovieClip, object:MovieClip, attack:Attack):void {
			playHitFxOn(aggresor);
			setShake(attack.shake);
			if (attack.flashScreen)
				_main.whiteScreenFlash.play();
			if (attack.hitFreeze != 0) {
				hitFreezeTimer = new Timer(attack.hitFreeze, 1);//60
				hitFreezeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, hitFreezeEnd, false, 0 ,true);
				hitFreezeTimer.start();
				pauseObjects();				
				}		
			object.hp--;
				trace(object.hp  + " DF DSFD");
			if (object.hp > 0)
				object.gotoAndPlay("hit");
			else
				object.gotoAndPlay("break");
		}
		public function playRandomStarChargeSound():void {if (android) return;
			_main.fx.playFx("star" + randomNumber(1, 9), 0.4);
		}
		public function playRandomStarAttackSound():void {if (android) return;
			_main.fx.playFx("starattack" + randomNumber(1, 7), 0.3);
		}
		public function playRandomStarFallSound():void {if (android) return;
			_main.fx.playFx("starfall" + randomNumber(1, 2), 0.3);
		}
		public function playRandomStarHurtSound():void {if (android) return;
			_main.fx.playFx("starhurt" + randomNumber(1, 8), 0.4);
		}
		public function playRandomImpactSparkleSound():void {if (android) return;
			_main.fx.playFx("ImpactSparkle" + randomNumber(1, 2), 0.6);
		}
		public function playRandomSwishSound():void {if (android) return;
			_main.fx.playFx("Swish" + randomNumber(1, 2), 0.8);
		}
		public function playExplosionSound():void {
			_main.fx.playFx("explosionSound");
		}
		public function playChickenScream1():void {
			_main.fx.playFx("ChickenScream1");
		}
		public function playChickenScream2():void {
			_main.fx.playFx("ChickenScream2");
		}
		public function playRandomCrabClawSound():void {if (android) return;
			_main.fx.playFx("CrabClaw" + randomNumber(1, 2));
		}
		public function playRandomMonsterAttackSound():void {if (android) return;
			_main.fx.playFx("monsterAttack" + randomNumber(1, 6), 0.6);
		}
		public function playRandomMonsterHurtSound():void {if (android) return;
			_main.fx.playFx("monsterHurt" + randomNumber(1, 12), 0.8);
		}
		public function playRandomChargeSound():void {if (android) return;
			_main.fx.playFx("monsterCharge" + randomNumber(1, 7), 0.7);
		}
		public function playRandomDeathSound():void {
			_main.fx.playFx("death" + randomNumber(1, 2));
		}
		public function playCactusHitSound():void {if (android) return;
			_main.fx.playFx("CactusHitSound");
		}
		public function playRandomPlayerHurtSound():void {if (android) return;
			_main.fx.playFx("PlayerHurt" + randomNumber(1, 4), 0.3);
		}
		public function playHealSound():void {
			_main.fx.play("HealthSound");
		}
		public function playRandomGunShotSound():void {
			_main.fx.play("GunSound" + randomNumber(1, 2));
		}
		
		public function playEggPopSound():void {
			_main.fx.play("Eggpoop", 3);
		}
		public function playLaser():void {
			_main.fx.play("BossChickenLaserNew", 3);
		}
		public function playScream():void {
			_main.fx.play("BossChickenScream", 3);
		}
		public function playEggFall():void {
			_main.fx.play("EggFall", 3);
		}
		public function playEggCrash():void {
			_main.fx.play("EggCrash_1", 3);
		}
		
		public function doTrainLoop():void {
			_main.fx.play("trainLoop", 3);
			_main.fx.getSound("trainLoop").fadeFrom(1, .2, 6000);
		}
		public function playInkHitSound():void {
			_main.fx.playFx("InkHitSound");
		}
		public function doTrainWhistle():void {
			_main.fx.playFx("trainWhistle");
			_main.fx.getSound("trainWhistle").fadeFrom(1, 0.3, 3000);
		}
		public function doRandomFootSplashSound():void {if (android) return;
			_main.fx.playFx("footSplash" + randomNumber(1, 3), 0.8);
		}
		public function doRandomWaterJumpSound():void {if (android) return;
			_main.fx.playFx("waterJump" + randomNumber(1, 3), 4);
		}
		public function playRandomWhooshSound():void {			
			_main.fx.playFx("whoosh" + randomNumber(1, 6), 4);
		}
		public function playRandomAttackSound():void {
			_main.fx.playFx("hit" + randomNumber(1, 3), 0.72);
		}
		public function playRandomBossHurtSound():void {
			_main.fx.playFx("bossHurt" + randomNumber(1, 8));
		}
		public function playBossAppearSound():void {
			_main.fx.playFx("bossAppearSound");
		}
		public function playBossDissapearSound():void {
			_main.fx.playFx("bossDissapearSound");
		}
		public function playRandomFart():void {if (android) return;
			_main.fx.playFx("fart" + randomNumber(1, 4));
		}
		public function playStomp():void {
			_main.fx.playFx("BigStomp");
		}
		public function collect():void {
			System.pauseForGCIfCollectionImminent(0);System.pauseForGCIfCollectionImminent(1);
		}
		
		public function checkShootHit(shoot:MovieClip):void
		{
			var object:MovieClip;
			var len:int = characterObjects.length;
			
			for (var i:int = 0; i < len; i++)
			{
				object = characterObjects[i];
				if (object.currentLabel != "down" && object.currentLabel != "death" && object.currentLabel != "death_no_head")
					if (sameGround(object, shoot) && shoot.hitPlace.hitTestObject(object._bodyBox) && object.enemy != shoot.enemy)//Check hit
					{
						//onHit(shoot, object, shoot.attackShake, shoot.attackDamage, shoot.attackKnockback, shoot.attackPushAccelerationX, shoot.attackPushAccelerationZ, shoot.slowMotion);
						shoot.arrowKill();
						return;
					}
			}
		}
		
		public function putFxOnPoint(fxName:String, p:Point, randomScaleX:Boolean = false):MovieClip {
			var temp:MovieClip = askForFx(fxName);
			temp.playFxOnPoint(p.x, p.y, randomScaleX);
			return temp;
		}
		
		
		
		public function putFxInkInPoint(p:Point):void
		{
			var temp:* = askForFx("fx_ink_hit");
			temp.playFxOnPoint(p.x, p.y, true);
		}
		public function putFxInkOnLandInPoint(p:Point):void
		{
			var temp:* = askForFx("fx_ink_on_land");
			temp.playFxOnPoint(p.x, p.y, true);
		}
		
		
		
		
		public function getGlobalPoint(mc:MovieClip, addHalfArea:int = 1):Point
		{
			return new Point(getGroundX(mc, addHalfArea), getGroundY(mc, addHalfArea));
		}

		public function getGroundX(mc:MovieClip, addHalfWidth:int = 1):int
		{				
		//return mc.x;
			return ( this.globalToLocal( new Point( ( mc.localToGlobal( new Point( mc.ground.x, 0 ) ).x ), 0 ) ).x + (mc.getGroundWidth() * 0.5) * mc.scaleX * addHalfWidth );
		}
		public function getGroundY(mc:MovieClip, addHalfHeight:int = 1):int
		{
			//return mc.y//
			return this.globalToLocal(new Point(0, (mc.localToGlobal(new Point(0, mc.ground.y)).y))).y + (mc.getGroundHeight() * 0.5 * addHalfHeight);
		}
		public function getGroundYofDepthObject(mc:MovieClip):int
		{
			return mc.y;
		}
		public function getGlobalFeetY(mc:MovieClip):int
		{
			return this.globalToLocal(new Point(0, (mc.localToGlobal(new Point(0, mc.feet.y)).y))).y + mc.height;
		}

		public function checkCollisionWithNodes(movingObject:MovieClip)
		{
			//x collision
			var p:Point = getGlobalPoint(movingObject, 0);
			
			if (getNodeAtPoint(p).traversable == false)
				collisionWithNodeX(movingObject,getNodeAtPoint(getGlobalPoint(movingObject, 0)) );
			
			p.x += movingObject.getGroundWidth() * movingObject.scaleX;
			if (getNodeAtPoint(p).traversable == false)
				collisionWithNodeX(movingObject,getNodeAtPoint(p) );
				
			p.y += movingObject.getGroundHeight();
			if (getNodeAtPoint(p).traversable == false)
				collisionWithNodeX(movingObject,getNodeAtPoint(p) );
			
			p.x -= movingObject.getGroundWidth() * movingObject.scaleX;
			if (getNodeAtPoint(p).traversable == false)
				collisionWithNodeX(movingObject,getNodeAtPoint(p) );
			
			//y collision
			p = getGlobalPoint(movingObject, 0);
			
			if (getNodeAtPoint(p).traversable == false)
				collisionWithNodeY(movingObject,getNodeAtPoint(getGlobalPoint(movingObject, 0)) );
			
			p.x += movingObject.getGroundWidth() * movingObject.scaleX;
			if (getNodeAtPoint(p).traversable == false)
				collisionWithNodeY(movingObject,getNodeAtPoint(p) );
				
			p.y += movingObject.getGroundHeight();
			if (getNodeAtPoint(p).traversable == false)
				collisionWithNodeY(movingObject,getNodeAtPoint(p) );
			
			p.x -= movingObject.getGroundWidth() * movingObject.scaleX;
			if (getNodeAtPoint(p).traversable == false)
				collisionWithNodeY(movingObject,getNodeAtPoint(p) );
		}	
		
		public function collisionWithNodeX(movingObject:MovieClip, nodeObject:Node)
		{
			
			var landPlaceX:int = getGroundX(movingObject, 0);
			var landPlaceY:int = getGroundY(movingObject, 0);
			
			var landPlaceHalfWidth:int = movingObject.getGroundWidth() * 0.5;
			var landPlaceHalfHeight:int = movingObject.getGroundHeight() * 0.5;
			
			//Static Object
			var sLandPlaceX:int = nodeObject.x;
			var sLandPlaceY:int =  nodeObject.y;

			//Calculations
			var dx:Number =(landPlaceX + landPlaceHalfWidth * movingObject.scaleX) - (sLandPlaceX + nodeHalfWidth);
			var ox:Number = (nodeHalfWidth + landPlaceHalfWidth) - Math.abs(dx);
			
			var dy:Number = (landPlaceY  + landPlaceHalfHeight) - (sLandPlaceY + nodeHalfHeight);
			var oy:Number = (nodeHalfHeight + landPlaceHalfHeight)- Math.abs(dy);		
			
			
			if (ox > 0)
			{
				if (oy > 0)
				{
					if (ox < oy)
					{
						if (dx < 0)
						{
							//Collision on right
							oy = 0;
							ox *= -1;
						}
						else
						{
							//Collision on left
							oy = 0;
						}
					}
					else
					{
						if (dy < 0)
						{
							//Collision on Top
							ox = 0;
							oy *= -1;
						}
						else
						{
							//Collision on Bottom
							ox = 0;
						}
					}
					//Use the calculated x and y overlaps to move objectA out of the collision
					if (ox !=0 || oy !=0)
					{
						if (movingObject.currentLabel == "pushed")// || movingObject instanceof Bomb)
						{	
							movingObject.x += Math.ceil(ox);
							movingObject.onPushedCollision(ox, oy);
						}
							else
							{
								
								if (ox != 0)
								//if (movingObject.name == "player")
								//trace(ox + "Lx   L");
								movingObject.x += ox;//Math.ceil(ox) + 7 * ox/Math.abs(ox);//int( ox + 0.5 );// + 7 * ox/Math.abs(ox);
								//movingObject.y+=oy;
								movingObject.onCollision(ox, oy);
								movingObject.collision = true;
	
							}
					}

				}
				
			}
		}
		
		public function collisionWithNodeY(movingObject:MovieClip, nodeObject:Node)
		{
			
			var landPlaceX:int = getGroundX(movingObject, 0);
			var landPlaceY:int = getGroundY(movingObject, 0);
			
			var landPlaceHalfWidth:int = movingObject.getGroundWidth() * 0.5;
			var landPlaceHalfHeight:int = movingObject.getGroundHeight() * 0.5;
			
			//Static Object
			var sLandPlaceX:int = nodeObject.x;
			var sLandPlaceY:int =  nodeObject.y;

			//Calculations
			var dx:Number =(landPlaceX + landPlaceHalfWidth * movingObject.scaleX) - (sLandPlaceX + nodeHalfWidth);
			var ox:Number = (nodeHalfWidth + landPlaceHalfWidth) - Math.abs(dx);
			
			var dy:Number = (landPlaceY  + landPlaceHalfHeight) - (sLandPlaceY + nodeHalfHeight);
			var oy:Number = (nodeHalfHeight + landPlaceHalfHeight)- Math.abs(dy);		
			
			
			if (ox > 0)
			{
				if (oy > 0)
				{
					if (ox < oy)
					{
						if (dx < 0)
						{
							//Collision on right
							oy = 0;
							ox *= -1;
						}
						else
						{
							//Collision on left
							oy = 0;
						}
					}
					else
					{
						if (dy < 0)
						{
							//Collision on Top
							ox = 0;
							oy *= -1;
						}
						else
						{
							//Collision on Bottom
							ox = 0;
						}
					}
					//Use the calculated x and y overlaps to move objectA out of the collision
					if (ox !=0 || oy !=0)
					{
						if (movingObject.currentLabel == "pushed")
						{	
							movingObject.y += oy;//Math.ceil(oy);
							movingObject.onPushedCollision(ox, oy);
						}
							else
							{
								
								if (oy != 0)//if (movingObject.name == "player")
								//trace(oy + "L   L");
								movingObject.y += Math.ceil(oy);//int( oy + 0.5 );// + 7 * oy/Math.abs(oy);
								//movingObject.x += ox;
								movingObject.onCollision(ox, oy);
								movingObject.collision = true;
	
							}
					}

				}
				
			}
		}		
		public function collisionWithNode(movingObject:MovieClip, nodeObject:Node)
		{
			
			var landPlaceX:int = getGroundX(movingObject, 0);
			var landPlaceY:int = getGroundY(movingObject, 0);
			
			var landPlaceHalfWidth:int = movingObject.getGroundWidth() * 0.5;
			var landPlaceHalfHeight:int = movingObject.getGroundHeight() * 0.5;
			
			//Static Object
			var sLandPlaceX:int = nodeObject.x;
			var sLandPlaceY:int =  nodeObject.y;

			//Calculations
			var dx:Number =(landPlaceX + landPlaceHalfWidth * movingObject.scaleX) - (sLandPlaceX + nodeHalfWidth);
			var ox:Number = (nodeHalfWidth + landPlaceHalfWidth) - Math.abs(dx);
			
			var dy:Number = (landPlaceY  + landPlaceHalfHeight) - (sLandPlaceY + nodeHalfHeight);
			var oy:Number = (nodeHalfHeight + landPlaceHalfHeight)- Math.abs(dy);		
			
			
			if (ox > 0)
			{
				if (oy > 0)
				{
					if (ox < oy)
					{
						if (dx < 0)
						{
							//Collision on right
							oy = 0;
							ox *= -1;
						}
						else
						{
							//Collision on left
							oy = 0;
						}
					}
					else
					{
						if (dy < 0)
						{
							//Collision on Top
							ox = 0;
							oy *= -1;
						}
						else
						{
							//Collision on Bottom
							ox = 0;
						}
					}
					//Use the calculated x and y overlaps to move objectA out of the collision
					if (ox !=0 || oy !=0)
					{
						if (movingObject.currentLabel == "pushed" )//|| movingObject instanceof Bomb)
						{	
							movingObject.x += Math.ceil(ox);
							movingObject.y += Math.ceil(oy);

							movingObject.onPushedCollision(ox, oy);
						}
							else
							{
								
								if (ox != 0)
								if (movingObject.name == "player")
								//trace(ox + "Lx   L");
								movingObject.x += ox;//Math.ceil(ox) + 7 * ox/Math.abs(ox);//int( ox + 0.5 );// + 7 * ox/Math.abs(ox);
								movingObject.y+=oy;
								movingObject.onCollision(ox, oy);
								movingObject.collision = true;
	
							}
					}

				}
				
			}
		}

		
	}
	
}
