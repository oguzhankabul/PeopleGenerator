//
//  PeopleManager.swift
//  PeopleGenerator
//
//  Created by Oğuzhan Kabul on 14.06.2023.
//

import Foundation

final class PeopleManager {
    
    static let shared = PeopleManager()
    
    private init() {}
    
    func fetchPeople(nextIdentifier: String?, completion: @escaping ([Person]?, String?, FetchError?) -> Void) {
        DataSource.fetch(next: nextIdentifier) { response, error in
            if let error = error {
                completion(nil, nil, error)
            } else if let response = response {
                completion(response.people, response.next, nil)
            }
        }
    }
}
