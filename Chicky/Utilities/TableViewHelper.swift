//
//  TableViewHelper.swift
//  Chicky
//
//  Created by Apple Mac on 1/1/2022.
//

import Foundation
import UIKit

class TableViewHelper {

    class func makeNoDataCell(message:String, cellWidth: Int, cellHeight: Int) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let messageLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: cellWidth, height: cellHeight)))
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        //messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        cell.contentView .addSubview(messageLabel)
        
        return cell
    }
}
