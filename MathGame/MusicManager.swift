//
//  MusicManager.swift
//  MathGame
//
//  Created by Vincent Tsui on 2/11/2025.
//

import AVFoundation
class MusicManager {
    static var buttonSelectSound: AVAudioPlayer?
    static var backgroundSound: AVAudioPlayer?
    static var isMuted: Bool = false
    static let backgroundSoundFile = "Kubbi - Digestive biscuit ♫ NO COPYRIGHT 8-bit Music"
    static let backgroundSoundType = "mp3"
    static let buttonSelectSoundFile = "gameSelectSound"
    static let buttonSelectSoundType = "mp3"
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
    static func playBackgroundSound() {
        guard let path = Bundle.main.path(forResource: backgroundSoundFile, ofType: backgroundSoundType) else {
            print ("Error: Sound file '\(backgroundSoundFile).\(backgroundSoundType)' not found in bundle.")
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            backgroundSound = try AVAudioPlayer(contentsOf: url)
            backgroundSound?.numberOfLoops = -1
            backgroundSound?.volume = 0.1
            backgroundSound?.play()
            
            if !isMuted {
                backgroundSound?.play()
            } else
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

