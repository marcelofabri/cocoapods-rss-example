//
//  EntriesTableViewController.swift
//  CocoaPodsFeed
//
//  Created by CursoIOS on 6/19/15.
//  Copyright (c) 2015 CursoIOS. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {

    let entries = EntryRepository.entriesFromJSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 68
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "Cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EntryTableViewCell

        let entry = entries[indexPath.row]
        cell.loadEntry(entry)
//        cell.layoutIfNeeded()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        UIApplication.sharedApplication().openURL(entries[indexPath.row].link)
    }
}
