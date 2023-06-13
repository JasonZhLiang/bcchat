//
//  ChannelTableViewController.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-09.
//

import UIKit
import SwipeCellKit
import StoreKit

class ChannelTableViewController: UITableViewController, SwipeTableViewCellDelegate, SKPaymentTransactionObserver {
    
    let productID = "com.braincloud.bcchat.dynamicchannel"
    
    let dataManager = DataManager()
    
    var channels = [Channel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 65.0
        SKPaymentQueue.default().add(self)
        channels = dataManager.getChannels()
        if isPurchased(){
            setUserIAPbool()
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        channels = dataManager.getChannels()
//    }
    

    //MARK: - tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //need to go to main.storyboard to change the cell identifier with a generic name Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = channels[indexPath.row].code ?? "this app has no channel shows up"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    //MARK: - tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chatVC = ChatViewController()
        chatVC.selectedChannel = channels[indexPath.row]
        chatVC.title = "⚡️bcChat"
        navigationController?.pushViewController(chatVC, animated: true)
    }

    //MARK: - swipe delegate methods
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            let deleteChannel = self.channels[indexPath.row]
            self.channels.remove(at: indexPath.row)
            if deleteChannel.type == "dy" {
                self.dataManager.deleteDynamicChannel(channelId: deleteChannel.id)
            }
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
    
    //MARK: - IAP SKPaymentTransactionObserver
    
    func buyPrivateChannel(){
        if SKPaymentQueue.canMakePayments(){
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        }else{
            print("user can't make payments")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased{
                //user payment successful
                setUserIAPbool()
                if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
                    FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {
                    print(appStoreReceiptURL.path)
                    print(appStoreReceiptURL.absoluteString)
                    do {
                        let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                        let receiptString = receiptData.base64EncodedString(options: [])
                        print(receiptString)
                        self.dataManager.verifyReceipt(receiptString: receiptString)
                        SKPaymentQueue.default().finishTransaction(transaction)
                    }
                    catch { print("Couldn't read receipt data with error: " + error.localizedDescription) }
                }
            }else if transaction.transactionState == .failed{
                //payment failed
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("transaction failed due to \(errorDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            }else if transaction.transactionState == .restored{
                //restore button pressed trigger a process of checking their current user ID and against Apple's database
                print("restore triggered and transaction restored")
                setUserIAPbool()
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    
    func setUserIAPbool(){
        //flag the user who has bought this product to local user device, so the user can have full access
        UserDefaults.standard.set(true, forKey: productID)
        tableView.reloadData()
    }
    
    func isPurchased() -> Bool{
        return UserDefaults.standard.bool(forKey: productID)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        if isPurchased(){
            var textField = UITextField()
            let alert = UIAlertController(title: "Add New private channel", message: "", preferredStyle: .alert)
            let addChannelAction = UIAlertAction(title: "Add channel", style: .default) { UIAlerAction in
                let channelCode = textField.text ?? UUID().uuidString
                var newChannel = Channel(id: "\(Bundle.main.infoDictionary?["appId"] as! String):dy:\(channelCode)",
                                         type: "dy",
                                         code: channelCode,
                                         name: channelCode,
                                         desc: channelCode)
                self.channels.append(newChannel)
                self.dataManager.addDynamicChannel(channelCode: channelCode)
            }
            alert.addTextField { alertTextField in
                alertTextField.placeholder = "Create new dynamic channel"
                textField = alertTextField
            }
            alert.addAction(addChannelAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                alert.dismiss(animated: true)
            }
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Buy private channel", message: "Click the Buy or Restore button below to add private channel", preferredStyle: .alert)
            let buyAction = UIAlertAction(title: "Buy", style: .default) { UIAlerAction in
                self.buyPrivateChannel()
            }
            alert.addAction(buyAction)
            let restoreAction = UIAlertAction(title: "Restore", style: .default) { UIAlerAction in
                SKPaymentQueue.default().restoreCompletedTransactions()
            }
            alert.addAction(restoreAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                alert.dismiss(animated: true)
            }
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
