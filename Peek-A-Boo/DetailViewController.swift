//
//  DetailViewController.swift
//  Peek-A-Boo
//
//  Created by Varad Pathak on 15/10/16.
//  Copyright © 2016 Varad Pathak. All rights reserved.
//  Copyright © 2016 MobileFirst Applications - http://mobilefirst.in

//

import UIKit

class DetailViewController: UIViewController {
    
    weak var TableViewDemoVC: TableViewDemoVC?
    weak var CollectionViewVC: CollectionViewVC?
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var txtcaption: UITextView!
    
    var photo: Photo!
    var sharing = false

    override var previewActionItems: [UIPreviewActionItem] {
        
        let shareAction = UIPreviewAction(title: "Share", style: .default) { (previewAction, viewController) in
            
            if let demoTVC = self.TableViewDemoVC, let activityVC = self.activityViewController {
                
                demoTVC.present(activityVC, animated: true, completion: nil)
            }
        }
        
        let likeAction = UIPreviewAction(title: "Like", style: .default, handler: { (previewAction, viewController) in
            
            // do something to like the photo here: photo.like()
        })
        
        return [shareAction, likeAction]
    }
    
    
    fileprivate var activityViewController: UIActivityViewController? {
        guard let photo = photo, let image = UIImage(named: photo.name) else { return nil }
        
        return UIActivityViewController(activityItems: [image], applicationActivities: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "View Photo"
        
        if photo != nil {
            self.mainImageView?.image = UIImage(named: photo.name)
            self.txtcaption?.text = photo.caption
            self.profileImageView?.image = UIImage(named: photo.photographerProfileImageName)
            
            // make the profile image view rounded with white border
            profileImageView.layer.borderColor = UIColor.white.cgColor
            profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2.0
            profileImageView.layer.masksToBounds = true
            profileImageView.layer.borderWidth = 1.5
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if sharing {
            presentActivityViewController()
        }
    }
    
    
    @IBAction func presentActivityViewController()
    {
        if let activityViewController = self.activityViewController {
            present(activityViewController, animated: true, completion: nil)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
