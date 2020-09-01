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
    var list: [NumberModel]?
    
    init(network: Network) {
        self.network = network
    }
    
    init() {
        self.network = Network()
    }
    
    func listCount() -> Int {
        return list?.count ?? 0
    }
    
    func getData(completion: @escaping (_ list: [NumberModel])->Void) {
        network.makeRequest(urlString: "https://dev.tapptic.com/test/json.php") {results in
            let list = self.getNumberModels(dtos: results)
            self.list = list
            completion(list)
        }
    }
    
    func getNumberModels(dtos: [DTOModel]) -> [NumberModel] {
        var modelList = [NumberModel]()
        for dto in dtos {
            let model = NumberModel.init(name: dto.name ?? "", imageUrl: dto.imageUrl ?? "")
            modelList.append(model)
        }
        return modelList
    }
    
}
