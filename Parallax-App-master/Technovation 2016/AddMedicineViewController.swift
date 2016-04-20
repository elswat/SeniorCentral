//
//  AddMedicineViewController.swift
//  Technovation 2016
//
//  Created by Ahsoka Tano on 3/20/16.
//  Copyright (c) 2016 Ahsoka Tano. All rights reserved.
//

import UIKit

public class AddMedicineViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIApplicationDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var dosageText: UITextField!
    
    @IBOutlet weak var oftenText: UITextField!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var reasonText: UITextField!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    let pickerData = ["Hours", "Days", "Weeks", "Months"]
    //var i = 0
    var events = NSMutableArray()
    //var objectC = DPCalendarTestStoryboardViewController()
    //var objectC =  UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CalendarID") as? DPCalendarTestStoryboardViewController
    
    @IBAction func addMedicine(sender: AnyObject) {
        //objectC!.events = NSMutableArray()
        let event: DPCalendarEvent = DPCalendarEvent(title: nameText.text, startTime: startDatePicker.date, endTime: startDatePicker.date, colorIndex: 1)
        events.addObject(event)
        //NSLog("Title: %@", events[i].title)
        //i += 1
    }
    
    @IBAction func medicineForeverButton(sender: AnyObject) {
        endDatePicker.hidden = true
    }
    
    func printMedicineInfo() {
        
    }
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        // Do any additional setup after loading the view.
        //address.frame = CGRectMake(address.frame.origin.x + 10.0, address.frame.origin.y, address.frame.size.width, address.frame.size.width)
        oftenText.frame.size.width = 40.0
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.events = appDelegate.events
        //var events: [DPCalendarEvent] = appDelegate.events

    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
