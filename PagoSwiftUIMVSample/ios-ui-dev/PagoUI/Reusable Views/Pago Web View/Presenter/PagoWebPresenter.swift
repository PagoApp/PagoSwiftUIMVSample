//
//  
//  PagoWebPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 05.10.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import WebKit

public protocol PagoWebPresenterView: PresenterView {
    
    func load(request: URLRequest)
    func load(htmlString: String)
    func load(fileUrl: URL)
    func setup(loader: PagoAnimationPresenter)
    func hideLoader()
    func showLoader()
    func hideView(isHidden: Bool)
}

public protocol PagoWebPresenterDelegate: AnyObject {
    func didReceiveServerRedirectForProvisionalNavigation(url: URL?)
    func didFinish(url: URL?)
    func decidePolicy(forURL: URL?, decisionHandler: @escaping(WKNavigationActionPolicy)->())
    func didReceiveJSCallBack(state: String)
	func didScrollToBottom()
}

public extension PagoWebPresenterDelegate {
    func didReceiveServerRedirectForProvisionalNavigation(url: URL?) { }
    func didFinish(url: URL?) { }
    func decidePolicy(forURL: URL?, decisionHandler: @escaping(WKNavigationActionPolicy)->()) { }
	func didScrollToBottom() { }
}

open class PagoWebPresenter: BasePresenter {

    public weak var delegate: PagoWebPresenterDelegate?
    
    private var view: PagoWebPresenterView? {
        return basePresenterView as? PagoWebPresenterView
    }
    public var model: PagoWebModel {
        get { (self.baseModel as! PagoWebModel) }
        set { baseModel = newValue }
    }
    public var isLoading: Bool {
        return loaderPresenter.isAnimating
    }
    private let service: PagoWebService = PagoWebService()
    private var loaderPresenter: PagoAnimationPresenter!
    
    public func loadData() {

        switch model.type {
            case .remote:
            if let request = model.urlRequest {
                load(request: request)
            } else {
                if let htmlString = model.htmlString {
                    load(htmlString: htmlString)
                }
            }
            break
        case .local:
            if let localUrl = model.url {
                load(fileUrl: localUrl)
            }
        }

        loaderPresenter = PagoAnimationPresenter(model: model.loaderModel)
        view?.setup(loader: loaderPresenter)
    }

    private func load(request: URLRequest) {
            
        service.cleanCache()
        view?.load(request: request)
    }
    
    private func load(htmlString: String) {
            
        service.cleanCache()
        view?.load(htmlString: htmlString)
    }

    private func load(fileUrl: URL) {

        service.cleanCache()
        view?.load(fileUrl: fileUrl)
    }
    
    public var isHidden: Bool = false {
        didSet {
            view?.hideView(isHidden: isHidden)
        }
    }
    public func showLoader() {
        
        loaderPresenter.play()
        view?.showLoader()
    }
    
    public func hideLoader() {
        
        loaderPresenter.stop()
        view?.hideLoader()
    }
    
    public func restartWebView() {
        
        loadData()
    }
    
    public func didReceiveServerRedirectForProvisionalNavigation(url: URL?) {
        
        delegate?.didReceiveServerRedirectForProvisionalNavigation(url: url)
    }
    
    public func didFinish(url: URL?) {
        
        delegate?.didFinish(url: url)
    }
    
    public func decidePolicy(forURL: URL?, decisionHandler: @escaping(WKNavigationActionPolicy)->()) {
     
        if delegate == nil {
            decisionHandler(.allow)
        } else {
            delegate?.decidePolicy(forURL: forURL, decisionHandler: decisionHandler)
        }
    }
    
    public func javascriptCallBack(state: String) {
     
        delegate?.didReceiveJSCallBack(state: state)
    }
	
	public func didScrollToBottom() {
		
		delegate?.didScrollToBottom()
	}
}
