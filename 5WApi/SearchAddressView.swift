//
//  SearchAddressView.swift
//  5WApi
//
//  Created by 최지철 on 2023/02/23.
//

import UIKit
import MapKit
let api = GetApi()

class SearchAddressView: UIViewController, UISearchBarDelegate, MKLocalSearchCompleterDelegate, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completerResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else { return UITableViewCell()}
        
        if let suggestion = completerResults?[indexPath.row] {
            cell.titleLabel.text = suggestion.title
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let suggestion = completerResults?[indexPath.row]
        let str:String = suggestion!.title
        let startIdx:String.Index = str.index(str.startIndex, offsetBy: 5)
        api.here = String(str[startIdx...])
        print(api.here)
        api.NaverApi()
    }
 
    private var searchCompleter: MKLocalSearchCompleter?
        private var searchRegion: MKCoordinateRegion = MKCoordinateRegion(MKMapRect.world)
        var completerResults: [MKLocalSearchCompletion]?
    
    
      private var places: MKMapItem? {
          didSet {
              tableView.reloadData()
          }
      }
    private var localSearch: MKLocalSearch? {
        willSet {
            // Clear the results and cancel the currently running local search before starting a new search.
            places = nil
            localSearch?.cancel()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
         searchCompleter?.resultTypes = .address // 혹시 값이 안날아온다면 이건 주석처리 해주세요
        searchCompleter?.region = searchRegion
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            completerResults = nil
        }
        
        searchCompleter?.queryFragment = searchText
       // print(searchText)
    }
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            completerResults = completer.results
            tableView.reloadData()
        }
        
        func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
            if let error = error as NSError? {
                print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(completer.queryFragment)\"")
            }
        }

}


