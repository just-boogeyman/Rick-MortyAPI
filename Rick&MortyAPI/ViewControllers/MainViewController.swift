//
//  TableViewController.swift
//  Rick&MortyAPI
//
//  Created by Ярослав Кочкин on 17.12.2022.
//

import UIKit

class MainViewController: UITableViewController {
    
    private var persons: [Results] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        feach()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath ) as? PersonCell
        else {
            return UITableViewCell()
        }
        
        let person = persons[indexPath.row]
        cell.configure(with: person)

        return cell
    }
}


extension MainViewController {
    private func feach() {
        NetworkManager.shared.feachPerson(from: "https://rickandmortyapi.com/api/character") { [weak self] result in
            switch result {
            case .success(let person):
                print(person.results.count)
                self?.persons = person.results
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
