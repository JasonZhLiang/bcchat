//
//  Channel.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-12.
//

import Foundation


struct Channel: Codable {
    var id: String
    var type: String
    var code: String?
    var name: String?
    var desc: String?
}
