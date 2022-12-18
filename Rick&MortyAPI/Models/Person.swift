//
//  Person.swift
//  Rick&MortyAPI
//
//  Created by Ярослав Кочкин on 17.12.2022.
//


struct Person: Decodable {
    let results: [Results]
}


struct Results: Decodable {
    let name: String
    let status: String
    let image: String
}
