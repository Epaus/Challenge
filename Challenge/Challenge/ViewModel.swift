//
//  ViewModel.swift
//  Challenge
//
//  Created by Estelle Paus on 8/27/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import Foundation

class ViewModel {
    // ViewModel - A ViewModel is definitely overkill for this project. But, if you wanted to do things with the data coming in, like sorting, or editing, or persisting, then this would be were you could handle that business type logic.
    
    private var network: Network
    var list: [Model]?
    
    init(network: Network) {
        self.network = network
    }
    
    init() {
        self.network = Network()
    }
    
    func getData(completion: @escaping (_ list: [Model])->Void) {
        network.makeRequest(urlString: "https://dev.tapptic.com/test/json.php") {results in
            self.list = results
            completion(results)
        }
    }
    
    func listCount() -> Int {
        return list?.count ?? 0
    }
    
    
}
