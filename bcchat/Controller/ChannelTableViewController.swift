//
//  ChannelTableViewController.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-09.
//

import UIKit
import SwipeCellKit

class ChannelTableViewController: UITableViewController, SwipeTableViewCellDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 65.0
    }

    //MARK: - tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //need to go to main.storyboard to change the cell identifier with a generic name Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = "Global Channel 1"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    //MARK: - tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chatVC = ChatViewController()
        chatVC.title = "⚡️bcChat"
        navigationController?.pushViewController(chatVC, animated: true)
    }

    //MARK: - swipe delegate methods
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in

//            if let deleteCategory = self.categoryArray?[indexPath.row]{
//                do{
//                    try self.realm.write({
//                        self.realm.delete(deleteCategory)
//                    })
//                }catch{
//                    print("Error deleting realm category\(error)")
//                }
//            }
            //if we add optional behaviour with options.expansionStyle = .destructive, we don't need this line
            tableView.reloadData()
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    //add optional behaviour
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
}
