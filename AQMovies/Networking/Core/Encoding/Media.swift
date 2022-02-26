//
//  Media.swift
//  Craft
//
//  Created by Ali on 10/17/21.
//

import UIKit


struct Media {
    let key : String
    let filename : String
    let data : Data
    let mimeType : String
    
    
    init?(withImage image : UIImage , forKey key : String) {
        
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "\(arc4random()).jpeg"
        guard let data = image.jpegData(compressionQuality: 0.40) else {
            return nil
        }
        self.data = data
    }
    
}

