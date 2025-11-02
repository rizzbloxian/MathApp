//
//  GameViewController.swift
//  MathGame
//
//  Created by Saeed Rahman on 2/10/2025.
//

import UIKit
import AVFoundation
class GameViewController: UIViewController {
    
    var rand1 = 0
    var rand2 = 0
    var isTimerRunning = Bool()
    var timeRemaining = 30
    var timer = Timer()
    var lives = 5
    var guess = ""
    var correctSound: AVAudioPlayer?
    var wrongSound: AVAudioPlayer?
    let wrongSoundFile = "131657__bertrof__game-sound-wrong"
    let wrongSoundType = "wav"
    let correctSoundFile = "654321__gronkjaer__correctch_new"
    let correctSoundTyoe = "mp3"

    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var equationLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var checkAnswerButton: UIButton!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    func playCorrectSound() {
        guard let path = Bundle.main.path(forResource: correctSoundFile, ofType: correctSoundTyoe) else {
            print ("Error: Sound file '\(correctSoundFile).\(correctSoundTyoe)' not found in bundle.")
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            correctSound = try AVAudioPlayer(contentsOf: url)
            correctSound?.play()
        } catch {
            // file not loaded
        }
            
    }
    
    func playIncorrectSound() {
        guard let path = Bundle.main.path(forResource: wrongSoundFile, ofType: wrongSoundType) else {
            print ("Error: Sound file '\(wrongSoundFile).\(wrongSoundType)' not found in bundle.")
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            wrongSound = try AVAudioPlayer(contentsOf: url)
            wrongSound?.play()
        } catch {
            // file not loaded
        }
    }
    
    @objc func countdown() {
    timeRemaining = timeRemaining - 1
        timerLabel.text = "Time: \(timeRemaining)"
        
        if timeRemaining < 1 {
            GameOver()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
        isTimerRunning = true
        if timeRemaining == 0 {
            timeRemaining = 0
            GameOver()
        }
            
    }
    @IBAction func checkAnswerAction(_ sender: Any) {
        guess = inputTextField.text!
        if guess == String(GameData.answer){
            GameData.score += 1
            scoreLabel.text = "Score: \(GameData.score)"
            feedbackLabel.text = "Correct!"
            inputTextField.text = ""
            playCorrectSound()
            NewEquation()
            timeRemaining = 31
        } else {
            lives -= 1
            
            if lives == 0 {
                playIncorrectSound()
                GameOver()
            } else {
                feedbackLabel.text = "Wrong! Try again."
                inputTextField.text = ""
                playIncorrectSound()
            }
            livesLabel.text = "Lives: \(lives)"
        }
    }
    @IBAction func homeScreenAction(_ sender: Any) {
    }
    @IBAction func newGameAction(_ sender: Any) {
        lives = 5
        livesLabel.text = "Lives: \(lives)"
        GameData.score = 0
        scoreLabel.text = "Score: \(GameData.score)"
        NewEquation()
        checkAnswerButton.isEnabled = true
        feedbackLabel.text = ""
        inputTextField.text = ""
    }
    
    func GameOver(){
        feedbackLabel.text = "Game Over! Your score is \(GameData.score)"
        checkAnswerButton.isEnabled = false
        GameData.recentScores.insert(GameData.score, at: 0)
        performSegue(withIdentifier: "showGameOverVC", sender: self)
        
    }
    func NewEquation(){
        //generate random numbers for the equation between 1 and 20
        rand1 = Int.random(in: 1...20)
        rand2 = Int.random(in: 1...20)
        //stores answer to be able to compare user's output when checking answer.
        GameData.answer = rand1 * rand2
        // display equation in equationLabel
        equationLabel.text = "\(rand1) x \(rand2)"
    }
    override func viewDidAppear(_ animated: Bool) {
        NewEquation()
        runTimer()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
