//
//  CollectionViewVC.swift
//  Peek-A-Boo
//
//  Created by Varad Pathak on 15/10/16.
//  Copyright © 2016 Varad Pathak. All rights reserved.
//  Copyright © 2016 MobileFirst Applications - http://mobilefirst.in

//

import UIKit

class CollectionViewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collecView: UICollectionView!
    
    var photos: [Photo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        photos = Photo.downloadAllPhotos()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collecView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath) as! DemoCVCell
        
        let photo = self.photos[indexPath.row]
        
        cell.photo = photo
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self as UIViewControllerPreviewingDelegate, sourceView: collecView)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedPhoto = photos[indexPath.row]
        performSegue(withIdentifier: "toDetailVCFromCV", sender: selectedPhoto)
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier  == "toDetailVCFromCV" {
            
            if let detailVC = segue.destination as? DetailViewController {
                let selectedPhoto = sender as! Photo
                detailVC.photo = selectedPhoto
            }
        }
    }
    

}

extension CollectionViewVC : UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collecView.indexPathForItem(at: location), let cell = collecView.cellForItem(at: indexPath) as? DemoCVCell else {
            
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

