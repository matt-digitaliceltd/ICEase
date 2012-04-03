Please see http://www.iosconsultancy.co.uk/ICEase for more information about this framework.

"Framework" contains the source code

"Products" contains the file to drop into your project

#Installation

To use this framework in your application follow the steps below:

1. Drag the ICEase.framework (in the products folder) file to your project in Xcode and choose "Copy Items into Destination Groups Folder". Make sure you pick "Create groups for anyy added folders" and your desired targets are checked
2. Go to your target configuration (under the project file), and go to build setting and search for "Other Linker Flags"
3. In files you want to use the framework add the line `#import <ICEase/ICEase.h>` to the top of the file

#Modules

ICEase comes in a modular type system. Each feature will be called a module, mainly for documentation and tutorial purposes.

Current modules are below.

##Logging
Logging was the first module to be released for ICEase. You can read about it at this link:
http://www.iosconsultancy.co.uk/2012/04/03/icease-a-new-open-source-ios-framework/