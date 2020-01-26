//
//  TodayViewController.swift
//  MyAppExtension
//
//  Created by Szymon Szysz on 18/01/2020.
//  Copyright © 2020 Szymon Szysz. All rights reserved.
//

import UIKit
import NotificationCenter

final class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var pacificLabel: UILabel!
    @IBOutlet weak var mountianLabel: UILabel!
    @IBOutlet weak var centralLabel: UILabel!
    @IBOutlet weak var easternLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        updateClocks()
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    private func setupSelf() {
        preferredContentSize = CGSize(width: 320.0, height: 50.0)
    }
    
    
    private func updateClocks() {
        let time: Date = Date()
        
        let formatter: DateFormatter = DateFormatter();
        var timeZone = TimeZone(identifier: "UTC")
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
        
        timeZone = TimeZone(identifier: "US/Eastern")
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
        easternLabel.text = formatter.string(from: time)
        
        timeZone = TimeZone(identifier: "US/Pacific")
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
        pacificLabel.text = formatter.string(from: time)
        
        timeZone = TimeZone(identifier: "US/Mountain")
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
        mountianLabel.text = formatter.string(from: time)
        
        timeZone = TimeZone(identifier: "US/Central")
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
        centralLabel.text = formatter.string(from: time)
    }
}
