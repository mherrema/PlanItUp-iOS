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
//    var updates = [String]()
    var updates = [Update]()
    //var projects = [String]()
    var projects = [Project]()
//    var tasks = [String]()
    var tasks = [Task]()
    var sectionTitles = [String]()
    var tableData = [String]()
    var filteredResults = [String]()
    var filteredUpdates = [Update]()
    var filteredProjects = [Project]()
    var filteredTasks = [Task]()
    
    var header = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updates = [Update(updateID: 1, projectId: 1, description: "Create Frontend", date: NSDate(), userId: 1), Update(updateID: 2, projectId: 1, description: "Build Login Page", date: NSDate(), userId: 1), Update(updateID: 1, projectId: 1, description: "Build API", date: NSDate(), userId: 1)]
        
        projects = [Project(projectId: 1, name: "Project 1", description: "Project 1 is the first project.", due_date: NSDate()), Project(projectId: 2, name: "Project 2", description: "Project 2 is the second project.", due_date: NSDate()), Project(projectId: 3, name: "Project 3", description: "Project 3 is the third project.", due_date: NSDate())]
        
        tasks = [Task(taskId: 1, name: "Sync with Twilio", description: "Get API to talk to Twilio's API", projectId: 1, dueDate: NSDate(), rating: 4, userID: 1, status: "Not Completed"),Task(taskId: 2, name: "Build Chat Interface", description: "Get Chat Interface built", projectId: 1, dueDate: NSDate(), rating: 4, userID: 1, status: "Not Completed")]
        
//        updates = ["\"Create Frontend\" task Completed", "\"Build Login Page\" task Completed"]
//        projects = ["Project 1", "Project 2", "Project 3"]
//        tasks = ["Complete Timetracker", "Hook Up With Twilio", "Create Chat"]
        sectionTitles = ["Recent Updates", "Projects", "Tasks"]
        
        // Do any additional setup after loading the view, typically from a nib.
        //        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        //
        //        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        //        self.navigationItem.rightBarButtonItem = addButton
        
        self.tableView.reloadData()
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        header = self.tableView(self.tableView, titleForHeaderInSection: indexPath.section)!
        if(header == "Recent Updates"){
            self.performSegueWithIdentifier("showUpdate", sender: tableView)
        }
        else if(header == "Projects"){
            self.performSegueWithIdentifier("showProject", sender: tableView)
        }
        else if(header == "Tasks"){
            self.performSegueWithIdentifier("showTask", sender: tableView)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showDetail" {
            let candyDetailViewController = segue.destinationViewController as UIViewController
            if (sender as UITableView == self.searchDisplayController!.searchResultsTableView) {
                NSLog("Got Here")
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
                let destinationTitle = "search"
                candyDetailViewController.title = destinationTitle
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow()!
//                let destinationTitle = self.candies[indexPath.row].name
                candyDetailViewController.title = "Title"
            }
        }
        if segue.identifier == "showUpdate" {
            let updateDetailViewController = segue.destinationViewController as UIViewController
                        let indexPath = self.tableView.indexPathForSelectedRow()!
            //                let destinationTitle = self.candies[indexPath.row].name
            updateDetailViewController.title = "Update Details"
            //            }
        }
        if segue.identifier == "showProject" {
            let projectDetailViewController = segue.destinationViewController as UIViewController
            let indexPath = self.tableView.indexPathForSelectedRow()!
            //                let destinationTitle = self.candies[indexPath.row].name
            projectDetailViewController.title = "Project Details"
            //            }
        }
        if segue.identifier == "showUpdate" {
            let taskDetailViewController = segue.destinationViewController as UIViewController
            let indexPath = self.tableView.indexPathForSelectedRow()!
            //                let destinationTitle = self.candies[indexPath.row].name
            taskDetailViewController.title = "Task Details"
            //            }
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
                    cell.textLabel?.text = filteredUpdates[indexPath.row].description
                }
                else if(filteredUpdates.count == 0 && filteredProjects.count != 0){
                    cell.textLabel?.text = filteredProjects[indexPath.row].name
                }
                else{
                    cell.textLabel?.text = filteredTasks[indexPath.row].name
                }
            }
            if(indexPath.section == 1){
                if(filteredUpdates.count == 0 || filteredProjects.count == 0){
                    cell.textLabel?.text = filteredTasks[indexPath.row].name
                }
                else{
                    cell.textLabel?.text = filteredProjects[indexPath.row].name
                }
                
            }
            if(indexPath.section == 2){
                cell.textLabel?.text = filteredTasks[indexPath.row].name
            }
        } else {
            if(indexPath.section == 0){
                if(indexPath.row != updates.count){
                    cell.textLabel?.text = updates[indexPath.row].description
                }
                else{
                    cell.textLabel?.text = "See All Updates"
                    cell.textLabel?.textAlignment = NSTextAlignment.Center
                    cell.textLabel?.font = UIFont.boldSystemFontOfSize(16)
                }
            }
            if(indexPath.section == 1){
                if(indexPath.row != projects.count){
                    cell.textLabel?.text = projects[indexPath.row].name
                }
                else{
                    cell.textLabel?.text = "See All Projects"
                    cell.textLabel?.textAlignment = NSTextAlignment.Center
                    cell.textLabel?.font = UIFont.boldSystemFontOfSize(16)
                }
            }
            if(indexPath.section == 2){
                if(indexPath.row != tasks.count){
                    cell.textLabel?.text = tasks[indexPath.row].name
                }
                else{
                    cell.textLabel?.text = "See All Tasks"
                    cell.textLabel?.textAlignment = NSTextAlignment.Center
                    cell.textLabel?.font = UIFont.boldSystemFontOfSize(16)
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
        filteredUpdates = self.updates.filter({(current) -> Bool in
            let stringMatch = current.description.lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil)
        })
        
        filteredProjects = self.projects.filter({(current) -> Bool in
let stringMatch = current.name.lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil)
        })
        
        filteredTasks = self.tasks.filter({(current) -> Bool in
            let stringMatch = current.name.lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil)
        })
        
//        filteredResults = filteredUpdates + filteredProjects + filteredTasks
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    func getDateFromString(input:String) -> NSDate{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm a"
        let date = dateFormatter.dateFromString(input)
        return date!
    }
    
    
}

