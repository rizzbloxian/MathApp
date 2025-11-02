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
    
    // when the view appears, display the user's score before losing, and show the answer to the equation they failed to solve.
    override func viewDidAppear(_ animated: Bool) {
        scoreLabel.text = "Score: \(GameData.score)"
        answerLabel.text = "The Answer Was \(GameData.answer)"
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
