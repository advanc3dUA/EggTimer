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
    @IBOutlet weak var stopSoundButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBarView: UIProgressView!
    let eggTimesDict = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer: Timer?
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBarView.alpha = 0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer?.invalidate()
        stopSoundButton.alpha = 0.0
        player?.stop()
        titleLabel.text = "Cooking " + sender.currentTitle! + "..."

        progressBarView.progress = 1
        progressBarView.trackTintColor = .systemGray
        progressBarView.alpha = 1.0
        
        guard let timeToCook = eggTimesDict[sender.currentTitle!] else { return }
        var secondsRemaining = timeToCook * 60
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [unowned self] timer in
            guard secondsRemaining != 0 else {
                timer.invalidate()
                progressBarView.trackTintColor = .systemGreen
                titleLabel.text = "Done"
                guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
                player = try! AVAudioPlayer(contentsOf: url)
                player?.play()
                stopSoundButton.alpha = 1.0
                return
            }
            secondsRemaining -= 1

            let newProgress = Float(secondsRemaining) / (Float(timeToCook) * 60)
            progressBarView.setProgress(newProgress, animated: true)
        })

    }
    @IBAction func stopSoundButton(_ sender: UIButton) {
        player?.stop()
        stopSoundButton.alpha = 0.0
    }
    
}
