package display 
{
	import com.kl.ui.KLabel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class FileMenu extends Sprite
	{
		private var _fileLabel:KLabel;
		private var _catObj:Object = new Object();
		private var _cats:Vector.<Category> = new Vector.<Category>();
		
		public function FileMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.RESIZE, onResize);
			Draw();
		}
		
		public function addItem(category:String, subcategory:String):void 
		{
			if (_catObj[category] != undefined)
			{
				_catObj[category].push(subcategory);
			}
			else
			{
				_catObj[category] = [subcategory];
				CreateCategory(category);
			}
			
			UpdateItems();
		}
		
		private function CreateCategory(catName:String):void 
		{
			var cat:Category = new Category(catName);
			_cats.push(cat);
			addChild(cat);
		}
		
		private function UpdateItems():void 
		{
			var xPos:Number = 5;
			for each (var item:Category in _cats) 
			{
				item.y = 3;
				item.x = xPos;
				xPos += item.width + 5;
			}
			
			/*for (var key:String in _catObj)
			{
				trace("key: " + key);
			}*/
		}
		
		private function onResize(e:Event):void 
		{
			this.graphics.clear();
			Draw();
		}
		
		private function Draw():void 
		{
			var colors:Array = [0xFFFFFF, 0x999999];
			var alphas:Array = [1, 1];
			var ratios:Array = [127, 255];
			var matrix:Matrix = new Matrix()
			matrix.createGradientBox(stage.stageWidth, 40, 90/180*Math.PI);
			
			this.graphics.lineStyle(1.5, 0x666666, 1, true, "none");
			this.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix );
			this.graphics.drawRect(0, 0, stage.stageWidth, 30);
		}
		
	}

}

import flash.display.Sprite;
import flash.events.MouseEvent;
import com.kl.ui.KLabel;

internal class Category extends Sprite
{
	public function Category(title:String):void 
	{
		buttonMode = true;
		mouseChildren = false;
		this.graphics.beginFill(0x000000, 0);
		this.graphics.drawRect(-5, -5, width + 10, height + 10);
		addChild(new KLabel(title, 0x464646, 16));
		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
	}
	
	private function onMouseOver(e:MouseEvent):void 
	{
		this.graphics.clear();
		this.graphics.beginFill(0x000000, .10);
		this.graphics.drawRect(-5, -5, width + 10, height + 10);
		addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
	}
	
	private function onMouseOut(e:MouseEvent):void 
	{
		graphics.clear();
	}
}