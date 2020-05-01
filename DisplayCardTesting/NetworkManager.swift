//
//  NetworkManager.swift
//  DisplayCardTesting
//
//  Created by Tayler Moosa on 4/26/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func getCharacters(completed: @escaping (Result<[Character],Error>) -> Void) {
        guard let url = URL(string: "https://hp-api.herokuapp.com/api/characters") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode([Character].self, from: data)
                completed(.success(characters))
            } catch {
                print("hey")
            }
        }
        task.resume()
    }
}
