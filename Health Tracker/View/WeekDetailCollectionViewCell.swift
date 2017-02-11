//
//  WeekDetailCollectionViewCell.swift
//  Health Tracker
//
//  Created by Thirumal on 11/02/17.
//  Copyright © 2017 Think42labs. All rights reserved.
//

import UIKit

class WeekDetailCollectionViewCell: UICollectionViewCell
{
 
    @IBOutlet weak var hexogonView: UIView!
    var dateDetailList : [DateDetailDataModel] = []
    
    func addHexagonalView()
    {
        for view in hexogonView.subviews
        {
            view.removeFromSuperview()
        }
        
        let space : CGFloat = 6
        
        let width = (self.hexogonView.frame.size.width - CGFloat(space * 8)) / 5.5
        let verticalCentre = self.hexogonView.frame.size.height / 2
        
        for index : Int in 0 ..< dateDetailList.count
        {
            let dateDetail = dateDetailList[index]
            
            let dateLabel = UILabel()
            dateLabel.textAlignment = NSTextAlignment.center
            dateLabel.numberOfLines = 2
            
            dateLabel.attributedText = WeekDetailDataBL.shared.getDisplayDate(date: dateDetail.date)
            
            var frame : CGRect = CGRect()
            let leading = (CGFloat(index * 3) * width)/4
            let frameX = space + CGFloat(index) * space + leading
            if index % 2 == 0
            {
                frame.origin.y = verticalCentre - (width / 2) + space
            }
            else
            {
                frame.origin.y = verticalCentre - width
            }
            
            frame.origin.x = frameX
            frame.size.width = width
            frame.size.height = width
            
            dateLabel.backgroundColor = Constant.Color.TabCollectionCellSelected
            dateLabel.frame = frame
            dateLabel.layer.mask = getHexagonPath(square: frame)
            
            self.hexogonView.addSubview(dateLabel)
            
            if dateDetail.numberOfSteps > 0
            {
                let imageView = UIImageView()
                
                var imageViewFrame = CGRect()
                imageViewFrame.size = CGSize(width: 16, height: 16)
                if index % 2 == 0
                {
                    imageViewFrame.origin.y = frame.origin.y + frame.size.height + 8
                }
                else
                {
                    imageViewFrame.origin.y = frame.origin.y - imageViewFrame.height - 8
                }
                imageViewFrame.origin.x = frame.origin.x + (width * 0.15)
                
                if dateDetail.numberOfSteps > 500
                {
                    imageView.backgroundColor = UIColor.red
                }
                else
                {
                    imageView.backgroundColor = UIColor.white
                }
                
                imageView.frame = imageViewFrame
                imageView.layer.cornerRadius = 3
                self.hexogonView.addSubview(imageView)
                
                let stepLabel = UILabel()
                
                stepLabel.text = String(dateDetail.numberOfSteps)
                stepLabel.textColor = UIColor.white
                stepLabel.font = UIFont.systemFont(ofSize: 10)
                
                stepLabel.frame.origin.x = imageViewFrame.origin.x + imageViewFrame.size.height + 4
                stepLabel.frame.origin.y = imageViewFrame.origin.y
                stepLabel.frame.size.height = 16
                stepLabel.frame.size.width = 100
                self.hexogonView.addSubview(stepLabel)
            }
        }
    }
    
    func getHexagonPath(square : CGRect) ->CAShapeLayer
    {
        let sides = 6
        let cornerRadius : Float = 0.0
        let lineWidth : Float = 0.0
        let path = UIBezierPath()
        
        let theta = Float(2.0 * M_PI) / Float(sides)
        let offset = cornerRadius * tanf(theta / 2.0)
        let squareWidth = Float(min(square.size.width, square.size.height))
        
        var length = squareWidth - lineWidth
        
        if sides % 4 != 0 {
            length = length * cosf(theta / 2.0) + offset / 2.0
        }
        
        let sideLength = length * tanf(theta / 2.0)
        
        var point = CGPoint(x:CGFloat((squareWidth / 2.0) + (sideLength / 2.0) - offset), y:CGFloat(squareWidth - (squareWidth - length) / 2.0))
        var angle = Float(M_PI)
        path.move(to: point)
        
        for _ : Int in  0 ..< sides
        {
            
            let x = Float(point.x) + (sideLength - offset * 2.0) * cosf(angle)
            let y = Float(point.y) + (sideLength - offset * 2.0) * sinf(angle)
            
            point = CGPoint(x: CGFloat(x), y: CGFloat(y))
            path.addLine(to: point)
            
            let centerX = Float(point.x) + cornerRadius * cosf(angle + Float(M_PI_2))
            let centerY = Float(point.y) + cornerRadius * sinf(angle + Float(M_PI_2))
            
            let center = CGPoint(x:CGFloat(centerX),y: CGFloat(centerY))
            
            let startAngle = CGFloat(angle) - CGFloat(M_PI_2)
            let endAngle = CGFloat(angle) + CGFloat(theta) - CGFloat(M_PI_2)
            
            path.addArc(withCenter: center, radius: CGFloat(cornerRadius), startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            point = path.currentPoint
            angle += theta
        }
        
        path.close()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.strokeColor = UIColor.clear.cgColor
        mask.fillColor = UIColor.white.cgColor
        
        return mask
    }
    
    
}


