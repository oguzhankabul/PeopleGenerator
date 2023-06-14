//
//  PeopleGeneratorTests.swift
//  PeopleGeneratorTests
//
//  Created by Oğuzhan Kabul on 14.06.2023.
//

import XCTest
@testable import PeopleGenerator

final class PeopleListViewModelTests: XCTestCase {
    
    var viewModel: PeopleListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = PeopleListViewModel()
        
        // Manually add a few people to simulate a fetch operation
        let person1 = Person(id: 1, fullName: "Person 1")
        let person2 = Person(id: 2, fullName: "Person 2")
        let person3 = Person(id: 3, fullName: "Person 3")

        viewModel.addPerson(person1)
        viewModel.addPerson(person2)
        viewModel.addPerson(person3)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchPeople() {
        // Given
        let initialCount = 3 // Since we manually added three people in `setUp`

        // When
        let fetchedCount = viewModel.numberOfPeople().numberOfPeople
        let fetchedIsEmpty = viewModel.numberOfPeople().isEmpty

        // Then
        XCTAssertEqual(fetchedCount, initialCount)
        XCTAssertEqual(fetchedIsEmpty, false)
    }

    // Test refreshing people
    func testAddPerson() {
        // Given
        let countBeforeAdded = viewModel.numberOfPeople().numberOfPeople

        // When
        viewModel.addPerson(Person(id: 4, fullName: "Person 4"))
        let countAferAdded = viewModel.numberOfPeople().numberOfPeople

        // Then
        XCTAssertFalse(countBeforeAdded == countAferAdded)
    }
    
    func testAddSamePerson() {
        // Given
        let countBeforeAdded = viewModel.numberOfPeople().numberOfPeople

        // When
        viewModel.addPerson(Person(id: 3, fullName: "Person 3")) // Array has already same Person
        let countAferAdded = viewModel.numberOfPeople().numberOfPeople

        // Then
        XCTAssertTrue(countBeforeAdded == countAferAdded)
    }
}
