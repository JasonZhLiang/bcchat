//
//  ChatViewController.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-09.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController {
    
    var currentUser = Sender(senderId: AppDelegate._bc.storedProfileId, displayName: "currentDefault")
    var messages =  [Message]()
    
    var dataManager = DataManager()
    
    var selectedChannel: Channel? {
        didSet{
            loadMessages()
        }
    }
    
    override func viewDidLoad() {
        if dataManager.isAuthenticated() {
            super.viewDidLoad()
            messagesCollectionView.messagesDataSource = self
            messagesCollectionView.messagesLayoutDelegate = self
            messagesCollectionView.messagesDisplayDelegate = self
            messageInputBar.delegate = self
            enableRtt()
        }
    }
    
    func loadMessages() {
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToLastItem(animated: false)
        }
    }
    
    //MARK: - bc rtt/chat methods
    
    func enableRtt(){
        AppDelegate._bc.getBCClient()?.rttService.disableRTT();
        AppDelegate._bc.getBCClient()?.rttService.enable(onRTTEnabled, failureCompletionBlock: onRTTFailed, cbObject: nil);
    }
    func onRTTEnabled(cbObject: NSObject?) {
        AppDelegate._bc.getBCClient()?.rttService.registerChatCallback(onChatEvent, cbObject: nil)
        connectChannel()
    }
    
    func onRTTFailed(message:String?, cbObject: NSObject?) {
        print("Rtt Enable Failure \(message!)")
    }
    
    func onChatEvent(eventJsonStr:String?, cbObject: NSObject?) {
        let data = eventJsonStr!.data(using: .utf8)
        let sOperation = serializedJson(jsonData: data!, fieldName: "operation") as! String
        if sOperation == "INCOMING" {
            let fMessage = serializedJson(jsonData: data!, fieldName: "data")
            let fFrom = fMessage!["from"] as! Dictionary<String, AnyObject>
            let senderId = fFrom["id"] as! String
            let senderName = fFrom["name"] as! String
            let newSender = Sender(senderId: senderId, displayName: senderName)
            let content = fMessage!["content"] as! Dictionary<String, AnyObject>
            let unixTime = fMessage!["date"] as! Double
            let date = Date(timeIntervalSince1970: unixTime/1000)
            var newMessage = Message(sender: newSender,
                                     messageId: fMessage!["msgId"] as! String,
                                     sentDate: date,
                                     kind: .text(content["text"] as! String))
            if senderId == currentUser.senderId {
                currentUser.displayName = senderName
                newMessage.sender = currentUser
            }else{
                messages.append(newMessage)
                loadMessages()
            }
        }
    }
    
    func connectChannel(){
        AppDelegate._bc.chatService.channelConnect(selectedChannel?.id, maxReturn: 200, completionBlock: onSuccess, errorCompletionBlock: onFail, cbObject: nil)
    }
    
    func onSuccess(serviceName:String?, serviceOperation:String?, jsonData:String?, cbObject: NSObject?) {
        print("\(serviceOperation!) Success \(jsonData!)")
        
        let data = jsonData?.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        switch serviceOperation {
        case "CHANNEL_CONNECT":
            let sData = serializedJson(jsonData: data!, fieldName: "data")
            let fMessages = sData!["messages"]! as! [AnyObject]
            for fMessage in fMessages {
                let fFrom = fMessage["from"] as! Dictionary<String, AnyObject>
                let senderId = fFrom["id"] as! String
                let senderName = fFrom["name"] as! String
                let newSender = Sender(senderId: senderId, displayName: senderName)
                let content = fMessage["content"] as! Dictionary<String, AnyObject>
                let unixTime = fMessage["date"] as! Double
                let date = Date(timeIntervalSince1970: unixTime/1000)
                var newMessage = Message(sender: newSender,
                                         messageId: fMessage["msgId"] as! String,
                                         sentDate: date,
                                         kind: .text(content["text"] as! String))
                if senderId == currentUser.senderId {
                    currentUser.displayName = senderName
                    newMessage.sender = currentUser
                }
                messages.append(newMessage)
            }
            loadMessages()
        case "POST_CHAT_MESSAGE":
            let sData = serializedJson(jsonData: data!, fieldName: "data")
            let msgId = sData!["msgId"] as! String
            print("POST_CHAT_MESSAGE message id:\(msgId)")
        case .none:
            print("with none")
        case .some(_):
            print("with some")
        }
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
    
    // MARK: - Private properties
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
}


