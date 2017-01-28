package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	
	public class Bully extends Enemy {
		public var headString:String = "normal";
		public var chestString:String = "normal";
		public var bellyString:String = "normal";
		public var upperLeftHandString:String = "normal";
		public var upperRightHandString:String = "normal";
		public var downLeftHandString:String = "normal";
		public var downRightHandString:String = "normal";

		public var headFrame:int = -1;
		public var chestFrame:int = -1;
		public var bellyFrame:int = -1;
		public var upperLeftHandFrame:int = -1;
		public var upperRightHandFrame:int = -1;
		public var downLeftHandFrame:int = -1;
		public var downRightHandFrame:int = -1;

		
		public function Bully(headStringVar:String, chestStringVar:String, bellyStringVar:String,
		upperLeftHandStringVar:String, upperRightHandStringVar:String, downLeftHandStringVar:String, downRightHandStringVar:String) {
			// constructor code
			super();	
			
			headString = headStringVar;
			chestString = chestStringVar;
			bellyString = bellyStringVar;
			upperLeftHandString = upperLeftHandStringVar;
			upperRightHandString = upperRightHandStringVar;
			downLeftHandString = downLeftHandStringVar;
			downRightHandString = downRightHandStringVar;
			updateLook();
			
			rechargeInSeconds = 3 * 44;
			
			_pressedRight = false;
			_pressedLeft = false;
			unknockable = true;
			unpushable = true;
				
			SPEED_LIMIT = NORMAL_SPEED_X;
			SPEED_LIMIT_Z = NORMAL_SPEED_Z;
			inited = false;
			noHitAnimation = true;
		}
		
		public function updateLook():void {
			var temp:MovieClip = new DollFrontHead();
			temp.gotoAndStop(headString);
			headFrame = temp.currentFrame;
			
			temp = new BullyUpperMuscule();
			temp.gotoAndStop(upperLeftHandString);
			upperLeftHandFrame = temp.currentFrame;
			
			temp = new downLeftHand();
			temp.gotoAndStop(downLeftHandString);
			downLeftHandFrame = temp.currentFrame;

			temp = new BullyChest();
			temp.gotoAndStop(chestString);
			chestFrame = temp.currentFrame;
			
			temp = new BullyBelly();
			temp.gotoAndStop(bellyString);
			bellyFrame = temp.currentFrame;
			
			temp = new UpperRightHand();
			temp.gotoAndStop(upperRightHandString);
			upperRightHandFrame = temp.currentFrame;
			
			temp = new DownRightHand();
			temp.gotoAndStop(downRightHandString);
			downRightHandFrame = temp.currentFrame;
			
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
			target = mc.getTarget();
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
			mc.askForNewBomb(this);
		}

		public function punchPeak():void {
			mc.checkAttackHit(this, canHitEverybody);
		}
		
		
		
		public override function onEnterFrameActor():void {
			if (collidedLastFrame)
				justCollided();
			/*
			state = ROAM_AROUND;
			mood = CASUAL;*/
			if (target == null) {
				getTarget();
				switchToNextState();
			}
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
