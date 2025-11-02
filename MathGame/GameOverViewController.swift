//
//  GameOverViewController.swift
//  MathGame
//
//  Created by Saeed Rahman on 2/10/2025.
//

import UIKit

class GameOverViewController: UIViewController {

    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        scoreLabel.text = "Score: \(GameData.score)"
        answerLabel.text = "The Answer Was \(GameData.answer)"
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
