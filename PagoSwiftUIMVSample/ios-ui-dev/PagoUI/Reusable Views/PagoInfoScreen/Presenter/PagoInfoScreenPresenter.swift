//
//  
//  PagoInfoScreenPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit

protocol PagoInfoScreenPresenterView: ViewControllerPresenterView {
    func setupDismissButton()
    func setup(main: PagoButtonPresenter?, secondary: PagoButtonPresenter?)
    func setup(image: PagoImageViewPresenter)
    func setup(animation: PagoAnimationPresenter)
    func setup(loadedImage: PagoLoadedImageViewPresenter)
    func setup(title: PagoLabelPresenter)
    func setup(detail: PagoLabelPresenter)
    func setup(error: PagoLabelPresenter)
    func setup(extra: PagoStackedInfoPresenter)
    func setup(footer: PagoStackedInfoPresenter)
    func add(space: CGFloat)
}

protocol PagoInfoScreenPresenterDelegate: AnyObject {
    func didSelectMainAction()
    func didSelectSecondaryAction()
    func didTapDetail()
    func didTapFooter()
}

class PagoInfoScreenPresenter: ViewControllerPresenter {
    weak var delegate: PagoInfoScreenPresenterDelegate?
    var view: PagoInfoScreenPresenterView? { return self.basePresenterView as? PagoInfoScreenPresenterView }
    private var mainButtonPresenter: PagoButtonPresenter!
    private var secondaryButtonPresenter: PagoButtonPresenter?
    private var titlePresenter: PagoLabelPresenter!
    private var detailPresenter: PagoLabelPresenter?
    private let predicate: PagoInfoScreenBasePredicate
    private var repository: PagoInfoScreenRepository { return baseRepository as! PagoInfoScreenRepository }
    private var model: PagoInfoScreenModel {
        get { return baseModel as! PagoInfoScreenModel }
        set { baseModel = newValue }
    }
    private let service: PagoInfoScreenService = PagoInfoScreenService()
    private var delay: Int { return predicate.secondaryButton?.delay ?? 0 }
    private var hasDelay: Bool { return delay != 0 }
    private var footerPresenter: PagoStackedInfoPresenter?
    
    init(navigation: PagoNavigationPresenter, predicate: PagoInfoScreenBasePredicate) {
        
        self.predicate = predicate
        super.init(navigation: navigation)
        self.baseRepository = PagoInfoScreenRepository()
    }
    
    override func loadData() {
        
        super.loadData()
        guard let modelT = repository.getData(predicate: predicate) as? PagoInfoScreenModel else { return }
        if predicate.dismissable {
            view?.setupDismissButton()
        }
        update(model: modelT)
        if let imageData = model.image as? PagoInfoScreenSimpleImage {
            let imagePresenter = PagoImageViewPresenter(model: imageData.image)
            view?.setup(image: imagePresenter)
        } else if let animationData = model.image as? PagoInfoScreenAnimatedImage {
            let animationPresenter = PagoAnimationPresenter(model: animationData.image)
            view?.setup(animation: animationPresenter)
        } else if let loadedImageModel = model.image as? PagoInfoScreenLoadedImage {
            let imagePresenter = PagoLoadedImageViewPresenter(model: loadedImageModel.image)
            view?.setup(loadedImage: imagePresenter)
        }
        if let title = model.title {
            titlePresenter = PagoLabelPresenter(model: title)
            view?.add(space: 32)
            view?.setup(title: titlePresenter)
        }
        if let error = model.error {
            let errorPresenter = PagoLabelPresenter(model: error)
            view?.add(space: 24)
            view?.setup(error: errorPresenter)
        }
        if let detailModel = model.detail {
            view?.add(space: 24)
            let detailPresenter = PagoLabelPresenter(model: detailModel)
            detailPresenter.delegate = self
            view?.setup(detail: detailPresenter)
            self.detailPresenter = detailPresenter
        }
        if let mainButtonModel = model.mainAction {
            let mainActionPresenter = PagoButtonPresenter(model: mainButtonModel)
            mainActionPresenter.delegate = self
            mainButtonPresenter = mainActionPresenter
        }
        if let secondActionModel = model.secondaryAction {
            let secondaryPresenter = PagoButtonPresenter(model: secondActionModel)
            secondaryPresenter.delegate = self
            secondaryButtonPresenter = secondaryPresenter
        }
        view?.setup(main: mainButtonPresenter, secondary: secondaryButtonPresenter)
        if let extra = model.extra {
            view?.add(space: 16)
            let extraPresenter = PagoStackedInfoPresenter(model: extra)
            view?.setup(extra: extraPresenter)
        }
        if let footer = model.footer {
            let footerPresenter = PagoStackedInfoPresenter(model: footer)
            footerPresenter.delegate = self
            view?.setup(footer: footerPresenter)
            self.footerPresenter = footerPresenter
        }
        if hasDelay {
            startDelay()
        }
    }
    
    func updateSecondaryTitle(timeLeft: Int) {
        guard let title = predicate.secondaryButton?.getDelayedTitle(delay: timeLeft) else { return }
        self.secondaryButtonPresenter?.update(title: title)
    }
    
    func startDelay() {
        guard let delayModel = predicate.secondaryButton else { return }
        self.secondaryButtonPresenter?.isEnabled = false
        updateSecondaryTitle(timeLeft: delay)
        let update: (Int)->() = { time in
            self.updateSecondaryTitle(timeLeft: time)
        }
        let completion: ()->() = {
            self.secondaryButtonPresenter?.isEnabled = true
            self.secondaryButtonPresenter?.update(title: delayModel.title)
        }
        service.repeater.startTimer(time: delay, update: update, completion: completion)
    }

}

extension PagoInfoScreenPresenter: PagoStackedInfoPresenterDelegate {

    func didTap(presenter: PagoStackedInfoPresenter) {
        guard presenter == footerPresenter else { return }
        delegate?.didTapFooter()
    }
}

extension PagoInfoScreenPresenter: PagoButtonPresenterDelegate {
    
    func didTap(button: PagoButtonPresenter) {
        guard button.isEnabled else { return }
        switch button {
        case mainButtonPresenter:
            delegate?.didSelectMainAction()
        case secondaryButtonPresenter:
            delegate?.didSelectSecondaryAction()
        default:
            break
        }
    }
}

extension PagoInfoScreenPresenter: PagoLabelPresenterDelegate {
    
    func didTap(label: PagoLabelPresenter) {
        delegate?.didTapDetail()
    }
}
