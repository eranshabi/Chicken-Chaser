package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
		import flash.geom.Point;

	public class FinalBossMC extends MovieClip {
		public var globalGroundY:int;
						public var mc:*;
public var damageable:Boolean = true;
public var flippable:Boolean = false;
		public var maxHp:Number = 5;
		public var hp:Number = 5; 
		public var slippyEnabled:Boolean = false;
		public var slippy:Boolean = false;
		public var onWater:Boolean = false;

		public var slowdownEnabled:Boolean = false;
		public var slowdown:Boolean = false;
		public var stunned:Boolean = false;
		public var invincibleFront:Boolean = false;
		public var unpushable:Boolean = false;
		public var oneHitKill:Boolean = false;
			public var enemy:Boolean = true;
		public var _bodyBox:MovieClip;
		public var _groundFoot:MovieClip;
public var feet:Point;// = new Point (_groundFoot.x + _groundFoot.weidth * 0.5 * scaleX, _groundFoot.y);
		public var ground:Point;
		public var originalGround:Point;
		public function FinalBossMC() {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0 ,true);
		}
		public function setHp(hpVar:int ):void {
			maxHp = hpVar;
			hp = hpVar;
		}
		public function getFlipSide():int
		{
			return 2;
		}
		public function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stop();
			_bodyBox = MovieClip(this).bodyBox;
			_groundFoot = MovieClip(this).groundFoot;

			mc = MovieClip(parent);
			
			feet = new Point (_groundFoot.x, _groundFoot.y);
			ground = new Point (_groundFoot.x, _groundFoot.y);
			originalGround = new Point (_groundFoot.x + _groundFoot.width * 0.5 * scaleX, _groundFoot.y);
			globalGroundY = mc.getGroundY(this);
		}
		public function pause():void {
				MovieClip(this).sprite.stop();
		}
		public function resume():void {
				MovieClip(this).sprite.play();
		}
		public function onEnterFrame():void
		{
			
		}
		public function takeDamage(damage:Number):void
		{	
			hp -= damage;
		}
		public function gotoTired():void {
			gotoAndStop("tired");
			MovieClip(sprite).gotoAndPlay("again");
		}
		public function onHit(attack:Attack):void {
			try{
			if (currentLabel == "hit1")
				gotoAndStop("hit2");
			else
				gotoAndStop("hit1");
			}
		catch (error:Error) {
			trace("HITERROR");

			//gotoAndStop("hit1");
		}		mc.playRandomBossHurtSound();

		}
		public function getGroundWidth():int
		{
			return _groundFoot.width;
		}
		public function getGroundHeight():int
		{
			return _groundFoot.height;
			
		}
		
	}
	
}
