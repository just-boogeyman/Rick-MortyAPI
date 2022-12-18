//
//  NetworkManager.swift
//  Rick&MortyAPI
//
//  Created by Ярослав Кочкин on 17.12.2022.
//

import Foundation


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func feachImage(from url: String?, complition: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            complition(.failure(.invalidURL))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                complition(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                complition(.success(imageData))
            }
        }
    }
    
    
    func feachPerson(from url: String, complition: @escaping(Result<Person, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            complition(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                complition(.failure(.noData))
                return
            }
            do {
                let json = try JSONDecoder().decode(Person.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(json))
                }
            } catch {
                complition(.failure(.decodingError))
            }
        }.resume()
    }
}
