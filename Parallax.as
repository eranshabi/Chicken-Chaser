package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;

	
	public class Parallax extends MovieClip {
		
		
			public var originalX:int;
			public var originalY:int;
			public var paraDepth:Number;
			public var paraDepthX100:int;


	public function Parallax() {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0 ,true);

		}
		
		private function init(e:Event = null):void 
		{	
//y*=1.5;
		//	y*= 1.4;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			originalX = this.x;
			originalY = this.y;
			
			paraDepth = uint(this.name.charAt(1)) * 10;
			paraDepth += uint(this.name.charAt(2));
			
			if (this.name.charAt(0) == "F")
				paraDepth *= -1;
			
			paraDepthX100 = paraDepth;
			paraDepth /= 100;
			
			MovieClip(parent).addParallax(this);

		}
	}
	
}
