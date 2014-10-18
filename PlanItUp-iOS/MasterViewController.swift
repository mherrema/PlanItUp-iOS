//
//  MasterViewController.swift
//  PlanItUp-iOS
//
//  Created by Mitch Herrema on 10/18/14.
//  Copyright (c) 2014 Mitch Herrema. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var objects = NSMutableArray()
    var updates = [String]()
    var projects = [String]()
    var tasks = [String]()
    var sectionTitles = [String]()
    var tableData = [String]()
    var filteredResults = [String]()
    var filteredUpdates = [String]()
    var filteredProjects = [String]()
    var filteredTasks = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updates = ["\"Create Frontend\" task Completed", "\"Build Login Page\" task Completed"]
        projects = ["Project 1", "Project 2", "Project 3"]
        tasks = ["Complete Timetracker", "Hook Up With Twilio", "Create Chat"]
        sectionTitles = ["Updates", "Projects", "Tasks"]
        
        // Do any additional setup after loading the view, typically from a nib.
        //        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        //
        //        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        //        self.navigationItem.rightBarButtonItem = addButton
        
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        objects.insertObject(NSDate.date(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as NSDate
                (segue.destinationViewController as DetailViewController).detailItem = object
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (tableView == self.searchDisplayController!.searchResultsTableView) {
            if(filteredUpdates.count != 0 && filteredProjects.count != 0 && filteredTasks.count != 0){
                return 3
            }
            else if((filteredUpdates.count != 0 && filteredProjects.count != 0) || (filteredUpdates.count != 0 && filteredTasks.count != 0) || (filteredProjects.count != 0 && filteredTasks.count != 0)){
                return 2
            }
            else{
                return 1
            }
        } else {
            return sectionTitles.count
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            if(filteredUpdates.count != 0 && filteredProjects.count != 0 && filteredTasks.count != 0){
                return sectionTitles[section]
            }
            else if(section == 1){
                if(filteredUpdates.count==0 || filteredProjects.count==0){
                    return "Tasks"
                }
                else{
                    return "Projects"
                }
            }
            else{
                if(filteredUpdates.count==0 && filteredProjects.count==0 && filteredTasks.count==0){
                    return ""
                }
                else if(filteredUpdates.count==0 && filteredProjects.count==0){
                    return "Tasks"
                }
                else if(filteredUpdates.count==0 && filteredProjects.count != 0){
                    return "Projects"
                }
                else{
                    return sectionTitles[section]
                }
            }
            } else {
            return sectionTitles[section]
        }
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            if(filteredUpdates.count != 0 && filteredProjects.count != 0 && filteredTasks.count != 0){
                if(section == 0){
                    return filteredUpdates.count
                }
                if(section == 1){
                    return filteredProjects.count
                }
                if(section == 2){
                    return filteredTasks.count
                }
            }
            else if(section == 1){
                if(filteredUpdates.count==0 || filteredProjects.count==0){
                    return filteredTasks.count
                }
                else{
                    return filteredProjects.count
                }
            }
            else{
                if(filteredUpdates.count==0 && filteredProjects.count==0){
                    return filteredTasks.count
                }
                else if(filteredUpdates.count==0 && filteredProjects.count != 0){
                    return filteredProjects.count
                }
                else{
                    return filteredUpdates.count
                }
            }
            
        } else {
            if(section == 0){
                return updates.count + 1
            }
            if(section == 1){
                return projects.count + 1
            }
            if(section == 2){
                return tasks.count + 1
            }
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        if tableView == self.searchDisplayController!.searchResultsTableView {
            //            cell.textLabel?.text = filteredResults[indexPath.row]
            if(indexPath.section == 0){
                if(filteredUpdates.count != 0){
                    cell.textLabel?.text = filteredUpdates[indexPath.row]
                }
                else if(filteredUpdates.count == 0 && filteredProjects.count != 0){
                    cell.textLabel?.text = filteredProjects[indexPath.row]
                }
                else{
                    cell.textLabel?.text = filteredTasks[indexPath.row]
                }
            }
            if(indexPath.section == 1){
                if(filteredUpdates.count == 0 || filteredProjects.count == 0){
                    cell.textLabel?.text = filteredTasks[indexPath.row]
                }
                else{
                    cell.textLabel?.text = filteredProjects[indexPath.row]
                }
                
            }
            if(indexPath.section == 2){
                cell.textLabel?.text = filteredTasks[indexPath.row]
            }
        } else {
            if(indexPath.section == 0){
                if(indexPath.row != updates.count){
                    cell.textLabel?.text = updates[indexPath.row]
                }
                else{
                    cell.textLabel?.text = "See All Updates"
                    cell.textLabel?.textAlignment = NSTextAlignment.Center
                }
            }
            if(indexPath.section == 1){
                if(indexPath.row != projects.count){
                    cell.textLabel?.text = projects[indexPath.row]
                }
                else{
                    cell.textLabel?.text = "See All Projects"
                    cell.textLabel?.textAlignment = NSTextAlignment.Center
                }
            }
            if(indexPath.section == 2){
                if(indexPath.row != tasks.count){
                    cell.textLabel?.text = tasks[indexPath.row]
                }
                else{
                    cell.textLabel?.text = "See All Tasks"
                    cell.textLabel?.textAlignment = NSTextAlignment.Center
                }
            }
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredUpdates = self.updates.filter({(String) -> Bool in
            let stringMatch = String.lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil)
        })
        
        filteredProjects = self.projects.filter({(String) -> Bool in
let stringMatch = String.lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil)
        })
        
        filteredTasks = self.tasks.filter({(String) -> Bool in
            let stringMatch = String.lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil)
        })
        
        filteredResults = filteredUpdates + filteredProjects + filteredTasks
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    
}

