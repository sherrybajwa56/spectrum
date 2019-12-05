//
//  MemberCell.swift
//  spectrumDemo
//
//  Created by Sherry Bajwa on 05/12/19.
//  Copyright © 2019 Sherry Bajwa. All rights reserved.
//

import UIKit

class MemberCell: UITableViewCell {
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblAge : UILabel!
    @IBOutlet weak var lblemail : UILabel!
    @IBOutlet weak var lblPhone : UILabel!

    func  configureData(_ data : MemberModel)  {
        lblName.text =   (data.name?.first ?? "") + (data.name?.last ?? "" )
        lblAge.text =    "Age:" + "\(String(describing: data.age))"
        lblemail.text = "Email:" + "\(String(describing: data.email))"
        lblPhone.text = "Phone::" + (data.phone ?? "")
      
       }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func markFvrtButton(_ sender: UIButton) {
          sender.isSelected = !sender.isSelected
      }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
