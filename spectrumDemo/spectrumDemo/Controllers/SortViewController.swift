//
//  SortViewController.swift
//  spectrumDemo
//
//  Created by Sherry Bajwa on 04/12/19.
//  Copyright © 2019 Sherry Bajwa. All rights reserved.
//

import UIKit

   protocol SortDelegate:class
    {
        func applySort(_ sortType: SortType)
    }

    class SortViewController : UIViewController , UITableViewDataSource, UITableViewDelegate
    {
        weak var delegate: SortDelegate?
        var originalSortType: SortType!

        var sortTypes: [SortType] = [.AgeAcending ,.AgeDecending , .nameAscending , .nameDecending]
        
        // MARK: - View Lifecycle
        override func viewDidLoad()
        {
            super.viewDidLoad()
            configureAppearance()
          
              //  sortTypes = CatalogManager.SearchParameters.SortType.categorySortCases
            
        }
        
        override func didReceiveMemoryWarning()
        {
            super.didReceiveMemoryWarning()
        }
        
        // MARK: - Setup
        func configureAppearance()
        {
            let cancel = UIBarButtonItem.init(title:"cancel" , style: .plain , target: self, action: #selector(pressedCancel(_:)))
            cancel.setTitleTextAttributes (
                //NSAttributedString.Key.font: AppContext.currentContext.appearanceManager.fonts.mediumFontRegularSecondary,
                [NSAttributedString.Key.foregroundColor: UIColor.white],
                for: .normal
            )
            navigationItem.leftBarButtonItem = cancel
//NSAttributedString.Key.font : AppContext.currentContext.appearanceManager.fonts.mediumFontLargePrimary,
            navigationItem.title = "SORT"
            navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.white]
        }
        
        // MARK: - Actions
        @objc func pressedCancel(_ sender: AnyObject)
        {
            dismiss(animated: true, completion: nil)
        }

        // MARK: - Table View
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return sortTypes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell = UITableViewCell()
            let type = sortTypes[indexPath.row]
            cell.textLabel?.text = type.displayString()
          //  cell.textLabel?.textColor = AppContext.currentContext.appearanceManager.colors.cellLabelColor
           // cell.textLabel?.font = AppContext.currentContext.appearanceManager.fonts.mediumFontRegularSecondary
            // cell.accessoryType = .None
            if type == originalSortType {
                //  cell.accessoryType = .Checkmark
                cell.accessoryView = UIImageView(image: UIImage(named: "check-icon"))
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            let type = sortTypes[indexPath.row]
            if type != originalSortType {
                 delegate?.applySort(type)
            }
            dismiss(animated: true, completion: nil)
        }
    }


