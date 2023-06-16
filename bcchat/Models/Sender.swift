//
//  Sender.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-12.
//

import Foundation
import MessageKit


struct Sender: SenderType, Codable {
    var senderId: String
    var displayName: String
}
