//
//  Entry.swift
//  CocoaPodsFeed
//
//  Created by CursoIOS on 6/19/15.
//  Copyright (c) 2015 CursoIOS. All rights reserved.
//

import Foundation
import Argo
import Runes

public struct Entry {
    public let content: String
    public let contentSnippet: String
    public let link: NSURL
    public let publishedDate: NSDate
    public let title: String
    public let attributedContent: NSAttributedString?
}

extension Entry: Decodable {
    private static func attributedStringFromHTML(htmlString: String) -> NSAttributedString? {
        let options = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding] as [NSObject: AnyObject]
        
        let paragraph = NSParagraphStyle.defaultParagraphStyle()
        
        var result = NSMutableAttributedString(data: htmlString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!,
            options: options, documentAttributes: nil, error: nil)
        
        let range = NSMakeRange(0, result!.length)
        result?.addAttribute(NSParagraphStyleAttributeName,
            value: NSParagraphStyle.defaultParagraphStyle(), range: range)
        
        return result
    }
    
    private static func parseAttributedContent(content: String) -> NSAttributedString? {
        let text = split(content) { $0 == "\n" }
//        println(text.first!)
        return attributedStringFromHTML(text.first!)
    }
    
    static func create(content: String)(_ contentSnippet: String)(_ link: NSURL)(_ publishedDate: NSDate)(_ title: String) -> Entry {
        
        return Entry(content: content, contentSnippet: contentSnippet, link: link, publishedDate: publishedDate,
            title: title, attributedContent: parseAttributedContent(contentSnippet))
    }
    
    public static func decode(j: JSON) -> Decoded<Entry> {
        return Entry.create
            <^> j <| "content"
            <*> j <| "contentSnippet"
            <*> j <| "link"
            <*> j <| "publishedDate"
            <*> j <| "title"
    }
}

extension NSURL: Decodable {
    public static func decode(j: JSON) -> Decoded<NSURL> {
        switch j {
        case let .String(s): return .fromOptional(NSURL(string: s))
        default: return .TypeMismatch("\(j) is not a String")
        }
    }
}

extension NSDate: Decodable {
    static private var rssDateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss Z"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        return formatter
    }()
    
    public static func decode(j: JSON) -> Decoded<NSDate> {
        switch j {
        case let .String(s): return .fromOptional(rssDateFormatter.dateFromString(s))
        default: return .TypeMismatch("\(j) is not a String")
        }
    }
}