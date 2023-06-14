//
//  PeopleListViewModel.swift
//  PeopleGenerator
//
//  Created by Oğuzhan Kabul on 14.06.2023.
//

import Foundation

// MARK: - PeopleListViewModelDelegate
protocol PeopleListViewModelDelegate: AnyObject {
    func didFetch()
    func showError(message: String)
    func showEmptyState()
    func hideEmptyState()
}

// MARK: - PeopleListViewModel
final class PeopleListViewModel: BaseViewModel {
    
    private var personsArray: [PersonUIModel] = []
    private var personsSet: Set<PersonUIModel> = []
    private var nextIdentifier: String?
    private var lastRefreshTime: Date?
    private let minimumRefreshInterval: TimeInterval = 3.0
    
    weak var delegate: PeopleListViewModelDelegate?
    
    func fetchPeople() {
        PeopleManager.shared.fetchPeople(nextIdentifier: nextIdentifier) { [weak self] people, nextIdentifier, error in
            guard let self else { return }
            if let error = error {
                self.delegate?.showError(message: error.errorDescription)
            } else if let people = people {
                for person in people {
                    self.addPerson(person)
                }
                self.nextIdentifier = nextIdentifier
                self.delegate?.didFetch()
            }
        }
    }
    
    func refreshPeople() {
        let now = Date()
        guard lastRefreshTime == nil || now.timeIntervalSince(lastRefreshTime!) > minimumRefreshInterval || personsArray.isEmpty else {
            return
        }
        lastRefreshTime = now
        personsArray = []
        personsSet = []
        nextIdentifier = nil
        fetchPeople()
    }
    
    func numberOfPeople() -> (numberOfPeople: Int, isEmpty: Bool) {
        return (personsArray.count, personsArray.isEmpty)
    }
    
    func person(at index: Int) -> PersonUIModel? {
        guard index >= 0 && index < personsArray.count else {
            return nil
        }
        return personsArray[index]
    }
    
    func addPerson(_ person: Person) {
        let personUIModel = PersonUIModel(person: person)
        if personsSet.insert(personUIModel).inserted {
            personsArray.append(personUIModel)
        }
    }
}
