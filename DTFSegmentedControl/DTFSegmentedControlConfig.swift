//
//  DTFSegmentedControlConfig.swift
//  DTFSegmentedControl
//
//  Created by Darren Ferguson on 10/24/15.
//  Copyright © 2015 Darren Ferguson. All rights reserved.
//

import UIKit

public final class DTFSegmentedControlConfig: NSObject {

    // MARK: - Constants
    let segmentTitles: [String]
    let segmentData: [String]

    // MARK: - Initializers
    public init(segmentTitles: [String], segmentData: [String]) {
        self.segmentTitles = segmentTitles
        self.segmentData = segmentData
        super.init()
    }
}
