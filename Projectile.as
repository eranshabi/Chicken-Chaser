package  {

	import flash.display.MovieClip;
	import flash.events.Event;
	//import flash.geom.Point;
	import flash.geom.Point;
	import flash.display.FrameLabel;
	
	public class Projectile extends MovieClip {
		public var depthArrIndex:int;

		protected const NO_DIR_X:int = -1;
		protected const NO_DIR_Y:int = -2;
		protected const UP:int = 0;
		protected const DOWN:int = 1;
		protected const LEFT:int = 2;
		protected const RIGHT:int = 3;

	
		public var enemy:Boolean = false;
		protected var GRAVITY:Number = 0.8; 

		public var collidedLastFrame:Boolean = false;
		public var lastFrameCollisionOx:int = 0;
		public var lastFrameCollisionOy:int = 0;
		protected var ACCELERATION:Number = 12; 
		protected var FRICTION:Number = 0.8;//0.7;//0.5;
		
		public var SPEED_LIMIT:Number = 18;
		public var SPEED_LIMIT_Y:Number = 9;
		public var SPEED_LIMIT_Z:Number = 8;
		public var PUSHED_SPEED_LIMIT:Number = 22;
		public var PUSHED_SPEED_LIMIT_Z:Number = 20;
		public var PUSHED_SPEED_LIMIT_Y:Number = 35;

		public var _vx:Number;
		public var _vy:Number;
		public var _vz:Number;
		
		public var bounceY:Number = 0;
		public var bounceX:Number = 0;

		public var _accelerationX:Number;
		protected var _accelerationY:Number;
		public var _accelerationZ:Number;
		
		protected var _frictionX:Number;
		protected var _frictionZ:Number;
		
		public var _bodyBox:MovieClip;
		public var _groundFoot:MovieClip;

		public var _pressedRight:Boolean;
		public var _pressedLeft:Boolean;
		
		public var _pressedUp:Boolean;
		public var _pressedDown:Boolean;
		
		public var collision:Boolean;
		public var collisionEnabled:Boolean;
		public var groundHit:Boolean = false;

		public var mc:*;
		
		public var globalGroundY:int;

		public var feet:Point;// = new Point (_groundFoot.x + _groundFoot.weidth * 0.5 * scaleX, _groundFoot.y);
		public var ground:Point;
		public var originalGround:Point;

		public var target:MovieClip = null;
		
		//Attacker vars
		var attackPushAccelerationX:Number = 0;//6 //Only for pushing to the air
		var attackPushAccelerationZ:Number = -22;
		var frictionX:int = 0.43;
		var attackKnockback:Number = 30; //Only for pushing to the land. Must be > 0
		var attackKnockbackFriction:Number = 0;
		var attackDamage:Number = 0;//6 //Only for pushing to the air
		var attackShake:int = 0;
		var oppositeDirPush:Boolean = false;
		var flashScreen:Boolean = false;

		//Attacked target vars
		var pushAccelerationX:Number = 0; //Only for pushing to the air
		var pushAccelerationZ:int = 0;
		var knockback:Number = 0; //Only for pushing to the land
		var knockbackFriction:Number = 0;
		var slowMotion:int = 0;
		
		public var death:Boolean = false;
		public var deathKnockback:int;
		
		public var SLOW_SPEED_LIMIT:int;
		public var SLOW_SPEED_LIMIT_Z:int;
		//var incredibleCounter:int = 100;
		public var rotateLevel:int = 0;
		public var flying:Boolean = true;
		public var manager:*;
		
		public var fxOnHit:String = null;	
		public var fxOnLandHit:String = null;
		
		var melee:Attack = new Attack("punchH1", 1.5, false, 0, -50, false, 60, 25, true, false);
		//var knockout:Boolean
		//power
		
		public function pause():void {
			if (getChildByName("sprite") != null)
				MovieClip(this).sprite.stop();
			if (getChildByName("sprite2") != null)
				MovieClip(this).sprite2.stop();
		}
		public function resume():void {
			if (getChildByName("sprite") != null)
				MovieClip(this).sprite.play();
			if (getChildByName("sprite2") != null)
				MovieClip(this).sprite2.play();
		}
		public function setProjectileTo(labelVar:String, rotateLevelVar:int, flyingVar:Boolean, heightVar:int):void {
			gotoAndStop(labelVar);
			rotateLevel = rotateLevel;
			flying = flyingVar;
			setY(heightVar);
		}
		public function setFx(onHit:String, onLandHit:String):void {
			fxOnHit = onHit;
			fxOnLandHit = onLandHit;
		}
		public function Projectile( managerVar:* = null) {
			// constructor code
			manager = managerVar;
			
			_vx = 0; _vz = 0; _vy = 0;
			_accelerationX = 0;	_accelerationZ = 0;	_accelerationY = 0;
			_frictionX = 0;	_frictionZ = 0;
			collisionEnabled = true;
			collision = false;
			
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0 ,true);
		}
		public function setDelayedCollision():void {
			collisionEnabled = false;
			mc.frameTimer.addTimer( name + "DelayedCollision" ,90 , FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "setCollisionTrue");
		}
		public function setCollisionTrue():void {
			collisionEnabled = true;
		}
		public function setY(yVar:int):void {
			y -= yVar;
			_groundFoot.y += (yVar);
			ground.y += yVar;
			MovieClip(this).shadowMC.y = ground.y;	
			
		}
		public function cleanUp(e:Event = null):void 
		{			
			removeEventListener(Event.REMOVED_FROM_STAGE, cleanUp);
			if ( !GlobalTimer.getInstance().isTimerRunning( name ))
				GlobalTimer.getInstance().removeTimer( name );
		}
		public function init(e:Event = null):void 
		{	//Init
			trace("Projectile init");
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, cleanUp, false, 0 ,true);
			visible = false;
			_bodyBox = MovieClip(this).bodyBox;
			_groundFoot = MovieClip(this).groundFoot;
			mc = MovieClip(parent);
			gotoAndStop("none");
			feet = new Point (_groundFoot.x, _groundFoot.y);
			ground = new Point (_groundFoot.x, _groundFoot.y);
			originalGround = new Point (_groundFoot.x + _groundFoot.width * 0.5 * scaleX, _groundFoot.y);
			globalGroundY = mc.getGroundY(this);
			fxOnHit = null;
			fxOnLandHit = null;
			
		}
		public function startProjectile(side:int):void {
			
			//setY(125);
			visible = true;
			//if (side == RIGHT)
				//rotateLevel *= -1;
			pushTo(side);//\/||
		}
		public function getGroundWidth():int {
			return _groundFoot.width;
		}
		public function getGroundHeight():int {
			return _groundFoot.height;
		}
		public function onHitGround():void {
			visible = false;
			if ( fxOnLandHit != null )
				manager.gameStage.playFxOn(this, fxOnLandHit);
			if ( fxOnLandHit == "fx_ink_on_land" ) {
			manager.gameStage.putInkOnLand(new Point(x,y));
				manager.gameStage.playInkHitSound();
			}
			resetProjectile();
		}
		public function onCollision(ox:int = 0, oy:int = 0):void {
			visible = false;
			collidedLastFrame = true;
			lastFrameCollisionOx = ox;
			lastFrameCollisionOy = oy;
			if ( fxOnLandHit == "fx_ink_on_land" ) 
				manager.gameStage.playInkHitSound();
			
			
			if (fxOnHit != null)
				manager.gameStage.playFxOn(this, fxOnHit);
			resetProjectile();
		}
		public function resetProjectile():void {
			_groundFoot.y = originalGround.y;
			feet = new Point (_groundFoot.x, _groundFoot.y);
			ground = new Point (_groundFoot.x, _groundFoot.y);
			globalGroundY = mc.getGroundY(this);
			MovieClip(this).shadowMC.y = ground.y;
			manager.popFromActiveArr(this);
			init();
		}
		
		public function getACCELERATION():Number {
			return ACCELERATION;
		}
		public function getFRICTION():Number {
			return FRICTION;
		}
		
		protected function stopForAMoment():void
		{
			//Stoping the character while remembering what keys he pressed
			this._accelerationX = 0;
			this._frictionX = FRICTION;
			this._accelerationZ = 0;
			this._frictionZ = FRICTION;
		}
			
		public function getFlipSide():int {
			if (scaleX == -1)
				return LEFT;
			return RIGHT;
		}
		public function getOppositeFlipSide():int {
			if (scaleX == 1)
				return LEFT;
			return RIGHT;
		}
		public function flip(side:int):void {
			if (side == LEFT && this.scaleX != -1) {
					this.scaleX = -1;
					this.x += _groundFoot.width;
			} else if (side == RIGHT && this.scaleX != 1) {
					this.scaleX = 1;
					this.x -= _groundFoot.width;
			}
		}
		
		
		public function pressDir(dir:int):void
		{
				if (dir == LEFT    )
				{
					_pressedLeft = true;
						flip(LEFT);
					_frictionX = 1;
					_accelerationX = -getACCELERATION();
					
				}
				else if (dir == RIGHT    )
				{
					_pressedRight = true;
						flip(RIGHT);

					_frictionX = 1;
					_accelerationX = getACCELERATION();
					
				}
				else if (dir == UP    )
				{
					_pressedUp = true;
					_frictionZ = 1;
					_accelerationZ = -getACCELERATION();
				}
				else if (dir == DOWN    )
				{
					_pressedDown = true;
					_frictionZ = 1;
					_accelerationZ = getACCELERATION();
				}
				else if (dir == NO_DIR_X    )
				{
					if (_pressedLeft)
						unpressDir(LEFT);
					if (_pressedRight)
						unpressDir(RIGHT);
					if (!_pressedUp && !_pressedDown)
						if (currentLabel != "stand")
							this.gotoAndStop("stand");
				}
				else if (dir == NO_DIR_Y    )
				{
					if (_pressedUp)
						unpressDir(UP);
					if (_pressedDown)
						unpressDir(DOWN);
					if (!_pressedLeft && !_pressedRight)
						if (currentLabel != "stand")
							this.gotoAndStop("stand");
				}
			}		
		public function unpressDir(dir:int):void
		{
			_accelerationX = 0;
			_frictionX = getFRICTION();
		}
		
		protected function flipSide():void {
			if (this.scaleX != -1) {
					this.scaleX = -1;
					this.x += _groundFoot.width;
			} else if (this.scaleX != 1) {
					this.scaleX = 1;
					this.x -= _groundFoot.width;
			}
		}

		//Punch Events
		public function pushTo(dir:int, accelerationX:Number = 6, accelerationY:int = -17, oppositeDirPush:Boolean = false, frictionX:Number = 0.43 ):void {
			flip(dir);
			knockback = 0;
			_vx = 0;
			_vz = 0;
			_vy = 0;
			_accelerationZ = 0;
			_accelerationX = accelerationX;
			_accelerationY = accelerationY;
			_frictionX = 0.43;
			if (dir == LEFT)
				_accelerationX *= -1;
		}
		
		//Enter Frame
		public function onEnterFrame():void {
			if (flying)
				onEnterFrameFlying();
			else
				onEnterFramePushed();
			mc.checkProjectileHit( this );
		}
		public function onEnterFrameFlying():void
		{
			collidedLastFrame = false;
			if ( rotateLevel != 0 )
				this.sprite.rotation += rotateLevel;
			
			_vx += _accelerationX;
			_vz += _accelerationZ;
			
			if (Math.abs(_vx) > SPEED_LIMIT)
				_vx = SPEED_LIMIT * _vx/Math.abs(_vx);
			if (Math.abs(_vz) > SPEED_LIMIT_Z)
				_vz = SPEED_LIMIT_Z * _vz/Math.abs(_vz);

			if (Math.abs(_vx) < 0.2) {
				_vx = 0;
			}
			if (Math.abs(_vz) < 0.2) {
				_vz = 0;
			}
			_vy = 0;
			this.x += Math.floor(_vx*0.7);
			collision = false;
			if (collisionEnabled)
				mc.checkCollisionWithNodes(this);
		}
		public function onEnterFramePushed():void
		{	//pressDir(LEFT);
			collidedLastFrame = false;
			if ( rotateLevel != 0 )
				this.sprite.rotation += rotateLevel;
			
			_vx += _accelerationX;
			_vz += _accelerationZ;
			
			if (feet.y >= ground.y) {	//On ground
				_vx *= _frictionX;
				_vz *= _frictionZ;
				_vy = 0;
			} else {					//On air
				//_accelerationY = 0;
				//_accelerationY = 0;
				_vy += GRAVITY;
				_vy += _accelerationY;
				//_vy *= 0.75;
			}
			
			if (Math.abs(_vx) > SPEED_LIMIT)
				_vx = SPEED_LIMIT * _vx/Math.abs(_vx);
			if (Math.abs(_vz) > SPEED_LIMIT_Z)
				_vz = SPEED_LIMIT_Z * _vz/Math.abs(_vz);
			if (Math.abs(_vy) > SPEED_LIMIT_Y)
				_vy = SPEED_LIMIT_Y * _vy/Math.abs(_vy);
			
			if (Math.abs(_vx) < 0.2) {
				_vx = 0;
			}
			if (Math.abs(_vz) < 0.2) {
				_vz = 0;
			}
			if (Math.abs(_vy) < 0.2) {
				_vy = 0;
			}
			this.x += Math.floor(_vx*0.7);
			//this.y += Math.floor(_vz);
			this.y += _vy*0.7;
			//curve maybe
			ground.y -= (_vy*0.7);
			

			if (feet.y < ground.y) { //On air
				_accelerationY = 0;
			}
				
			if (feet.y >= ground.y)	{
				_vx *= _frictionX;
				var del:Number = (feet.y - ground.y);
				y -= del;
				ground.y = feet.y;
				onHitGround();
			}
			
			collision = false;
			if (collisionEnabled)
				mc.checkCollisionWithNodes(this);
			//var thisNode = mc.getNodeAtPoint( mc.getGlobalPoint(this) );
			MovieClip(this).shadowMC.y = ground.y;			
		}
		
	}
	
}
