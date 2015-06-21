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
}

extension Entry: Decodable {
    static func create(content: String)(_ contentSnippet: String)(_ link: NSURL)(_ publishedDate: NSDate)(_ title: String) -> Entry {
        
        return Entry(content: content, contentSnippet: contentSnippet, link: link, publishedDate: publishedDate,
            title: title)
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