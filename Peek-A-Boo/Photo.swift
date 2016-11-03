//
//  Photo.swift
//  UITableViewDemo
//
//  Created by Varad Pathak on 14/10/16.
//  Copyright © 2016 Varad Pathak. All rights reserved.
//  Copyright © 2016 MobileFirst Applications - http://mobilefirst.in

//

import Foundation
import UIKit

class Photo
{
    var name: String = ""
    var photographerProfileImageName: String = ""
    var caption: String = ""
    
    init(name: String, photographerProfileImageName: String, caption: String)
    {
        self.name = name
        self.photographerProfileImageName = photographerProfileImageName
        self.caption = caption
    }
    
    static func configureDynamicsShortcut()
    {
        if let mostRecentPhoto = Photo.downloadAllPhotos().first {
            
            let shortcutType = "varad.pathak.UITableViewDemo.share"
            let shortcutItem = UIApplicationShortcutItem(type: shortcutType, localizedTitle: "Share Latest Photo", localizedSubtitle: mostRecentPhoto.caption, icon: UIApplicationShortcutIcon(type: .share), userInfo: nil)
            
            UIApplication.shared.shortcutItems = [shortcutItem]
        } else {
            UIApplication.shared.shortcutItems = []
        }
    }
    
    static func downloadAllPhotos() -> [Photo]
    {
        var photos = [Photo]()
        
        for i in 1...10 {
            let photo = Photo(name: "\(i)", photographerProfileImageName: "p\(i)", caption: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Epsum factorial non deposit quid pro quo hic escorol. Olypian quarrels et gorilla congolium sic ad nauseum.")
            
            photos.append(photo)
        }
        
        return photos
    }
}
















