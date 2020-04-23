//
//  Created by La Hy Tai on 4/23/20.
//

import UIKit
import RxSwift
import SVProgressHUD

class HomeViewController: UIViewController {
    @IBOutlet var tableView : UITableView!
    var viewModel: HomeViewControllerModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getDataUsage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindViewModel()
    }
    
    func setupView(){
        tableView.register(UINib(nibName: DataUsageCell.identifier, bundle: nil), forCellReuseIdentifier: DataUsageCell.identifier)
    }
    
    func bindViewModel(){
        viewModel?.isLoading.drive(SVProgressHUD().rx.isLoading).disposed(by: disposeBag)
        viewModel?.errorMessage.filter { !$0.isEmpty }
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {[weak self] (errorMessage) in
                    self?.showAlert(errorMessage)
                }
        ).disposed(by: disposeBag)
        
        viewModel?.cellModels.drive(self.tableView.rx.items(cellIdentifier: DataUsageCell.identifier, cellType:DataUsageCell.self)){
            (row, cellModel, cell) in
            cell.viewModel = cellModel
        }.disposed(by: disposeBag)
    }
    
    
    @IBAction func reLoadData(_ sender: Any) {
        getDataUsage()
    }
    
    private let disposeBag = DisposeBag()
}

extension HomeViewController {
    private func getDataUsage(){
        viewModel?.getDataUsage()
    }
}

extension HomeViewController {
    private func showAlert(_ errorMessage: String) {
        let okAlertAction = UIAlertAction(title: Constant.OK_BUTTON, style: .default, handler: nil)
        let alertViewController = UIAlertController(title: Constant.ERROR_TITLE, message: errorMessage, preferredStyle: .alert)
        alertViewController.addAction(okAlertAction)
        present(alertViewController, animated: true, completion: nil)
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DataUsageCell.cellHeight
    }
}

