//
//  ViewController.swift
//  Car Fax
//
//  Created by Alex Paul on 3/1/22.
//

import UIKit

class ListOfCarsViewController: UIViewController {
    var carsArray = [Listing]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        getCars()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func getCars(){
        NetworkService.shared.getJSON() {  [weak self]  (carsArray) in
            guard let self = self else { return}
            guard let carsArray = carsArray else{ return }
            self.carsArray = carsArray.listings
            self.tableView.reloadData()
            
        }
    }
    
}
extension ListOfCarsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsArray.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cars" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailCarViewController
                destinationController.selectedPhotos = carsArray[indexPath.row].images
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListOfCarsTableViewCell
        let carsIndex = carsArray[indexPath.row]
        cell.carImage.downloadImage(carsIndex.images.firstPhoto.large, placeholder: nil)
        cell.yearLabel.text = String(carsIndex.year)
        cell.makeLabel.text = carsIndex.make
        cell.priceLabel.text = String("$\(carsIndex.currentPrice)")
        cell.modelLabrl.text =  carsIndex.model
        cell.trimLabel.text = carsIndex.trim
        cell.locationLabel.text = carsIndex.dealer.address
        cell.stateLabel.text = carsIndex.dealer.state
        cell.mileageLabel.text = String("\(carsIndex.mileage)k mi")
        cell.phoneButton.setTitle(carsIndex.dealer.phone.toPhoneNumber(), for: .normal)
        
        return cell
        
    }
    
    @objc func callTapped(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        if let indexPath = tableView.indexPathForRow(at: buttonPosition){
            let phoneNumber = carsArray[indexPath.row].dealer.phone
            callNumber(phoneNumber: phoneNumber)
        }
        
    }
    
    
}
