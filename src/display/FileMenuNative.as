package display 
{
	import as3d.display.Object3D;
	import as3d.loaders.DAELoader;
	import flash.events.Event;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	import flash.net.FileFilter;
	//import com.kl.utils.Log;
	import flash.filesystem.File;
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class FileMenuNative 
	{
		private var _stage:Stage;
		private var _menu:NativeMenu;
		private var _file:NativeMenuItem;
		private var _edit:NativeMenuItem;
		private var _create:NativeMenuItem;
		
		private var recentDocuments:Array = new Array(new File("app-storage:/GreatGatsby.pdf"),  
													  new File("app-storage:/WarAndPeace.pdf"),  
													  new File("app-storage:/Iliad.pdf")); 
		
		public function FileMenuNative() 
		{
			_stage = Config.stage;
			
			if (NativeWindow.supportsMenu)
			{
				_stage.nativeWindow.menu = new NativeMenu();
				_menu = _stage.nativeWindow.menu;
			}
			else if (NativeApplication.supportsMenu)
			{
				_menu = NativeApplication.nativeApplication.menu;
			}
			else
			{
				//Log.error("FileMenuNative() Native File Menu not supported!");
			}
			
			if (_menu)
			{
				
				_file = _menu.addItem(new NativeMenuItem("File"));
				_edit = _menu.addItem(new NativeMenuItem("Edit"));
				_create = _menu.addItem(new NativeMenuItem("Create"));
				_file.submenu = CreateFileMenu();
				_edit.submenu = CreateEditMenu();
				_create.submenu = CreateCreateMenu();
				
				_menu.addEventListener(Event.SELECT, selectCommandMenu); 
			}
		}
		
		private function CreateFileMenu():NativeMenu 
		{
			var fileMenu:NativeMenu = new NativeMenu(); 
            fileMenu.addEventListener(Event.SELECT, selectCommandMenu); 
             
            var newCommand:NativeMenuItem = fileMenu.addItem(new NativeMenuItem("New Project"));
            newCommand.addEventListener(Event.SELECT, selectCommand);
			var openCommand:NativeMenuItem = fileMenu.addItem(new NativeMenuItem("Open Project"));
			openCommand.keyEquivalent = "o";
			openCommand.addEventListener(Event.SELECT, selectCommand);
            var saveCommand:NativeMenuItem = fileMenu.addItem(new NativeMenuItem("Save Project")); 
            saveCommand.addEventListener(Event.SELECT, selectCommand); 
            var openRecentMenu:NativeMenuItem = fileMenu.addItem(new NativeMenuItem("Open Recent Project"));  
            openRecentMenu.submenu = new NativeMenu(); 
            openRecentMenu.submenu.addEventListener(Event.DISPLAYING, updateRecentDocumentMenu); 
            openRecentMenu.submenu.addEventListener(Event.SELECT, selectCommandMenu); 
			
			// seperator
			fileMenu.addItem(new NativeMenuItem("", true));
			
			// import
			var importCommand:NativeMenuItem = fileMenu.addItem(new NativeMenuItem("Import"));
			importCommand.keyEquivalent = "i";
			importCommand.addEventListener(Event.SELECT, selectCommand);
            
            return fileMenu; 
		}
		
		public function CreateEditMenu():NativeMenu
		{ 
            var editMenu:NativeMenu = new NativeMenu(); 
            editMenu.addEventListener(Event.SELECT, selectCommandMenu); 
             
            var copyCommand:NativeMenuItem = editMenu.addItem(new NativeMenuItem("Copy")); 
            copyCommand.addEventListener(Event.SELECT, selectCommand); 
            copyCommand.keyEquivalent = "c"; 
            var pasteCommand:NativeMenuItem = editMenu.addItem(new NativeMenuItem("Paste")); 
            pasteCommand.addEventListener(Event.SELECT, selectCommand); 
            pasteCommand.keyEquivalent = "v"; 
            editMenu.addItem(new NativeMenuItem("", true)); 
            var preferencesCommand:NativeMenuItem = editMenu.addItem(new NativeMenuItem("Preferences")); 
            preferencesCommand.addEventListener(Event.SELECT, selectCommand); 
             
            return editMenu; 
        } 
		
		public function CreateCreateMenu():NativeMenu
		{ 
            var createMenu:NativeMenu = new NativeMenu(); 
            createMenu.addEventListener(Event.SELECT, selectCommandMenu); 
             
            var planeCommand:NativeMenuItem = createMenu.addItem(new NativeMenuItem("Plane")); 
            planeCommand.addEventListener(Event.SELECT, selectCommand); 
            
			var cubeCommand:NativeMenuItem = createMenu.addItem(new NativeMenuItem("Cube")); 
            cubeCommand.addEventListener(Event.SELECT, selectCommand);  
            
            var sphereCommand:NativeMenuItem = createMenu.addItem(new NativeMenuItem("Sphere")); 
            sphereCommand.addEventListener(Event.SELECT, selectCommand); 
             
            return createMenu; 
        } 
		
		private function updateRecentDocumentMenu(event:Event):void
		{ 
            trace("Updating recent document menu."); 
            var docMenu:NativeMenu = NativeMenu(event.target); 
             
            for each (var item:NativeMenuItem in docMenu.items)
			{ 
                docMenu.removeItem(item); 
            } 
             
            for each (var file:File in recentDocuments)
			{ 
                var menuItem:NativeMenuItem = docMenu.addItem(new NativeMenuItem(file.name)); 
                menuItem.data = file; 
                menuItem.addEventListener(Event.SELECT, selectRecentDocument); 
            } 
        } 
		
		private function selectRecentDocument(event:Event):void
		{ 
            trace("Selected recent document: " + event.target.data.name); 
        } 
         
        private function selectCommand(event:Event):void { 
            trace("Selected command: " + event.target.label);
			switch (event.target.label) 
			{
				case "Import":
					var file:File = new File();
					var files3DFilter:FileFilter = new FileFilter("3D Files", "*.atf;*.jpg;*.png;*.dae;");
					file.addEventListener(Event.SELECT, HandleImportSelected);
					file.browseForOpen("Import 3D files", [files3DFilter]);
				break;
				default:
			}
        } 
		
		private function HandleImportSelected(e:Event):void 
		{
			var file:File = e.target as File;
			trace("FileMenuNative.HandleImportSelected() " + file.name + ", ext: " + file.extension);
			
			switch (file.extension) 
			{
				case "dae":
					var daeLoader:DAELoader = new DAELoader(file.nativePath);
					daeLoader.addEventListener(Event.COMPLETE, HandleDAELoaded);
					daeLoader.load();
					break;
					
				case "jpg":
					
					break;
					
				case "png":
					
					break;
					
				case "atf":
					
					break;
			}
		}
		
		private function HandleDAELoaded(e:Event):void 
		{
			var ld:DAELoader = e.target as DAELoader;
			for each (var child:Object3D in ld.children) 
			{
				AS3DConfig.tabMenu.addToHierarchy(child);
			}
			
		}
 
        private function selectCommandMenu(event:Event):void
		{ 
            if (event.currentTarget.parent != null)
			{ 
                var menuItem:NativeMenuItem = findItemForMenu(NativeMenu(event.currentTarget)); 
                if (menuItem != null) 
				{ 
                    trace("Select event for \"" + event.target.label + "\" command handled by menu: " + menuItem.label); 
                } 
            } 
			else
			{ 
                trace("Select event for \"" + event.target.label + "\" command handled by root menu."); 
            } 
        } 
		
		private function findItemForMenu(menu:NativeMenu):NativeMenuItem
		{ 
            for each (var item:NativeMenuItem in menu.parent.items) 
			{ 
                if (item != null) 
				{ 
                    if (item.submenu == menu) 
					{ 
                        return item; 
                    } 
                } 
            } 
            return null; 
        } 
		
	}

}