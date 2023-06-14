//
//  PeopleListViewModel.swift
//  PeopleGenerator
//
//  Created by Oğuzhan Kabul on 14.06.2023.
//

import Foundation

protocol PeopleListViewModelDelegate: AnyObject {
    func fetchCompleted()
    func showError(message: String)
    func showEmptyState()
    func hideEmptyState()
}

final class PeopleListViewModel: BaseViewModel {
    
    private var persons: Set<PersonUIModel> = []
    private var nextIdentifier: String?
    
    weak var delegate: PeopleListViewModelDelegate?
    
    func fetchPeople() {
        PeopleManager.shared.fetchPeople(nextIdentifier: nextIdentifier) { [weak self] people, nextIdentifier, error in
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(message: error.errorDescription)
            } else if let people = people {
                for person in people {
                    self.addPerson(person)
                }
                self.nextIdentifier = nextIdentifier
                self.delegate?.fetchCompleted()
            }
        }
    }
    
    func refreshPeople() {
        persons = []
        nextIdentifier = nil
        fetchPeople()
    }
    
    func numberOfPeople() -> Int {
        return persons.count
    }
    
    func person(at index: Int) -> PersonUIModel? {
        guard index >= 0 && index < persons.count else {
            return nil
        }
        
        let personArray = Array(persons)
        return personArray[index]
    }
    
    private func addPerson(_ person: Person) {
        let personUIModel = PersonUIModel(person: person)
        
        persons.insert(personUIModel)
    }
}
