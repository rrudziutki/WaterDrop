//
//  TimerConfiguration.swift
//  WaterDrop
//
//  Created by Remigiusz Makuchowski on 15/08/2022.
//

import Foundation

extension ViewController {
    @objc func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [unowned self] _ in
            if self.seconds > 0 {
                self.seconds -= 1
            } else {
                self.minutes -= 1
                self.seconds = 59
            }
            
            if seconds < 10 {
                self.timerLabel.text = "\(minutes):0\(seconds)"
            } else if minutes < 10 {
                self.timerLabel.text = "0\(minutes):\(seconds)"
            } else {
                self.timerLabel.text = "\(minutes):\(seconds)"
            }
        })
    }
    
    @objc func stopTimer() {
        timer.invalidate()
    }
}
