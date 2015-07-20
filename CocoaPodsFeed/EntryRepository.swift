//
//  EntryRepository.swift
//  CocoaPodsFeed
//
//  Created by CursoIOS on 6/19/15.
//  Copyright (c) 2015 CursoIOS. All rights reserved.
//

import Foundation

public struct EntryRepository {
    public static func entriesFromJSON(path: String = NSBundle.mainBundle().pathForResource("new-pods", ofType: "json")!) -> [Entry] {
        if let data = NSData(contentsOfFile: path),
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary,
            let responseData = dictionary["responseData"] as? NSDictionary,
            let feed = responseData["feed"] as? NSDictionary,
            let json = feed["entries"] as? [NSDictionary] {
                let entries = json.map { Entry.decode($0) }.filter { $0 != nil }.map { $0! }
                return entries
        }
        
        return []
    }
}