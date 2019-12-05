//
//  MasterModel.swift
//  spectrumDemo
//
//  Created by Sherry Bajwa on 04/12/19.
//  Copyright © 2019 Sherry Bajwa. All rights reserved.
//

import Foundation

struct CompanyModel:SBJSONModel{
    
    var id:String?
    var company:String?
    var website:String?
    var logo:String?
    var about:String?
    var members:[MemberModel]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case company = "company"
        case website = "website"
        case logo = "logo"
        case about = "about"
        case members = "members"//Custom keys
        
    }    
}
struct MemberModel:SBJSONModel{
    var id:String?
    var email:String?
    var phone:String?
    var age:Int?
    var name :Name?
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case email = "email"
        case phone = "phone"
        case age = "age"
        case name = "name"
        
    }
}
  struct Name :SBJSONModel{
        var first :String?
        var last :String?

    }

