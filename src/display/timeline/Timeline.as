package display.timeline 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.CapsStyle;
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class Timeline extends Sprite
	{
		
		public function Timeline() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			Draw();
		}
		
		private function Draw():void 
		{
			this.graphics.clear();
			this.graphics.beginFill(0xCCCCCC);
			this.graphics.drawRect(0, 0, stage.stageWidth - 352, 200);
			this.graphics.lineStyle(3, 0, 1, true, "none", CapsStyle.SQUARE, null, 1);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(stage.stageWidth - 352, 0);
			this.graphics.endFill();
		}
		
		public function resize(resizeWidth:Number):void 
		{
			this.graphics.clear();
			this.graphics.beginFill(0xCCCCCC);
			this.graphics.drawRect(0, 0, resizeWidth - 2, 200);
			this.graphics.lineStyle(3, 0, 1, true, "none", CapsStyle.SQUARE, null, 1);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(resizeWidth - 2, 0);
			this.graphics.endFill();
		}
	}

}