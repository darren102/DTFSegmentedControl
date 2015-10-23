//
//  DTFSegmentedControlCollectionViewCell.swift
//  DTFSegmentedControl
//
//  Created by Darren Ferguson on 4/26/15.
//  Copyright (c) 2015 Darren Ferguson. All rights reserved.
//

import UIKit

class DTFSegmentedControlCollectionViewCell: UICollectionViewCell {

    // MARK: - Variables
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFontOfSize(17.0)
        label.textAlignment = .Center
        label.backgroundColor = .clearColor()
        return label
    }()

    private lazy var selectorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blueColor()
        return view
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(label)
        contentView.addSubview(selectorView)

        let metrics = ["spacing": 8.0, "labelHeight": 17.0, "selectorHeight": 3.0]
        let views = ["label" : label, "selectorView" : selectorView]

        // Setting the horizontal constraints for the label and selector view
        NSLayoutConstraint.activateConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("|-(spacing)-[label]-(spacing)-|",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: metrics,
                views: views))

        NSLayoutConstraint.activateConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("|-(spacing)-[selectorView]-(spacing)-|",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: metrics,
                views: views))

        NSLayoutConstraint.activateConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-(spacing)-[label(labelHeight)]-(spacing)-[selectorView(selectorHeight)]-(spacing)-|",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: metrics,
                views: views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 44.0)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        label.sizeToFit()
        selectorView.hidden = true
        selectorView.sizeToFit()
    }
}

// MARK: - Internal
extension DTFSegmentedControlCollectionViewCell {

    func configureCell(labelText: String?, isSelected: Bool) {
        if let labelText = labelText {
            label.text = labelText
            label.sizeToFit()
            selectorView.sizeToFit()
        }
        selectorView.hidden = !isSelected
    }
}