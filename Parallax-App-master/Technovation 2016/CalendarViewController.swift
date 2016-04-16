//
//  CalendarViewController.swift
//  Technovation 2016
//
//  Created by Ahsoka Tano on 3/20/16.
//  Copyright (c) 2016 Ahsoka Tano. All rights reserved.
//

import UIKit
import EventKit

class CalendarViewController: UIViewController {

    //@IBOutlet weak var addEventButton: UIButton!
    
    let eventStore = EKEventStore()
    
    var calendars: [EKCalendar]?
    
    /*func createCalendar() {
        let calendars = EKCalendar(forEntityType: EKEntityTypeEvent, eventStore: eventStore)
        calendars.title = "Calendar"
        // Access list of available sources from the Event Store
        let sourcesInEventStore: [EKSource] = eventStore.sources() as! [EKSource]
        
        // Filter the available sources and select the "Local" source to assign to the new calendar's
        // source property
        calendars.source = sourcesInEventStore.filter{
            (source: EKSource) -> Bool in
            source.sourceType.value == EKSourceTypeLocal.value
        }.first
        
        // Save the calendar using the Event Store instance
        var error: NSError? = nil
        let calendarWasSaved = eventStore.saveCalendar(calendars, commit: true, error: &error)
        
        // Handle situation if the calendar could not be saved
        if calendarWasSaved == false {
            let alert = UIAlertController(title: "Calendar could not save", message: error?.localizedDescription, preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            NSUserDefaults.standardUserDefaults().setObject(calendars.calendarIdentifier, forKey: "EventTrackerPrimaryCalendar")
        }
  
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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
