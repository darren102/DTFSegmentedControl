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
    public var cellWidth = 60.0 {
        didSet { updateCollectionViewCellEstimatedSize() }
    }
    public var selectedFunc: ((String, NSIndexPath) -> Void) = { _ in () }
    private var segmentTitles = [String]()
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
    public func configureSegmentedControl(titles: [String], data: [String]) {
        guard titles.count > 0 && titles.count == data.count else {
            fatalError("Number of \"titles\" does not match the number of \"data\" provided")
        }

        segmentTitles = titles
        segmentData = data
        selectedSegment = titles.first!
        reloadData()
    }
    
    // MARK: - Private
    private func setupControl() {
        registerClass(DTFSegmentedControlCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifers.DTFSegmentedCell.rawValue)

        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false

        updateCollectionViewCellEstimatedSize()

        dataSource = self
        delegate = self
    }

    private func updateCollectionViewCellEstimatedSize() {
        assert(cellWidth > 0.0, "Cell width must be greater than 0.0")
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
