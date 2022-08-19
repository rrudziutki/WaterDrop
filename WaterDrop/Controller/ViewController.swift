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
    var minutes = 15
    var seconds = 0
    //MARK: - Time Labels
    var fromTimeLabel: UILabel!
    var toTimeLabel: UILabel!
    var byTimeLabel: UILabel!
    //MARK: - Time Pickers
    var fromPicker: UIPickerView!
    var toPicker: UIPickerView!
    var byPicker: UIPickerView!
    var fromHour = 8
    var toHour = 16
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
        configure()
    }
    
    func updateTimerLabel(_ min: Int, _ sec: Int) {
        timerLabel.text = "\(min.withLeadingZeros):\(sec.withLeadingZeros)"
    }
}

//MARK: - Configuration
private extension ViewController {
    func configure() {
        buildUI()
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
            return "\(DatePickerData.hourArray[row].withLeadingZeros):00"
        } else {
            return "\(DatePickerData.byMinutesArray[row]) min."
        }
    }
    
}

//MARK: - UIPicker Delegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case byPicker:
            minutes = DatePickerData.byMinutesArray[row]
            updateTimerLabel(minutes, seconds)
        case fromPicker:
            fromHour = DatePickerData.hourArray[row]
        case toPicker:
            toHour = DatePickerData.hourArray[row]
        default:
            return
        }
        comparePickers(fromHour, toHour, showAlert)
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
                //TODO Push Notifications -- it requires paid developer account
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
    
    func comparePickers(_ from: Int, _ to: Int,_ alert: () -> Void) {
        if from >= to {
            alert()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Wrong time setup", message: "Start hour can not be greater than end hour", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reset", style: .default) { [unowned self] _ in
            self.resetPickers()
        })
        self.present(alert, animated: true)
    }
    
    func resetPickers() {
        toPicker.selectRow(23, inComponent: 0, animated: true)
        toHour = 23
        fromPicker.selectRow(0, inComponent: 0, animated: true)
        fromHour = 0
    }
}
