//
//  MusicManager.swift
//  MathGame
//
//  Created by Vincent Tsui on 2/11/2025.
//

import AVFoundation
class MusicManager {
    static var backgroundSound: AVAudioPlayer?
    static var isMuted: Bool = false
    static let backgroundSoundFile = "Kubbi - Digestive biscuit ♫ NO COPYRIGHT 8-bit Music"
    static let backgroundSoundType = "mp3"
    static func playBackgroundSound() {
        guard let path = Bundle.main.path(forResource: backgroundSoundFile, ofType: backgroundSoundType) else {
            print ("Error: Sound file '\(backgroundSoundFile).\(backgroundSoundType)' not found in bundle.")
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            backgroundSound = try AVAudioPlayer(contentsOf: url)
            backgroundSound?.numberOfLoops = -1
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