//MARK: - MessagesDataSource

extension ChatViewController: MessagesDataSource{
    var currentSender: SenderType {
        currentUser
    }
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return NSAttributedString(
            string: MessageKitDateFormatter.shared.string(from: message.sentDate),
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10),
                NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            ])
    }
    
    func cellBottomLabelAttributedText(for _: MessageType, at _: IndexPath) -> NSAttributedString? {
        NSAttributedString(
            string: "Read",
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10),
                NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            ])
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at _: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at _: IndexPath) -> NSAttributedString? {
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(
            string: dateString,
            attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
    
}

//MARK: - MessagesDisplayDelegate

extension ChatViewController: MessagesDisplayDelegate {
    func messageStyle(for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> MessageStyle {
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(tail, .curved)
    }
}


//MARK: - MessagesLayoutDelegate

extension ChatViewController: MessagesLayoutDelegate {
    
    //    func backgroundColor(for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> UIColor {
    //        isFromCurrentSender(message: message) ? .purple : UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
    //    }
    func cellTopLabelHeight(for _: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
        18
    }
    
    func cellBottomLabelHeight(for _: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
        17
    }
    
    func messageTopLabelHeight(for _: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
        20
    }
    
    func messageBottomLabelHeight(for _: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
        16
    }
}

//MARK: - InputBarAccessoryViewDelegate

extension ChatViewController: InputBarAccessoryViewDelegate {
    // MARK: Internal
    
    @objc
    func inputBar(_: InputBarAccessoryView, didPressSendButtonWith _: String) {
        processInputBar(messageInputBar)
    }
    
    func processInputBar(_ inputBar: InputBarAccessoryView) {
        // Here we can parse for which substrings were autocompleted
        let attributedText = inputBar.inputTextView.attributedText!
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { _, range, _ in
            
            let substring = attributedText.attributedSubstring(from: range)
            let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
        }
        
        let components = inputBar.inputTextView.components
        inputBar.inputTextView.text = String()
        inputBar.invalidatePlugins()
        // Send button activity animation
        inputBar.sendButton.startAnimating()
        inputBar.inputTextView.placeholder = "Sending..."
        // Resign first responder for iPad split view
        inputBar.inputTextView.resignFirstResponder()
        DispatchQueue.global(qos: .default).async {
            // fake send request task
            sleep(1)
            DispatchQueue.main.async { [weak self] in
                inputBar.sendButton.stopAnimating()
                inputBar.inputTextView.placeholder = "Aa"
                self?.insertMessages(components)
                self?.messagesCollectionView.scrollToLastItem(animated: true)
            }
        }
    }
    
    // MARK: Private
    
    private func insertMessages(_ data: [Any]) {
        for component in data {
            let user = currentUser
            if let str = component as? String {
                let message = Message(sender: user, messageId: UUID().uuidString, sentDate: Date(), kind: .text(str))
                AppDelegate._bc.chatService.postMessage(selectedChannel?.id, content: "{\"text\":\"\(str)\"}", recordInHistory: true, completionBlock: onSuccess, errorCompletionBlock: onFail, cbObject: nil)
                insertMessage(message)
            }
        }
    }
    
    // MARK: - Helpers
    
    func insertMessage(_ message: Message) {
        messages.append(message)
        
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messages.count - 1])
            if messages.count >= 2 {
                messagesCollectionView.reloadSections([messages.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToLastItem(animated: true)
            }
        })
    }
    
    func isLastSectionVisible() -> Bool {
        guard !messages.isEmpty else { return false }
        
        let lastIndexPath = IndexPath(item: 0, section: messages.count - 1)
        
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
}

