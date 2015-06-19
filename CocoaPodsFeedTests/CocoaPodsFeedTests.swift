//
//  CocoaPodsFeedTests.swift
//  CocoaPodsFeedTests
//
//  Created by CursoIOS on 6/19/15.
//  Copyright (c) 2015 CursoIOS. All rights reserved.
//

import UIKit
import XCTest
import CocoaPodsFeed
import Nimble
import Argo

class CocoaPodsFeedTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEntryModel() {
        // This is an example of a functional test case.
        let json = [
            "title": "RTInstagramPopTransition",
            "link": "https://cocoapods.org/pods/RTInstagramPopTransition",
            "author": "",
            "publishedDate": "Fri, 19 Jun 2015 10:16:56 -0700",
            "contentSnippet": "Pop Navigation Controller with swipe gesture on UIViewController like Instagram App\n\nAuthored by Rishabh Tayal.\n[ Available at: ...",
            "content": "<p><p>Pop Navigation Controller with swipe gesture on UIViewController like Instagram App</p>\n</p>\n<p>Authored by Rishabh Tayal.</p>\n<p>[ Available at: <a href=\"https://github.com/rishabhtayal/RTInstagramPopTransition.git\">https://github.com/rishabhtayal/RTInstagramPopTransition.git</a> ]</p>\n<ul>\n  <li>Latest version: 1.0</li>\n  <li>Platform: iOS 7.0</li>\n  <li>Homepage: <a href=\"https://github.com/rishabhtayal/RTInstagramPopTransition\">https://github.com/rishabhtayal/RTInstagramPopTransition</a></li>\n  <li>License: MIT</li>\n</ul>",
            "categories": []
        ]
        
        let entry: Entry? = decode(json)
        expect(entry).toNot(beNil())
        
        if let entry = entry {
            expect(entry.title) == "RTInstagramPopTransition"
            expect(entry.link.absoluteString) == "https://cocoapods.org/pods/RTInstagramPopTransition"
            expect(entry.contentSnippet) == "Pop Navigation Controller with swipe gesture on UIViewController like Instagram App\n\nAuthored by Rishabh Tayal.\n[ Available at: ..."
            expect(entry.content) == "<p><p>Pop Navigation Controller with swipe gesture on UIViewController like Instagram App</p>\n</p>\n<p>Authored by Rishabh Tayal.</p>\n<p>[ Available at: <a href=\"https://github.com/rishabhtayal/RTInstagramPopTransition.git\">https://github.com/rishabhtayal/RTInstagramPopTransition.git</a> ]</p>\n<ul>\n  <li>Latest version: 1.0</li>\n  <li>Platform: iOS 7.0</li>\n  <li>Homepage: <a href=\"https://github.com/rishabhtayal/RTInstagramPopTransition\">https://github.com/rishabhtayal/RTInstagramPopTransition</a></li>\n  <li>License: MIT</li>\n</ul>"
            
            let components = NSDateComponents()
            components.year = 2015
            components.month = 6
            components.day = 19
            components.hour = 10
            components.minute = 16
            components.second = 56
            components.timeZone = NSTimeZone(forSecondsFromGMT: -7*60*60)
            
            expect(entry.publishedDate) == NSCalendar.currentCalendar().dateFromComponents(components)
        }
    }
    
    func testRepository() {
        expect(count(EntryRepository.entriesFromJSON())) == 20
    }
}
