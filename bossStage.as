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

	public class bossStage extends GameStage {
		
		public var armLastX:int = -1;

				public var armLastY:int = 0;
		
		public var attackNum:int = 1;
		public var attackSubNum:int = 1;
public var bossObject:MovieClip = null;
		public var bossMaxHp:int = 10;
		public var bossHp:int;

		public var originalTimeFrames:int = 1;
		public var currentPond:* = rightPond;
		public var didOcto:Boolean = false;
		public var pash:int = 1;
		var armAttackStats:Attack = new Attack("punch1", 1, false, 4, -24, true, 67, 40, true, true);

		public function bossStage() {}
			public override function reached():void {}//player can walk when auto reach stage because of boss movie
		protected override function init2():void {
			setUnmoveable();
			rightPond.visible = false;
			leftPond.visible = false;
			bossHp = bossMaxHp;
			levelNum = 4;
			fxManager.createPool("fx_arm_attack", armAttack, 10);
			fxManager.createPool("fx_arm_attack_ground", armAttackGround, 10);
			Main.instance.askForBackground("sun");
			addPlayer(-200);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0 ,true);
		}
		/*public override function remove(mc:MovieClip):void {
			var toBeRemove:MovieClip = MovieClip(getChildByName(mc.name));
			toBeRemove.parent.removeChild(toBeRemove);
		}*/
		
		
		public function finishLevel():void {
			Main.instance.putVictoryScreen(overAllDeathCount, frameTimer.currentFrameCount, levelNum, lastLevel);
		}
		
		public function fillBossHp():void {
			Main.instance.doBossBarFill();
		}
		public function startBoss():void {
			Main.instance.showReadyGo();
			bossObject = new BossMC();
			addChild(bossObject);
			bossObject.x = point4.x;
			bossObject.y = point4.y;
			bossObject.setHp(36);
			rightPond.visible = true;
			depthArr.push(bossObject);
			setMoveable();
			originalTimeFrames =  gameFrameRate * 0.2 ; //11
			//frameTimer.removeTimer("bossTimerAttack");
			frameTimer.addTimer("bossTimerAttack", originalTimeFrames, FrameTimer.CALL_IN_INTERVALS, this, null, "updateBossAttack" );
			frameTimer.removeTimer("hideGoInDilay");
			frameTimer.addTimer("hideGoInDilay", gameFrameRate * 3, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "hideGo");
		}
		public override function pauseObjects():void
		{
			super.pauseObjects();
			if (boosIntro.visible)
				boosIntro.stop();
		}
		public override function resumeObjects():void
		{
			super.resumeObjects();
			if (boosIntro.visible)
				boosIntro.play();
		}
		 ////////////////////////////////
		///////Start Meet: meet1////////
		
		public function meet1update():void {genericMeetUpdate();}

		public function meet1preload():void {
			expectingEvents = true;
			setFreeRoam();
			setUnmoveable();
				setCirclesSize(11, 2, 10);
			/*projectileManager.createLaser(250, 700, LEFT);
			projectileManager.createLaser(550, 800, RIGHT);
			projectileManager.createLaser(550, 750, LEFT);*/
		}
		
		public function updateBossAttackAndReturnToNormal():void {
			updateBossAttack();
			frameTimer.removeTimer("bossTimerAttack");
			frameTimer.addTimer( "bossTimerAttack", originalTimeFrames, FrameTimer.CALL_IN_INTERVALS, this, null, "updateBossAttack" );
		}
		
		public function updateBossAttack():void {
		if (pash == 1 || pash == 3) {
			if (attackNum == 1) {
				if (attackSubNum == 1) {
				armLastX = getGroundX(player) - 250;
				armLastY = getGroundY(player) - 15;
				}
				
				putArmOn(armLastX + (attackSubNum * 135),armLastY + attackSubNum * 3);
				attackSubNum++;
				if (attackSubNum == 8) {
					attackSubNum = 1;
					attackNum = 2;
				}
			}
			else if (attackNum == 2) {
				if (attackSubNum == 1) {
				armLastX = getGroundX(player) - 350;
				armLastY = getGroundY(player) - 200;
				}
				
				putArmOn(armLastX + (attackSubNum * 180),armLastY + (attackSubNum * 50));
				attackSubNum++;
				if (attackSubNum == 15) {
					attackSubNum = 1;
					attackNum = 3;
				}
			}
			else if (attackNum == 3) {
				if (attackSubNum == 1) {
				armLastX = getGroundX(player) - 300;
				armLastY = getGroundY(player) + 200;
				}
				
				putArmOn(armLastX + (attackSubNum * 180),armLastY - (attackSubNum * 50));
				attackSubNum++;
				if (attackSubNum == 15) {
					attackSubNum = 1;
					attackNum = 4;
				}
			}
			else if (attackNum == 4) {
				if (attackSubNum == 1) {
				armLastX = getGroundX(player) - 300;
				armLastY = getGroundY(player) - 200;
				}
				putArmOn(armLastX + (attackSubNum * 130),armLastY - (attackSubNum * 50) + 400);
				putArmOn(armLastX + (attackSubNum * 130),armLastY + (attackSubNum * 50));
				attackSubNum++;
				if (attackSubNum == 15) {
					attackSubNum = 1;
					attackNum = 1;
				}
			}
		}
		
		
		else {//other side to the right
			if (attackNum == 1) {
				if (attackSubNum == 1) {
				armLastX = getGroundX(player) + 250;
				armLastY = getGroundY(player) - 15;
				}
				
				putArmOn(armLastX - (attackSubNum * 135),armLastY + attackSubNum * 3);
				attackSubNum++;
				if (attackSubNum == 14) {
					attackSubNum = 1;
					attackNum = 2;
				}
			}
			else if (attackNum == 2) {
				if (attackSubNum == 1) {
				armLastX = getGroundX(player) + 350;
				armLastY = getGroundY(player) - 200;
				}
				
				putArmOn(armLastX - (attackSubNum * 180),armLastY + (attackSubNum * 50));
				attackSubNum++;
				if (attackSubNum == 15) {
					attackSubNum = 1;
					attackNum = 3;
				}
			}
			else if (attackNum == 3) {
				if (attackSubNum == 1) {
				armLastX = getGroundX(player) + 300;
				armLastY = getGroundY(player) + 200;
				}
				
				putArmOn(armLastX - (attackSubNum * 180),armLastY - (attackSubNum * 50));
				attackSubNum++;
				if (attackSubNum == 15) {
					attackSubNum = 1;
					attackNum = 4;
				}
			}
			else if (attackNum == 4) {
				if (attackSubNum == 1) {
				armLastX = getGroundX(player) + 300;
				armLastY = getGroundY(player) - 200;
				}
				putArmOn(armLastX - (attackSubNum * 130),armLastY - (attackSubNum * 50) + 400);
				putArmOn(armLastX - (attackSubNum * 130),armLastY + (attackSubNum * 50));
				attackSubNum++;
				if (attackSubNum == 15) {
					attackSubNum = 1;
					attackNum = 1;
				}
			}
		}
			/*
			trace("arm attack" + armLastX);
			if (armLastX == -1) {
				armLastX = getGroundX(player);
			}
			else {
				armLastX += 130;
			}
			armLastY = getGroundY(player);
			if (armLastX > getGroundX(player) + 250)
				armLastX = -1;
				
			putArmOn(armLastX,armLastY);
*/
			/*if (attackNum == 1) {
				attackNum++;
				putArmOn(getGroundX(player) - 100, getGroundY(player) - 5);
				putArmOn(getGroundX(player), getGroundY(player));
				putArmOn(getGroundX(player) + 100, getGroundY(player) + 5);
			}
			else if (attackNum == 2) {
				attackNum = 1;
				putArmOn(getGroundX(player) - 100, getGroundY(player) + 50);
				putArmOn(getGroundX(player), getGroundY(player) + 55);
				putArmOn(getGroundX(player) + 100, getGroundY(player) + 45);
			}*/
			
		}
		public override function killStage():void
		{
			super.killStage();
			boosIntro.stop();
			removeChild(boosIntro);
			
		}

		public function checkArmHit(arm:MovieClip):void {
				if (player != null)
				if (sameGround(player, arm) && arm.hitPlace.hitTestObject(player._bodyBox) )//Check hit
				if (player.currentLabel != "down" && player.currentLabel != "death" && player.currentLabel != "pushed" && player.currentLabel != "death_no_head" && player.currentLabel != "hit_no_head")
				{
									playRandomAttackSound();
						armLastX = -1;
						onHit(arm, player, armAttackStats);
					frameTimer.removeTimer("bossTimerAttack");
				frameTimer.addTimer( "bossTimerAttack", gameFrameRate * 1.5, FrameTimer.CALL_IN_INTERVALS, this, null, "updateBossAttackAndReturnToNormal" );
				}
		}
		public override function checkAttackHit(aggresor:MovieClip, canHitEverybody:Boolean = false, noSound:Boolean = false):int
		{
			if (bossObject != null)
			if (sameGround(player, bossObject) && player.hitPlace.hitTestObject(bossObject._bodyBox) )//Check hit
				if (bossObject.currentLabel != "death" && bossObject.currentLabel != "changeSide")
			//if (player.currentLabel != "down" && player.currentLabel != "death" && player.currentLabel != "pushed" && player.currentLabel != "death_no_head" && player.currentLabel != "hit_no_head")
				{
					var attack:Attack = aggresor.melee;
					bossObject.onHit(attack);//gotoAndStop("hit1");
					playHitFxOn(aggresor);
					playBloodOn(bossObject);
					//Set land blood
					bossObject.takeDamage(attack.damage);
					
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
					}
						//stage.frameRate = 20;
						Main.instance.updateBossHp(bossObject.hp, bossObject.maxHp);
					//killBoss();
					
						if (pash == 1 && bossObject.hp <= bossObject.maxHp * 0.75) {
								changeBossSide();
								pash = 2;
							}
						else if (!didOcto && pash == 2 && bossObject.hp <= bossObject.maxHp * 0.65) {
							didOcto = true;
								addOcto(NO_DIR_Y, RIGHT, 50, 1, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null).recharge();
							}
						else if (pash == 2 && bossObject.hp <= bossObject.maxHp * 0.50) {
								changeBossSide();
								pash = 3;
							}
						else if (pash == 3 && bossObject.hp <= bossObject.maxHp * 0.25) {
								changeBossSide();
								pash = 4;
							}
						else if (pash == 4 && bossObject.hp <= 0) {
								killBoss();
							}
						playRandomAttackSound();
						return 1;
				}
				
			return super.checkAttackHit(aggresor, canHitEverybody);
		}
		public function killBoss():void {
			killAll(); //Kill dummies
			bossObject.gotoAndStop("death");
			overAllDeathCount++;
			frameTimer.removeTimer("bossTimerAttack");
			frameTimer.addTimer( "VictoryDelay", gameFrameRate * 4, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "victorystart");
			Main.instance.unlockNgMedal("Through Hell and Back");
		}
		public function sideChanged():void {
			if (pash == 2) {
				bossObject.x = point5.x;
				bossObject.y = point5.y;
				originalTimeFrames--;
				armAttackStats.oppositeDirPush = false;
				frameTimer.removeTimer("bossTimerAttack");
				//originalTimeFrames =  gameFrameRate * 0.7;
				frameTimer.addTimer( "bossTimerAttack", originalTimeFrames, FrameTimer.CALL_IN_INTERVALS, this, null, "updateBossAttack" );
				addOcto(NO_DIR_Y, RIGHT, 50, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, LEFT, null).recharge();
				addOcto(NO_DIR_Y, RIGHT, 50, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, LEFT, null).recharge();
				addOcto(NO_DIR_Y, RIGHT, 50, 1, getMeetPoint("point6").x , getMeetPoint("point6").y, LEFT, null).recharge();
				armAttackStats.damage = 0.5;
				armAttackStats.pushX = 6;
			}
			else if (pash == 3) {
				bossObject.x = point4.x;
				bossObject.y = point4.y;
				armAttackStats.oppositeDirPush = true;
				frameTimer.removeTimer("bossTimerAttack");
				originalTimeFrames--;
				//originalTimeFrames =  gameFrameRate * 0.6;
				frameTimer.addTimer( "bossTimerAttack", originalTimeFrames, FrameTimer.CALL_IN_INTERVALS, this, null, "updateBossAttack" );
				addOcto(NO_DIR_Y, LEFT, 50, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null).recharge();
				//addOcto(NO_DIR_Y, LEFT, 50, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null).recharge();
				addOcto(NO_DIR_Y, LEFT, 50, 1, getMeetPoint("point6").x , getMeetPoint("point6").y, RIGHT, null).recharge()
				armAttackStats.damage = 1;
				armAttackStats.pushX = 7;
			}
			else if (pash == 4) {
				bossObject.x = point5.x;
				bossObject.y = point5.y;
				armAttackStats.oppositeDirPush = false;
				frameTimer.removeTimer("bossTimerAttack");
				originalTimeFrames--;
				//originalTimeFrames =  gameFrameRate * 0.6;
				frameTimer.addTimer( "bossTimerAttack", originalTimeFrames, FrameTimer.CALL_IN_INTERVALS, this, null, "updateBossAttack" );
				//addOcto(NO_DIR_Y, LEFT, 50, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null).recharge();
				//addOcto(NO_DIR_Y, LEFT, 50, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null).recharge();
				//addOcto(NO_DIR_Y, LEFT, 50, 1, getMeetPoint("point6").x , getMeetPoint("point6").y, RIGHT, null).recharge()
				armAttackStats.damage = 1;
				armAttackStats.pushX = 8;
			}
		}
		public function changeBossSide():void {
			if (pash == 1) {
				bossObject.gotoAndStop("changeSide");
				leftPond.visible = true;
				rightPond.gotoAndPlay("disappear");
			}
			else if (pash == 2) {
				bossObject.gotoAndStop("changeSide");
				rightPond.visible = true;
				rightPond.gotoAndStop(1);
				leftPond.gotoAndPlay("disappear");
			}
			else if (pash == 3) {
				bossObject.gotoAndStop("changeSide");
				leftPond.visible = true;
				leftPond.gotoAndStop(1);
				rightPond.gotoAndPlay("disappear");;
			}
		}
		public function hideGo():void {
				Main.instance.hideGo();
		}
		public function meet1start():void {
			
			//Main.instance.hideGo();
			//setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
						setToCurrentMeetLimits();
			//startBoss();
		
			setUnmoveable();
			cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.point3, 186, 55, 0) );
			boosIntro.gotoAndPlay(2);
			
			//setCirclesSize(1, 2, 10);
			//addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			//addOcto(NO_DIR_Y, LEFT, 60, 30, getMeetPoint("point6").x , getMeetPoint("point6").y, RIGHT, null);
			Main.instance.collectGarbage();
		}
		public function meet1_event1():Boolean {
			/*if (deathCount >= 1) {
				Main.instance.unlockMedal("First Kill");
				Main.instance.playUnlockAnimation("First Kill");
				return true;
			}*/
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
		
		
		
		 ///////////////////////////////
		///////Start Meet: VICTORY///////
		
		public function victorypreload():void {Main.instance.music.fadeAllTo(0, 2000);

			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		public function victorystart():void {
			
			finishLevel();
			
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
		
		
		public function putArmOn(xVar:int, yVar:int):void {
			//if (actor.getChildByName("bloodPoint") != null)
			
			if ( getNodeAtPoint( new Point(xVar, yVar)).traversable )
								if (bossObject == null || !(bossObject.dontTouch.hitTestObject(getNodeAtPoint( new Point(xVar, yVar))
									)) )
								{
				putFxOnPoint("fx_arm_attack", new Point(xVar, yVar) , true);
			putFxOnPoint("fx_arm_attack_ground", new Point(xVar, yVar) , true);
			}
		}
		public override function checkPopItem(character:MovieClip):void
		{
			//Hearth poping manager
			//if ( Math.random() < 0.03 ||  overAllDeathCount == 1  || character is Heavy )
			//if (player.hp <= 2 || character is Heavy || overAllDeathCount == 1 || true)
			{
				popItem("hearth", character.x, character.y);
			}
		}
		public override function getTarget():MovieClip
		{
			return player;
		}

		
		
	}
	
}
