//
//  Ext.swift
//  Car Fax
//
//  Created by Alex Paul on 3/2/22.
//

import UIKit
let imageCache = NSCache<NSString, UIImage>()

func callNumber(phoneNumber:String) {
        if let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url, options: [:]) { success in
                if success {
                    print("Making phone call")
                } else {
                    print("Something went wrong while making phone call")
                }
            }
        } else {
            print("Failed to make phone call")
        }
    }

extension UIImageView {
    func downloadImage(_ imgURL: String, placeholder: UIImage? = nil)  {
        guard let url = URL(string: imgURL) else { return  }
        if let imageToCache = imageCache.object(forKey: imgURL as NSString) {
            image = imageToCache
            return
        }
        image = placeholder
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            guard let data = data, error == nil,
                  let imageToCache = UIImage(data: data)
            else {
                print(error ?? URLError(.badServerResponse))
                return
            }
            
            DispatchQueue.main.async {
                imageCache.setObject(imageToCache, forKey: imgURL as NSString)
                self.image = imageToCache
            }
        }
        task.resume()
        
    }
}
