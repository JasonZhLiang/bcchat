//
//  ChatViewController.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-09.
//

import UIKit
import MessageKit
import InputBarAccessoryView

public struct Sender: SenderType {
    public let senderId: String
    public let displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class ChatViewController: MessagesViewController {
    
    let currentUser = Sender(senderId: "any_unique_id", displayName: "Jason")
    let otherUser = Sender(senderId: "other user", displayName: "John")
    var messages =  [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        messages.append(Message(sender: currentUser,
                                messageId: "1", sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("hello")))
        messages.append(Message(sender: otherUser,
                                messageId: "2", sentDate: Date().addingTimeInterval(-70000),
                                kind: .text("text vs attributedText")))
        messages.append(Message(sender: currentUser,
                                messageId: "3", sentDate: Date().addingTimeInterval(-64000),
                                kind: .text("text from current user, text from current user,text from current user,text from current user,")))
        messages.append(Message(sender: otherUser,
                                messageId: "4", sentDate: Date().addingTimeInterval(-56400),
                                kind: .attributedText(NSAttributedString(string: "other User what's up?  jubmle marble works other User what's up?  jubmle marble works other User what's up?  jubmle marble works"))))
        messages.append(Message(sender: otherUser,
                                messageId: "4", sentDate: Date().addingTimeInterval(-56400),
                                kind: .text("other User what's up?  jubmle marble works other User what's up?  jubmle marble works other User what's up?  jubmle marble works")))
        messages.append(Message(sender: currentUser,
                                messageId: "5", sentDate: Date().addingTimeInterval(-26400),
                                kind: .attributedText(NSAttributedString(string: "current User that will be a wonderful day"))))
        loadMessages()
    }
    
    func loadMessages() {
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToLastItem(animated: false)
        }
    }
    
    
    // MARK: - Private properties
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
}

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
            print("Autocompleted: `", substring, "` with context: ", context ?? [])
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
          insertMessage(message)
        }
//        else if let img = component as? UIImage {
//          let message = MockMessage(image: img, user: user, messageId: UUID().uuidString, date: Date())
//          insertMessage(message)
//        }
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

