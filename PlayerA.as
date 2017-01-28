package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.display.Stage;
	
		public class Player extends Physical_Object {
		public var HP:int = 10;
			
		public var pressedA:Boolean = false;
		public var pressedS:Boolean = false;

		public var headString:String = "player";
		public var handString:String = "player";
		public var bellyString:String = "player";
		public var weaponString:String = "player";
		
		public var headFrame:int = -1;
		public var headSideFrame:int = -1;
		public var handFrame:int = -1;
		public var bellyFrame:int = -1;
		public var weaponFrame:int = -1;
		
		public var combo:int = 0;
		public var comboShown:int = 0;
		public var standCount:int = 0;

		public var wantNextAttack:Boolean;
		public var inited:Boolean;
		public var delay:int = 30;
		public var walkSmokeCounter:int = 4;
		public var moveable:Boolean = false;
		
		public var melee:Attack; //Current Attack pointer
			
			
			public var _punch1:Attack = new Attack("punch1", 1, true, 0, 0, false, 0, 17, false, false, 0.01);
			public var _punch1combo:Attack = new Attack("punch1c", 1.5, true, 0, 0, false, 77, 22, false, false, 0.03);
			
			public var _punch2:Attack = new Attack("punch2", 1, true, 0, 0, false, 77, 20, true, false,0.03);
			public var _punch2combo:Attack = new Attack("punch2c", 1.5, false, 3, -20, false, 77, 22, true, false, 0.03);
			
			public var _spin:Attack = new Attack("spin", 1.5, false, 15, -20, false, 77, 40, true, false, 0.03);
			
			public var _punch1H:Attack = new Attack("punchH1", 2, false, 0, -25, false, 77, 25, false, false, 0.03);
			public var _punch2H:Attack = new Attack("punchH3", 2, false, 20, -20, true, 77, 25, true, false, 0.03);
			public var _punchSpinH:Attack = new Attack("punch2", 2.5, true, 0, 0, false, 77, 15, true, false, 0.03);
			public var _punch3H:Attack = new Attack("punchH2", 2, false, 25, -40, true, 77, 30, false, false, 0.03);
			
		public function Player() {
			// constructor code
			super();
			ouchEnabled = true;
			slippyEnabled = true;
			slowdownEnabled = true;
			wantNextAttack = false;
			_pressedRight = false;
			_pressedLeft = false;
			_pressedUp = false;
			_pressedDown = false;
			FRICTION = 0.3;
			ACCELERATION = 1.35;
			
			SPEED_LIMIT = 8;
			SPEED_LIMIT_Z = 6;
			
			SLOW_SPEED_LIMIT = 4;
			SLOW_SPEED_LIMIT_Z = 3;
			
			addEventListener(Event.ADDED_TO_STAGE, init2,false,0,true);
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
		public function pause():void {
				MovieClip(this).sprite.stop();
		}
		public function resume():void {
				MovieClip(this).sprite.play();
		}
		public override function cleanUp(e:Event = null):void 
		{			
			removeEventListener(Event.REMOVED_FROM_STAGE, cleanUp);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp);
		}
		public override function takeDamage(damage:Number):void
		{
			mc.playRandomPlayerHurtSound();
			resetCombo();
			hp -= damage;
			Main.instance.updateHearts(hp);
		}
		public function heal(hpToAdd:int):void
		{
			hp += hpToAdd;
			if (hp > maxHp)
				hp = maxHp;
			Main.instance.updateHearts(hp);

		}
		public function die():void
		{
			gotoAndStop("death");
			_accelerationX = 0;
			_accelerationZ = 0;
			_vx = 0;
			_vz = 0;
			death = true;
			//deathKnockback = 6; 

		}
		public function checkIfDeath():void
		{
			if (hp <= 0)
			{
				die();
			}
		}
		public function overkilled():void
		{
			Main.instance.gameOver(mc.overAllDeathCount, mc.frameTimer.currentFrameCount);
			//removeEventListener(Event.ADDED_TO_STAGE, init2);
			//mc.removeCharacter( this );
		}
		
		private function init2(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init2);
			inited = false;
			maxHp = HP;
			hp = maxHp;
			Main.instance.setMaxHP(maxHp);
			Main.instance.updateHearts(hp);
			updateLook();
		}
		public function onKeyDown(event:KeyboardEvent):void
		{		if (hp <= 0)
				return;
				if (moveable)
				{if (event.keyCode == Keyboard.A && !pressedA){
					tryAttack();
				pressedA = true;}
			else if (event.keyCode == Keyboard.S && !pressedS)
			{pressedS = true;
					tryAttackHeavy();
			}
					wantNextAttack = false;
					if (event.keyCode == Keyboard.LEFT)
						pressDir(LEFT);
					else if (event.keyCode == Keyboard.RIGHT)
						pressDir(RIGHT);
					else if (event.keyCode == Keyboard.UP)
						pressDir(UP);
					else if (event.keyCode == Keyboard.DOWN)
						pressDir(DOWN);
				}
			
//				else if (event.keyCode == Keyboard.SPACE)
					//pushTo(LEFT);
					//jump();
		}
		public function onKeyUp(event:KeyboardEvent):void
		{
			if (hp <= 0)
				return;
			if (event.keyCode == Keyboard.A){
				pressedA = false;}
			else if (event.keyCode == Keyboard.S)
			{pressedS = false;
			}
			
			//if (!moveable)
				//return;
			if (event.keyCode == Keyboard.LEFT)
				unpressDir(LEFT);
			else if (event.keyCode == Keyboard.RIGHT)
				unpressDir(RIGHT);
			else if (event.keyCode == Keyboard.UP)
				unpressDir(UP);
			else if (event.keyCode == Keyboard.DOWN){
				unpressDir(DOWN);}
			//else if (event.keyCode == Keyboard.D){
					//tryShoot();}
if (inked) {
			Main.instance.shakeInk();
			return;
		}			
			 //if (event.keyCode == Keyboard.K){ heal(10);MovieClip(parent).killAll();}
		/*	if (event.keyCode == Keyboard.SPACE)
			{MovieClip(parent).creatLaser();
				//jump();
				//_accelerationY = 0;
				//Main.instance.startInk();
				//goInked();
			}*/
			//else if (event.keyCode == Keyboard.Z) {				MovieClip(parent).killAll();		}
		}		
		public function goInked():void
		{
			
			resetCombo();
			gotoAndStop("inked");
			stunned = true;
			inked = true;
			unpressEveryDir();
			_accelerationX = 0;
			_accelerationY = 0;
			_accelerationZ = 0;
			_vx =0;
			_vz =0;

		}
		public function goUnInked():void
		{
			gotoAndStop("stand");
			stunned = false;
			pressDirsPressed();
			inkRemovedFromPlayer.play();
			mc.putInkOnLand(mc.getGlobalPoint(this,1));
			inked = false;
		}
		
		public function resetCombo():void
		{
			if (combo != 0)
				Main.instance.updateCombo(0);
			combo = 0;
			comboShown = 0;
		}
		public function addToCombo(hits:int):void
		{
			combo += 1;
			comboShown += hits;
			Main.instance.updateCombo(comboShown);
		}
		public function tryShoot():void
		{
			if (canWalk()) 
			{attackShake = 20;
			attackDamage = 1.5;
			attackKnockback = 0;
			attackPushAccelerationX = 3;
			attackPushAccelerationZ = -10;
				stopForAMoment();
				if (this.currentLabel == "shoot")
					sprite.gotoAndPlay(1);
				else
					gotoAndStop("shoot");
			}
		}
		public function tryAttack():void
		{if (inked && mc.android) {
			Main.instance.shakeInk();
			return;
		}
			if (canWalk()) 
			{
				stopForAMoment();
				if (this.currentLabel == "punch1")
					punch2();
				//else if (this.currentLabel == "punch2")
					//punch3();
				else if (this.currentLabel == "punch2")
					spin();
				else
					punch();
				//else if (this.currentLabel == "punch2")
			}
		}
		public function tryAttackHeavy():void
		{if (inked && mc.android) {
			Main.instance.shakeInk();
			return;
		}
			if (canWalk()) 
			{
				stopForAMoment();
				if (this.currentLabel == "punchH1")
					punchH2();
				else
					punchH1();
			}
		}
		public function punch3():void	//PUCNH FUNCTION
		{
			attackPushAccelerationX =1;
			attackPushAccelerationZ =-17;
			attackKnockback = 10;
			frictionX = 0;
			gotoAndStop("punch3");
		}
		public function punch2():void	//PUCNH FUNCTION
		{
			if (combo <= 2)
				melee = _punch2;
			else
				melee = _punch2combo;
			gotoAndStop("punch2");
			flipToHit();
			fowardAlittle();
		}
		public function flipToHit():void {
			if (! mc.checkIfCanHit(this) )
				flipSide(true);
			if (! mc.checkIfCanHit(this) )
				flipSide(true);
		}
		public function fowardAlittle():void {
			_accelerationX = 10;
			knockback = -6 * scaleX;
		}
		
		public function punch():void	//PUCNH FUNCTION
		{			//heal(19);
			if (combo <= 2)
				melee = _punch1;
			else
				melee = _punch1combo;
			gotoAndStop("punch1");
			flipToHit();
			fowardAlittle();
		}
		public function spin():void	//PUCNH FUNCTION
		{			
			melee = _spin;
			gotoAndStop("spin");
			fowardAlittle();
		}
		public function punchH1():void	//PUCNH FUNCTION
		{
			melee = _punch1H;
			gotoAndStop("punchH1");
			flipToHit();
			fowardAlittle();
		}
		public function punchH2():void	//PUCNH FUNCTION
		{
			if (combo >=1 ) {
				melee = _punch3H;
				gotoAndStop("punchH2");
				
			}
			else {
				melee = _punch2H;
				gotoAndStop("punchH3");
			}
		}
		public override function isAttacking():Boolean
		{
			if (currentLabel == "punch1" || currentLabel == "punch2" || currentLabel == "punch3" || currentLabel == "punchH1" ||  currentLabel == "punchH2" || currentLabel == "spin" ||currentLabel == "punchH3")
				return true;
			return false;
		}
		public override function canStopAttack():Boolean
		{
			if (isAttacking())
				if (sprite.currentLabel == "end")
					return true;
			return false;
			if (currentLabel == "punch1")
			{
				if (sprite.currentFrame >= 15)
					return true;
			}
			else if (currentLabel == "punch2")
			{
				if (sprite.currentFrame >= 14)
					return true;
			}
			else if (currentLabel == "punch3")
			{
				if (sprite.currentFrame >= 45)
					return true;
			}
			else if (currentLabel == "punchH1")
			{
				if (sprite.currentFrame >= 17)
					return true;
			}
			else if (currentLabel == "punchH3")
			{
				if (sprite.currentFrame >= 13 && sprite.currentFrame <= 20)
					return true;
			}
			//spin
			return false;
		}
		
		
		public function punchStart():void
		{
			
		}
		public function punchPeak():void
		{trace("peakPlayer");
			this.melee.noHeadChance = this.melee.originalNoHeadChance + 0.6 * combo;
			var hits:int = mc.checkAttackHit(this);
			if (hits == 0)
				resetCombo();
			else
				addToCombo(hits);
		}
		public function shootPeak():void
		{
			mc.askForNewOctoHeadShoot(this);
		}
		public function shootEnd():void
		{
			gotoAndStop("stand");
			pressDirsPressed();
		}
		public function attackEnd():void
		{
			trace("PUNCHEND");
			gotoAndStop("stand");
			_accelerationX = 0;
			pressDirsPressed();
		}
		//Enter Frame
		public function onEnterFrame():void
		{	
			if (delay == 0)
			{
				if (!inited)
				{
					pressDir(RIGHT);
					if (x < 0)
					collisionEnabled = false;		
					
					if (this.x >= mc.playerStartX && !inited)
					{
						inited = true;
						collisionEnabled = true;
						unpressDir(RIGHT);
						Main.instance._gameStageMC.reached();
					}
				}
			}
			else
				delay--;
			
			onEnterFrameReal();
			
		}
		public function onEnterFrameReal():void
		{trace("player can walk = " + canWalk());
	/*		
 var xVel:Number = Math.cos(4.71) * 6; //uses the cosine to get the xVel from the speed and rotation
    var yVel:Number = Math.sin(4.71) * 6; //uses the sine to get the yVel
 
    x += xVel; //updates the position
    y += yVel;
		*/	
			
			if ( currentLabel == "stand")
				standCount++;
			else
				standCount = 0;
			if ( standCount >= 10 || currentLabel == "walk")
				resetCombo();
			if (--walkSmokeCounter == 0)
			{			
				walkSmokeCounter = 5;
				if (currentLabel == "walk")
					if (!onNoLandEffects)
					if ( onWater)
					{
						
						mc.askForNewWalkFxAtPoint(mc.getGroundX(this, 1), mc.getGroundY(this, 1), scaleX, true);	walkSmokeCounter = 6;			
					}
					else if ( !slippy)
						mc.askForNewWalkFxAtPoint(mc.getGroundX(this, 1), mc.getGroundY(this, 1), scaleX);				
			}
			
			
			mc.checkCollisionWithItems(this, mc.getNodeAtPoint( mc.getGlobalPoint(this) ));
			onEnterFrame2(null);
		}
	}
}
