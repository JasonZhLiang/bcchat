//
//  Message.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-12.
//

import Foundation
import MessageKit

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}
