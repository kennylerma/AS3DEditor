package display 
{
	import com.kl.ui.KLabel;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class Tab extends Sprite
	{
		private var _index:int = 0;
		private var _content:DisplayObject;
		private var _label:KLabel;
		private var _active:Boolean = false;
		
		public function Tab(title:String, index:int = 0) 
		{
			_index = index;
			
			_label = new KLabel(title, 0xFFFFFF, 12);
			var tf:TextFormat = _label.getTextFormat();
			tf.letterSpacing += .5
			_label.setTextFormat(tf);
			addChild(_label);
			
			Draw();
			
			mouseChildren = false;
			buttonMode = true;
		}
		
		private function Draw():void 
		{
			this.graphics.clear();
			this.graphics.beginFill((_active) ? 0x666666 : 0x4F4F4F);
			this.graphics.lineStyle(3, 0x464646, 1, true, LineScaleMode.NONE, CapsStyle.SQUARE);
			this.graphics.moveTo( -3, _label.height + 6);
			this.graphics.lineTo( -3, -3);
			this.graphics.lineTo(_label.width + 3, -3);
			this.graphics.lineTo(_label.width + 3, _label.height + 6);
			
			this.graphics.lineStyle(3, 0x666666, 1, true, LineScaleMode.NONE, CapsStyle.SQUARE);
			this.graphics.moveTo(_label.width,  _label.height + 6);
			this.graphics.lineTo(0, _label.height + 6);
			this.graphics.endFill();
		}
		
		public function get index():int 
		{
			return _index;
		}
		
		public function get content():DisplayObject 
		{
			return _content;
		}
		
		public function set content(value:DisplayObject):void 
		{
			_content = value;
		}
		
		public function get active():Boolean 
		{
			return _active;
		}
		
		public function set active(value:Boolean):void 
		{
			_active = value;
			Draw();
		}
	}

}