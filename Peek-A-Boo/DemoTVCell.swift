//
//  DemoTVCell.swift
//  Peek-A-Boo
//
//  Created by Varad Pathak on 14/10/16.
//  Copyright © 2016 Varad Pathak. All rights reserved.
//  Copyright © 2016 MobileFirst Applications - http://mobilefirst.in

//

import UIKit

class DemoTVCell: UITableViewCell {
    
    var photo: Photo! {
        didSet {
            self.updateUI()
        }
    }

    @IBOutlet weak var mainImageVIew: UIImageView!
    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var lblDisplayText: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func updateUI() {
     
        self.mainImageVIew.image = UIImage(named: photo.name)
        self.profileImageVIew.image = UIImage(named: photo.photographerProfileImageName)
        self.lblDisplayText.text = photo.caption
        
        // configure gradient view
        let gradient = CAGradientLayer()
        gradient.frame = self.gradientView.bounds
        gradient.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.0).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor]
        self.gradientView.layer.insertSublayer(gradient, at: 0)
        
        profileImageVIew.layer.borderColor = UIColor.white.cgColor
        profileImageVIew.layer.cornerRadius = profileImageVIew.bounds.width / 2.0
        profileImageVIew.layer.masksToBounds = true
        profileImageVIew.layer.borderWidth = 1.5
    }

}
