//
//  BaseViewController.swift
//  PeopleGenerator
//
//  Created by Oğuzhan Kabul on 14.06.2023.
//

import UIKit

class BaseViewController<ViewModel: BaseViewModel>: UIViewController {

    var viewModel: ViewModel!

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    // MARK: - SetupViews
    func setupViews() {}
    
    // MARK: - SetupLayouts
    func setupLayouts() {}
    
    // MARK: - Error Handling
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
