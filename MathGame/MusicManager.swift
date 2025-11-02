//
//  MusicManager.swift
//  MathGame
//
//  Created by Vincent Tsui on 2/11/2025.
//

import AVFoundation
class MusicManager {
    
    // inistializing sound file names and extensions
    static var buttonSelectSound: AVAudioPlayer?
    static var backgroundSound: AVAudioPlayer?
    static var isMuted: Bool = false
    static let backgroundSoundFile = "Kubbi - Digestive biscuit ♫ NO COPYRIGHT 8-bit Music"
    static let backgroundSoundType = "mp3"
    static let buttonSelectSoundFile = "gameSelectSound"
    static let buttonSelectSoundType = "mp3"
    
    // creating universal function to play sound on button presses
    static func playButtonSelectSound() {
        guard let path = Bundle.main.path(forResource: buttonSelectSoundFile, ofType: buttonSelectSoundType) else {
            print ("Error: Sound file '\(buttonSelectSoundFile).\(buttonSelectSoundType)' not found in bundle.")
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            buttonSelectSound = try AVAudioPlayer(contentsOf: url)
            buttonSelectSound?.play()
        } catch {
            
        }
    }
    
    //creating universal function to play background music
    static func playBackgroundSound() {
        guard let path = Bundle.main.path(forResource: backgroundSoundFile, ofType: backgroundSoundType) else {
            // print error if sound file is not found
            print ("Error: Sound file '\(backgroundSoundFile).\(backgroundSoundType)' not found in bundle.")
            return
        }
        // creating URL to point to location of sound file
        let url = URL(fileURLWithPath: path)
        do {
            backgroundSound = try AVAudioPlayer(contentsOf: url)
            // set amount of loops to -1 to loop audio infinitely
            backgroundSound?.numberOfLoops = -1
            // adjusting volume of background music to ensure button sounds can still be heard
            backgroundSound?.volume = 0.2
            backgroundSound?.play()
            
            
            if !isMuted {
                // if the music is not muted, play the background music
                backgroundSound?.play()
            } else
                // if the music is muted, stop playing
                {backgroundSound?.stop()}
        } catch {
            // file not loaded
        }

    }
    static func toggleMute() {
        if isMuted {
            backgroundSound?.play()
            isMuted = false
        } else {
            backgroundSound?.pause()
            isMuted = true
        }
    }
}

