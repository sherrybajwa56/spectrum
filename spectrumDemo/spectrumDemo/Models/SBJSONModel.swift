//
//  SBJSONModel.swift
//  spectrumDemo
//
//  Created by Sherry Bajwa on 04/12/19.
//  Copyright © 2019 Sherry Bajwa. All rights reserved.
//


import Foundation

protocol SBJSONModel: Codable {
    init?(object: [String : Any])
  
    
}
extension SBJSONModel {
    
    init?(object: [String : Any] ) {
//        guard let data = jsonString.data(using: .utf8) else {
//            return nil
//        }
        let jsondata =  try! JSONSerialization.data(withJSONObject:object , options: .prettyPrinted) as Data
        self = try! JSONDecoder().decode(Self.self, from: jsondata as Data)
        
        // I used force unwrap for simplicity.
        // It is better to deal with exception using do-catch.
        
    }


  public func toDictionary() -> [String : Any]{

        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            
            let dictionry =  try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String : Any]
           // let jsonString = String(data: jsonData, encoding: .utf8)
           // print("JSON String : " + jsonString!)
            
            return dictionry!
            
        }
        catch {
            
        }
      //  let data = try! JSONEncoder.encode(Self.self)
        
        return [:]
    }
    public func toJSONString() -> String{
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            
             let jsonString = String(data: jsonData, encoding: .utf8)
             print("JSON String : " + jsonString!)
            
            return jsonString!
            
        }
        catch {
            
        }
        
        return ""
    }
    public func toData() -> Data?{
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            
            return jsonData
            
        }
        catch {
            
        }
        
        return nil
    }
//    init?(jsonData: Data) {
//
//        self = try! JSONDecoder().decode(Self.self, from: jsonData as Data)
//        // I used force unwrap for simplicity.
//        // It is better to deal with exception using do-catch.
//    }
}
