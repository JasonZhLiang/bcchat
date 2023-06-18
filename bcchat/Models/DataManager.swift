//
//  DataManager.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-12.
//

import Foundation
import BrainCloud

struct DataManager {

    func onSuccess(serviceName:String?, serviceOperation:String?, jsonData:String?, cbObject: NSObject?) {
        print("\(serviceOperation!) Success \(jsonData!)")
        let data = jsonData?.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        switch serviceOperation {
        case "RUN":
            let sData = serializedJson(jsonData: data!)
            let scriptSuccess = sData!["response"] as! Dictionary<String, AnyObject>
            print("script running result: \(scriptSuccess)")
        case "VERIFY_PURCHASE":
            let sData = serializedJson(jsonData: data!)
            let transactionSummary = sData!["transactionSummary"] as! Dictionary<String, AnyObject>
            print("VERIFY_PURCHASE result: \(transactionSummary)")
        case .none:
            print("with none")
        case .some(_):
            print("with some")
        }
    }
    
    func serializedJson(jsonData: Data) -> AnyObject? {
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
            let data = json["data"] as AnyObject;
            return data
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
            return nil
        }
    }
    
    func parseJSON(_ channelData: Data)-> Channel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Channel.self, from: channelData)
            return decodedData
        } catch {
            print("Failed to parseJSON: \(error.localizedDescription)")
            return nil
        }
    }
    
    func onFail(serviceName:String?, serviceOperation:String?, statusCode:Int?, reasonCode:Int?, jsonError:String?, cbObject: NSObject?) {
        print("\(serviceOperation!) Failure \(jsonError!)")
    }
    
    func addDynamicChannel(channelCode: String){
        let scriptData = "{\"channelSubId\":\"\(channelCode)\"}"
        print("scriptData is : \(scriptData)")
        AppDelegate._bc.scriptService.run("bcchat/addDynamicChannel", jsonScriptData: scriptData, completionBlock: onSuccess, errorCompletionBlock: onFail, cbObject: nil)
    }
    
    func verifyReceipt(receiptString: String){
        let receiptData = "{\"receipt\":\"\(receiptString)\"}"
        AppDelegate._bc.appStoreService.verifyPurchase("itunes", receiptData: receiptData, completionBlock: onSuccess, errorCompletionBlock: onFail, cbObject: nil)
    }
    
    func deleteDynamicChannel(channelId: String){
        let scriptData = "{\"channelId\":\"\(channelId)\"}"
        AppDelegate._bc.scriptService.run("bcchat/deleteDynamicChannel", jsonScriptData: scriptData, completionBlock: onSuccess, errorCompletionBlock: onFail, cbObject: nil)
    }
    
    func isAuthenticated() -> Bool {
        return UserDefaults.standard.bool(forKey: "HasAuthenticated")
    }
}
