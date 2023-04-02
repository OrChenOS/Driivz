//
//  UIImage+Extension.swift
//  Driivz
//
//  Created by Or Chen on 02/04/2023.
//

import Foundation
import UIKit

extension UIImage {
    
    //Resize the image to enable smooth scrolling
    func resizeImage() -> UIImage {
        let newWidth: CGFloat = 350
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
