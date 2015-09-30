# drakonoid
Android adapted version of Drakon Editor

#================================================================================
Drakonoid - Android version of Drakon Editor software
Now it reuses Androwish runtime
#================================================================================

Requirements:

Android SDK (version 12 or later)
http://developer.android.com/sdk/index.html

Minimum API level supported by SDL: 10 (Android 2.3.3)
Requested API level from project.properties: 14 (Android 4.0)
CPUs supported for native shared libraries (jni/Application.mk): armeabi x86
Joystick support is available for API level >=12 devices.

================================================================================
 How it works
================================================================================

- This project is TCL/tk application re-using the installed components of AndroWish in another app
- The required Java code is an empty class deriving from tk.tcl.wish.AndroWish
- Tcl code of Drakonoid should be placed below .../assets/app and gets mounted
  on runtime as /assets/assets/app
- The main entry script must be .../assets/app/main.tcl
- To refer to your packaged Tcl files [file dirname [info script]] should be
  used

================================================================================
 Building the package
================================================================================

1. Refresh the project settings using the android command from Android SDK:

   android update project

2. Review local.properties to point to the directory where Android SDK resides

3. Use ant to build the project:

      ant debug

4. Install Drakonoid on emulator or device:

   adb install -r bin/Drakonoid-debug.apk

5. Start Drakonoid on emulator or device using adb from development system:

   adb shell am start tk.tcl.Drakonoid

6. Clean the build tree:

   ant clean

