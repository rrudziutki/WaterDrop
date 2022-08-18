//
//  ViewController.swift
//  WaterDrop
//
//  Created by Remigiusz Makuchowski on 04/08/2022.
//

import UIKit

class ViewController: UIViewController {
    var backgroundImage: UIImageView!
    var droplet: UIImageView!
    //MARK: - Timer
    var timer: Timer!
    var timerLabel: UILabel!
    var minutes = 1
    var seconds = 0
    //MARK: - Time Labels
    var fromTimeLabel: UILabel!
    var toTimeLabel: UILabel!
    var byTimeLabel: UILabel!
    //MARK: - Time Pickers
    var fromPicker: UIPickerView!
    var toPicker: UIPickerView!
    var byPicker: UIPickerView!
    //MARK: - Buttons
    var startButton: UIButton!
    var stopButton: UIButton!
    var isCounting = false {
        didSet {
            startButton.setNeedsUpdateConfiguration()
            stopButton.setNeedsUpdateConfiguration()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buildUI()
        configure()
    }
    
    func updateTimerLabel(_ min: Int, _ sec: Int) {
        timerLabel.text = "\(min.withLeadingZeros):\(sec.withLeadingZeros)"
    }
}

private extension ViewController {
    func configure() {
        fromPicker.delegate = self; toPicker.delegate = self ; byPicker.delegate = self
        fromPicker.dataSource = self; toPicker.dataSource = self ; byPicker.dataSource = self
        
        fromPicker.selectRow(8, inComponent: 0, animated: true)
        toPicker.selectRow(16, inComponent: 0, animated: true)
        byPicker.selectRow(2, inComponent: 0, animated: true)
    }
}

//MARK: - UIPicker DataSource
extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView != byPicker {
            return DatePickerData.hourArray.count
        } else {
            return DatePickerData.byMinutesArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView != byPicker {
            return DatePickerData.hourArray[row]
        } else {
            return "\(DatePickerData.byMinutesArray[row]) min."
        }
    }
    
}

//MARK: - UIPicker Delegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == byPicker {
            minutes = DatePickerData.byMinutesArray[row]
            updateTimerLabel(minutes, seconds)
        }
    }
}

//MARK: - Timer Configuration
extension ViewController {
    @objc func startTimer() {
        var m = self.minutes
        var s = self.seconds
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [unowned self] _ in
            if m == 0 && s == 0 {
                m = self.minutes
                s = self.seconds
                //TODO Notifications
            }
            let _ = calcTime(&m, &s)
            updateTimerLabel(m, s)
        })
    }
    
    @objc func stopTimer() {
        timer.invalidate()
    }
    
    
    func calcTime( _ m: inout Int, _ s: inout Int) -> (Int, Int) {
        guard (m,s) != (0,0) else { return (0, 0) }
        if s > 0 {
            s -= 1
        } else {
            m -= 1
            s = 59
        }
        return (m, s)
    }
}
