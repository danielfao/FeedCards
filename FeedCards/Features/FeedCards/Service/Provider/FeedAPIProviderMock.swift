//
//  FeedAPIProviderMock.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

class FeedAPIProviderMock: FeedAPIProviderProtocol {
    // MARK: - Private properties
    
    private var file: String
    private var error: NetworkError?
    private var bundle: Bundle

    // MARK: - Initializer
    
    init(file: String = String(), error: NetworkError? = nil, bundle: Bundle = Bundle.main) {
        self.file = file
        self.error = error
        self.bundle = bundle
    }
    
    // MARK: - Public functions
    
    func fetchData(_ urlString: String? = String(), completion: @escaping FeedResultCompletion) {
        if let path = bundle.path(forResource: file, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                if let response = try? JSONDecoder().decode(FeedResult.self, from: data) {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(response))
                    }
                } else {
                    fatalError("Can't find \(file).json file")
                }
            } else {
                fatalError("Can't find \(file).json file")
            }
        }
    }
}
