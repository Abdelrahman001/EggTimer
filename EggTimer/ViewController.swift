//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var hardnessProgressBar: UIProgressView!

    var player : AVAudioPlayer!
    let eggTimes = ["Soft": 300 , "Medium": 420 , "Hard": 720]
    var totalTime = 0
    var timePassed = 0
    var timer = Timer()
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    @objc func updateCounter() {
        
        if timePassed <= totalTime {
            let progressPercentage = Float(timePassed) / Float(totalTime)
            hardnessProgressBar.progress = progressPercentage
            timePassed += 1
            
        }else {
            timer.invalidate()
            Label.text = "Done!"
            playSound(soundName: "alarm_sound")
        }
    }
    
    @IBAction func hardnessBtnPressed(_ sender: UIButton) {
        timer.invalidate()
        
        
        let hardness = sender.currentTitle!
        timePassed = 0
        hardnessProgressBar.progress = 0.0
        Label.text = sender.currentTitle
        
        totalTime = eggTimes[hardness]!
         timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        

    }
}
