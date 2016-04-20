//
//  AddExerciseViewController.swift
//  Technovation 2016
//
//  Created by Ahsoka Tano on 4/17/16.
//  Copyright © 2016 Ahsoka Tano. All rights reserved.
//

import UIKit

class AddExerciseViewController: UIViewController, UIPickerViewDataSource, UIApplicationDelegate, UIPickerViewDelegate {
    
    @IBOutlet weak var exerciseTypeText: UITextField!
    @IBOutlet weak var exerciseDateAndTime: UIDatePicker!
    @IBOutlet weak var exerciseLocationText: UITextField!
    @IBOutlet weak var exerciseReminder: UISwitch!
    @IBOutlet weak var exerciseOftenText: UITextField!
    @IBOutlet weak var exercisePickerView: UIPickerView!
    @IBOutlet weak var exerciseEndRepeat: UIDatePicker!
    
    let pickerData = ["Hours", "Days", "Weeks", "Months"]
    var events = NSMutableArray()
    
    @IBAction func addExercise(sender: AnyObject) {
        let event: DPCalendarEvent = DPCalendarEvent(title: exerciseTypeText.text, startTime: exerciseDateAndTime.date, endTime: exerciseDateAndTime.date, colorIndex: 1)
        events.addObject(event)

    }
    
    @IBAction func exerciseForeverButton(sender: AnyObject) {
        exerciseEndRepeat.hidden = true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exercisePickerView.delegate = self
        self.exercisePickerView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.events = appDelegate.events
        
        
    }
    
    override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
