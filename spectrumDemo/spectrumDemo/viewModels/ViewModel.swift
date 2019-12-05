//
//  ViewModel.swift
//  spectrumDemo
//
//  Created by Sherry Bajwa on 04/12/19.
//  Copyright © 2019 Sherry Bajwa. All rights reserved.
//

import Foundation

public enum ViewType:Int {
   case companyListType ,
        memberListType
}
public enum SortType:Int {
       case nameAscending,
       nameDecending,
       AgeAcending,
       AgeDecending,
       None
public func displayString() -> String
           {
               switch self {
               case .nameAscending:
                   return "By Name (A-Z)"
               case .nameDecending:
                   return "By Name (Z-A)"
               case .AgeAcending:
                   return "By Age (younger-older)"
               case .AgeDecending:
                   return "By Age (older-younger)"
               case .None:
                return ""
            }
           }
    }
 
protocol ViewModelDelegate  {
    func refreshData()
}
class  ViewModel {
    
    var viewType : ViewType = .companyListType
    
    init(viewtype: ViewType) {
        viewType = viewtype
        configureData()
     }
    var companyList : [CompanyModel]? {
        didSet{
            setDataSourceToShow()
        }
    }
    var dataListToPresent : [Any]?
    var delegate : ViewModelDelegate?
    
    func sortlist(_ type : SortType) {
         
        switch type {
        case .AgeAcending , .AgeDecending:
            sortAgeInOrder(type: type)
         break
            
        case .nameDecending ,.nameAscending :
               sortNamesInOrder(type: type )
            break
        case .None:
            break
            
        }
    }
    func sortAgeInOrder(type : SortType) {
        if let list = dataListToPresent as? [MemberModel] {
            let filteredList = list.sorted { (model1, model2) -> Bool in
                let age1 = model1.age ?? 0;
                let age2 = model2.age ?? 0;
                return type == .AgeDecending ? age1 < age2 : age1 > age2
            }
            dataListToPresent = filteredList
            delegate?.refreshData()
        }
    }
    
    func sortNamesInOrder(type : SortType) {
        if viewType == .companyListType {
              if let companylist : [CompanyModel] = dataListToPresent as? [CompanyModel]  {
                  let sortedNames = companylist.sorted{ (model1, model2) -> Bool in
                      if let name1 = model1.company , let name2 = model2.company{
                        return  type == .nameDecending ? name1 > name2 : name1 < name2
                      }
                      return false
                  }
                  dataListToPresent = sortedNames
                  delegate?.refreshData()
              }
          }
          
          else{
              if let list = dataListToPresent as? [MemberModel] {
                  let sortedNames = list.sorted{ (model1, model2) -> Bool in
                      if let namemodel1 =  model1.name ,let name1 = namemodel1.first , let namemodel2 =  model2.name ,let name2 = namemodel2.first{
                      return type == .nameDecending ? name1 > name2 : name1 < name2
                      }
                      return false
                  }
                   dataListToPresent = sortedNames
                    delegate?.refreshData()
              }
          }
    }
    func searchItemsWith(searchText : String){
        if viewType == .companyListType{
                let filteredList = companyList?.filter({
                if let companyName = $0.company {
                     return (companyName.localizedCaseInsensitiveContains(searchText) )
                }
                   return false
            })
                dataListToPresent = filteredList
                delegate?.refreshData()
          
            
        }
        else{
            guard let memberList = companyList?.first?.members  else{
                    return
            }
            let filteredList = memberList.filter({
                if let companyName = $0.name , let first = companyName.first ,let last = companyName.last {
                    return (first.contains(searchText) || (last.localizedCaseInsensitiveContains(searchText)))
                         }
                            return false
                     })
             dataListToPresent = filteredList
             delegate?.refreshData()
        }
      
    }
    public func fetchJSON(_ fileName:String, fromBundle bundle: Bundle) -> Any? {
        
        if let bundleURL = bundle.path(forResource: fileName, ofType: "json") {
            if let
                jsonData = try? Data(contentsOf: URL(fileURLWithPath: bundleURL)) {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
                    return jsonObject
                } catch {
                    print("Could not parse JSON from \(fileName)")
                }
            }
        }
        return nil
    }
    func configureData() {
        if viewType == .companyListType{
            guard let json = self.fetchJSON("data", fromBundle: Bundle.main),
                           let data = json as? [[String:AnyObject]] else {
                               return
                       }
            companyList = data.map({CompanyModel(object: $0)!})
        }
        
    }
    func  resetData() {
        setDataSourceToShow()
        delegate?.refreshData()
    }
    
    func setDataSourceToShow() {
        if viewType == .companyListType{
                  dataListToPresent = companyList
              }
              else{
                  dataListToPresent = companyList?.first?.members
              }
    }
}
