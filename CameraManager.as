package  {
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	import flash.ui.GameInput;
	import flash.events.TimerEvent;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	public class CameraManager {
		
		public var cameraInstancesArr = [];
		public var gameStage:*;
		public var in1:CameraInstance;
		public var cameraPointX:int = 0;
		public var cameraPointY:int = 0;
		public var currentSpeed:int = 10;
		public var lookingFoward:Boolean = false;
		var currentInstance:*;
		
		public var stageWidth:int;
		
		
		var centerChar:*;
		
		public function CameraManager(gameStageVar:GameStage) {
			gameStage = gameStageVar;
		}
		
		public function startNextInstance():void {
			if (cameraInstancesArr.length != 1) {
				cameraInstancesArr.pop();
				currentInstance = cameraInstancesArr[cameraInstancesArr.length - 1];
				updateInstances();
				update();
			}
		}
		public function addInstanceBefore(instance:CameraInstance):void {
			cameraInstancesArr.push(instance);
			updateInstances();
			update();
		}
		public function updateInstances():void {
			
			currentInstance = cameraInstancesArr[cameraInstancesArr.length - 1];
			
			var delayTemp:int = 1;
			while ( currentInstance.delay > 0 ) {
				currentInstance.delay--;
				currentInstance = cameraInstancesArr[cameraInstancesArr.length - 1 - delayTemp];
				delayTemp++;
			}
			if ( currentInstance.time > 0 )
				currentInstance.time--;
			if (currentInstance.time == 0 || currentInstance.movieClipCenter == null) //go to next instance
				startNextInstance();
		}
		
		public function update():void {
			centerChar = currentInstance.movieClipCenter;
			var i:int;
			var object:*;
			
			//Camera X
			if (lookingFoward)	//Camera will look to the right
				cameraPointX = -centerChar.x + 100;
			else	//Camera will center on actor
				cameraPointX = gameStage.stageWidth * 0.5 - centerChar.x;
			if (centerChar.scaleX == -1)	//Flip check
				cameraPointX += centerChar.groundFoot.width;
			if (lookingFoward && gameStage.lookingFowardToBit != -1)
				if (cameraPointX < -gameStage.lookingFowardToBit)
				{
					cameraPointX = -gameStage.lookingFowardToBit;
				}
			//Camera Y
			var landPlaceY:int = centerChar.y;
			cameraPointY = gameStage.stageHeight * 0.5 - landPlaceY;
			
			//Boundries bit check
			if (currentInstance.checkBoundriesX) {
				//X boundires
				if (cameraPointX < gameStage.stageWidth - gameStage.rightBit || currentInstance.stayOnRightBit)
					cameraPointX = gameStage.stageWidth - gameStage.rightBit;
				if (cameraPointX > -gameStage.leftBit || currentInstance.stayOnLeftBit)
					cameraPointX = -gameStage.leftBit;
			}
			if (currentInstance.checkBoundriesY) {
				//Y boundires
				if (cameraPointY < gameStage.stageHeight - gameStage.levelHeight)
					cameraPointY = gameStage.stageHeight - gameStage.levelHeight;
				else if (cameraPointY > 200)
					cameraPointY = 200;
			}				

			if ( Math.abs (gameStage.cameraX - cameraPointX) > 1 || Math.abs (gameStage.cameraY - cameraPointY) > 1 )
				TweenLite.to(gameStage, currentInstance.speed, {cameraX:cameraPointX, cameraY:cameraPointY, overwrite:true, useFrames:true});
			
				
			//Managin paralaxes
			var len:int = gameStage.backParallaxObjects.length;
			for ( i = 0; i < len; ++i )
			{
				object = gameStage.backParallaxObjects[i];
				if (object.x != (object.originalX - cameraPointX)*object.paraDepth)
				TweenLite.to(object, currentInstance.speed, {x:(object.originalX - cameraPointX)*object.paraDepth, y:(object.originalY - cameraPointY)*object.paraDepth, 
							 overwrite:true, useFrames:true});//, delay:3});
			}
			len = gameStage.frontParallaxObjects.length;
			for ( i = 0; i < len; ++i )
			{
				object = gameStage.frontParallaxObjects[i];
				if (object.x != (object.originalX - cameraPointX)*object.paraDepth)
				TweenLite.to(object, currentInstance.speed, {x:object.originalX - cameraPointX*object.paraDepth, y:object.originalY - cameraPointY*object.paraDepth, 
							 overwrite:true, useFrames:true});//, delay:3});
			}
			/*	for ( i = 0; i < frontParallaxObjects.length; i++ )
			{
				object = frontParallaxObjects[i];
				TweenLite.to(object, costumCameraSpeed, {x:object.originalX - cameraPointX*object.paraDepth, y:object.originalY - cameraPointY*object.paraDepth, 
							 overwrite:false, useFrames:true});//, delay:3});
			}*/			
			
		}
	}
}
