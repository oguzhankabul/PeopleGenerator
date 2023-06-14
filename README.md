# People Listing App - Oguzhan Kabul

This is a simple, single screen app that lists people retrieved from a data source. The app follows the MVVM architecture and is implemented programmatically without using Storyboard. It ensures memory leak prevention, separates logic from controllers and UI components, and follows the principles of reusability. Unit tests have also been written to ensure code quality.

## Requirements

The app fulfills the following requirements:

### 1. Displaying People

The app displays a list of people, each identified by an `id` and a `fullName`.

### 2. Pagination

Since there are lots of people to list and only a subset can be retrieved at once, the app implements a pagination mechanism using the provided `DataSource`. The next set of people can be fetched by passing the `next` identifier to the `fetch` method of the data source.

### 3. Refresh Control

The app includes a "Refresh Control" feature that allows the user to refresh the list.

### 4. Error Handling and Retry

The app handles errors properly and provides a retry mechanism in case of failures during data retrieval.

### 5. Empty List Handling

When there are no people to list, the app displays a proper message and implements a functionality to refresh the list.

### 6. Unique Listing

The app ensures that the list is unique based on the person's `id`. Duplicate items with the same `fullName` but different `id` values are allowed.

## Implementation Details

### Data Source

The app utilizes the `DataSource` class provided. Import the `DataSource.swift` file into your project and review its implementation.

### User Interface

The user interface is implemented using a UITableView to display the list of people. The UI components are created programmatically, following the MVVM architecture.

## Dependencies

This project does not require any third-party dependencies.

## Unit Tests

Unit tests have been written to ensure code quality and validate the expected behavior of the app. Run the unit tests to verify the correctness of the implementation.
