//
//  EntryTableViewCell.swift
//  CocoaPodsFeed
//
//  Created by CursoIOS on 6/19/15.
//  Copyright (c) 2015 CursoIOS. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    
    func loadEntry(entry: Entry, favorite: Bool = false) {
        nameLabel.text = entry.title
        
        let lines = split(entry.contentSnippet) { $0 == "\n" }
        contentLabel.text = lines.first
        
        let font: UIFont
        var color: UIColor
        if favorite {
            font = UIFont.boldSystemFontOfSize(17)
            color = UIColor.blackColor()
        } else {
            font = UIFont.systemFontOfSize(16)
            color = UIColor.darkGrayColor()
        }
        
        if NSCalendar.currentCalendar().isDateInToday(entry.publishedDate) {
            color = UIColor.blueColor()
        }
        
        nameLabel.textColor = color
        contentLabel.textColor = color
        nameLabel.font = font
    }
}
