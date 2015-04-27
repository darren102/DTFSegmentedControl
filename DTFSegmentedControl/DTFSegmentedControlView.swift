//
//  DTFSegmentedControlView.swift
//  DTFSegmentedControl
//
//  Created by Darren Ferguson on 4/26/15.
//  Copyright (c) 2015 Darren Ferguson. All rights reserved.
//

import UIKit

public class DTFSegmentedControlView: UICollectionView {
   
    // MARK: - Constants
    private let kDTFSegmentedCellIdentifier = "DTFSegmentedCell"
    
    // MARK: - Variables
    public var cellWidth = 100.0
    public var selectedFunc: ((String, NSIndexPath) -> Void) = { _ in () }
    private var segmentTitles = [String]()
    private var segmentData = [String]()
    private var selectedSegment: String = ""
    
    // MARK: - Initializers
    required public init(coder aDecoder: NSCoder) {
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
    public func configureControl(titles: [String], data: [String]) {
        assert(titles.count == data.count, "Number of Titles does not match the number of data provided")
        segmentTitles = titles
        segmentData = data
        selectedSegment = titles.first!
        reloadData()
    }
    
    // MARK: - Private
    private func setupControl() {
        registerClass(DTFSegmentedControlCollectionViewCell.self, forCellWithReuseIdentifier: kDTFSegmentedCellIdentifier)

        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = CGSize(width: cellWidth, height: 44.0)
        flowLayout.scrollDirection = .Horizontal
        
        dataSource = self
        delegate = self
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kDTFSegmentedCellIdentifier, forIndexPath: indexPath) as! DTFSegmentedControlCollectionViewCell
        cell.configureCell(segmentTitle, isSelected: selected)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DTFSegmentedControlView: UICollectionViewDelegate {
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedSegment = segmentTitles[indexPath.row]
        selectedFunc(selectedSegment, indexPath)

        reloadData()
        scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
    }
}
