//
//  ViewController.swift
//  MathGame
//
//  Created by Saeed Rahman on 2/10/2025.
//

import UIKit
import AVFoundation
class HomeScreenViewController: UIViewController {
    
    
    
    
    // play button press feedback sounds on press of buttons
    @IBAction func startAction(_ sender: Any) {
        MusicManager.playButtonSelectSound()
    }
    
    @IBAction func scoresAction(_ sender: Any) {
        MusicManager.playButtonSelectSound()
    }
    
    @IBOutlet weak var toggleMusicSwitch: UISwitch!
    // mute button
    @IBAction func toggleMusicAction(_ sender: Any) {
        MusicManager.playButtonSelectSound()
        MusicManager.toggleMute()
        
    }
    // play background music when the view loads.
    override func viewDidLoad() {
        toggleMusicSwitch.isOn = !MusicManager.isMuted
        MusicManager.playBackgroundSound()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

