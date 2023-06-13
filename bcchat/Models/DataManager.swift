//
//  DataManager.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-12.
//

import Foundation

struct DataManager {
    var channels = [Channel]()
    
    //MARK: - bc methods
    func getChannels() -> [Channel] {
        //append from GetSubscribedChannels() for gl and gr channels
        
        //append from customEntity collection dyanmicChannel for dy channels
        
        return channels
    }
    
    func loadMessagesByChannel(channel: Channel){
        
    }
    ///add bc dynamic channel
    func addDynamicChannel(channelCode: String){
        
    }
    
    func verifyReceipt(receiptString: String){
        
    }
    
    func deleteDynamicChannel(channelId: String){
        
    }
}
