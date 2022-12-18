//
//  PersonCell.swift
//  Rick&MortyAPI
//
//  Created by Ярослав Кочкин on 17.12.2022.
//

import UIKit

class PersonCell: UITableViewCell {

    
    
    @IBOutlet weak var personImage: UIImageView!
    
    @IBOutlet weak var nameLable: UILabel!
    
    
    
    func configure(with person: Results) {
        nameLable.text = person.name
        
        NetworkManager.shared.feachImage(from: person.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.personImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        
        personImage.layer.cornerRadius = personImage.bounds.width / 2
    }
}
