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

	public class finalBossStage extends GameStage {
		public var eggsArr:Array = [];
		public var eggsArr2:Array = [];
		public var pash:int = 0;
		public var attackNum:int = 1;
		var armAttackStats:Attack = new Attack("punch1", 1, true, 0, 0, false, 67, 40, false, true);
		var beamAttackStats:Attack = new Attack("punch1", 1, false, 16, -36, false, 67, 50, true, true);

		public function finalBossStage() {}
			
		protected override function init2():void {
			setUnmoveable();
			fxManager.createPool("Eggshot", Eggshot, 10);
			levelNum = 7;
			useBodiesArr = false;
			if (Main.instance.android)
				Main.instance.askForBackground("space");
			else
				Main.instance.askForBackground("space");
			addPlayer(-2864);
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0 ,true);//killBoss();
		}
		/*public override function remove(mc:MovieClip):void {
			var toBeRemove:MovieClip = MovieClip(getChildByName(mc.name));
			toBeRemove.parent.removeChild(toBeRemove);
		}*/
		public override function startCamera():void {
			cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.player, -1, 40, 0) );			

						cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.flying, 225, 2) );		
	
		}
		public function fillBossHp():void {
			Main.instance.doBossBarFill();
		}
		public function finishLevel():void {
			Main.instance.putVictoryScreen(overAllDeathCount, frameTimer.currentFrameCount, levelNum, lastLevel);
		}
		/*public override function startCamera():void {
			cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.player, -1, 10) );			

			cameraManager.cameraInstancesArr.push ( new CameraInstance(thisMC.player, 150, 1, 0, true, true) );						
		}*/
		public function checkBeamHit():void {
			if (player != null)
				if (sameGround(player, bossObject) && bossObject.hitPlace.hitTestObject(player._bodyBox) )//Check hit
				if (player.currentLabel != "down" && player.currentLabel != "death" && player.currentLabel != "pushed" && player.currentLabel != "death_no_head" && player.currentLabel != "hit_no_head")
				{
						playRandomAttackSound();
						onHit(bossObject, player, beamAttackStats);
				}
			
		}
		public function checkEggHit(arm:MovieClip):void {
				if (player != null)
				if (sameGround(player, arm) && arm.hitPlace.hitTestObject(player._bodyBox) )//Check hit
				if (player.currentLabel != "down" && player.currentLabel != "death" && player.currentLabel != "pushed" && player.currentLabel != "death_no_head" && player.currentLabel != "hit_no_head")
				{
									playRandomAttackSound();
						armLastX = -1;
						onHit(arm, player, armAttackStats);
					frameTimer.removeTimer("bossTimerAttack");
					//frameTimer.addTimer( "bossTimerAttack", gameFrameRate * 2.5, FrameTimer.CALL_IN_INTERVALS, this, null, "updateBossAttackAndReturnToNormal" );
				}
		}
		public function startBoss():void {
			//setMoveable();
			bossObject.setHp(100);
			//setMoveable();
			bossObject.gotoAndStop("stand");
			pash = 1;
			getNextMove();
			//originalTimeFrames =  gameFrameRate * 0.2 ; //11
			//frameTimer.removeTimer("bossTimerAttack");
		/*	frameTimer.addTimer("bossTimerAttack", originalTimeFrames, FrameTimer.CALL_IN_INTERVALS, this, null, "updateBossAttack" );
			frameTimer.removeTimer("hideGoInDilay");
			frameTimer.addTimer("hideGoInDilay", gameFrameRate * 3, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "hideGo");
		*/
		}
		
		public function justShootEgg():void {
			updateBossAttack();
		}
		public function gotoNextMove():void {
			attackNum++;
			getNextMove();
		}
		public function getNextMove():void {trace("PASH" + pash + "NUM" + attackNum);
			if (pash == 1) {
				if (attackNum == 1) {
					bossObject.gotoAndStop("stand");
					frameTimer.addTimer("standTimer", gameFrameRate * 3, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
				else if  (attackNum == 2) {
					bossObject.gotoAndStop("beam");
				}
				else if  (attackNum >= 3 && attackNum <= 9) {
					if (eggsArr.length == 0) {
						eggsArr = [0, 0, 0, 11, 22, 33, 44];
						eggsArr2= [0, 0, 0, 61, 52, 43, 34];
					}
					bossObject.gotoAndStop("poop");
					bossObject.sprite.gotoAndPlay(1);
				}
				else if  (attackNum == 10) {
					attackNum = 1;
					bossObject.gotoAndStop("tired");
					frameTimer.addTimer("tiredTimer", gameFrameRate * 5, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
			
			}
			else if (pash == 2) {
				if (attackNum == 1) {
					bossObject.gotoAndStop("stand");
					frameTimer.addTimer("standTimer", gameFrameRate * 2, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
				else if  (attackNum == 2) {
					bossObject.gotoAndStop("beam");
				}
				else if  (attackNum >= 3 && attackNum <= 14) {
					if (eggsArr.length == 0) {
						eggsArr = [11, 21, 31, 41, 51, 61, 62, 52, 42, 32, 22, 12];
						eggsArr2= [64, 54, 44, 34, 24, 14, 13, 23, 33, 43, 53, 63];
					}
					bossObject.gotoAndStop("poop");
					bossObject.sprite.gotoAndPlay(1);
				}
				if (attackNum == 15) {
					bossObject.gotoAndStop("stand");
					frameTimer.addTimer("standTimer", gameFrameRate * 1, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
				else if  (attackNum == 16) {
					bossObject.gotoAndStop("beam");
				}
				else if  (attackNum >= 17 && attackNum <= 27) {
					if (eggsArr.length == 0) {
						eggsArr = [];
						eggsArr2= [];
					}
					bossObject.gotoAndStop("dpoop");
					bossObject.sprite.gotoAndPlay(1);
				}
				else if  (attackNum == 28) {
					attackNum = 1;
					bossObject.gotoAndStop("tired");
					frameTimer.addTimer("tiredTimer", gameFrameRate * 5, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
			}
			
			else if (pash == 3) {
				if (attackNum == 1) {
					bossObject.gotoAndStop("stand");
					frameTimer.addTimer("standTimer", gameFrameRate * 1, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
				else if  (attackNum == 2) {
					bossObject.gotoAndStop("beam");
				}
				else if  (attackNum >= 3 && attackNum <= 19) {
					if (eggsArr.length == 0) {
						eggsArr = [0, 0, 0, 0, 0, 0, 11, 22, 33, 44];
						eggsArr2= [0, 0, 0, 0, 0, 0, 51, 42, 33, 24];
					}
					bossObject.gotoAndStop("dpoop");
					bossObject.sprite.gotoAndPlay(1);
				}
				else if  (attackNum == 20) {
					attackNum = 1;
					bossObject.gotoAndStop("tired");
					frameTimer.addTimer("tiredTimer", gameFrameRate * 5, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
			}
			
			else if (pash == 4) {
				if (attackNum == 1) {
					bossObject.gotoAndStop("stand");
					frameTimer.addTimer("standTimer", gameFrameRate * 2, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
				else if  (attackNum == 2) {
					bossObject.gotoAndStop("beam");
				}
				else if  (attackNum >= 3 && attackNum <= 20) {
					if (eggsArr.length == 0) {
						eggsArr = [0, 0, 0, 0, 0, 0, 11, 22, 33, 44, 0, 0, 0, 0, 0, 0, 0];
						eggsArr2= [0, 0, 0, 0, 0, 0, 51, 42, 33, 24, 0, 0, 0, 0, 0, 0, 0];
					}
					bossObject.gotoAndStop("dpoop");
					bossObject.sprite.gotoAndPlay(1);
				}
				else if  (attackNum == 21) {
					bossObject.gotoAndStop("beam");
				}
				else if  (attackNum == 22) {
					attackNum = 1;
					bossObject.gotoAndStop("tired");
					frameTimer.addTimer("tiredTimer", gameFrameRate * 5, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
			}
			
			else if (pash == 5) {
				if (attackNum == 1) {
					bossObject.gotoAndStop("stand");
					frameTimer.addTimer("standTimer", gameFrameRate * 2, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
				else if  (attackNum == 2) {
					bossObject.gotoAndStop("beam");
				}
				else if  (attackNum >= 3 && attackNum <= 20) {
					if (eggsArr.length == 0) {
						eggsArr = [];
						eggsArr2= [];
					}
					bossObject.gotoAndStop("dpoop");
					bossObject.sprite.gotoAndPlay(1);
				}
				else if  (attackNum == 21) {
					bossObject.gotoAndStop("beam");
				}
				if (attackNum == 22) {
					bossObject.gotoAndStop("stand");
					frameTimer.addTimer("standTimer", gameFrameRate * 2, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
				else if  (attackNum == 23) {
					bossObject.gotoAndStop("beam");
				}
				else if  (attackNum >= 24 && attackNum <= 31) {
					if (eggsArr.length == 0) {
						eggsArr = [0, 0, 0, 11, 22, 33, 44];
						eggsArr2= [0, 0, 0, 61, 52, 43, 34];
					}
					bossObject.gotoAndStop("poop");
					bossObject.sprite.gotoAndPlay(1);
				}
				else if  (attackNum == 32) {
					attackNum = 1;
					bossObject.gotoAndStop("tired");
					frameTimer.addTimer("tiredTimer", gameFrameRate * 5, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
			}
			
			else if (pash == 6) {
				if (attackNum == 1) {
					bossObject.gotoAndStop("stand");
					frameTimer.addTimer("standTimer", gameFrameRate * 2, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
				else if  (attackNum == 2) {
					bossObject.gotoAndStop("beam");
				}
				if (attackNum == 3) {
					bossObject.gotoAndStop("stand");
					frameTimer.addTimer("standTimer", gameFrameRate * 2, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
				else if  (attackNum == 4) {
					bossObject.gotoAndStop("beam");
				}
				else if  (attackNum >= 5 && attackNum <= 42) {
					if (eggsArr.length == 0) {
						eggsArr = [];
						eggsArr2= [];
					}
					bossObject.gotoAndStop("dpoop");
					bossObject.sprite.gotoAndPlay(1);
				}
				else if  (attackNum == 43) {
					attackNum = 1;
					bossObject.gotoAndStop("tired");
					frameTimer.addTimer("tiredTimer", gameFrameRate * 5, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "gotoNextMove");
				}
			}

		}
		
		public override function killStage():void
		{
			super.killStage();
			bossObject.stop();
			removeChild(bossObject);
			
		}
		public override function checkAttackHit(aggresor:MovieClip, canHitEverybody:Boolean = false, noSound:Boolean = false):int
		{
			if (bossObject != null)
			if (sameGround(player, bossObject) && player.hitPlace.hitTestObject(bossObject._bodyBox) )//Check hit
				if (bossObject.currentLabel == "tired" || bossObject.currentLabel == "hit2" || bossObject.currentLabel == "hit1")
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
					
					if (pash == 1 && bossObject.hp <= bossObject.maxHp * 0.80)
						pash = 2;
					else if (pash < 3 && bossObject.hp <= bossObject.maxHp * 0.60)
						pash = 3;
					else if (pash < 4 && bossObject.hp <= bossObject.maxHp * 0.60)
						pash = 4;
					else if (pash < 5 && bossObject.hp <= bossObject.maxHp * 0.40)
						pash = 5;
					else if (pash < 6 && bossObject.hp <= bossObject.maxHp * 0.20)
						pash = 6;
					if (bossObject.hp <= 0)
						killBoss();
						
							playRandomAttackSound();
						return 1;

				}
				
			return super.checkAttackHit(aggresor, canHitEverybody);
		}
		public function killBoss():void {
			Main.instance.unlockNgMedal("A Chicken Chaser");
			//killAll(); //Kill dummies
			bossObject.gotoAndStop("death");
			overAllDeathCount++;
			frameTimer.removeTimer("tiredTimer");
			frameTimer.removeTimer("standTimer");
			Main.instance.music.fadeAllTo(0, 2000);
			frameTimer.addTimer( "VictoryDelay", 600, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "victorystart");
		}
		public function updateBossAttackAndReturnToNormal():void {
			updateBossAttack();
			frameTimer.removeTimer("bossTimerAttack");
			frameTimer.addTimer( "bossTimerAttack", gameFrameRate * 0.5, FrameTimer.CALL_IN_INTERVALS, this, null, "updateBossAttackAndReturnToNormal" );
		}
		public function updateBossAttack():void {
			if (eggsArr.length == 0 || eggsArr[0] == 0) {
				putFxOnPoint("Eggshot", new Point(getGroundX(player), getGroundY(player)) , true);eggsArr.shift();eggsArr2.shift();
			}
			else {
				putFxOnPoint("Eggshot", new Point(getChildByName("pointEgg" + eggsArr[0]).x, getChildByName("pointEgg" + eggsArr[0]).y) , true);
				eggsArr.shift();
				if (eggsArr2.length != 0){
				putFxOnPoint("Eggshot", new Point(getChildByName("pointEgg" + eggsArr2[0]).x, getChildByName("pointEgg" + eggsArr2[0]).y) , true);
				eggsArr2.shift();}
			}
		}
		 ////////////////////////////////
		///////Start Meet: meet1////////
		public override function pauseObjects():void
		{
			super.pauseObjects();
			if (flying.visible)
				flying.stop();
			if (bossObject != null)
				MovieClip(bossObject.sprite).stop();
		}
		public override function resumeObjects():void
		{
			super.resumeObjects();
			if (flying.visible)
				flying.play();
			if (bossObject != null)
				MovieClip(bossObject.sprite).play();
		}
		public function meet1update():void {genericMeetUpdate();}

		public function meet1preload():void {
			depthArr.push(bossObject);
				//frameTimer.addTimer( "bossTimerAttack", gameFrameRate * 0.5, FrameTimer.CALL_IN_INTERVALS, this, null, "updateBossAttackAndReturnToNormal" );

			expectingEvents = true;
			setFreeRoam();
			/*projectileManager.createLaser(250, 700, LEFT);
			projectileManager.createLaser(550, 800, RIGHT);
			projectileManager.createLaser(550, 750, LEFT);*/
		}
		
		public function meet1start():void {Main.instance.hideGo();
			setToCurrentMeetLimitsAndStickTo(RIGHT);
			didntDoEvents();
			setCirclesSize(1, 2, 10);
			//addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			//addOcto(NO_DIR_Y, LEFT, 60, 30, getMeetPoint("point6").x , getMeetPoint("point6").y, RIGHT, null);
			Main.instance.collectGarbage();
		}
		public function meet1_event1():Boolean {
			if (deathCount >= 1) {
				Main.instance.unlockMedal("First Kill");
				Main.instance.playUnlockAnimation("First Kill");
				return true;
			}
			return false;
		}
			
		public function meet1_event2():Boolean {
			if (deathCount >= 2) {
				currentMeet().end();
				Main.instance.showGo();
				return true;
			}
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
		
		public function meet2preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function meet2start():void {Main.instance.hideGo();
			resetBloodContainer();
			F98m.visible = false;
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			setCirclesSize(2, 2, 10);
			addOcto(NO_DIR_Y, LEFT, 60, 66, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "jumpIntro");
			addOcto(NO_DIR_Y, RIGHT, 60, 23, getMeetPoint("point11").x , getMeetPoint("point11").y, LEFT, "jumpIntro");
				Main.instance.collectGarbage();
		}
		
		
		
		public function meet2_event1():Boolean {
			if (deathCount >= 2) {
			addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point9").x , getMeetPoint("point9").y, RIGHT, "jumpIntro");
			addOcto(NO_DIR_Y, RIGHT, 60, 23, getMeetPoint("point11").x , getMeetPoint("point11").y, LEFT, "jumpIntro");
					Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meet2_event2():Boolean {
			if (deathCount == 5) {
				currentMeet().end();
				Main.instance.showGo();
				
				
				return true;
			}
			return false;
		}
		
		public function meet2update():void {genericMeetUpdate();}
		
		public function meet2end():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////Meet2 END///////////////
		///////////////////////////////
		
		///
		
		 ///////////////////////////////
		///////Start Meet: meet2///////
		
		public function meetPreArenapreload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function meetPreArenastart():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			setCirclesSize(3, 2, 10);
			addOcto(NO_DIR_Y, RIGHT, 60, 11, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 44, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 11, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
			Main.instance.collectGarbage();
		}
		
		public function meetPreArena_event1():Boolean {
			if (deathCount >= 1) {
				addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, "jumpIntro");
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meetPreArena_event2():Boolean {
			if (deathCount == 4) {
				currentMeet().end();
				Main.instance.showGo();				
				return true;
			}
			return false;
		}
		
		public function meetPreArenaupdate():void {genericMeetUpdate();}
		
		public function meetPreArenaend():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meetPreArena END///////////////
		///////////////////////////////
		
			
		 ///////////////////////////////
		///////Start Meet: meet2///////
		
		public function meetPond1preload():void {
			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		
		public function meetPond1start():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			setCirclesSize(3, 2, 10);
			addOcto(NO_DIR_Y, RIGHT, 60, 1, getMeetPoint("point9").x , getMeetPoint("point9").y, LEFT, "jumpIntro");
			addOcto(NO_DIR_Y, LEFT, 60, 22, getMeetPoint("point8").x , getMeetPoint("point8").y, NO_DIR_X, "jumpIntro");
			addOcto(NO_DIR_Y, LEFT, 60, 44, getMeetPoint("point7").x , getMeetPoint("point7").y, RIGHT, "jumpIntro");
			Main.instance.collectGarbage();
		}		
		
		public function meetPond1_event1():Boolean {
			if (deathCount >= 2) {
				addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point8").x , getMeetPoint("point8").y, RIGHT, "jumpIntro");
				addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
			
		public function meetPond1_event2():Boolean {
			if (deathCount == 5) {
				currentMeet().end();
				Main.instance.showGo();				
				return true;
			}
			return false;
		}
		
		public function meetPond1update():void {genericMeetUpdate();}
		
		public function meetPond1end():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////meetPond1 END///////////////
		///////////////////////////////
		
		
		
		 ///////////////////////////////
		///////Start Meet: meetArena///////
		public function meetArenapreload():void {
			expectingEvents = true;
			arenaFence.gotoAndStop("cheer");
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		public function meetArenastart():void {Main.instance.hideGo();
			resetBloodContainer();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();		
			setCirclesSize(3, 2, 10);
			arenaStartFrame = frameTimer.currentFrameCount;
			frameTimer.addTimer( "arenaShake1", 30, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "arenaShake");
			frameTimer.addTimer( "arenaShake2", 30 + 40 + 55, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "arenaShake2");
			frameTimer.addTimer( "arenaShake3", 210, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "arenaShake3");
			arenaGuy = addBullyAI(NO_DIR_Y, LEFT, 80, 230, getMeetPoint("point5").x + 40 , getMeetPoint("point5").y, "octo", "octo", "octo", "octo", LEFT,null);
		//	arenaGuy = addFatOcto(NO_DIR_Y, LEFT, 120, 230, getMeetPoint("point5").x + 40 , getMeetPoint("point5").y, NO_DIR_X);
			Main.instance.collectGarbage();
		}
		public function arenaShake():void {
			playStomp();
			trace("arenaShake");
			setShake(40);
		}
		public function arenaShake2():void {
playStomp();			setShake(50);
		}
		public function arenaShake3():void {
playStomp();			setShake(60);
		}
		public function meetArena_event1():Boolean {
			if (arenaGuy.hp == arenaGuy.maxHp)
				if (frameTimer.currentFrameCount - arenaStartFrame >= gameFrameRate * 17) {
					arenaFence.helper.play();
				return true;
			}
			return false;
		}
		public function meetArena_event2():Boolean {
			if (arenaGuy.hp == arenaGuy.maxHp)
				if (frameTimer.currentFrameCount - arenaStartFrame >= gameFrameRate * 32) {
					arenaFence.helper.play();
				return true;
			}
			return false;
		}
		public function meetArena_event3():Boolean {trace("YO YO YO " + deathCount);
			if (deathCount >= 1) {
				//arenaGuy = null;
				didEvent2 = true;
				didEvent1 = true;
				_main.fx.play("Squidcrowd");
				arenaFence.gotoAndPlay("moveOut");
				trace("YO YO");
				//Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function arenaLinch():void {
			setCirclesSize(2, 1, 10);
			addOcto(NO_DIR_Y, RIGHT, 60, 50, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
			addOcto(NO_DIR_Y, RIGHT, 60, 100, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 45, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
			addOcto(NO_DIR_Y, LEFT, 60, 90, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
			Main.instance.collectGarbage();
		}
		public function meetArena_event4():Boolean {
			if (deathCount >=3) {
				addOcto(NO_DIR_Y, RIGHT, 60, 100, getMeetPoint("point2").x , getMeetPoint("point2").y, LEFT, null);
				addOcto(NO_DIR_Y, LEFT, 60, 45, getMeetPoint("point5").x , getMeetPoint("point5").y, RIGHT, null);
				addOcto(NO_DIR_Y, LEFT, 60, 1, getMeetPoint("point4").x , getMeetPoint("point4").y, RIGHT, null);
				Main.instance.collectGarbage();
				return true;
			}
			return false;
		}
		public function meetArena_event5():Boolean {
			if (deathCount == 8) {
				currentMeet().end();
				Main.instance.showGo();
				return true;
			}
			return false;
		}
		
		public function meetArenaupdate():void {genericMeetUpdate();}
		
		public function meetArenaend():void {
			freeCamera();
			resetDeathCount();
			endMeet();
			//frameTimer.addTimer( "victoryTimer", 80, FrameTimer.DIFFERENCE_FROM_CURRENT_TIME, this, "finishLevel");
			//cameraManager.lookingFoward = true;
			preloadNextMeet();
		}
		////////MeetArena END///////////////
		///////////////////////////////
		
		 ///////////////////////////////
		///////Start Meet: VICTORY///////
		
		public function victorypreload():void {Main.instance.music.fadeAllTo(0, 2000);

			expectingEvents = true;
			lookingFowardToBit = getBitsNode(currentMeet().leftLimit) + NODE_WIDTH_CONST;
		}
		public function victorystart():void {Main.instance.hideGo();
			
			finishLevel();
			setToCurrentMeetLimitsAndStickTo(LEFT);
			didntDoEvents();
			
			freeAllNodesFromLimit();
			setLimits(currentMeet().leftLimit, currentMeet().rightLimit + 111);
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
		
		
		
		public override function checkPopItem(character:MovieClip):void
		{
			//Hearth poping manager
			if ( Math.random() < 0.5 ||  overAllDeathCount == 1  || character is Bully )
			//if (player.hp <= 2 || character is Heavy || overAllDeathCount == 1 || true)
			{
				popItem("hearth", character.x, character.y);
			}
		}
		public override function getTarget():MovieClip
		{
			return player;
		}
		
		/*public override function updateFrames():void
		{
			
			//checkIfDecoShakeByDeco();
			//checkIfSlowdown(player);
		}*/
		
		
	}
	
}
