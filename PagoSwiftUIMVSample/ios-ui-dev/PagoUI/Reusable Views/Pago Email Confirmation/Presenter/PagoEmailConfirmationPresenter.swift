//
//  
//  PagoEmailConfirmationPresenter.swift
//  PagoRCASDK
//
//  Created by Gabi on 19.10.2022.
//
//
import PagoUISDK
import UIKit

public protocol PagoEmailConfirmationPresenterView: BaseStackViewControllerPresenterView {
    
    func add(space: CGFloat)
    func setup(stackView: PagoStackedInfoPresenter)
    func setup(textField: PagoTextFieldPresenter)
    func setup(label: PagoLabelPresenter)
    func setup(button: PagoButtonPresenter)
}

public protocol PagoEmailConfirmationPresenterDelegate: AnyObject {
    func presenterDidStop()
    func presenterWillStop(animated: Bool)
    func handle(email: String)
}

public class PagoEmailConfirmationPresenter: ViewControllerPresenter {

    internal weak var delegate: PagoEmailConfirmationPresenterDelegate?
    private var model: PagoEmailConfirmationModel {
        get { return baseModel as! PagoEmailConfirmationModel }
        set { baseModel = newValue }
    }
    private var repository: PagoEmailConfirmationRepository { return baseRepository as! PagoEmailConfirmationRepository }
    private var service = PagoEmailConfirmationService()
    private var view: PagoEmailConfirmationPresenterView? { return self.basePresenterView as? PagoEmailConfirmationPresenterView }
    private let predicate: PagoEmailConfirmationPredicate
    private var detailPresenter: PagoLabelPresenter!
    private var textFieldPresenter: PagoTextFieldPresenter!
    private var continueButtonPresenter: PagoButtonPresenter!

    public init(navigation: PagoNavigationPresenter, predicate: PagoEmailConfirmationPredicate) {
        
        self.predicate = predicate
        super.init(navigation: navigation)
        baseRepository = PagoEmailConfirmationRepository()
    }
    
    public override func loadData() {

        super.loadData()
        setupLoadingStart(from: repository)
    }
    
    public override func getData(completion: @escaping (Model) -> ()) {
        repository.getData(predicate: predicate, completion: completion)
    }
        
    public override func getRemoteData(completion: @escaping (Model) -> ()) {
        repository.getRemoteData(predicate: predicate, completion: completion)
    }
    
    public override func popScreen() {
        
        delegate?.presenterWillStop(animated: true)

    }
    
    public override func didFinishInteractivePop() {
        
        delegate?.presenterDidStop()
    }
    
    public override func setupPresenters() {
        
        let imageViewPresenter = PagoStackedInfoPresenter(model: model.imageStackModel)
        textFieldPresenter = PagoTextFieldPresenter(model: model.textField)
        textFieldPresenter.delegate = self
        detailPresenter = PagoLabelPresenter(model: model.detailModel)
        continueButtonPresenter = PagoButtonPresenter(model: model.continueButton)
        continueButtonPresenter.delegate = self
        
        view?.setup(stackView: imageViewPresenter)
        view?.add(space: 24)
        view?.setup(label: detailPresenter)
        view?.add(space: 32)
        view?.setup(textField: textFieldPresenter)
        view?.add(space: 16)
        view?.setup(button: continueButtonPresenter)
        view?.add(space: 16)
        validateFields()
    }
    
    private func validateFields() {
        
        let isEmailValid = textFieldPresenter.isValid ?? false
        continueButtonPresenter.isEnabled = isEmailValid
    }
}

extension PagoEmailConfirmationPresenter: PagoButtonPresenterDelegate {
    
    public func didTap(button: PagoButtonPresenter) {
        
        guard button.isEnabled, let email = textFieldPresenter.text else { return }
        delegate?.handle(email: email)
    }
}

extension PagoEmailConfirmationPresenter: PagoTextFieldPresenterDelegate {
    
    public func didUpdate(presenter: PagoTextFieldPresenter) {
        
        validateFields()
    }
}
