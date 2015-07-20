//
//  Entry.swift
//  CocoaPodsFeed
//
//  Created by CursoIOS on 6/19/15.
//  Copyright (c) 2015 CursoIOS. All rights reserved.
//

import Foundation

struct JSONParseUtils {
    static func parseURL(URLString: String?) -> NSURL? {
        return flatMap(URLString) { NSURL(string: $0) }
    }
    
    static private var rssDateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss Z"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        return formatter
        }()
    
    static func parseDate(dateString: String?) -> NSDate? {
        return flatMap(dateString) { rssDateFormatter.dateFromString($0) }
    }
}

public struct Entry {
    public let content: String
    public let contentSnippet: String
    public let link: NSURL
    public let publishedDate: NSDate
    public let title: String
    
    public static func decode(j: AnyObject?) -> Entry? {
        if let json = j as? NSDictionary,
        content = json["content"] as? String,
        snippet = json["contentSnippet"] as? String,
        link = JSONParseUtils.parseURL(json["link"] as? String),
        publishedDate = JSONParseUtils.parseDate(json["publishedDate"] as? String),
            title = json["title"] as? String {
                return Entry(content: content, contentSnippet: snippet, link: link, publishedDate: publishedDate, title: title)
        }
        
        return nil
    }
}

