package  {

	import flash.display.MovieClip;
	import flash.events.Event;
	//import flash.geom.Point;
	import flash.geom.Point;
	import flash.display.FrameLabel;
	
	public class Physical_Object extends MovieClip {
		public var callAllStationsOnDeath:Boolean = false;
		
		public var doChargeSound:Boolean = false;
		public var doMonsterHurtSound:Boolean = false;
		public var doMonsterAttackSound:Boolean = false;
		public var isStar:Boolean = false;
		public var isMoon:Boolean = false;
		public var scary:Boolean = false;
		public var alreadyReportedDeath:Boolean = false;
		public var depthArrIndex:int;
		public var canLoseHead:Boolean = false;
		public var guarding:Boolean = false;
		
		
		
		protected const NO_DIR_X:int = -1;
		protected const NO_DIR_Y:int = -2;
		protected const UP:int = 0;
		protected const DOWN:int = 1;
		protected const LEFT:int = 2;
		protected const RIGHT:int = 3;
		public var oneHitKill:Boolean = false; //Can this enemy be killed in one hit?
		public var inked:Boolean = false;

		public var flippable:Boolean = false;
		
		public var slippyEnabled:Boolean = false;
		public var slippy:Boolean = false;
		public var onWater:Boolean = false;
		public var onNoLandEffects:Boolean = false;
		public var ouchEnabled:Boolean = false;
		public var slowdownEnabled:Boolean = false;
		public var slowdown:Boolean = false;
		public var stunned:Boolean = false;
		public var enemy:Boolean = false;
		public var invincibleFront:Boolean = false;
		public var unpushable:Boolean = false;

		protected const JUMP_FORCE:Number = -26;
		protected var GRAVITY:Number = 4; 

		public var collidedLastFrame:Boolean = false;
		public var lastFrameCollisionOx:int = 0;
		public var lastFrameCollisionOy:int = 0;
		protected var ACCELERATION:Number = 2; 
		protected var FRICTION:Number = 0.8;//0.7;//0.5;
		
		public var slippyACCELERATION:Number = 1;
		public var slippyFRICTION:Number = 0.91;
		
		public var SPEED_LIMIT:Number = 16;
		public var SPEED_LIMIT_Y:Number = 30;
		public var SPEED_LIMIT_Z:Number = 8;
		public var PUSHED_SPEED_LIMIT:Number = 22;
		public var PUSHED_SPEED_LIMIT_Z:Number = 23;
		public var PUSHED_SPEED_LIMIT_Y:Number = 35;

public var damageable:Boolean = true;
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
		
		public var maxHp:Number = 5;
		public var hp:Number = 5; 
		
		public var globalGroundY:int;
		
		public var deltaToReachTargetX:int;
		public var deltaToReachTargetY:int;
		
		public var moonWalk:Boolean = false;

		public var feet:Point;// = new Point (_groundFoot.x + _groundFoot.weidth * 0.5 * scaleX, _groundFoot.y);
		public var ground:Point;
		public var originalGround:Point;

		public var target:* = null;
		public var topPriorityTarget:* = null;
		
		public var inKnockback:Boolean = false;
		
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
				public var noHitAnimation:Boolean = false;

		public var unknockable:Boolean = false;
		public var canHitEverybody:Boolean = false;
		//var incredibleCounter:int = 100;
		
		//var knockout:Boolean
		//power
		
		
		
		public function Physical_Object() {
			// constructor code
			stop();
			_vx = 0;
			_vz = 0;
			_vy = 0;
			_accelerationX = 0;
			_accelerationZ = 0;
			_accelerationY = 0;
			_frictionX = 0;
			_frictionZ = 0;
			collisionEnabled = true;
			collision = false;
			deltaToReachTargetX = 0;
			trace("Physical object constarcotr");

			addEventListener(Event.ADDED_TO_STAGE, init, false, 0 ,true);

		}
		public function cleanUp(e:Event = null):void 
		{			
			removeEventListener(Event.REMOVED_FROM_STAGE, cleanUp);
			if ( !GlobalTimer.getInstance().isTimerRunning( name ))
				GlobalTimer.getInstance().removeTimer( name );
		}
		public function init(e:Event = null):void 
		{	//Init
			trace("Physical object init");
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, cleanUp, false, 0 ,true);
			
			_bodyBox = MovieClip(this).bodyBox;
			_groundFoot = MovieClip(this).groundFoot;

			mc = MovieClip(parent);
			
			feet = new Point (_groundFoot.x, _groundFoot.y);
			ground = new Point (_groundFoot.x, _groundFoot.y);
			originalGround = new Point (_groundFoot.x + _groundFoot.width * 0.5 * scaleX, _groundFoot.y);
			globalGroundY = mc.getGroundY(this);
			trace("global " + globalGroundY);
//			MovieClip(this).gotoAndStop("stand");

		}
		
		public function setNoHeadKnockback(side:int = NO_DIR_X):void
		{
			stopForAMoment();
		try{
			hp =-1;
			if (currentLabel != "pushed" && currentLabel != "down" && currentLabel != "death" && currentLabel != "death_no_head")
			{
				mc.askForNewWalkFxAtPoint(mc.getGroundX(this, 1),mc.getGroundY(this, 1), scaleX, false);
				knockback = 102;
				if (side == RIGHT)
					knockback *= -1;
				gotoAndStop("hit_no_head");
			}
		}
		catch (error:Error) {
			trace("HITERROR");
		}
		}	
		
		public function setKnockback(side:int = NO_DIR_X):void
		{trace("_+_+" +this);
					trace(MovieClip(this).sprite);
					trace(currentLabel);
					//stage.invalidate();
			try{
			if (flippable)
				if (getFlipSide() == side)
					flipSide(true);
			stopForAMoment();
				}
		catch (error:Error) {
			trace("flip error");
		}
			
		try{
			if (currentLabel != "pushed" && currentLabel != "down" && currentLabel != "death" && currentLabel != "death_no_head"&& currentLabel != "hit_no_head")
			{
				mc.askForNewWalkFxAtPoint(mc.getGroundX(this, 1),mc.getGroundY(this, 1), scaleX, false);
				knockback = 20;
				if (side == RIGHT)
					knockback *= -1;
				if (currentLabel == "hit2")
						gotoAndStop("hit1");
				else if (currentLabel == "hit1")
						gotoAndStop("hit2");
				else {
					if (Math.random() < 0.5)
						gotoAndStop("hit2");
					else
						gotoAndStop("hit1");
				}
			}
		}
		catch (error:Error) {
			trace("HITERROR");
		}
		}		
		public function getGroundWidth():int
		{
			return _groundFoot.width;
		}
		public function getGroundHeight():int
		{
			return _groundFoot.height;
			
		}
		
		public function onCollision(ox:int, oy:int):void
		{
			collidedLastFrame = true;
			lastFrameCollisionOx = ox;
			lastFrameCollisionOy = oy;
		}
		public function getACCELERATION():Number {
			if ( !slippy )
				return ACCELERATION;
			else
				return slippyACCELERATION;
		}
		public function getFRICTION():Number {
			if ( !slippy )
				return FRICTION;
			else
				return slippyFRICTION;
		}
		public function pressDir(dir:int):void
		{
			//Check if can go
			if (isAttacking())
			{
				if (dir == LEFT)
					_pressedLeft = true;
					else if (dir == UP)
					_pressedUp = true;
					else if (dir == DOWN)
					_pressedDown = true;
					else if (dir == RIGHT)
					_pressedRight = true;
			}
			else if (canWalk())
			{
			if (dir != NO_DIR_X &&  dir != NO_DIR_Y  )
			if (this.currentLabel != "walk")
				this.gotoAndStop("walk");	
				if (dir == LEFT    )
				{
					_pressedLeft = true;
					if (!moonWalk)
						flip(LEFT);
					else
						flip(mc.getRelativeToTarget(this, target));
					_frictionX = 1;
					_accelerationX = -getACCELERATION();
					
				}
				else if (dir == RIGHT    )
				{
					_pressedRight = true;
					if (!moonWalk)
						flip(RIGHT);
					else
						flip(mc.getRelativeToTarget(this, target));
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
		}
		public function onPushEnd():void {
			inKnockback = false;
			gotoAndStop("stand");
			pressDirsPressed();
			//if (hp < 0)
				//gotoAndStop("death");
		}
		public function canWalk():Boolean
		{
			if (this.currentLabel == "walk")// || this.currentLabel == "stand")
				return true;
			if (guarding)
				return false;

			if (inked)
				return false;
			
			if (stunned)
				return false;
			if (inKnockback)
				return false;
				if (this.currentLabel == "stand")
				return true;
			if (this.currentLabel == "down")
				return false;	
			if (this.currentLabel == "pushed")
				return false;
			if (this.currentLabel == "hit")
				return false;
			if (this.currentLabel == "hit1")
				return false;
			if (this.currentLabel == "hit_no_head")
				return false;
			if (this.currentLabel == "hit2")
				return false;
			if (this.currentLabel == "death")
				return false;
			if (this.currentLabel == "death_no_head")
				return false;
			
			if (isAttacking())
				if (canStopAttack())
					return true;
				else
					return false;
			
			//	if (hp ==0 && hp != maxHp)
				//	return false;
			return true;
		}
		
		public function stopForAMoment():void
		{
			//Stoping the character while remembering what keys he pressed
			this._accelerationX = 0;
			this._frictionX = FRICTION;
			this._accelerationZ = 0;
			this._frictionZ = FRICTION;
		}
			
		
		public function unpressDir(dir:int):void
		{
			
			if (canWalk())// || currentLabel == "hit1" ||currentLabel == "hit2")
			{
				if (dir == LEFT)
				{
					if (!_pressedRight)
					{
						_accelerationX = 0;
						_frictionX = getFRICTION();
					}
					else 
						pressDir(RIGHT);
					_pressedLeft = false;				
				}
				else if (dir == RIGHT)
				{
					if (!_pressedLeft)
					{
						_accelerationX = 0;
						_frictionX = getFRICTION();
					}
					else
						pressDir(LEFT);
					_pressedRight = false;		
				}
				else if (dir == UP)
				{
					if (!_pressedDown)
					{
						_accelerationZ = 0;
						_frictionZ = getFRICTION();
					}
					else 
						pressDir(DOWN);
					_pressedUp = false;		
				}
				else if (dir == DOWN)
				{
					if (!_pressedUp)
					{
						_accelerationZ = 0;
						_frictionZ = getFRICTION();
					}
					else 
						pressDir(UP);
					_pressedDown = false;		
				}
				
				if (!_pressedUp && !_pressedDown && !_pressedLeft && !_pressedRight)
				{
					if (currentLabel != "stand")
							this.gotoAndStop("stand");
				}
			}
			else// if (isAttacking() || inKnockback || knockback || currentLabel == "pushed" || currentLabel == "down")
			{
				if (dir == LEFT)
					_pressedLeft = false;
				else if (dir == UP)
					_pressedUp = false;
				else if (dir == DOWN)
					_pressedDown = false;
				else if (dir == RIGHT)
					_pressedRight = false;
			}
		}
		public function unpressEveryDir():void
		{
			/*if (currentLabel != "pushed")
			{
			_frictionX = FRICTION;
			_accelerationX = 0;
			_accelerationZ = 0;
			_frictionZ = FRICTION;
			}*/
			_pressedLeft = false;				
			_pressedDown = false;
			_pressedRight = false;		
			_pressedUp = false;		
			//if (currentLabel != "stand")
							//this.gotoAndStop("stand");
		}
		public function isDirsPressed():Boolean
		{
			if (_pressedUp || _pressedDown || _pressedLeft || _pressedRight)
				return true;
			return false;
		}
		public function getDirPressed():int
		{
			if (_pressedUp)
				return UP;
			if (_pressedDown)
				return DOWN;
			if (_pressedLeft)
				return LEFT;
			if (_pressedRight)
				return RIGHT;
			return -1;
		}
		public function pressDirsPressed():void
		{
			if (_pressedUp)
				pressDir(UP);
			if (_pressedDown)
				pressDir(DOWN);
			if (_pressedLeft)
				pressDir(LEFT);
			if (_pressedRight)
				pressDir(RIGHT);
		}	
		
		public function getFlipSide():int
		{
			if (scaleX == -1)
				return LEFT;
			return RIGHT;
		}
		public function getOppositeFlipSide():int
		{
			if (scaleX == 1)
				return LEFT;
			return RIGHT;
		}
		public function flip(side:int):void
		{
			if (canWalk())
				if (side == LEFT && this.scaleX != -1)
				{
					this.scaleX = -1;
					this.x += _groundFoot.width;
				}
				else if (side == RIGHT && this.scaleX != 1)
				{
					this.scaleX = 1;
					this.x -= _groundFoot.width;
				}
		}
		
		protected function flipSide(forceFlip:Boolean = false):void
		{
			if (forceFlip || canWalk())
				if (this.scaleX != -1)
				{
					this.scaleX = -1;
					this.x += _groundFoot.width;
				}
				else if (this.scaleX != 1)
				{
					this.scaleX = 1;
					this.x -= _groundFoot.width;
				}
		}
		public function isAttacking():Boolean
		{
			if (currentLabel == "punch1")
				return true;
			else if (currentLabel == "shoot")
				return true;
			return false;
		}
		public function canStopAttack():Boolean
		{
			//if (currentLabel == "punch1")
				//if (sprite.currentFrame > 20)
					//return true;
			return false;
		}
		public function backwardAlittle():void {
			_accelerationX = 10;
			knockback = 10 * scaleX;
		}
		//Punch Events
		public function pushTo(dir:int, accelerationX:Number = 6, accelerationY:int = -22, oppositeDirPush:Boolean = false, frictionX:Number = 0.43 ):void
		{trace(dir + " , " + accelerationX + " , " +accelerationY );
		

			if ( currentLabel != "death" && currentLabel != "death_no_head" && currentLabel != "hit_no_head" && currentLabel != "down" )//&& currentLabel != "pushed")
			{
				trace(currentLabel);
				try{					gotoAndStop("pushed");

					knockback = 0;
			_vx = 0;
			_vz = 0;
			_vy = 0;
		//	unpressEveryDir();
moonWalk = false;
_accelerationX = 0;
_accelerationY = 0;
				_accelerationZ = 0;
pressDir(NO_DIR_X);
					
					_accelerationY = accelerationY;
				_frictionX = 2.43;
			if (!oppositeDirPush)
			{
				if (dir == LEFT)
					_accelerationX = -accelerationX;
				else
					_accelerationX = accelerationX;
			}
			else
			{
				if (dir == RIGHT)
					_accelerationX = -accelerationX;
				else
					_accelerationX = accelerationX;
			}
			
				
				bounceY = -accelerationY;
				bounceX = _accelerationX;
								//_accelerationX = -accelerationX;
			
				}
		catch (error:Error) {
			trace("PUSH ERROR");
		}
				

			}
			trace("JKL" + accelerationX);
		}
		public function jump():void
		{
			//_frictionX = 1;
			//if (feet.y >= ground.y)
			_accelerationY = JUMP_FORCE;
		}
		
		public function onHit(damage:Number = 0):void
		{	
			//hp -= damage;
		}
		public function takeDamage(damage:Number):void
		{	
			if (doMonsterHurtSound)
				if (isStar)
					mc.playRandomStarHurtSound();
				else
					mc.playRandomMonsterHurtSound();
			hp -= damage;
		}
		public function onHitEnd():void
		{
			MovieClip(this).gotoAndStop("stand");
			//pressDirsPressed();
			//MovieClip(this).this.gotoAndStop("stand");
		}
		public function onPushedCollision(ox:int, oy:int):void
		{
			_vx = 0;
			_accelerationX = -_accelerationX/2;
			bounceX = -bounceX;
		}
		//Enter Frame
		protected function onEnterFrame3(event:Event):void
		{
		
		}
		public function reouch():void {
			ouchEnabled = true;
				mc.frameTimer.removeTimer( name + "reouch" );
		}
		protected function onEnterFrame2(event:Event):void
		{	
		collidedLastFrame = false;

		if (this.currentLabel != "death" || currentLabel != "death_no_head")
		{
		if (Math.abs(knockback) >= 3)
		{
			if (knockback % 3 == 0)
			//mc.askForNewWalkFxAtPoint(mc.getGroundX(this, 1),mc.getGroundY(this, 1), scaleX, false);
			trace("knockbacl" + knockback);
				_vx = 0;
			_vz = 0;
			_vy = 0;
				inKnockback = true;
			//unpressEveryDir();
moonWalk = false;
_accelerationX = 0;
_accelerationY = 0;
				_accelerationZ = 0;
pressDir(NO_DIR_X);
			_accelerationX = Math.floor(knockback*-1);//*-5 
			trace(_accelerationX);
			knockback *= 0.8;//knockbackFriction;
			//unpressEveryDir();
		}
		else if (knockback != 0)	//Resting knockback
		{inKnockback = false;
			knockback = 0;
			_frictionX = FRICTION;
			//gotoAndStop("stand");
			_accelerationX = 0;
			//pressDirsPressed();
		}
		//else 
			//inKnockback = false;
		
		//if (name != "player")
		
			//ground.y = originalGround.y + 100;
//if (name == "player")
			//trace(feet.y + "f VS g" + ground.y + "GLOBA: " + mc.getGroundY(this));
			_vx += _accelerationX;
			_vz += _accelerationZ;
			

			if (feet.y >= ground.y)	//On ground
			{
				_vx *= _frictionX;
				_vz *= _frictionZ;
				
				_vy = 0;
			}
			else	//On air
			{
				_accelerationY = 0;
				_vy += GRAVITY;
				if (currentLabel == "pushed")
				{
					//_vz = 0;
				}
			}
			_vy += _accelerationY;

			if ( currentLabel != "pushed" )
			{
				if (slippy) {
					if (Math.abs(_vx) > SPEED_LIMIT*1.6)
					{
							_vx = SPEED_LIMIT*1.6 * _vx/Math.abs(_vx);
					}
					if (Math.abs(_vz) > SPEED_LIMIT_Z*1.6)
					{
							_vz = SPEED_LIMIT_Z*1.6 * _vz/Math.abs(_vz);
					}
				}
				else if (!slowdown)
				{
					if (Math.abs(_vx) > SPEED_LIMIT)
					{
							_vx = SPEED_LIMIT * _vx/Math.abs(_vx);
					}
					if (Math.abs(_vz) > SPEED_LIMIT_Z)
					{
							_vz = SPEED_LIMIT_Z * _vz/Math.abs(_vz);
					}
				}
				else
				{
					if (Math.abs(_vx) > SLOW_SPEED_LIMIT)
					{
							_vx = SLOW_SPEED_LIMIT * _vx/Math.abs(_vx);
					}
					if (Math.abs(_vz) > SLOW_SPEED_LIMIT_Z)
					{
							_vz = SLOW_SPEED_LIMIT_Z * _vz/Math.abs(_vz);
					}
				}
				if (Math.abs(_vy) > SPEED_LIMIT_Y)
				{
						_vy = SPEED_LIMIT_Y * _vy/Math.abs(_vy);
				}
			}
			else
			{
				if (Math.abs(_vx) > PUSHED_SPEED_LIMIT)
				{
						_vx = PUSHED_SPEED_LIMIT * _vx/Math.abs(_vx);
				}
				if (Math.abs(_vz) > PUSHED_SPEED_LIMIT_Z)
				{
						_vz = PUSHED_SPEED_LIMIT_Z * _vz/Math.abs(_vz);
				}
				if (Math.abs(_vy) > PUSHED_SPEED_LIMIT_Y)
				{
						_vy = PUSHED_SPEED_LIMIT_Y * _vy/Math.abs(_vy);
				}
			}
			
			if (Math.abs(_vx) < 0.3)
			{
				_vx = 0;
			}
			if (Math.abs(_vz) < 0.3)
			{
				_vz = 0;
			}
			if (Math.abs(_vy) < 0.3)
			{
				_vy = 0;
			}
		
			
			
			if (deltaToReachTargetX != 0)// && Math.abs(_vx) > Math.abs(deltaToReachTargetX))
			{	
				_vx = -deltaToReachTargetX;
				deltaToReachTargetX = 0;
			}
			
			if (deltaToReachTargetY != 0)// && Math.abs(_vz) > Math.abs(deltaToReachTargetY))
			{
				_vz = -deltaToReachTargetY;
				deltaToReachTargetY = 0;
			}
	
			
			this.x += Math.floor(_vx)/2;
			this.y += Math.floor(_vz)/2;
			this.y += (_vy)/2;
		if (collisionEnabled)
			{
				mc.checkCollisionWithNodes(this);
				//mc.checkCollisionWithNodes(this);
			}
		this.x += Math.floor(_vx)/2;
			this.y += Math.floor(_vz)/2;
			this.y += (_vy)/2;
		/*	var curve:int = mc.checkCurve(this);			
			if ( curve != 0 )
			if (feet.y >= ground.y )
				y -= _vx/curve;
			else
			{
				ground.y +=_vx;
			}
*/
			ground.y -= (_vy);

			if (feet.y < ground.y)
			{
				_accelerationY = 0;
				
			}
			if (feet.y >= ground.y)
			{				//_vx *= _frictionX;

				var del:Number = (feet.y - ground.y);
				y -= del;
				ground.y = feet.y;
				
				
				if (currentLabel == "pushed")
				{mc.addStompFx(this);
					//mc.playBloodOn(this);
					mc.putBloodOnLand( mc.getGlobalPoint(this, 1) );
				//mc.askForNewWalkFxAtPoint(mc.getGroundX(this, 1),mc.getGroundY(this, 1), scaleX, false);
					bounceY *= 0.7;
					bounceX *= 0.9;
					if (bounceY <11)
					{
						bounceY = 0;
						trace("PUSH END");
						gotoAndStop("down");
						_accelerationX = 0;
								_accelerationY = 0;
								_accelerationZ = 0;
								_frictionX = FRICTION;
								_frictionZ = 0;
								_vx = 0;
								_vy = 0;
								_vz = 0;
					}
					else
					{//bounce again
						_accelerationX = bounceX;
								_accelerationY = -bounceY;
								_accelerationZ = 0;
								_frictionX = 0.43;
								_frictionZ = 0;
								_vx = 0;
								_vy = 0;
								_vz = 0;
							if (MovieClip(this).sprite.currentLabel == "push1")
								MovieClip(this).sprite.gotoAndPlay("push2");
							else
								MovieClip(this).sprite.gotoAndPlay("push1");
					}
				}
			}
			
			collision = false;
			//mc.checkCollisionWithStaticObjects(this);
			if (collisionEnabled)
			{
				mc.checkCollisionWithNodes(this);
				//mc.checkCollisionWithNodes(this);
			}
			var thisNode = mc.getNodeAtPoint( mc.getGlobalPoint(this) );
			if (ouchEnabled)
				if (thisNode.ouch) {
					mc.doOuch(thisNode, this);
					ouchEnabled = false;
						mc.frameTimer.addTimer( name + "reouch" , 34 , FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "reouch");
				}
			if (slippyEnabled)
				if (thisNode.slippy)
					slippy = true;
				else
					slippy = false;
			if (thisNode.water) {
				if (!onWater)
				mc.doRandomFootSplashSound();
				onWater = true;
			}
			else
				onWater = false;
			
			if (thisNode.noLandEffects) {
				if (!onNoLandEffects)
				onNoLandEffects = true;
			}
			else
				onNoLandEffects = false;
			
			if (slowdownEnabled)
				if (thisNode.slowdown)
					slowdown = true;
				else
					slowdown = false;
		}
		else
		{
			//death
			if (Math.abs(deathKnockback) > 0.1)
			{_accelerationZ = 0;
			_vx =0;
				_accelerationX = deathKnockback*-5; 
				deathKnockback *= 0.9;
				_vx += _accelerationX * scaleX;
				this.x += int(_vx);
			}
		}
					//trace(_vz + "s");
			MovieClip(this).shadowMC.y = ground.y;			
			//x = int(x);
			//y = int(y);
			
		}
		
	}
	
}
