SoundMachine
============

A easy way to play system sounds in an iOS app. This allows for performant playing of .wav files easily.

Setup
=====

* Drag in SGSoundMachine.h and SGSoundMachine.m into your app bundle
* Link the framework AudioToolbox into your bundle
* Create a folder called "Sounds" and drag into your bundle. Make sure to select "Create folder references for any added folders"

Usage
=====

* For any place that you want to play a sound, import SGSoundMachine.h
* Then call `-(void)playSoundWithName:(NSString *)soundName` with the soundName being the file name of the sound you want to play. (e.g. `[[SGSoundMachine soundMachine] playSoundWithName:@"test"];`)

Notes
======

* If you want to mute the soundMachine, set it's `soundIsOff` property which is a `BOOL`.
* To prevent any lag during the first playing of a sound, it's okay to call `[SGSoundMachine soundMachine]` at `- (void)applicationDidFinishLaunching:(UIApplication *)application`.
* If you get any errors including `-1500`, the wav may not be in a format that the iOS device can handle. Try resaving in QuickTime and reimporting.

Let me know if you have any feedback!
