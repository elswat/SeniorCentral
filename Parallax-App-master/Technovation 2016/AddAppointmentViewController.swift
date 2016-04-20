//
//  AddAppointmentViewController.swift
//  Technovation 2016
//
//  Created by Ahsoka Tano on 4/18/16.
//  Copyright © 2016 Ahsoka Tano. All rights reserved.
//

import UIKit

class AddAppointmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIApplicationDelegate {
    
    @IBOutlet weak var appointmentTypeText: UITextField!
    @IBOutlet weak var appointmentDateAndTime: UIDatePicker!
    @IBOutlet weak var appointmentLocationText: UITextField!
    @IBOutlet weak var appointmentReminderSwitch: UISwitch!
    @IBOutlet weak var repeatOftenText: UITextField!
    
    @IBOutlet weak var appointmentEndRepeatDate: UIDatePicker!
    @IBOutlet weak var appointmentPickerView: UIPickerView!
    
    let pickerData = ["Hours", "Days", "Weeks", "Months"]
    var events = NSMutableArray()
    
    @IBAction func addAppointment(sender: AnyObject) {
        let event: DPCalendarEvent = DPCalendarEvent(title: appointmentTypeText.text, startTime: appointmentDateAndTime.date, endTime: appointmentDateAndTime.date, colorIndex: 1)
        events.addObject(event)

    }
    
    @IBAction func appointmentForeverButton(sender: AnyObject) {
        appointmentEndRepeatDate.hidden = true
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
        self.appointmentPickerView.delegate = self
        self.appointmentPickerView.dataSource = self
        
        // Do any additional setup after loading the view.
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.events = appDelegate.events
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
