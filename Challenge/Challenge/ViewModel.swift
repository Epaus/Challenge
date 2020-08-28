//
//  ViewModel.swift
//  Challenge
//
//  Created by Estelle Paus on 8/27/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import Foundation

class ViewModel {
    private var network: Network
    private var list: [Model]?
    
    init(network: Network) {
        self.network = network
        getData()
    }
    
    init() {
        self.network = Network()
    }
    
    func getData() {
        network.makeRequest(urlString: "https://dev.tapptic.com/test/json.php") {results in
            DispatchQueue.main.async(execute: {
                self.list = results
                print(results)
            })
        }
    }
    
    
}
