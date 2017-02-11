//
//  TabCollectionViewCell.swift
//  Health Tracker
//
//  Created by Thirumal on 11/02/17.
//  Copyright © 2017 Think42labs. All rights reserved.
//

import UIKit

class TabCollectionViewCell: UICollectionViewCell
{
    
    //MARK:- Variables
    
    //MARK:-- Outlet
    @IBOutlet weak var selectionView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    //MARK:- Life Cycle
    override func awakeFromNib()
    {
        self.selectionView.layer.cornerRadius = 8.0
        self.imageView.layer.cornerRadius = 5.0
    }
    
    func setCollectionViewDetail(cellDetail : TabCollectionViewCellDataModel)
    {
        self.imageView.image = UIImage(named: cellDetail.imageName)
        self.titleLabel.text = cellDetail.titleText
        self.subTitleLabel.text = cellDetail.subTitleText
    }
    
    func setCellSelected(selected : Bool)
    {
        if selected
        {
            self.selectionView.backgroundColor = Constant.Color.TabCollectionCellSelected
        }
        else
        {
            self.selectionView.backgroundColor = UIColor.clear
        }
        
    }
    
}
