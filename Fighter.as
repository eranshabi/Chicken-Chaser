package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	
	public class Fighter extends Enemy {
		public var headString:String = "normal";
		public var handString:String = "normal";
		public var bellyString:String = "normal";
		public var weaponString:String = "normal";
		
		public var headFrame:int = -1;
		public var headSideFrame:int = -1;
		public var handFrame:int = -1;
		public var bellyFrame:int = -1;
		public var weaponFrame:int = -1;

		public var nextOneToo:int = 3;
		public function Fighter(headStringVar:String, handStringVar:String, bellyStringVar:String, weaponStringVar:String) {
			// constructor code
			super();	
			flippable = true;
			canLoseHead = true;
			headString = headStringVar;
			handString = handStringVar;
			bellyString = bellyStringVar;
			weaponString = weaponStringVar;
			updateLook();
			
			rechargeInSeconds = 3 * 44;
			
			_pressedRight = false;
			_pressedLeft = false;
				
			SPEED_LIMIT = NORMAL_SPEED_X;
			SPEED_LIMIT_Z = NORMAL_SPEED_Z;
			inited = false;
			
			if ( Main.instance.android)
				nextOneToo = -1;
		}
		
		public function updateLook():void {
			var temp:MovieClip = new DollFrontHead();
			temp.gotoAndStop(headString);
			headFrame = temp.currentFrame;
			
			temp = new DollSideHead();
			temp.gotoAndStop(headString);
			headSideFrame = temp.currentFrame;
			
			temp = new DollBelly();
			temp.gotoAndStop(bellyString);
			bellyFrame = temp.currentFrame;
			
			temp = new DollHand();
			temp.gotoAndStop(handString);
			handFrame = temp.currentFrame;
			
			temp = new DollWeapon();
			temp.gotoAndStop(weaponString);
			weaponFrame = temp.currentFrame;
			
			temp = null;
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
		///Ranger
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
					if (doMonsterAttackSound)
						if (isStar)
							mc.playRandomStarAttackSound();
						else
							mc.playRandomMonsterAttackSound();
				}
				attackRecharged = false;
				startRechargeTimer();
			}
		}
		
		public override function rangedAttack():void {
			if (attackRecharged) {	
				if ( canWalk() ) {
					flip(mc.whereIsTargetComparedTo(this, target));
					_accelerationX = 0;	_accelerationZ = 0;	_vx = 0; _vz = 0;
					gotoAndStop(ranged.attackName);
					mc.iJustShoot(this);
				}
				attackRecharged = false;
				startRechargeTimer();
			}
		}
		
		
		public function shootPeak():void
		{
			if (currentLabel == "gunShot")
				mc.askForNewShot(this);
			else
				mc.askForNewBomb(this);
		}

		public function punchPeak():void {
			mc.checkAttackHit(this, canHitEverybody);
		}
		
		public function doWaterThing():void {
			mc.askForNewWalkFxAtPoint(mc.getGroundX(this, 1), mc.getGroundY(this, 1), scaleX, true);
		}
		
		public override function onEnterFrameActor():void {
			/*
			state = ROAM_AROUND;
			mood = CASUAL;*/
			if (--walkSmokeCounter == 0)
			{			
				walkSmokeCounter = 4;
				if (currentLabel == "walk")
					if ( onWater)
					{
						
						mc.askForNewWalkFxAtPoint(mc.getGroundX(this, 1), mc.getGroundY(this, 1), scaleX, true);	walkSmokeCounter = 10;			
					}
					else if (nextOneToo != -1)
						if ( Math.random() < 0.05 || nextOneToo > 0) {
						mc.askForNewWalkFxAtPoint(mc.getGroundX(this, 1), mc.getGroundY(this, 1), scaleX);	
						if (nextOneToo == 0)
							nextOneToo = 3;
						else
							nextOneToo--;
					}
			}
			
			if (target == null) {
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
			onEnterFrame2(null);
		}
	}
	
}
