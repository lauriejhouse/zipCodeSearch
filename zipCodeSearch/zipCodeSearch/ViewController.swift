//
//  ViewController.swift
//  zipCodeSearch
//
//  Created by Jackie Norstrom on 5/4/19.
//  Copyright © 2019 Oblast. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredZip.count
        }
        
        //        return signsArray.count. returning 0 makes it so only shows results when typing in the search box.
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! zipCodeCell
        //added as signtableviewcell. if crashes, try to fix, or remove. Worked fine without it
        
        let zip: zipCode
        
        if inSearchMode {
            zip = filteredZip[indexPath.row]
        } else {
            zip = zips[indexPath.row]
        }
        //using configure cell instead of this. change back to this if it doesn;t work.
        //        cell.textLabel!.text = sign.signName
        //        cell.detailTextLabel!.text = candy.category
        cell.configureTableCell(zips: zip)
        return cell
    }
    
    
    

   

    var zips = [zipCode]()
    var filteredZip = [zipCode]()
    var inSearchMode = false
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    func parseZipCSV() {
                let path = Bundle.main.path(forResource: "zip", ofType: "csv")!
                do {
                    let csv = try CSV(contentsOfURL: path)
                    let rows = csv.rows
                    //            print(rows)
                    for row in rows {
                        let pokeId = Int(row["id"]!)!
                        let name = row["identifier"]!
        
                        let poke = zipCode(name: name, number: pokeId)
                        zips.append(poke)
                    }
        
        
        
                } catch let err as NSError {
                    print(err.debugDescription)
                }
            }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parseZipCSV()
        
        
    }
    
    
    // MARK: - Search Bar
    
    func searchBarIsEmpty() -> Bool {
        //Returns true if empty or nil
        
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //need to be searching for the zipcode? or city? - currently searching for city
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredZip = zips.filter({(zips : zipCode) -> Bool in return zips.city.lowercased().contains(searchText.lowercased())
            
        })
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            inSearchMode = true
            filteredZip = zips.filter{$0.city.range(of: searchBar.text!) != nil}
            
            tableView.reloadData()
        }
    }

    
}


extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
