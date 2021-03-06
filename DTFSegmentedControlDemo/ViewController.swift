//
//  ViewController.swift
//  DTFSegmentedControlDemo
//
//  Created by Darren Ferguson on 4/26/15.
//  Copyright (c) 2015 Darren Ferguson. All rights reserved.
//

import UIKit
import DTFSegmentedControl

class ViewController: UIViewController {

    private let titles = ["All (88)", "Equipment (44)", "Feeders (22)", "Terminations (22)"]
    private let data = ["All", "Equipment", "Feeders", "Terminations"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let control = DTFSegmentedControlView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        control.translatesAutoresizingMaskIntoConstraints = false
        control.backgroundColor = .whiteColor()
        view.addSubview(control)
        
        NSLayoutConstraint.activateConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("|[control]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["control":control]))
        NSLayoutConstraint.activateConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-(22)-[control(44)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["control":control]))
        control.configureSegmentedControl(generateSegmentedControlData())
    }
    
    private func generateSegmentedControlData() -> DTFSegmentedControlConfig {
        return DTFSegmentedControlConfig(segmentTitles: titles, segmentData: data)
    }
}

