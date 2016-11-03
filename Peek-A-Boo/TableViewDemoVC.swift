//
//  TableViewDemoVC.swift
//  Peek-A-Boo
//
//  Created by Varad Pathak on 14/10/16.
//  Copyright © 2016 Varad Pathak. All rights reserved.
//  Copyright © 2016 MobileFirst Applications - http://mobilefirst.in

//

import UIKit

class TableViewDemoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    
    var photos: [Photo]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        photos = Photo.downloadAllPhotos()
        Photo.configureDynamicsShortcut()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "demoCell") as! DemoTVCell
        
        let photo = self.photos[(indexPath as NSIndexPath).row]
        
        cell.photo = photo
        cell.selectionStyle = .none
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self as UIViewControllerPreviewingDelegate, sourceView: tableView)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPhoto = self.photos[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "tableViewToDetailView", sender: selectedPhoto)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier  == "tableViewToDetailView" {
            
            if let detailVC = segue.destination as? DetailViewController {
                let selectedPhoto = sender as! Photo
                detailVC.photo = selectedPhoto
            }
        }

    }
    

}

extension TableViewDemoVC: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tblView.indexPathForRow(at: location), let cell = tblView.cellForRow(at: indexPath) as? DemoTVCell else {
        
            return nil
        }
        let identifier = "DetailViewController"
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: identifier) as? DetailViewController else {
            return nil
        }
        
        
        detailVC.photo = cell.photo
        
        previewingContext.sourceRect = cell.frame
        
        return detailVC
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        self.show(viewControllerToCommit, sender: self)
    }
}
