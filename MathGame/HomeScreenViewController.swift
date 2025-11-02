//
//  ViewController.swift
//  MathGame
//
//  Created by Saeed Rahman on 2/10/2025.
//

import UIKit
import AVFoundation
class HomeScreenViewController: UIViewController {
    
    
    
    
    
    @IBAction func startAction(_ sender: Any) {
        MusicManager.playButtonSelectSound()
    }
    
    @IBAction func scoresAction(_ sender: Any) {
        MusicManager.playButtonSelectSound()
    }
    
    @IBAction func toggleMusicAction(_ sender: Any) {
        MusicManager.toggleMute()
    }
    override func viewDidLoad() {
        MusicManager.playBackgroundSound()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

