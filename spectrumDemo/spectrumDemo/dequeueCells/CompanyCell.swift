//
//  CompanyListCell.swift
//  spectrumDemo
//
//  Created by Sherry Bajwa on 05/12/19.
//  Copyright © 2019 Sherry Bajwa. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    @IBOutlet weak var lblName : UILabel!
     @IBOutlet weak var imvLogo : UIImageView!
     @IBOutlet weak var lblWebsite : UILabel!
     @IBOutlet weak var lblDescription : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func  configureData(_ data : CompanyModel)  {
        lblName.text = data.company ?? ""
        lblWebsite.text = data.website ?? ""
        lblDescription.text = data.about ?? ""
        //load image
        let url = URL(string: "https://placehold.it/32x32")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.imvLogo.image = UIImage(data: data!)
            }
            
        }
    }
    
    
    @IBAction func markFvrtButton(_ sender: UIButton) {
         sender.isSelected = !sender.isSelected
     }
     @IBAction func markFollowButton(_ sender: UIButton) {
           sender.isSelected = !sender.isSelected
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

