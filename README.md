ofStateManagerCocoa
===================

Cocoa GUI wrapper for Christoph Buchner's ofStateManager script   
[https://github.com/bilderbuchi/ofStateManager](https://github.com/bilderbuchi/ofStateManager)

ofStateManagerCocoa by Memo Akten   
[https://github.com/memo/ofStateManagerCocoa](https://github.com/memo/ofStateManagerCocoa)

context:   
[http://forum.openframeworks.cc/index.php/topic,11559.msg51285.html](http://forum.openframeworks.cc/index.php/topic,11559.msg51285.html)

In summary, this is a tool to - for any selected openFrameworks project:  

1. Record a snapshot of the state (i.e. git commit ID) for every involved component for the project (the project itself, openFrameworks, and any used addons). This state information is stored in a JSON file, by default, along with the project in the project folder. 

2. Later, load that JSON file and restore the states for all involved components - effectively reverting all components to the states which were known to compile and run successfully for that particular project. 

3. Similar, later load that JSON file, restore the states for all involved components but copying and collecting them into a separate folder; creating a self-contained archive of your project and all required components. As a stand-alone, minimal (containing only the files you need) source repository, ready for backing up or distributing.  



Instructions
===================

Place bilderbuchi's ofStateManager folder containing the python scripts next to the ofStateManagerCocoa.app application bundle, and run ofStateManagerCocoa.app. 

i.e. the folder structure should be:   
./ofStateManagerCocoa.app   
./ofStateManager/  
./ofStateManager/ofStateManager.py etc.

The GUI is pretty straightforward and just reflects the python script parameters. Refer to bilderbuchi's instructions. 


Known Issues
===================
If the script terminates with an error (e.g. if the project path can't be found, one of the components has uncommitted changes, or doesn't have a git repo), the GUI doesn't know why the error occured, only that an error did occur. This isn't very helpful, you need to check in terminal what went wrong. (I can capture the terminal output if the script completes successfully, I can't capture the terminal output if the script fails). Looking for a fix.
