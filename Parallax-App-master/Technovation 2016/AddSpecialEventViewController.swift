//
//  AddSpecialEventViewController.swift
//  
//
//  Created by Ahsoka Tano on 4/7/16.
//
//

import UIKit

class AddSpecialEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var endOfRepeatDatePicker: UIDatePicker!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var repeatText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var eventNameText: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var allDaySwitch: UISwitch!
    @IBOutlet weak var dateAndTimeDatePicker: UIDatePicker!
    
    let pickerData = ["Hours", "Days", "Weeks", "Months"]
    
    func printSpecialEventInfo() {
        
    }
    
    var objectD =  UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CalendarID") as? DPCalendarTestStoryboardViewController
    
    @IBAction func addSpecialEvent(sender: AnyObject) {
        objectD!.events = NSMutableArray()
        let event: DPCalendarEvent = DPCalendarEvent(title: eventNameText.text, startTime: dateAndTimeDatePicker.date, endTime: dateAndTimeDatePicker.date, colorIndex: 1)
        objectD!.events.addObject(event)
    }
    
    func allDay() {
        if allDaySwitch.on {
            dateAndTimeDatePicker.datePickerMode = UIDatePickerMode.Date
        }
        //Reload dateAndTimeDatePicker
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        // Do any additional setup after loading the view.
        allDaySwitch.setOn(false, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
