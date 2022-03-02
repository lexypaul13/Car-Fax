//
//  Car Service.swift
//  Car Fax
//
//  Created by Alex Paul on 3/1/22.
//

import Foundation

class NetworkService{
    static let shared = NetworkService()
    private let baseURL = "https://carfax-for-consumers.firebaseio.com/assignment.json"
    private init() {}
    
    func getJSON(completion: @escaping(Cars?) -> Void){
        guard let url = URL(string: baseURL ) else{return}
        let request =  URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to query database", error)
            }
            guard let data = data else {
                print("Data not received\(String(describing: error))")
                return
            }
            let decoder = JSONDecoder()
            do{
                let decodedJson = try decoder.decode(Cars.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedJson)
                }

            }catch let error{
                print("Json failed to decode\(String(describing: error))")
                return
            }
        }.resume()
    }

}
