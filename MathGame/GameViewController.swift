//
//  GameViewController.swift
//  MathGame
//
//  Created by Saeed Rahman on 2/10/2025.
//

import UIKit
import AVFoundation
class GameViewController: UIViewController {
    
    // inistialize values
    
    var rand1 = 0
    var rand2 = 0
    var isTimerRunning = Bool()
    var timeRemaining = 30
    var timer = Timer()
    var lives = 5
    var guess = ""
    // inistialize sound file locations
    var losingSound: AVAudioPlayer?
    var correctSound: AVAudioPlayer?
    var wrongSound: AVAudioPlayer?
    let losingSoundFile = "270329__littlerobotsoundfactory__jingle_lose_00"
    let losingSoundType = "wav"
    let wrongSoundFile = "131657__bertrof__game-sound-wrong"
    let wrongSoundType = "wav"
    let correctSoundFile = "654321__gronkjaer__correctch_new"
    let correctSoundType = "mp3"

    // outlets for labels, text fields, and buttons
    
    @IBOutlet weak var toggleMusicSwitch: UISwitch!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var equationLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var checkAnswerButton: UIButton!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    
    @IBAction func toggleMusicAction(_ sender: Any) {
        MusicManager.playButtonSelectSound()
        MusicManager.toggleMute()
    }
    
    // function to play losing sound file
    func playLosingSound() {
        guard let path = Bundle.main.path(forResource: losingSoundFile, ofType: losingSoundType) else {
            print ("Error: Sound file '\(losingSoundFile).\(losingSoundType)' not found in bundle.")
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            losingSound = try AVAudioPlayer(contentsOf: url)
            losingSound?.play()
        } catch {
            // file not loaded
        }
    }
    // function to play sound file to indicate user is correct
    func playCorrectSound() {
        guard let path = Bundle.main.path(forResource: correctSoundFile, ofType: correctSoundType) else {
            print ("Error: Sound file '\(correctSoundFile).\(correctSoundType)' not found in bundle.")
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
    // function to play sound file to indicate user is incorrect
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
    
    // function to make time remaining decrease by 1, and when time remaining is equal to 0
    @objc func countdown() {
    timeRemaining = timeRemaining - 1
        timerLabel.text = "Time: \(timeRemaining)"
        
        if timeRemaining == 0 {
            isTimerRunning = false
            GameOver()
        }
    }
    
    //function to run timer, which calls on the countdown function every second
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
        isTimerRunning = true
        if timeRemaining == 0 {
            timeRemaining = 0
            GameOver()
        }
            
    }
    // button function to check if the user is correct
    @IBAction func checkAnswerAction(_ sender: Any) {
        guess = inputTextField.text!
        // if user is correct, add 1 to the user's score and display "Correct!" in the feedback label, and clear the user's input text field
        if guess == String(GameData.answer){
            GameData.score += 1
            scoreLabel.text = "Score: \(GameData.score)"
            feedbackLabel.text = "Correct!"
            inputTextField.text = ""
            playCorrectSound()
            NewEquation()
            // reset timer (set to 31 because when set to 30, would immediately countdown to 29)
            timeRemaining = 31
        } else {
            // if user is incorrect, subtract 1 life from lives
            lives -= 1
            
            // when user reaches 0 lives, end game.
            if lives == 0 {
                playIncorrectSound()
                GameOver()
            } else {
            // if user is still above 0 lives, display feedback in feedback label and clear user's input text field.
                feedbackLabel.text = "Wrong! Try again."
                inputTextField.text = ""
                playIncorrectSound()
            }
            livesLabel.text = "Lives: \(lives)"
        }
    }
    @IBAction func homeScreenAction(_ sender: Any) {
        timer.invalidate()
        GameData.score = 0
        MusicManager.playButtonSelectSound()
    }
    // when new game button is pressed, reset all user variables, and create new equation.
    @IBAction func newGameAction(_ sender: Any) {
        MusicManager.playButtonSelectSound()
        lives = 5
        livesLabel.text = "Lives: \(lives)"
        GameData.score = 0
        scoreLabel.text = "Score: \(GameData.score)"
        NewEquation()
        checkAnswerButton.isEnabled = true
        feedbackLabel.text = ""
        inputTextField.text = ""
        timeRemaining = 30
    }
    
    // function to end game, disabling the check answer button and moving user to the game over view controller
    func GameOver(){
        timer.invalidate()
        playLosingSound()
        feedbackLabel.text = "Game Over! Your score is \(GameData.score)"
        checkAnswerButton.isEnabled = false
        GameData.recentScores.insert(GameData.score, at: 0)
        GameData.finalScore = GameData.score
        GameData.score = 0
        performSegue(withIdentifier: "showGameOverVC", sender: self)
        
    }
    //function to create a new equation
    func NewEquation(){
        //generate random numbers for the equation between 1 and 20
        rand1 = Int.random(in: 1...20)
        rand2 = Int.random(in: 1...20)
        //stores answer to be able to compare user's output when checking answer.
        GameData.answer = rand1 * rand2
        // display equation in equationLabel
        equationLabel.text = "\(rand1) x \(rand2)"
    }
    // when the view appears, call on NewEquation function and run timer.
    override func viewDidAppear(_ animated: Bool) {
        NewEquation()
        runTimer()
    }
    override func viewDidLoad() {
        toggleMusicSwitch.isOn = !MusicManager.isMuted
        MusicManager.playBackgroundSound()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
