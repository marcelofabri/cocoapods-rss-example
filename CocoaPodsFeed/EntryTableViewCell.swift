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
    
    func loadEntry(entry: Entry) {
        nameLabel.text = entry.title
        
//        contentLabel.text = "dasdas\ndsadsadsadasdas \ndas"
        
        contentLabel.attributedText = entry.attributedContent
    }
    
    private func attributedStringFromHTML(htmlString: String) -> NSAttributedString? {
        let options = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding] as [NSObject: AnyObject]
        
        let result = NSAttributedString(data: htmlString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!,
            options: options, documentAttributes: nil, error: nil)
        
        
        
        return result
    }
//    
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.layoutIfNeeded()
//        nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(nameLabel.frame)
//        contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(contentLabel.frame)
//    }
}
