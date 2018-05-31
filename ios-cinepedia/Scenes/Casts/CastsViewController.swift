//
//  CastsViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol CastsDisplayLogic {
    func displayCasts(viewModel: CastsModel.FetchCasts.ViewModel)
}

class CastsViewController: UIViewController, CastsDisplayLogic, NVActivityIndicatorViewable {
    
    private var presenter: CastsPresentationLogic?
    private var interactor: CastsBusinessLogic?
    private var casts = [CastsModel.FetchCasts.ViewModel.Cast]()
    
    var router: (NSObjectProtocol & CastsRouterLogic & CastsDataPassing)?
    
    @IBOutlet weak var castsTableView: UITableView!
    @IBOutlet weak var mainMenu: MainMenuBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        castsTableView.dataSource = self
        castsTableView.delegate = self
        
        // castsTableView.tableFooterView = UIView()
        castsTableView.rowHeight = UITableViewAutomaticDimension
        castsTableView.estimatedRowHeight = 175
        
        mainMenu.initialize(withViewController: self)
       
        fetchCasts()
    }
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let interactor = CastsInteractor()
        let presenter = CastsPresenter()
        let router = CastsRouter()
        
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
   
    // MARK: Fetch casts
    
    private func fetchCasts() {
        if let movieId = router?.dataStore?.movieId {
            startAnimating(type: .ballScaleMultiple)
            let request = CastsModel.FetchCasts.Request(movieId: movieId)
            interactor?.fetchCasts(request: request)
        }
    }
    
    func displayCasts(viewModel: CastsModel.FetchCasts.ViewModel) {
        stopAnimating()
        casts = viewModel.casts
        
        if casts.count > 0 {
            castsTableView.reloadData()
        } else {
            castsTableView.emptyMessage(message: "No casts found.")
        }
    }
}

extension CastsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell") as? CastTableViewCell {
            cell.initialize(cast: casts[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell(style: .value1, reuseIdentifier: "CastTableViewCell")
    }
}
