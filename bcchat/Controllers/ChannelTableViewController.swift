//
//  ChannelTableViewController.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-09.
//

import UIKit
import SwipeCellKit
import StoreKit
import ChameleonFramework

class ChannelTableViewController: UITableViewController, SwipeTableViewCellDelegate, SKPaymentTransactionObserver {
    
    let productID = "com.braincloud.bcchat.dynamicchannel"
    
    var dataManager = DataManager()
    
    var channels = [Channel]()
    
    override func viewDidLoad() {
        if dataManager.isAuthenticated() {
            super.viewDidLoad()
            tableView.rowHeight = 65.0
            SKPaymentQueue.default().add(self)
            loadChannels()
            if isPurchased(){
                setUserIAPbool()
            }
            title = "⚡️bcChat-Channels"
            tableView.separatorStyle = .none
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navbar = navigationController?.navigationBar else{
            fatalError("guard navigation controller does not exist.")
        }
        navbar.backgroundColor = UIColor(named: "BrandBlue")
        navbar.tintColor = UIColor(hexString: "1D9BF6")
    }
    
    //MARK: - bc methods
    
    func loadChannels() {
        channels.removeAll()
        //append from GetSubscribedChannels() for gl and gr channels
        AppDelegate._bc.chatService.getSubscribedChannels("gl", completionBlock: onSuccess, errorCompletionBlock: onFail, cbObject: nil)
        //append from customEntity collection dyanmicChannel for dy channels
        let context = "{\"pagination\":{\"rowsPerPage\":50,\"pageNumber\":1},\"searchCriteria\":{},\"sortCriteria\":{\"createdAt\":1,\"updatedAt\":-1}}"
        AppDelegate._bc.customEntityService.getPage("dynamicChannel", context: context, completionBlock: onSuccess, errorCompletionBlock: onFail, cbObject: nil)
    }
    
    func onSuccess(serviceName:String?, serviceOperation:String?, jsonData:String?, cbObject: NSObject?) {
        let data = jsonData?.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        switch serviceOperation {
        case "GET_SUBSCRIBED_CHANNELS":
            let sData = serializedJson(jsonData: data!, fieldName: "data")
            let fChannels = sData!["channels"]! as! [AnyObject]
            for fChannel in fChannels{
                let newChannel = Channel(id: fChannel["id"] as! String,
                                         type: fChannel["type"] as! String,
                                         code: fChannel["code"] as? String,
                                         name: fChannel["name"] as? String,
                                         desc: fChannel["desc"] as? String ?? "bcChat app global channel"
                )
                channels.append(newChannel)
                channels  = channels.sorted {
                    $0.id < $1.id
                }
            }
        case "GET_ENTITY_PAGE":
            let sData = serializedJson(jsonData: data!, fieldName: "data")
            let sResults = sData!["results"] as! Dictionary<String, AnyObject>
            let fChannels = sResults["items"]! as! Array<AnyObject>
            for fChannel in fChannels{
                let entityData = fChannel["data"] as! Dictionary<String, AnyObject>
                let newChannel = Channel(id: entityData["id"] as! String,
                                         type: entityData["type"] as! String,
                                         code: entityData["code"] as? String,
                                         name: entityData["name"] as? String,
                                         desc: entityData["desc"] as? String ?? "bcChat app global channel"
                )
                channels.append(newChannel)
                channels  = channels.sorted {
                    $0.id < $1.id
                }
            }
        case .none:
            print("with none")
        case .some(_):
            print("with some")
        }
        tableView.reloadData()
    }
    
    
    func serializedJson(jsonData: Data, fieldName: String) -> AnyObject? {
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
            let data = json[fieldName] as AnyObject;
            return data
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
            return nil
        }
    }
    
    func onFail(serviceName:String?, serviceOperation:String?, statusCode:Int?, reasonCode:Int?, jsonError:String?, cbObject: NSObject?) {
        print("\(serviceOperation!) Failure \(jsonError!)")
    }
    
    
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
        cell.backgroundColor = UIColor.randomFlat()
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        return cell
    }
    
    //MARK: - tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chatVC = ChatViewController()
        chatVC.selectedChannel = channels[indexPath.row]
        chatVC.title = "⚡️" + channels[indexPath.row].id
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
//        return UserDefaults.standard.bool(forKey: productID)
        return true
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        if isPurchased(){
            var textField = UITextField()
            let alert = UIAlertController(title: "Add New private channel", message: "", preferredStyle: .alert)
            let addChannelAction = UIAlertAction(title: "Add channel", style: .default) { UIAlerAction in
                let channelCode = textField.text ?? UUID().uuidString
                let newChannel = Channel(id: "\(Bundle.main.infoDictionary?["appId"] as! String):dy:\(channelCode)",
                                         type: "dy",
                                         code: channelCode,
                                         name: channelCode,
                                         desc: channelCode)
                self.channels.append(newChannel)
                self.dataManager.addDynamicChannel(channelCode: channelCode)
                self.tableView.reloadData()
            }
            alert.addTextField { alertTextField in
                alertTextField.placeholder = "dynamic channel code"
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

extension ChannelTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        channels = channels.filter({
            $0.code!.localizedCaseInsensitiveContains(searchBar.text!)
        })
        tableView.reloadData()
//        let channelPredicate = NSPredicate(format: "code CONTAINS[cd] %@", searchBar.text!)
//        let nsChannels = channels as NSArray
//        channels = nsChannels.filtered(using: channelPredicate) as! Array<Channel>
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchBar.text?.count == 0 {
            loadChannels()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
