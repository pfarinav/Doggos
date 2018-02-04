//
//  ListViewController.swift
//  Doggos
//
//  Created by Patricio Fariña on 02-02-18.
//  Copyright © 2018 Patricio Fariña. All rights reserved.
//

import UIKit
protocol ListViewControllerProtocol: class {
    func displayDoggosList(doggos: [DoggoViewModel])
    func displayErrorView(withMessage message: String)
}
class ListViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var doggosListTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: - Properties
    lazy var presenter: ListPresenterProtocol = {
        let repo = RestSource()
        let router = ListRouter(view: self)
        return ListPresenter(view: self, repo: repo, router: router)
    }()
    var doggos: [DoggoViewModel] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: DoggoTableViewCell.nibName, bundle: nil)
        doggosListTableView.register(nib, forCellReuseIdentifier: DoggoTableViewCell.identifier)
        doggosListTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getDoggosList()
    }
}

extension ListViewController: ListViewControllerProtocol {
    func displayDoggosList(doggos: [DoggoViewModel]) {
        self.doggos = doggos
        doggosListTableView.reloadData()
        spinner.stopAnimating()
    }
    
    func displayErrorView(withMessage message: String) {
        let errorView = ErrorView()
        errorView.frame = doggosListTableView.frame
        errorView.titleLabel.text = "Oh oh... we had a problem."
        errorView.descriptionLabel.text = message
        view.addSubview(errorView)
    }
}

    //MARK: - TableView's delegate and datasource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doggos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DoggoTableViewCell.identifier, for: indexPath) as? DoggoTableViewCell
        let name = doggos[indexPath.row].name
        cell!.name = name
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DoggoTableViewCell.cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToGallery(forDoggoInIndex: indexPath.row)
    }
}
