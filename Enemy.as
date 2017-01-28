package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import pathfinding.Pathfinder;
	
	public class Enemy extends Physical_Object {
		
		protected var SLOW_SPEED_X:int = 2; protected var SLOW_SPEED_Z:int = 1;
		protected var NORMAL_SPEED_X:int = 4; protected var NORMAL_SPEED_Z:int = 2;
		protected var FAST_SPEED_X:int = 6; protected var FAST_SPEED_Z:int = 3;
		
		public var usingAiTimer:Boolean = false;
		public var state:int = -1;
		public var alreadyTried:Boolean = true;
		public var xDistanceFromTarget:int = 0;
		public var yDistanceFromTarget:int = 0;
		public var fixedFromTarget:Boolean = false;
		
		//start levels
		public var startLevel:int = -1;
		protected const STARTED:int = 0;
		protected const START_ANIMATION:int = 1;
		protected const START_WALK:int = 2;
		protected const DELAY:int = 3;
		
		//Ranged vars
		public var minDistanceToShoot:int = 100;
		public var maxDistanceToShoot:int = 500;
		
		//states
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
		protected const CRAZY:int = 9;
		protected const RANGED_DISTANCE:int = 10;

		protected var AIlevel:int;
		public var angryEnemy:Boolean = false; //If always aggresive
		public var rechargeInSeconds:int = 5 * 10;
		public var doGuardAnimation:Boolean = false;
		//protected const AGGRESIVE:int = 1;
		//protected const ALERT:int = 2;
		
		public var mood:int = -1;
		public var side:int = NO_DIR_X;
		
		public var walkSmokeCounter:int = 4;
				
		public var dirX:int;
		public var dirY:int;

		public var counter:int = 0;
		
		public var space = 0;
		public var initDirY = 0;

		public var initDirX = 0;

		/// dir up =0 middle = 1 down =2
		public var attackRecharged:Boolean = true;
		public var wayNodes:Array = null;
		public var reachedNodes:int = 0;
		public var inited:Boolean = false;
		
		public var rangerDistanceX:int = 0;
		public var rangerMaxRange:int = 0;
		public var rangerMinRange:int = 0;
				
		public var canRange:Boolean = false;
		public var canMelee:Boolean = false;
		
		public var tryAttackAlways:Boolean = false;
		public var alwaysGoToTarget:Boolean = false;
		
		
		public var melee:Attack;
		public var ranged:Attack;
		
		public function Enemy() {
			// constructor code
			super();
			trace("enemy object constactor");

			_pressedRight = false;
			_pressedLeft = false;
			//fixedPoint = false;
			hp = maxHp;
			inited = false;
			setSpeedNormal();
			//attackRecharged = false;
			
			addEventListener(Event.ADDED_TO_STAGE, init2, false, 0 ,true);

		}
		public function setHp(hpVar:int):void {
			maxHp = hpVar;
			hp = maxHp;
		}
		public function setSpeed(slowX:int, slowY:int, normalX:int, normalY:int, fastX:int, fastY:int):void {
			SLOW_SPEED_X = slowX;	SLOW_SPEED_Z = slowY;
			NORMAL_SPEED_X = normalX;	NORMAL_SPEED_Z = normalY;
			FAST_SPEED_X = fastX;	FAST_SPEED_Z = fastY;
			SPEED_LIMIT = NORMAL_SPEED_X;
			SPEED_LIMIT_Z = NORMAL_SPEED_Z;
		}
		public function recharge():void
		{//trace(name);
			attackRecharged = true;
			if ( mc.frameTimer.isTimerRunning( name + "recharge" ))
				mc.frameTimer.removeTimer( name + "recharge" );
		}
		//Set speed function//
		public function setSpeedSlow():void
		{
			SPEED_LIMIT = SLOW_SPEED_X;
			SPEED_LIMIT_Z = SLOW_SPEED_Z;
		}
		public function setSpeedNormal():void
		{
			SPEED_LIMIT = NORMAL_SPEED_X;
			SPEED_LIMIT_Z = NORMAL_SPEED_Z;
		}
		public function setSpeedFast():void
		{
			SPEED_LIMIT = FAST_SPEED_X;
			SPEED_LIMIT_Z = FAST_SPEED_Z;
		}
		////////////////////
		protected function init2(e:Event = null):void 
		{	//Init
			removeEventListener(Event.ADDED_TO_STAGE, init2);
			trace("enemy object init");
			dirX = NO_DIR_X;
			dirY = NO_DIR_Y;
			enemy = true;
			gotoAndStop("stand");
}
		public function die():void
		{
			if (isMoon)
				Main.instance.unlockNgMedal("Lovely moonchild");
			if (!alreadyReportedDeath)
				reportDeath();
			
			if (!death ) {
				if (currentLabel == "hit_no_head")
					gotoAndStop("death_no_head");
				else
					gotoAndStop("death");
				//hp = -10;
				stopForAMoment();
				death = true;
			}
		}
		public function checkIfDeath():void
		{try {
			if (hp <= 0 || currentLabel == "hit_no_head")
			{
				die();
			}
			}
			catch (error:Error) {trace("checkIfDeath error");}
		}
		public function reportDeath():void {
			if (callAllStationsOnDeath)
				mc.callingAllStations();
			alreadyReportedDeath = true;
			mc.reportDeath();
			if (state == KEEP_COVER) {
				mc.coverWasDiscovered();
			}
		}
		public function overkilled():void
		{
			
			trace("please kill me" + this.name + "__");// + this.maxHP);
			try {
			mc.frameTimer.removeTimer( name + "recharge" );
			mc.frameTimer.removeTimer( name + "startDelay" );
			mc.frameTimer.removeTimer( name + "walking" );
			}
			catch (error:Error) {}
						mc.removeCharacter( this );

		}
		
		public function forceStartModd(moodVar:int):void {
			mood = moodVar;
			startState( getNextStateForMood() );
		}
		public function getNextStateForMood():int {
			//Return the next state that should be done for current mood
			
			if (mood == DISTANCE) {
				//if last state
				if (state == RETREAT) {
					if (xDistanceFromTarget != 0 && yDistanceFromTarget != 0 )
						return KEEP_YOUR_GROUND;
					else
						return RETREAT;
				}
				else if (state == KEEP_YOUR_GROUND) {
					return RETREAT;
				}
				else {
					return RETREAT;
				}
			}
			else if (mood == CLOSE) {
				//if last state
				if (state == GO_CLOSE) {
					if (xDistanceFromTarget != 0 && yDistanceFromTarget != 0 )
						return KEEP_YOUR_GROUND;
					else
						return GO_CLOSE;
				}
				else if (state == KEEP_YOUR_GROUND) {
					return GO_CLOSE;
				}
				else {
					return GO_CLOSE;
				}
			}
			else if (mood == ATTACK) {
				//if last state
				if ( (state == GO_CLOSE && attackRecharged) || (alwaysGoToTarget) ) {
						return DIRECT_ATTACK;
				}
				else {
					return GO_CLOSE;
				}
			}
			else if (mood == CASUAL) {
				if (state == ROAM_AROUND)
					return STOP_FOR_A_WHILE;
				else 
					return ROAM_AROUND;
			}
			else if (mood == RANGED) {
				if (state == SHOOT )
					return RUN_AWAY;
				else
					return SHOOT;
			}
			else if (mood == RANGED_DISTANCE) {
					return RUN_AWAY;
			}
			else if (mood == UNDER_COVER) {
				return KEEP_COVER;
			}	
			else if (mood == CRAZY) {
				if (state != CHARGE)
					recharge(); //If first time he is charge instant recharge
				rechargeInSeconds = 3 * 55;
				if (!attackRecharged)
					return KEEP_YOUR_GROUND;
				return CHARGE;
			}	
			return RETREAT;
		}
		
		public function switchToNextState():void
		{
			endState();
			//if using ai timer
			startState( getNextStateForMood() );
		}
		public function updateRoad():void
		{trace("xdistance" + xDistanceFromTarget);
			getRoadToDistanceFromTarget(xDistanceFromTarget, yDistanceFromTarget);
		}
		public function restartState():void	{
			endState();
			startState(state);
		}
		public function getTarget():void {
			if (topPriorityTarget == null)
				target = mc.getTarget();
			else 
				target = topPriorityTarget;

		}
		public function startState(stateVar:int):void {
			state = stateVar;
			if (state == RETREAT) {
				moonWalk = true;
				setSpeedNormal();
				getRoadToRandomDistanceFromTarget(5, true, side);
			}
			else if (state == RUN_AWAY) {	//Running away while shooting ranged attacks if possible
				moonWalk = false;
				setSpeedFast();
				getRoadToRandomDistanceFromTarget(5, true);
			}
			else if (state == GO_CLOSE) {
				moonWalk = true;
				setSpeedNormal();
				getRoadToRandomDistanceFromTarget(3, true, side);
				//var p:Point = wayNodes[0];
				//wayNodes = [];
				//wayNodes.push(p);
			}
			else if (state == DIRECT_ATTACK) {
				getTarget();
				//moonWalk = false;
				moonWalk = true;
				setSpeedFast();
				//xDistanceFromTarget = 0;
				//yDistanceFromTarget = 0;
				//updateRoad();
				getRoadToRandomDistanceFromTarget(2, false, side);

			}
			else if (state == KEEP_YOUR_GROUND) {
				setSpeedNormal();
				moonWalk = true;
				var targetPoint:Point = mc.fixPointFromTarget( xDistanceFromTarget, yDistanceFromTarget, target );
				wayNodes = [];
				wayNodes[0] = targetPoint;
				if (xDistanceFromTarget == 0)
					startState(RETREAT);
			}
			else if (state == ROAM_AROUND) {
				target = this;trace("start raming");
				moonWalk = false;
				setSpeedSlow();
				getRoadToRandomDistanceFromTarget(1);
			}
			else if (state == STOP_FOR_A_WHILE) {
				target = this;
				moonWalk = false;
				trace("start stopping");
					mc.frameTimer.addTimer( name,mc.randomNumber(15, 45), FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "switchToNextState");
									unpressEveryDir();
				dirX = NO_DIR_X;
				dirY = NO_DIR_Y;stopForAMoment();
			}
			else if (state == SHOOT) {
				setSpeedNormal();
				getTarget();
				moonWalk = true;
				xDistanceFromTarget = rangerDistanceX;
				if ( side == LEFT )
					xDistanceFromTarget *= -1;
				yDistanceFromTarget = 0;
				var targetPoint:Point = mc.fixPointFromTarget( xDistanceFromTarget, yDistanceFromTarget, target );
				if (! mc.getNodeAtPoint(targetPoint).traversable)
					xDistanceFromTarget *= -1;
				targetPoint = mc.fixPointFromTarget( xDistanceFromTarget, yDistanceFromTarget, target );
				wayNodes = [];
				wayNodes[0] = targetPoint;
			}
			else if (state == GET_INTO_POSITION) {
				
			}
			else if (state == CHARGE) {
				//lookCrazy();
				
				getTarget();
				moonWalk = false;
				setSpeedFast();
				xDistanceFromTarget = 0;
				yDistanceFromTarget = 0;
				updateRoad();
				
			}
			
			else if (state == KEEP_COVER) {
				gotoAndStop("underCover");
				oneHitKill = true;
				getTarget();
			}
		}
		
		public function justCollided():void
		{	
			if (hp <= 0 || death)
				return;
			checkIfDeath();
			if (dirX == NO_DIR_X || dirY == NO_DIR_Y || lastFrameCollisionOx != 0 || lastFrameCollisionOy != 0)	//If 
			{trace(wayNodes);
			trace("*" + state);
				//Check if on same node as point
				if (state != -1 && state != STOP_FOR_A_WHILE && wayNodes != null)
				{
				if (wayNodes[ 0 ] != null) {
					if (
						this._groundFoot.hitTestObject( mc.getNodeAtPoint(wayNodes[ 0 ]) ) ||
						this.mc.getNodeAtPoint( mc.getGlobalPoint(this, 1) ).hitTestObject( mc.getNodeAtPoint(wayNodes[ 0 ]) )
						)
						{
							if ( wayNodes.length == 1) {
							//Reached the point
								if (wayNodes != null)
									setDirToNextNode(true);
								else	//Reached destenation
									switchToNextState();
							}
							else
								switchToNextState();
							//setDirToNextNode();//
							//////////switchToNextState();
						}
					
					else {	// cant reach the point without put, so create one
						updateRoad();trace("CAN BE FIXED");
						trace(mc.getGlobalPoint(this,1));
					}
				}
				}
			}
			
		}
		public function getRoadToRandomDistanceFromTarget(distance:int, edge:Boolean = false, side:int = NO_DIR_X):void
		{
			reachedNodes = 0;
			if (target != null) {
				/*var targetNode:* = mc.getRandomNodeAtDistanceFromTarget(target, distance, true);
				trace("End node: " + targetNode);
				targetNode.highlight(Math.random()*0xFFFFFF);
				var tempArr:Array = mc.getPathFromActorToNode(this, targetNode);
				//wayNodes = mc.getPathFromActorToNode(this, targetNode);*/
				wayNodes = [];
				wayNodes.push( mc.getRandomPointAtDistanceFromTarget(target, distance, edge, side) );
				
				xDistanceFromTarget = wayNodes[wayNodes.length - 1].x - mc.getGlobalPoint(target, 1).x;
				yDistanceFromTarget = wayNodes[wayNodes.length - 1].y - mc.getGlobalPoint(target, 1).y;
			}
		}
		public function getRoadToDistanceFromTarget(xDistance:int, yDistance:int):void
		{
			reachedNodes = 0;
			if (target != null) {
				var targetPoint:Point = mc.fixPointFromTarget( xDistance, yDistance, target );
				 mc.getNodeAtPoint(targetPoint).highlight(Math.random()*0xFFFFFF);
				if ( mc.getNodeAtPoint(targetPoint).traversable ) {
					wayNodes = mc.getPathToPoint(this, targetPoint);
				}
				else { //if distance point is untrversable
					restartState();
				}
			}
		}
		public function startModd(moodVar:int):void {
			if (mood != moodVar) {
				mood = moodVar;
				startState( getNextStateForMood() );
			}
		}
		
		public function endState():void
		{
			reachedNodes = 0;
			wayNodes = null;
			
			if (state == RETREAT) {
				
			}
			else if (state == GO_CLOSE) {
				
			}
			else if (state == DIRECT_ATTACK) {
				
			}
			else if (state == KEEP_YOUR_GROUND) {
				
			}
			else if (state == ROAM_AROUND) {
				
			}
			else if (state == STOP_FOR_A_WHILE) {
				mc.frameTimer.removeTimer( name );
			}
			else if (state == KEEP_COVER) {
					oneHitKill = false;
			}
		}

		public function setDirToNextNode(fixed:Boolean = true):void
		{
			if (wayNodes.length == 1 && fixed) {	//go to last point
				var targetPoint:Point = mc.fixPointFromTarget( xDistanceFromTarget, yDistanceFromTarget, target );
				wayNodes[0] = targetPoint;
				if (mc.getNodeAtPoint(targetPoint).traversable){
					dirX = mc.checkDirectionToX(this, targetPoint.x);
					dirY = mc.checkDirectionToY(this, targetPoint.y);
				//	MovieClip(mc).pointer.x = targetPoint.x;
				//	MovieClip(mc).pointer.y = targetPoint.y;
				}
				else	//last point unreachable
				{
					restartState();
					//switchToNextState();
				}
			}
			else {	//go to next road point
				dirX = mc.checkDirectionToX(this, wayNodes[0].x );
				dirY = mc.checkDirectionToY(this, wayNodes[0].y );
				
			//	MovieClip(mc).pointer.x = wayNodes[0].x;
			//	MovieClip(mc).pointer.y = wayNodes[0].y;
			}
			
			if (dirX == NO_DIR_X && dirY == NO_DIR_Y) {
				reachedNodes++;
				if (wayNodes.length != 1 && reachedNodes <=3){
					wayNodes.shift();onEnterFrameActor();}
				else if (wayNodes.length == 1) //Road end
				{
					switchToNextState();
				}
				else {
					trace("end road ");
					updateRoad();
					onEnterFrameActor();
				}
			}
		}
		public function stayFixedToPoint():void
		{
			if (wayNodes.length == 1) {	//go to last point
				var targetPoint:Point = mc.fixPointFromTarget( xDistanceFromTarget, yDistanceFromTarget, target );
				wayNodes[0] = targetPoint;
				if (mc.getNodeAtPoint(targetPoint).traversable){
					dirX = mc.checkDirectionToX(this, targetPoint.x);
					dirY = mc.checkDirectionToY(this, targetPoint.y);
					//MovieClip(mc).pointer.x = targetPoint.x;
					//MovieClip(mc).pointer.y = targetPoint.y;
					
					//mc.getNodeAtPoint(targetPoint).highlight(  Math.random()*0xFFFFFF );
				}
				else	//last point unreachable
				{
					switchToNextState();
				}
			}
		}
		public function attack():void {
			
		}
		public function rangedAttack():void {
		}
		public function updateState():void {
			alreadyTried = false; //already tried to attack
			if (state == RETREAT)
			{
				if (wayNodes != null)
					setDirToNextNode();
				else	//Reached destenation
					switchToNextState();
			}
			else if (state == RUN_AWAY)
			{
				/*if (mc.checkAttackWorth(this, target))
				{trace("!");
				attack();
				//switchToNextState();
				}*/
				if (wayNodes != null)
					setDirToNextNode();
				else	//Reached destenation
					switchToNextState();
			}
			else if (state == KEEP_YOUR_GROUND) {
				stayFixedToPoint();
			}
			else if (state == DIRECT_ATTACK || state == CHARGE) {
				
			if (mc.checkAttackWorth(this, target))
			{
				attack();
				switchToNextState();
			}
				else if (wayNodes != null)
					setDirToNextNode(false);
				else	//Reached destenation
					switchToNextState();
				alreadyTried = true;
			}
			else if (state == GO_CLOSE)
			{
				if (mc.checkAttackWorth(this, target))
			{trace("sd!");
				attack();
				switchToNextState();
			}
				else if (wayNodes != null)
					setDirToNextNode(true);
				else	//Reached destenation
					switchToNextState();
							alreadyTried = true;

			}
			else if (state == ROAM_AROUND) {
				if (wayNodes != null)
					setDirToNextNode(false);
				else	//Reached destenation
					switchToNextState();
			}
			else if (state == STOP_FOR_A_WHILE) {

			}
			else if ( state == SHOOT ) {
				stayFixedToPoint();
				if (mc.checkRangedAttackWorth(this, target, rangerMinRange, rangerMaxRange) && attackRecharged) {
					rangedAttack();
					switchToNextState();
				}
				alreadyTried = true;
			}
			else if (state == GET_INTO_POSITION) {
				
			}
			else if (state == KEEP_COVER) {
				if (targetIsHelpless())
					if (currentLabel == "underCover")
					MovieClip(this).sprite.gotoAndPlay("getOutOfCover");
			}
			
			if (tryAttackAlways && !alreadyTried) {
				if (mood == RANGED) {
					if (mc.checkRangedAttackWorth(this, target, rangerMinRange, rangerMaxRange) && attackRecharged) {
						rangedAttack();
						switchToNextState();
					}
				}
				if (mood == ATTACK) {
					if (mc.checkAttackWorth(this, target)) {
						attack();
						switchToNextState();
					}
				}
			}
		}
		
		public function targetIsHelpless():Boolean {
			if (mc.checkAttackWorth(this, target)) 
			//if (target.x > x)
				return true;
			return false;
		}
		public function onOutOfCover():void {
			oneHitKill = false;
			startModd(CRAZY);
			mc.removeFromArr( this.name, mc.underCoverArr );
		}
		
		public function pause():void {
			if (startLevel != DELAY)
				MovieClip(this).sprite.stop();
		}
		public function resume():void {
			if (startLevel != DELAY)
				if (!(currentLabel == "underCover" && MovieClip(this).sprite.currentFrame == 1))
					MovieClip(this).sprite.play();
		}
		//Start functions//
		public function setStartWalk(dirYVar:int, dirXVar:int, spaceVar:int, delayVar:int, sideVar:int = NO_DIR_X):void {
			//Set start walk init
			damageable = false;
			space = spaceVar;
			initDirY = dirYVar;
			initDirX = dirXVar;
			side = sideVar;
			collisionEnabled = false;
			startLevel = DELAY;
			//visible = false;
			mc.frameTimer.addTimer( name + "startDelay" ,delayVar + 15 , FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "startStartWalk");
		}
		public function startStartWalk():void {
			//Change startLevel so onEnterFrame will know to update walk every frame
			visible = true;
			if (doChargeSound)
				if (isStar)
					mc.playRandomStarChargeSound();
				else
					mc.playRandomChargeSound();
			startLevel = START_WALK;
			mc.frameTimer.addTimer( name + "walking" ,space  , FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "endStartWalk");
			setSpeedFast();
			SPEED_LIMIT = FAST_SPEED_X + 2;
			SPEED_LIMIT_Z = FAST_SPEED_Z + 1;
		}
		public function endStartWalk():void {
			//End start walk and start real class
			if (mood != -1)
				forceStartModd(mood);
			trace("KLKL" + mood);
			setSpeedNormal();
			start();
		}
		public function updateStartWalk():void {
			//Update start walk every frame
			if ( initDirY != NO_DIR_Y )
				pressDir(initDirY);
			if (initDirX != NO_DIR_X)
				pressDir(initDirX);
			onEnterFrame2(null);
		}
		public function setStartAnimation(animationLabel:String, delayVar:int):void {
			//Set start animation and wait until delay end to proceed
			//jumpIntro //ShootIntro
			visible = false;
			damageable = false;
			this.gotoAndStop(animationLabel);
			MovieClip(this).sprite.stop();
			startLevel = DELAY;
			collisionEnabled = false;
			mc.frameTimer.addTimer( name + "startDelay" ,delayVar , FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "startStartAnimation");
		}
		public function startStartAnimation():void {
			//start animation dela ended. know play the animation
			visible = true;
			if (doChargeSound)
				if (isStar)
					mc.playRandomStarChargeSound();
				else
					mc.playRandomChargeSound();
			startLevel = START_ANIMATION;
			MovieClip(this).sprite.play();
		}
		public function endStartAnimation():void {
			//Stop the animation and start standing and real class
			this.gotoAndStop("stand");
			start();
		}
		public function start():void {
			//Force statring the reall class
			damageable = true;
			collisionEnabled = true;
			startLevel = STARTED;
			
		}
		//End start functions//
		
		public function onEnterFrame():void
		{
			if (startLevel == STARTED)
				onEnterFrameActor();
			else if (startLevel == START_WALK)
				updateStartWalk();
		}
		public function onEnterFrameActor():void {
			//Shall be overriden by child class
		}
		public function setSide(sideVar:int):void
		{
			side = sideVar;
		}
		public function setChraged():void {
			attackRecharged = true;
			if ( mc.frameTimer.isTimerRunning( name + "recharge" ))
				mc.frameTimer.removeTimer( name + "recharge" );
		}
		public function startRechargeTimer():void {
			if (! attackRecharged )
				if ( !mc.frameTimer.isTimerRunning( name + "recharge" ))
					mc.frameTimer.addTimer( name + "recharge" ,rechargeInSeconds , FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "recharge");
		}
		public function uncharge():void {
			attackRecharged = false;
			startRechargeTimer();
		}
		
		public function attackEnd():void {
			gotoAndStop("stand");
		}
		public override function canStopAttack():Boolean {
			return false;
		}
		
		public override function isAttacking():Boolean {
			if (canMelee)
				if (currentLabel == melee.attackName){
					return true;}
			if (canRange)
				if (currentLabel == ranged.attackName)
					return true;
			return false;
		}

		public function setVisible(e:Event = null):void {
			removeEventListener(Event.ENTER_FRAME, setVisible);
			visible = true;
		}
		
		
	}
	
}
