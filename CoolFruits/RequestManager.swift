//
//  RequestManager.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 21-07-22.
//

import Foundation

protocol FruitsLoader {
    func getAllFruits(_ completion: @escaping (([FruitModel?]?, Error?) -> Void))
}

final class RequestManager: FruitsLoader {
    var session: URLSession
    var baseURL: String = "https://www.fruityvice.com/api/fruit"
    
    public static let shared = RequestManager()
    
    init() {
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func getAllFruits(_ completion: @escaping (([FruitModel?]?, Error?) -> Void)) {
        session.dataTask(with: URL(string: baseURL + "/all")!) { data, response, error in
            if error != nil {
                completion(nil, error)
                return
            } else {
                do {
                    let decodedObject = try JSONDecoder().decode([FruitModel].self, from: data!)
                    completion(decodedObject, nil)
                } catch {
                    completion(nil, NSError())
                }
            }
        }.resume()
    }
}
