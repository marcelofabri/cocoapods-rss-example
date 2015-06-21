//
//  EntriesTableViewController.swift
//  CocoaPodsFeed
//
//  Created by CursoIOS on 6/19/15.
//  Copyright (c) 2015 CursoIOS. All rights reserved.
//

import UIKit
import SafariServices

class EntriesTableViewController: UITableViewController {

    let entries = EntryRepository.entriesFromJSON()
    var favorites = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 68
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "Cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EntryTableViewCell

        let entry = entries[indexPath.row]
        cell.loadEntry(entry, favorite: favorites.contains(indexPath.row))
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        UIApplication.sharedApplication().openURL(entries[indexPath.row].link)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let title = self.favorites.contains(indexPath.row) ? "Unstar" : "Star"
        let favoriteAction = UITableViewRowAction(style: .Normal, title: title) { [unowned self] (_, indexPath) in
            if self.favorites.contains(indexPath.row) {
                self.favorites.remove(indexPath.row)
            } else {
                self.favorites.insert(indexPath.row)
            }
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
        favoriteAction.backgroundColor = UIColor.orangeColor()
        
        let safariAction = UITableViewRowAction(style: .Normal, title: "Add to Reading List") { [unowned self] (_, indexPath) in
            let item = self.entries[indexPath.row]
            let controller: UIAlertController
            
            if let list = SSReadingList.defaultReadingList()
                where list.addReadingListItemWithURL(item.link, title: item.title, previewText: item.contentSnippet, error: nil) {
                    controller = UIAlertController(title: "Sucesso!", message: "Item adicionado com sucesso", preferredStyle: .Alert)
            } else {
                controller = UIAlertController(title: "Ooops!", message: "Não foi possível adicionar à lista de leitura", preferredStyle: .Alert)
            }
            
            controller.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(controller, animated: true, completion: nil)
        }
        
        safariAction.backgroundColor = UIColor.purpleColor()
        
        return [favoriteAction, safariAction]
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Intentionally blank. Required to use UITableViewRowActions
    }
}
