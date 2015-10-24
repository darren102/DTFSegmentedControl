//
//  DTFSegmentedControlView.swift
//  DTFSegmentedControl
//
//  Created by Darren Ferguson on 4/26/15.
//  Copyright (c) 2015 Darren Ferguson. All rights reserved.
//

import UIKit

public class DTFSegmentedControlView: UICollectionView {
   
    // MARK: - CellIdentifiers
    private enum CellIdentifers: String {
        case DTFSegmentedCell
    }
    
    // MARK: - Variables
    public var selectedFunc: ((String, NSIndexPath) -> Void) = { _ in () }
    private var segmentTitles = [String]() {
        didSet { updateCollectionViewCellEstimatedSize() }
    }
    private var segmentData = [String]()
    private var selectedSegment = ""
    private var selectedIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    // MARK: - Initializers
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupControl()
    }
    
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        setupControl()
    }
    
    override public func intrinsicContentSize() -> CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 44.0)
    }
    
    // MARK: - Public
    public func configureSegmentedControl(config: DTFSegmentedControlConfig) {
        guard config.segmentTitles.count > 0 && config.segmentTitles.count == config.segmentData.count else {
            fatalError("Number of \"Segment Titles\" does not match the number of \"Segment Data\" provided")
        }

        segmentTitles = config.segmentTitles
        segmentData = config.segmentData
        selectedSegment = segmentTitles.first!

        updateCollectionViewCellEstimatedSize()

        reloadData()
    }
    
    // MARK: - Private
    private func setupControl() {
        registerClass(DTFSegmentedControlCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifers.DTFSegmentedCell.rawValue)

        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false

        dataSource = self
        delegate = self
    }

    private func updateCollectionViewCellEstimatedSize() {
        assert(segmentTitles.count > 0, "Segment titles must have a count greater than 0")
        
        var totalLength = CGFloat(0.0)
        let currentFont = UIFont.systemFontOfSize(17.0)
        for title in segmentTitles {
            let size = (title as NSString).sizeWithAttributes([NSFontAttributeName : currentFont])
            totalLength = totalLength + size.width + 16.0
        }

        let cellWidth = totalLength / CGFloat(segmentTitles.count)
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = CGSize(width: cellWidth, height: 44.0)
        flowLayout.scrollDirection = .Horizontal
    }
}

// MARK: - UICollectionViewDataSource
extension DTFSegmentedControlView: UICollectionViewDataSource {
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentTitles.count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let segmentTitle = segmentTitles[indexPath.row]
        let selected = selectedSegment == segmentTitle
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifers.DTFSegmentedCell.rawValue, forIndexPath: indexPath) as! DTFSegmentedControlCollectionViewCell
        cell.configureCell(segmentTitle, isSelected: selected)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DTFSegmentedControlView: UICollectionViewDelegate {
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedSegment = segmentTitles[indexPath.row]
        selectedFunc(selectedSegment, indexPath)
        selectedIndexPath = indexPath
        reloadData()
        
        scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
    }
}
