//
//  PersonUIModel.swift
//  PeopleGenerator
//
//  Created by Oğuzhan Kabul on 14.06.2023.
//

import Foundation

class PersonUIModel: Equatable, Hashable {
    let person: Person
    
    init(person: Person) {
        self.person = person
    }
    
    var fullName: String {
        return person.fullName
    }
    
    var id: Int {
        return person.id
    }
    
    static func == (lhs: PersonUIModel, rhs: PersonUIModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
