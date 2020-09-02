//
//  ViewController.swift
//  RummikubTimer
//
//  Created by Bartosz Gejgał on 02/09/2020.
//  Copyright © 2020 Bartosz Gejgał. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var pauseTimerButton: UIButton!
    
    var timer = Timer()
    var counter = 60.0
    var isPaused = false
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func timerButtonPressed(_ sender: UIButton) {
        
        counter = 60.0 // resetting the counter
        timer.invalidate() // invalidating current timer if there is one
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        updateTimerButtonText(with: "\(counter)")
    }
    
    @IBAction func pauseTimerButtonPressed(_ sender: UIButton) {
        if isPaused { // resuming
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            isPaused = false
            pauseTimerButton.setTitle("Pause", for: .normal)
            startTimerButton.isEnabled = true
        } else { // pausing
            timer.invalidate()
            isPaused = true
            pauseTimerButton.setTitle("Resume", for: .normal)
            startTimerButton.isEnabled = false
        }
    }
    
    @objc func updateCounter(){
        if counter <= 0.0 {
            timer.invalidate()
            updateTimerButtonText(with: "Time's up!")
            playSound()
        } else {
            counter = round((counter - 0.1) * 10) / 10
            updateTimerButtonText(with: "\(counter)")
        }
    }
    
    func updateTimerButtonText(with text: String){
        UIView.performWithoutAnimation {
            startTimerButton.setTitle("\(text)", for: .normal)
            startTimerButton.layoutIfNeeded()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "TimesUpSound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

