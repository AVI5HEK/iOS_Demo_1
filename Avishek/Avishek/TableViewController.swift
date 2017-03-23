//
//  ViewController.swift
//  Country
//
//  Created by framgia on 10/20/16.
//  Copyright © 2016 framgia. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    var namesOfCountries = [String]()
    var filteredNamesOfCountries = [String]()
    var nameDict = [String: [String]]()
    var filteredNameDict = [String: [String]]()
    var sectionTitles = [String]()
    var filteredSectionTitles = [String]()
    let searchBar = UISearchBar()
    var shouldShowSearchResult = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.\
        
        createSearchBar()
        
        let imageArray = Bundle.main.urls(
            forResourcesWithExtension: "png", subdirectory: "Flags")
        for n: URL in imageArray!
        {
            let urlString = "\(n)"
            let name = urlString.components(separatedBy: ".")
            let imageName = name.first?.replacingOccurrences(of: "%20", with: " ")
            
            if nameDict["\((imageName?.characters.first)!)"] == nil {
                nameDict["\((imageName?.characters.first)!)"] = [imageName!]
            } else {
                nameDict["\((imageName?.characters.first)!)"]?.append(imageName!)
            }
            namesOfCountries.append(imageName!)
            
        }
        sectionTitles = nameDict.keys.sorted(by: <)
    }
    
    func createSearchBar(){
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Enter country name"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(shouldShowSearchResult){
            return filteredSectionTitles.count
        } else {
            return sectionTitles.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(shouldShowSearchResult){
            return filteredSectionTitles[section]
        } else {
            return sectionTitles[section]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(shouldShowSearchResult){
            return (filteredNameDict[filteredSectionTitles[section]]?.count)!
        } else {
            let elements = nameDict[sectionTitles[section]]
            
            return (elements?.count)!
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        if(shouldShowSearchResult){
            var sectionCountries = filteredNameDict[filteredSectionTitles[indexPath.section]]
            cell.textLabel?.text = sectionCountries?[indexPath.row]
            cell.imageView?.image = UIImage(named: "Flags/"+(sectionCountries?[indexPath.row])!)
        } else {
            let sectionTitle = sectionTitles[indexPath.section]
            var sectionCountries = nameDict[sectionTitle]
            cell.textLabel?.text = sectionCountries?[indexPath.row]
            cell.imageView?.image = UIImage(named: "Flags/"+(sectionCountries?[indexPath.row])!)
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if(shouldShowSearchResult){
            return filteredSectionTitles
        } else {
            return sectionTitles
        }
    }
    
    // MARK: - SearchBar delegates
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResult = true
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }
    
    // MARK: - SearchBar functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNameDict.removeAll()
        filteredNamesOfCountries = namesOfCountries.filter({ (names: String) -> Bool in
            return (names.lowercased().range(of: searchText.lowercased()) != nil)
        })
        
        for name: String in filteredNamesOfCountries {
            if filteredNameDict["\((name.characters.first)!)"] == nil {
                filteredNameDict["\((name.characters.first)!)"] = [name]
            } else {
                filteredNameDict["\((name.characters.first)!)"]?.append(name)
            }
        }
        
        filteredSectionTitles = filteredNameDict.keys.sorted(by: <)
        
        if searchText != "" {
            shouldShowSearchResult = true
        } else {
            shouldShowSearchResult = false
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func logOut(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
