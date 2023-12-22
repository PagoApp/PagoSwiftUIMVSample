//
//  BaseTableViewController.swift
//  Pago
//
//  Created by Gabi Chiosa on 29.07.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import Foundation
import UIKit

public protocol BaseTableViewScrollDelegate: AnyObject {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView)
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
}

open class BaseTableViewController: BaseViewController {
    
    weak var scrollDelegate: BaseTableViewScrollDelegate?

    public var tableView: PagoTableView!
   
    private var presenter: BaseTableViewControllerPresenter {
        return basePresenter as! BaseTableViewControllerPresenter
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        let margins = view.layoutMarginsGuide

        tableView = PagoTableView()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.keyboardDismissMode = .interactive
        tableView.alwaysBounceVertical = true
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        self.view.addSubview(tableView)
        if let navigationView = navigationView {
            tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        }
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        let scrollViewBottomConstraint = margins.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        scrollViewBottomConstraint.isActive = true
        self.scrollViewBottomConstraint = scrollViewBottomConstraint
        self.navScrollView = tableView
        tableView.tableFooterView = nil
        tableView.register(PagoLoadingCell.classForCoder(), forCellReuseIdentifier: PagoLoadingCell.reuseIdentifier)
        setupPullToRefresh(with: tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    open override func setupPullToRefresh() {
        setupPullToRefresh(with: tableView)
    }
    
    open override func removePullToRefresh() {
        removePullToRefresh(from: tableView)
    }
    
    open override func setupViewBackground(hasEmptyScreen: Bool) {
        
        super.setupViewBackground(hasEmptyScreen: hasEmptyScreen)
        if presenter.hasEmptyScreen {
            tableView.backgroundColor = .clear
        } else {
            tableView.backgroundColor = PagoThemeStyle.custom.primaryBackgroundColor.color
        }
    }
    
}


extension BaseTableViewController {
    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        super.scrollViewDidScroll(scrollView)
        scrollDelegate?.scrollViewDidScroll(scrollView)
        
    }

    public override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        super.scrollViewWillBeginDecelerating(scrollView)
        scrollDelegate?.scrollViewWillBeginDecelerating(scrollView)
    }
    
    public override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        super.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
        scrollDelegate?.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }

    public override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        super.scrollViewDidEndDecelerating(scrollView)
        scrollDelegate?.scrollViewDidEndDecelerating(scrollView)
    }
    
}

extension BaseTableViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let headerPresenter = presenter.headerPresenter(section: section) else {
            return nil
        }
        //TODO: Improve to handle generic components
        if let simplePresenter = headerPresenter as? TableViewSimpleHeaderPresenter {
            let header = TableViewSimpleHeaderView.fromNib(presenter: simplePresenter)
            return header
        } else if let informativePresenter = headerPresenter as? PagoInformativePresenter {
            let header = PagoInformativeView(presenter: informativePresenter)
            header.translatesAutoresizingMaskIntoConstraints = false
            let width = UIScreen.main.bounds.width
            header.widthAnchor.constraint(equalToConstant: width).isActive = true
            return header
        } else if let stackPresenter = headerPresenter as? PagoStackedInfoPresenter {
            let header = PagoStackedInfoView(presenter: stackPresenter)
            header.translatesAutoresizingMaskIntoConstraints = false
            let width = UIScreen.main.bounds.width
            header.widthAnchor.constraint(equalToConstant: width).isActive = true
            return header
        } else {
            return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard presenter.headerPresenter(section: section) != nil else {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        guard presenter.headerPresenter(section: section) != nil else {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return presenter.sectionsCount
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.cellsCount(in: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellPresenter = presenter.cellPresenter(row: indexPath.row, section: indexPath.section), let cell = tableView.dequeueReusableCell(withIdentifier: cellPresenter.identifier, for: indexPath) as? BaseTableViewCell else {
            return UITableViewCell()
        }
        
        cellPresenter.setView(mView: cell)
        cell.presenter = cellPresenter
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          
        return UITableView.automaticDimension
    }
}

extension BaseTableViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // NOTE: Handle selection
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelect(row: indexPath.row, section: indexPath.section)
    }
}
