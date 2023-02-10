package display 
{
	import as3d.display.Object3D;
	import com.kl.events.DEvent;
	import com.kl.ui.KButton;
	import com.kl.ui.KCheck;
	import com.kl.ui.KLabel;
	import com.kl.ui.KSpinner;
	import com.kl.ui.Tree;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.CapsStyle;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class TabMenu extends Sprite
	{
		private var _bar:Sprite;
		private var _tabs:Vector.<Tab> = new Vector.<Tab>();
		private var _selectedIndex:int = 0;
		private var _hierarchy:Tab;
		private var _hierarchyContent:Sprite;
		private var _propertiesContent:Sprite;
		private var _tree:Tree;
		private var _currentContent:DisplayObject;
		
		// position
		private var _xPos:KSpinner;
		private var _yPos:KSpinner;
		private var _zPos:KSpinner;
		
		// rotation
		private var _xRot:KSpinner;
		private var _yRot:KSpinner;
		private var _zRot:KSpinner;
		
		// scale
		private var _xScale:KSpinner;
		private var _yScale:KSpinner;
		private var _zScale:KSpinner;
		private var _scaleChk:KCheck;
		
		private var _applyBTN:KButton;
		
		// specular
		private var _power:KSpinner;
		private var _level:KSpinner;
		
		public function TabMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(Event.RESIZE, onResize);
			Draw();
			
			_bar = new Sprite();
			_bar.graphics.lineStyle(3, 0x464646, 1, true, "none", CapsStyle.SQUARE, null, 1);
			_bar.graphics.moveTo(3, 0);
			_bar.graphics.lineTo(350, 0);
			_bar.y = 28;
			addChild(_bar);
			
			_hierarchy = new Tab("Hierarchy", 0);
			_tabs.push(_hierarchy);
			
			_hierarchyContent = new Sprite();
			_tree = new Tree();
			_tree.addEventListener(Tree.TREE_ITEM_DELETED, onTreeItemDeleted);
			_tree.addEventListener(Tree.TREE_ITEM_CLICKED, onTreeItemClicked);
			for (var j:int = 0; j < 10; j++) 
			{
				_tree.addItem("TEST STUFF " + j).addItem("OTHER STUFF " + j).addItem("MORE ITEMS " + j);
			}
			_hierarchyContent.addChild(_tree);
			_hierarchyContent.x = 10;
			_hierarchyContent.y = 40;
			_hierarchy.content = _hierarchyContent;
			_currentContent = _hierarchyContent;
			addChild(_hierarchyContent);
			
			var properties:Tab = new Tab("Properties", 1);
			_tabs.push(properties);
			
			var posLabel:KLabel = new KLabel("Position:", 0xFFFFFF, 14);
			var rotLabel:KLabel = new KLabel("Rotation:", 0xFFFFFF, 14);
			var scaleLabel:KLabel = new KLabel("Scale:", 0xFFFFFF, 14);
			
			_propertiesContent = new Sprite();
			var xLabel:KLabel = new KLabel("X:", 0xFFFFFF);
			var yLabel:KLabel = new KLabel("Y:", 0xFFFFFF);
			var zLabel:KLabel = new KLabel("Z:", 0xFFFFFF);
			_xPos = new KSpinner(60, 20, .2, 2);
			_yPos = new KSpinner(60, 20, .2, 2);
			_zPos = new KSpinner(60, 20, .2, 2);
			_xPos.y = _yPos.y = _zPos.y = 20;
			_xPos.x = 40;
			_yPos.x = _xPos.x + _xPos.width + 20;
			_zPos.x = _yPos.x + _xPos.width + 20;
			_xPos.addEventListener(Event.CHANGE, onSpinnerChange);
			_yPos.addEventListener(Event.CHANGE, onSpinnerChange);
			_zPos.addEventListener(Event.CHANGE, onSpinnerChange);
			xLabel.y = yLabel.y = zLabel.y = 20;
			xLabel.x = _xPos.x - 15;
			yLabel.x = _yPos.x - 15;
			zLabel.x = _zPos.x - 15;
			
			var rotXLabel:KLabel = new KLabel("X:", 0xFFFFFF);
			var rotYLabel:KLabel = new KLabel("Y:", 0xFFFFFF);
			var rotZLabel:KLabel = new KLabel("Z:", 0xFFFFFF);
			_xRot = new KSpinner(60, 20, 1, 2);
			_yRot = new KSpinner(60, 20, 1, 2);
			_zRot = new KSpinner(60, 20, 1, 2);
			_xRot.y = _yRot.y = _zRot.y = 80;
			_xRot.x = 40;
			_yRot.x = _xRot.x + _xRot.width + 20;
			_zRot.x = _yRot.x + _yRot.width + 20;
			_xRot.addEventListener(Event.CHANGE, onSpinnerChange);
			_yRot.addEventListener(Event.CHANGE, onSpinnerChange);
			_zRot.addEventListener(Event.CHANGE, onSpinnerChange);
			rotXLabel.y = rotYLabel.y = rotZLabel.y = 80;
			rotXLabel.x = _xRot.x - 15;
			rotYLabel.x = _yPos.x - 15;
			rotZLabel.x = _zPos.x - 15;
			
			var scXLabel:KLabel = new KLabel("X:", 0xFFFFFF);
			var scYLabel:KLabel = new KLabel("Y:", 0xFFFFFF);
			var scZLabel:KLabel = new KLabel("Z:", 0xFFFFFF);
			_xScale = new KSpinner(60, 20, .2, 3);
			_yScale = new KSpinner(60, 20, .2, 3);
			_zScale = new KSpinner(60, 20, .2, 3);
			_xScale.y = _yScale.y = _zScale.y = 140;
			_xScale.x = 40;
			_yScale.x = _xScale.x + _xScale.width + 20;
			_zScale.x = _yScale.x + _yScale.width + 20;
			_xScale.addEventListener(Event.CHANGE, onSpinnerChange);
			_yScale.addEventListener(Event.CHANGE, onSpinnerChange);
			_zScale.addEventListener(Event.CHANGE, onSpinnerChange);
			scXLabel.y = scYLabel.y = scZLabel.y = 140;
			scXLabel.x = _xScale.x - 15;
			scYLabel.x = _yScale.x - 15;
			scZLabel.x = _zScale.x - 15;
			
			// lock scale ratio
			_scaleChk = new KCheck();
			_scaleChk.x = this.width / 2;
			_scaleChk.y = 170;
			var scaleLockLabel:KLabel = new KLabel("Scale Lock: ", 0xFFFFFF);
			scaleLockLabel.x = _scaleChk.x - scaleLockLabel.width;
			scaleLockLabel.y = 170;
			
			posLabel.y = _xPos.y - _xPos.height;
			rotLabel.y = _xRot.y - _xRot.height;
			scaleLabel.y = _xScale.y - _xScale.height;
			
			_applyBTN = new KButton("Apply Transforms", 10);
			_applyBTN.y = _scaleChk.y + _scaleChk.height + 10;
			_applyBTN.x = this.width - _applyBTN.width - 30;
			
			// specular
			var specularLabel:KLabel = new KLabel("Specular:", 0xFFFFFF, 14);
			specularLabel.y = _applyBTN.y + _applyBTN.height;
			_power = new KSpinner(60, 20, 1);
			_level = new KSpinner(60, 20, .05, 2);
			_power.value = 50;
			_level.value = 1;
			_power.addEventListener(Event.CHANGE, onSpinnerChange);
			_level.addEventListener(Event.CHANGE, onSpinnerChange);
			_power.y = _level.y = specularLabel.y;
			_power.x = specularLabel.width + 10;
			_level.x = _power.x  + _power.width + 10;
			
			_propertiesContent.addChild(posLabel);
			_propertiesContent.addChild(rotLabel);
			_propertiesContent.addChild(scaleLabel);
			_propertiesContent.addChild(_xPos);
			_propertiesContent.addChild(_yPos);
			_propertiesContent.addChild(_zPos);
			_propertiesContent.addChild(_xRot);
			_propertiesContent.addChild(_yRot);
			_propertiesContent.addChild(_zRot);
			_propertiesContent.addChild(_xScale);
			_propertiesContent.addChild(_yScale);
			_propertiesContent.addChild(_zScale);
			_propertiesContent.addChild(xLabel);
			_propertiesContent.addChild(yLabel);
			_propertiesContent.addChild(zLabel);
			_propertiesContent.addChild(rotXLabel);
			_propertiesContent.addChild(rotYLabel);
			_propertiesContent.addChild(rotZLabel);
			_propertiesContent.addChild(scXLabel);
			_propertiesContent.addChild(scYLabel);
			_propertiesContent.addChild(scZLabel);
			_propertiesContent.addChild(_scaleChk);
			_propertiesContent.addChild(scaleLockLabel);
			_propertiesContent.addChild(_applyBTN);
			_propertiesContent.addChild(specularLabel);
			_propertiesContent.addChild(_power);
			_propertiesContent.addChild(_level);
			_propertiesContent.x = 10;
			_propertiesContent.y = 40;
			properties.content = _propertiesContent;
			
			
			var materials:Tab = new Tab("Materials", 2);
			_tabs.push(materials);
			
			var animations:Tab = new Tab("Animations", 3);
			_tabs.push(animations);
			
			var sounds:Tab = new Tab("Sounds", 4);
			_tabs.push(sounds);
			
			OrderTabs();
		}
		
		private function onSpinnerChange(e:Event):void 
		{
			if (!_tree.selectedItem) return;
			
			var spinner:KSpinner = e.target as KSpinner;
			var obj:Object3D = _tree.selectedItem.info as Object3D;
			
			if (!obj) return;
			
			switch (spinner) 
			{
				case _xPos:
					obj.x = _xPos.value;
					break;
					
				case _yPos:
					obj.y = _yPos.value;
					break;
					
				case _zPos:
					obj.z = _zPos.value;
					break;
					
				case _xRot:
					obj.rotationX = _xRot.value;
					break;
					
				case _yRot:
					obj.rotationY = _yRot.value;
					break;
					
				case _zRot:
					obj.rotationZ = _zRot.value;
					break;
					
				case _xScale:
					obj.scaleX = _xScale.value;
					if (_scaleChk.checked)
					{
						obj.scaleY = _xScale.value;
						obj.scaleZ = _xScale.value;
						_yScale.value = _xScale.value;
						_zScale.value = _xScale.value;
					}
					break;
					
				case _yScale:
					obj.scaleY = _yScale.value;
					if (_scaleChk.checked)
					{
						obj.scaleX = _yScale.value;
						obj.scaleZ = _yScale.value;
						_xScale.value = _yScale.value;
						_zScale.value = _yScale.value;
					}
					break;
					
				case _zScale:
					obj.scaleZ = _zScale.value;
					if (_scaleChk.checked)
					{
						obj.scaleX = _zScale.value;
						obj.scaleY = _zScale.value;
						_xScale.value = _zScale.value;
						_yScale.value = _zScale.value;
					}
					break;
					
				case _power:
					obj.specularPower = _power.value;
					break;
					
				case _level:
					obj.specularLevel = _level.value;
					break;
			}
		}
		
		private function onTreeItemClicked(e:Event):void 
		{
			trace("Selected Item: " + _tree.selectedItem.name);
			var obj:Object3D = _tree.selectedItem.info as Object3D;
			if (!obj) return;
			
			_xPos.value = obj.x;
			_yPos.value = obj.y;
			_zPos.value = obj.z;
			_xRot.value = obj.rotationX;
			_yRot.value = obj.rotationY;
			_zRot.value = obj.rotationZ;
			_xScale.value = obj.scaleX;
			_yScale.value = obj.scaleY;
			_zScale.value = obj.scaleZ;
		}
		
		private function onTreeItemDeleted(e:DEvent):void 
		{
			Config.scene.removeChild(e.data);
		}
		
		private function OrderTabs():void 
		{
			var posX:Number = 8;
			for each (var tab:Tab in _tabs) 
			{
				tab.mouseEnabled = (tab.index != _selectedIndex);
				tab.addEventListener(MouseEvent.CLICK, onTabClicked);
				tab.x = posX;
				tab.y = 8;
				tab.active = false;
				posX += tab.width + 2;
				addChild(tab);
			}
			
			_tabs[_selectedIndex].active = true;
			addChild(_bar);
			addChild(_tabs[_selectedIndex]);
		}
		
		private function onTabClicked(e:MouseEvent):void 
		{
			var tab:Tab = e.target as Tab;
			_selectedIndex = tab.index;
			OrderTabs();
			
			if (_currentContent && this.contains(_currentContent)) removeChild(_currentContent);
			if (tab.content) addChild(tab.content);
			_currentContent = tab.content;
		}
		
		private function Draw():void 
		{
			this.graphics.clear();
			this.graphics.beginFill(0x666666);
			this.graphics.drawRect(0, 0, 350, stage.stageHeight);
			this.graphics.lineStyle(3, 0, 1, true, "none", CapsStyle.SQUARE, null, 1);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(0, stage.stageHeight);
			this.graphics.endFill();
		}
		
		private function onResize(e:Event):void 
		{
			Draw();
		}
		
		public function addToHierarchy(obj:Object3D, treeNode:* = "root"):void 
		{
			var node:*;
			if (treeNode == "root")
			{
				node = _tree.addItem(obj.name, "root", obj);
			}
			else
			{
				node = treeNode.addItem(obj.name, obj);
			}
			
			for (var i:int = 0; i < obj.numChildren; i++) 
			{
				addToHierarchy(obj.children[i], node);
			}
		}
	}

}