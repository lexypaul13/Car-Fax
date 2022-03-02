//
//  DetailCarViewController.swift
//  Car Fax
//
//  Created by Alex Paul on 3/2/22.
//

import UIKit

class DetailCarViewController: UIViewController {

    var selectedPhotos : Images?
    @IBOutlet weak var carImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage()
    }
    func downloadImage(){
        if let _ = selectedPhotos{
            carImage.downloadImage(selectedPhotos?.firstPhoto.large ?? "", placeholder: UIImage(named: "no image large"))
        }
    }

}
