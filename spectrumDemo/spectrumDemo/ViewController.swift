//
//  ViewController.swift
//  spectrumDemo
//
//  Created by Sherry Bajwa on 03/12/19.
//  Copyright © 2019 Sherry Bajwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var searchbar: UISearchBar!
    @IBOutlet  weak var tableView: UITableView!
    var viewType : ViewType = .companyListType
    var viewModel : ViewModel!
    var currentSortType : SortType = .None
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewType == .companyListType{
            viewModel = ViewModel(viewtype: viewType)
        }
        viewModel.delegate = self
        searchbar.delegate = self
        tableView.tableHeaderView = searchbar
        
        tableView.reloadData()
    }
    @IBAction func performSort(_ sender: Any) {
        performSegue(withIdentifier: "sortSegue", sender:sender )
        
    }
    @IBAction func resetList(_ sender: Any) {
        viewModel.resetData()
        currentSortType = .None
        
    }
    
    func navigateToMemberListView(datamodel : CompanyModel) {
        
        guard datamodel.members != nil else {
            return
        }
        if  let vc : ViewController = self.storyboard?.instantiateViewController(identifier: "ViewController"){
            
            vc.viewModel = ViewModel(viewtype: .memberListType)
            vc.viewModel.companyList = [datamodel]
            vc.viewType = .memberListType
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController else { return }
        guard navigationController.viewControllers.count > 0 else { return }
        
        if segue.identifier == "sortSegue" {
            guard let toVC = navigationController.viewControllers[0] as? SortViewController else { return }
            toVC.originalSortType = currentSortType
            toVC.delegate = self
        }
    }
}
extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
        if searchText.isEmpty{
            viewModel.resetData()
                   if currentSortType != .None{
                       viewModel.sortlist(currentSortType)
                   }
        }
        else{
            viewModel.searchItemsWith(searchText: searchText)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        self.view.endEditing(true)
        searchBar.text = ""
        viewModel.resetData()
        if currentSortType != .None{
            viewModel.sortlist(currentSortType)
        }
        
    }
}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
      
        // return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataModel = viewModel.dataListToPresent as? [CompanyModel] , viewType == .companyListType{
            
            navigateToMemberListView(datamodel: dataModel[indexPath.row])
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.dataListToPresent?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewType == .companyListType {
            let cell : CompanyCell = tableView.dequeueReusableCell(withIdentifier: "CompanyListCell", for: indexPath) as! CompanyCell
            
            if let dataModel = viewModel.dataListToPresent , let companydata = dataModel[indexPath.row] as? CompanyModel{
                cell.configureData(companydata)
            }
            
            return cell
        }
        else{
            
            let cell : MemberCell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MemberCell
            
            if let dataModel = viewModel.dataListToPresent , let data = dataModel[indexPath.row] as? MemberModel{
                cell.configureData(data)
            }
            
            return cell
        }
    }
}
extension ViewController : ViewModelDelegate {
    func refreshData() {
        tableView.reloadData()
    }
}
extension ViewController : SortDelegate{
    func applySort(_ sortType: SortType) {
        if currentSortType == sortType {
            return
        }
        currentSortType = sortType
        viewModel.sortlist(sortType)
    }
    
}

