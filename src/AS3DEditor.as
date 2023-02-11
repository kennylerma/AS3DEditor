package
{
	import as3d.display.Object3D;
	import as3d.loaders.DAELoader;
	import as3d.primitives.Cube;
	import as3d.primitives.Lines3D;
	import as3d.primitives.Plane;
	import as3d.primitives.Sphere;
	import display.FileMenu;
	import display.FileMenuNative;
	import display.TabMenu;
	import display.timeline.Timeline;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Capabilities;
	import as3d.display.Scene3D;
	import Config;
	
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class AS3DEditor extends Sprite 
	{
		private var _scene:Scene3D;
		private var _fileMenu:FileMenu;
		private var _fileMenuNative:FileMenuNative;
		private var _tabMenu:TabMenu;
		private var _timeline:Timeline;
		
		public function AS3DEditor() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageWidth = Capabilities.screenResolutionX;
			stage.stageHeight = Capabilities.screenResolutionY - 80;
			
			init();
		}
		
		private function init():void 
		{
			_scene = new Scene3D(this);
			_scene.bgColor(0.2, 0.2, 0.2);
			_scene.camera.near = 0.1;
			_scene.camera.far = 10000;
			_scene.addEventListener(Scene3D.SCENE_READY, onSceneReady);
			
			_fileMenuNative = new FileMenuNative();
			
			/*_fileMenu = new FileMenu();
			_fileMenu.addItem("File", "Open File");
			_fileMenu.addItem("Edit", "Poop");
			_fileMenu.addItem("View", "Grid");
			_fileMenu.addItem("Export", "AS3D");
			addChild(_fileMenu);*/
			
			_tabMenu = new TabMenu();
			addChild(_tabMenu);
			_tabMenu.x = stage.stageWidth - _tabMenu.width;
			AS3DConfig.tabMenu = _tabMenu;
			
			_timeline = new Timeline();
			addChild(_timeline);
			_timeline.y = stage.stageHeight - _timeline.height;
			
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function onSceneReady(e:Event):void 
		{
			_scene.x = ((stage.stageWidth - 350) - _scene.width) / 2;
			_scene.y = ((stage.stageHeight - 200) - _scene.height) / 2;
			
			var daeLoader:DAELoader = new DAELoader("assets/AxeOnly.dae");
			daeLoader.addEventListener(Event.COMPLETE, HandleDAELoaded);
			daeLoader.load();
			
			/*var daeLoader2:DAELoader = new DAELoader("assets/light.dae");
			daeLoader2.load();
			*/
			
			/*var plane:Plane = new Plane("My Plane", 150, 150);
			plane.moveDown(10);
			_scene.addChild(plane);
			_tabMenu.addToHierarchy(plane);*/
			
			var cube:Cube = new Cube("My Cube", 10);
			cube.moveUp(25);
			cube.moveForward(50);
			cube.moveRight(12);
			_scene.addChild(cube);
			_tabMenu.addToHierarchy(cube);
			
			var sphere:Sphere = new Sphere("My Sphere", 100, 100);
			sphere.scale(7);
			sphere.moveUp(.5);
			sphere.moveForward(.5);
			sphere.rotateY(180);
			sphere.moveRight(2);
			_scene.addChild(sphere);
			_tabMenu.addToHierarchy(sphere);
			
			var lines:Lines3D = new Lines3D();
			//_scene.addChild(lines);
		}
		
		private function HandleDAELoaded(e:Event):void 
		{
			var ld:DAELoader = e.target as DAELoader;
			for each (var child:Object3D in ld.children) 
			{
				_tabMenu.addToHierarchy(child);
			}
			
		}
		
		private function onResize(e:Event):void 
		{
			_tabMenu.x = stage.stageWidth - _tabMenu.width;
			_timeline.y = stage.stageHeight - _timeline.height;
			_timeline.resize(stage.stageWidth - _tabMenu.width);
			_scene.x = ((stage.stageWidth - 350) - _scene.width) / 2;
			_scene.y = ((stage.stageHeight - 200) - _scene.height) / 2;
		}
		
	}
	
}