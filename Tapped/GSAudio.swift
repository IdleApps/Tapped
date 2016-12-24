//
//  GSAudio.swift
//  Tapped
//
//  Created by Luke Cheskin on 22/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

var shouldStop = false
var timer: Timer!

class GSAudio: NSObject, AVAudioPlayerDelegate {
    
    static let sharedInstance = GSAudio()
    
    private override init() {}
    
    var players = [NSURL:AVAudioPlayer]()
    
    func playSound (soundFileName: String){
        
        let soundFileNameURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: soundFileName, ofType: "mp3")!)
        
        if let player = players[soundFileNameURL] { // player for sound has been found
            
            if player.isPlaying == false { // player is not in use, so use that one
                print("The audio player is not in use. Playing soundtrack..")
                player.numberOfLoops = -1 // Infinite playing
                player.prepareToPlay()
                player.play()
                
                _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
                    (_) in
                    
                    if shouldStop == true {
                        player.stop()
                    }
                    
                    
                }
                
            } else { // player is in use, create a new, duplicate, player and use that instead
                
                print("The audio player is currently in use.")
                
                _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
                    (_) in
                    
                    if shouldStop == true {
                        player.stop()
                    }
                    
                    
                }
                
                
            }
        } else { // player has not been found, create a new player with the URL if possible
            do {
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL as URL)
                players[soundFileNameURL] = player
                player.numberOfLoops = -1 // Infinite playing
                player.prepareToPlay()
                player.play()
                
                _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
                    (_) in
                    
                    if shouldStop == true {
                        player.stop()
                    }
                    
                    
                }
                
            } catch {
                print("Could not play sound file!")
            }
        }
    }
    
    
    func playSounds(soundFileNames: [String]){
        
        for soundFileName in soundFileNames {
            playSound(soundFileName: soundFileName)
        }
    }
    
    func playSounds(soundFileNames: String...){
        for soundFileName in soundFileNames {
            playSound(soundFileName: soundFileName)
        }
    }
    
    func playSounds(soundFileNames: [String], withDelay: Double) { //withDelay is in seconds
        for (index, soundFileName) in soundFileNames.enumerated() {
            let delay = withDelay*Double(index)
            let _ = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(playSoundNotification(notification: )), userInfo: ["fileName":soundFileName], repeats: false)
        }
    }
    
    func playSoundNotification(notification: NSNotification) {
        if let soundFileName = notification.userInfo?["fileName"] as? String {
            playSound(soundFileName: soundFileName)
        }
    }
    
}
