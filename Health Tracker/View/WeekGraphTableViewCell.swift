//
//  WeekGraphTableViewCell.swift
//  Health Tracker
//
//  Created by Thirumal on 11/02/17.
//  Copyright © 2017 Think42labs. All rights reserved.
//

import UIKit

class WeekGraphTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var graphCollectionView: UICollectionView!
    
    var hourStepList : [HourDetail] = []

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDateDetail(dateDetail : DateDetailDataModel)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        
        self.monthLabel.text = dateFormatter.string(from: dateDetail.date).uppercased()
        
        dateFormatter.dateFormat = "EEE"
        self.dayLabel.text = dateFormatter.string(from: dateDetail.date).uppercased()
        
        self.hourStepList = dateDetail.hourStepList
        
        self.graphCollectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return hourStepList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CollectionViewCellIdentifier.GraphCollectionViewCell, for: indexPath) as! GraphCollectionViewCell
        
        let hourDetail = hourStepList[indexPath.item]
        let maxHeight = collectionView.frame.size.height * 0.8
        let maxStep = 1000
        cell.barView.backgroundColor = UIColor.cyan
        
        if hourDetail.numberOfSteps < maxStep
        {
            let heightIntensity = CGFloat(hourDetail.numberOfSteps) / CGFloat(maxStep)
            cell.viewHeightConstraint.constant = maxHeight * heightIntensity
            cell.barView.alpha = heightIntensity
        }
        else
        {
            cell.viewHeightConstraint.constant = maxHeight
            cell.barView.alpha = 1.0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width / 48, height: collectionView.frame.size.height)
    }

}
