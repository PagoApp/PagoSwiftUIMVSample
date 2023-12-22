//
//  
//  LoginAccountViewController.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

protocol PagoInfoScreenDelegate: AnyObject {
    func dismissScreen()
    func didDismissScreen()
}

public class PagoInfoScreenViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: PagoScrollView!
    @IBOutlet weak var stackView: PagoStackView!
    private var buttonsStackView: PagoStackView!
    private var imageView: PagoImageView!
    private var titleLabel: PagoLabel!
    private var detailLabel: PagoLabel!
    var gradient: CAGradientLayer!
    weak var delegate: PagoInfoScreenDelegate?
    var presenter: PagoInfoScreenPresenter {
        return basePresenter as! PagoInfoScreenPresenter
    }
    
    init(presenter: ViewControllerPresenter) {
        super.init(nibName: nil, bundle: Bundle.init(for: PagoInfoScreenViewController.self))
        basePresenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.presentationController?.delegate = self
        stackView.alignment = .center
        stackView.spacing = 0
        buttonsStackView = PagoStackView()
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonsStackView)
        buttonsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        let horizontalMargins = CGFloat(PagoUIConfigurator.customConfig.buttons.marginHorizontal)
        buttonsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: horizontalMargins).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -horizontalMargins).isActive = true
        buttonsStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        buttonsStackView.spacing = 16
        buttonsStackView.axis = .vertical
        presenter.setView(mView: self)
        presenter.loadData()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //TODO: to be fixed, it was adding a shadow behind action buttons, without it in bigger info screens the content is seen between buttons
//        gradient = CAGradientLayer()
//        gradient.colors = [ UIColor.Pago.clear.cgColor, UIColor.white.cgColor]
//        gradient.locations = [0.0, 1.0]
//        gradient.frame = buttonsStackView.bounds
//        buttonsStackView.layer.insertSublayer(gradient, at: 0)
    }
    
    @objc func dismissScreenAction() {
        delegate?.dismissScreen()
    }
}

extension PagoInfoScreenViewController: UIAdaptivePresentationControllerDelegate {
  
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.didDismissScreen()
    }
}

extension PagoInfoScreenViewController: PagoInfoScreenPresenterView {

    func setupDismissButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.closeButton(self, action: #selector(self.dismissScreenAction))
    }
    
    func setup(main: PagoButtonPresenter?, secondary: PagoButtonPresenter?) {

        if let mainT = main {
            let mainButton = PagoButton(presenter: mainT)
            mainButton.translatesAutoresizingMaskIntoConstraints = false
            buttonsStackView.addArrangedSubview(mainButton)
            mainButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        if let secondaryT = secondary {
            let secondaryButton = PagoButton(presenter: secondaryT)
            secondaryButton.translatesAutoresizingMaskIntoConstraints = false
            buttonsStackView.addArrangedSubview(secondaryButton)
            secondaryButton.tintColor = PagoThemeStyle.custom.xBtnColor.color
            secondaryButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24 + 48 + 16 + 48 + 16, right: 0)
            
        } else {
            //TODO: Check if this is needed or if we can delete it
//            mainButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24).isActive = true
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24 + 48 + 16, right: 0)
        }
        buttonsStackView.addVerticalSpace(24)
    }

    func setup(animation: PagoAnimationPresenter) {
        
        let animationView = PagoAnimationView(presenter: animation)
        stackView.addArrangedSubview(animationView)
    }
    
    func setup(image: PagoImageViewPresenter) {
        
        imageView = PagoImageView(presenter: image)
        stackView.addArrangedSubview(imageView)
    }
    
    func setup(loadedImage: PagoLoadedImageViewPresenter) {
        let imageView = PagoLoadedImageView(presenter: loadedImage)
        stackView.addArrangedSubview(imageView)
    }
    
    func setup(title: PagoLabelPresenter) {
        
        titleLabel = PagoLabel(presenter: title)
        stackView.addArrangedSubview(titleLabel)
    }
    
    func setup(error: PagoLabelPresenter) {
        
        let errorLabel = PagoLabel(presenter: error)
        stackView.addArrangedSubview(errorLabel)
    }
    
    func setup(detail: PagoLabelPresenter) {
        
        detailLabel = PagoLabel(presenter: detail)
        stackView.addArrangedSubview(detailLabel)
    }
    
    func setup(extra: PagoStackedInfoPresenter) {
        
        let extraStack = PagoStackedInfoView(presenter: extra)
        stackView.addArrangedSubview(extraStack)
    }
    
    func setup(footer: PagoStackedInfoPresenter) {
        
        let footer = PagoStackedInfoView(presenter: footer)
        footer.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.addArrangedSubview(footer)
        buttonsStackView.addVerticalSpace(24)
    }
    
    func add(space: CGFloat) {
        
        stackView.addVerticalSpace(space)
    }
}
