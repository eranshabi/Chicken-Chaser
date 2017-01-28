package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import pathfinding.Pathfinder;
	public class Heavy extends Enemy {
		
		
		
		public function Heavy() {
			// constructor code
			super();

			_pressedRight = false;
			_pressedLeft = false;
			//fixedPoint = false;
			
			SPEED_LIMIT = NORMAL_SPEED_X;
			SPEED_LIMIT_Z = NORMAL_SPEED_Z;

			unpushable = true;
			SPEED_LIMIT = 6;
			SPEED_LIMIT_Z = 3;
			inited = false;
			invincibleFront = false;
			//SPEED_LIMIT *=2;SPEED_LIMIT_Y *= 2;
			addEventListener(Event.ADDED_TO_STAGE, init2, false, 0 ,true);
				//				AIlevel = STOP_FOR_A_WHILE;

		}
		protected override function init2(e:Event = null):void 
		{	//Init
			removeEventListener(Event.ADDED_TO_STAGE, init2);
			//addEventListener(Event.ENTER_FRAME, setVisible, false, 0 ,true);
			//updateLook();
			
			dirX = NO_DIR_X;
			dirY = NO_DIR_Y;
			enemy = true;
	
			gotoAndStop("stand");
			startRechargeTimer();
			getTarget();
}
		
		//Punch Events
		public function punchStart():void
		{				/*slowMotion = 10;

			attackShake = 40;
			attackDamage = 0.5;
			attackKnockback = 0;
			attackPushAccelerationX = 3;
			attackPushAccelerationZ = -20;*/
		}
		public override function isAttacking():Boolean
		{
			if (currentLabel == "punch1")
				return true;
			return false;
		}
		public override function canStopAttack():Boolean
		{
			/*if (currentLabel == "punch1")
				if (sprite.currentFrame >= 20)
					return true;*/
			return false;
		}
		
		
		public function punchPeak():void {
			mc.checkAttackHit(this, canHitEverybody);
		}
		
		public override function attack():void {
			if (attackRecharged)
			{	
				if ( canWalk() )
				{
					_accelerationX = 0;
					_accelerationZ = 0;
					_vx = 0;
					_vz = 0;
					//_frictionX = 1;
					//_accelerationX = ACCELERATION;
					gotoAndStop(melee.attackName);trace(melee.attackName+"BAWAH");trace("current label: " + currentLabel);
					mc.iJustAttacked(this);
				}
				attackRecharged = false;
				startRechargeTimer();
			}
		}
		
		public override function onEnterFrameActor():void
		{		if (target == null) {
				getTarget();
				switchToNextState();
			}
			if (collidedLastFrame)
				justCollided();
			trace("Enter frame trace: target: " + target);trace("current label: " + currentLabel);
			if (state != -1)
				updateState();
			trace("Enter frame trace: state: " + state);
			
			if (canWalk() && state != KEEP_COVER) {		
				pressDir(dirX);
				pressDir(dirY);
			}
			else
				unpressEveryDir();trace("current label: " + currentLabel);
			moonWalk = true;
			onEnterFrame2(null);

		}

	}
	
}
