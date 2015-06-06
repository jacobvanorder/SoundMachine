//
//  SGSoundMachine.swift
//  SoundMachine
//
//  Created by mrJacob on 9/14/14.
//  Copyright (c) 2014 sushiGrass. All rights reserved.
//

import UIKit

import AudioToolbox

private let _soundMachine = SoundMachine()
public class SoundMachine: NSObject {
    
    public var soundIsOff : Bool = false
    
    private var soundDictionary : [NSString : NSNumber]
    
    class var sharedInstance: SoundMachine {
        return _soundMachine
    }
    override init() {
        var temporaryDictionary = [NSString : NSNumber]()
        
        if let newSoundPath = NSBundle.mainBundle().resourcePath {
            let appendedSoundPath = newSoundPath.stringByAppendingPathComponent("Sounds")
            
            var pathError : NSError? = nil
            
            let soundFileNameArray = NSFileManager.defaultManager().contentsOfDirectoryAtPath(appendedSoundPath, error:&pathError) as! [NSString]
            
            for rawFileName in soundFileNameArray {
                let fileName = rawFileName.stringByDeletingPathExtension
                let fullFileName = "Sounds/" + fileName;
                if let soundPath = NSBundle.mainBundle().pathForResource(fullFileName, ofType:"wav") {
                    let soundURL = NSURL.fileURLWithPath(soundPath)
                    var soundID : SystemSoundID = 0 as SystemSoundID
                    var error = AudioServicesCreateSystemSoundID(soundURL, &soundID)
                    
                    if soundID != 0 {
                        temporaryDictionary[fileName] = NSNumber(unsignedInt: soundID)
                    }
                    else {
                        NSLog("Could not load \(soundURL), error code \(error)")
                    }
                }
                else {
                    NSLog("Sound path \(fullFileName) not valid")
                }
            }
        }
        
        self.soundDictionary = temporaryDictionary
        
        super.init()
    }
    
    public func playSoundWithName (soundName : String) {
        if self.soundIsOff == false {
            if let soundIDNumber = soundDictionary[soundName] {
                let soundID = soundIDNumber.unsignedIntValue as SystemSoundID
                AudioServicesPlaySystemSound(soundID)
            }
        }
    }
}
