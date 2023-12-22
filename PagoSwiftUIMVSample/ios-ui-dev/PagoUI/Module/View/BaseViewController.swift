//
//  BaseViewControllerT.swift
//  Pago
//
//  Created by Bogdan-Gabriel Chiosa on 05/12/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController, ViewControllerPresenterView {

    private lazy var datasource: PagoSDWebImageDataSource? = {
        return PagoUIConfigurator.datasource?.sdwebImage
    }()
    
    public var basePresenter: ViewControllerPresenter!
    private var observation: NSKeyValueObservation?
    private var navImageView: UIImageView?
    private var navTitleLabel: UILabel?
    private let refreshControl = UIRefreshControl()

    @IBOutlet public var navScrollView: UIScrollView?
    @IBOutlet public var navigationView: PagoNavigationView?
    @IBOutlet public var scrollViewBottomConstraint: NSLayoutConstraint?
    public var emptyScreen: PagoEmptyListScreenView?
    public var emptyScreenBottomOffset: CGFloat = 0
    
    var oldScroll = CGPoint.zero
    private var loadingOverlayContainer: PagoView?
    private var backButtonOverlay: UIButton?
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    public convenience init(presenter: ViewControllerPresenter) {
        
        self.init()
        self.basePresenter = presenter
        if let hidesBottomBarWhenPushed = PagoUIConfigurator.hidesBottomBarWhenPushed {
            self.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        }
    }

    open override func viewDidLoad() {
        
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        self.navigationController?.delegate = self
        view.backgroundColor = .white
        self.automaticallyAdjustsScrollViewInsets = false
        self.setNeedsStatusBarAppearanceUpdate()
        let margins = view.layoutMarginsGuide
        let navigationView = PagoNavigationView()
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationView)
        
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        self.navigationView = navigationView

        //TODO: This is a handle for simple base view controllers
        if let navScrollView = navScrollView {
            navScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            navScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            navScrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
            navScrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            let scrollViewBottomConstraint = margins.bottomAnchor.constraint(equalTo: navScrollView.bottomAnchor)
            scrollViewBottomConstraint.isActive = true
            self.scrollViewBottomConstraint = scrollViewBottomConstraint
        }
        self.navigationController?.navigationBar.tintColor = PagoThemeStyle.custom.backButtonColor.color
    }
    
    open func secureScreen() {
        //Security settings
        
        if #available(iOS 11.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(didDetectRecording), name: UIScreen.capturedDidChangeNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(didDetectScreenshot), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
            
            if UIScreen.main.isCaptured || UIScreen.main.mirrored != nil  {
                showBlockedScreen()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(willResignApp), name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkPasteboardChange), name: UIPasteboard.changedNotification, object: nil)
    }
    
    @objc public func didDetectRecording() {
        
        DispatchQueue.main.async { [weak self] in
            self?.showBlockedScreen()
        }
    }
    
    
    @objc public func didDetectScreenshot() {
        
        let alertController = UIAlertController(title: "Informație despre securitate", message: "Am detectat că ai facut captură de ecran într-un ecran cu informații personale. Iți recomandăm să nu distribui poza și să o ștergi din galeria telefonului.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Am înțeles", style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc public func willResignApp() {
        
        self.view.bringSubviewToFront(blockedView)
        NotificationCenter.default.removeObserver(self, name: UIPasteboard.changedNotification, object: nil)
    }
    
    @objc public func didBecomeActive() {
        
        self.showBlockedScreen()
        NotificationCenter.default.addObserver(self, selector: #selector(checkPasteboardChange), name: UIPasteboard.changedNotification, object: nil)
    }

    private lazy var blockedView: PagoView = {
        
        let view = PagoView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.view.sendSubviewToBack(view)
 
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = PagoVisualEffectView(effect: blurEffect, intensity: 0.2)
        view.addSubview(visualEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.insertSubview(visualEffectView, at: 0)
        return view
    }()
    
    @objc public func showBlockedScreen() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.canLeak {
                self.view.bringSubviewToFront(self.blockedView)
            } else {
                self.view.sendSubviewToBack(self.blockedView)
            }
        }
    }
    
    @objc public func checkPasteboardChange() {
        
        UIPasteboard.remove(withName: UIPasteboard.general.name)
    }
    
    private var canLeak: Bool {
        if #available(iOS 11.0, *) {
            return UIScreen.main.isCaptured || UIScreen.main.mirrored != nil
        } else {
            return false
        }
    }

    public func setupPullToRefresh(with scrollView: UIScrollView) {
        
        refreshControl.addTarget(self, action: #selector(syncDataWithRemote), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    public func removePullToRefresh(from scrollView: UIScrollView) {
        
        refreshControl.removeTarget(self, action: #selector(syncDataWithRemote), for: .valueChanged)
        scrollView.refreshControl = nil
    }
    
    open func setupPullToRefresh() {}
    
    open func removePullToRefresh() {}
    
    open func setupViewBackground(hasEmptyScreen: Bool) {
        if hasEmptyScreen {
            view.backgroundColor = UIColor.Pago.white.color
        } else {
            view.backgroundColor = PagoThemeStyle.custom.primaryBackgroundColor.color
        }

    }

    @objc func syncDataWithRemote() {
        
        basePresenter.reloadDataFromRemote()
    }

    open func keyboardWillAppearUpdates() {}
    
    open func keyboardWillDissappearUpdates() {}
    
    @objc func baseKeyboardWillChangeFrame(_ notification:Notification) {
    
        guard let scrollViewBottomConstraint = scrollViewBottomConstraint else { return }
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            
            var bottomSafeArea: CGFloat!
            if #available(iOS 11.0, *) {
                bottomSafeArea = view.safeAreaInsets.bottom
            } else {
                bottomSafeArea = bottomLayoutGuide.length
            }
            
            if endFrameY >= UIScreen.main.bounds.size.height {
                guard scrollViewBottomConstraint.constant != 0.0 else { return }
                scrollViewBottomConstraint.constant = 0.0
                keyboardWillDissappearUpdates()
            } else if let height = endFrame?.size.height {
                keyboardWillAppearUpdates()
                scrollViewBottomConstraint.constant = (height - bottomSafeArea)
            } else {
                keyboardWillDissappearUpdates()
                scrollViewBottomConstraint.constant = 0.0
            }
            UIView.animate(withDuration: duration,
                                       delay: TimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(baseKeyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        basePresenter.willAppear()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        basePresenter.willDissapear()
    }

    func reloadData() {
        
        basePresenter.reloadData()
    }
    
    var rightBarButtonItems = [UIBarButtonItem]()
    
    func setupCustomNavigation(rightButtons: [PagoButtonPresenter]? = nil) {

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.text = basePresenter.navigationTitle
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = basePresenter.navigationTitleColor.color
        self.navTitleLabel = titleLabel
        
        let imageView = UIImageView()
        let imageName = basePresenter.navigationImage ?? ""
        imageView.image = imageName.isEmpty ? nil : UIImage(named: imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.contentMode = .scaleAspectFit
        let contentView = UIView()
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.alpha = 0
        self.navImageView = imageView

        if !(basePresenter.navigationImage ?? "").isEmpty || !(basePresenter.navigationTitle ?? "").isEmpty {
            self.navigationItem.titleView = contentView
        }
        
        navScrollView?.delegate = self
        navScrollView?.alwaysBounceVertical = true
        
        if let image = basePresenter.navigationImage, !image.isEmpty {
            navImageView?.image = UIImage(named: image)
        } else if let bImage = basePresenter.navigationBackendImage {
            loadCustomNavigationImage(placeholder: bImage.placeholderImageName, url: bImage.url)
        }
        
        rightBarButtonItems.removeAll()
        
        if let images = rightButtons {
            for buttonPresenter in images.reversed() {
                let button = PagoButton(presenter: buttonPresenter)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: 36).isActive = true
                button.widthAnchor.constraint(equalToConstant: 36).isActive = true
                let item = UIBarButtonItem(customView: button)
                rightBarButtonItems.append(item)
            }
        }
    }
    
    public func setupScreenLoader(presenter: PagoStackedInfoPresenter, backgroundColor: UIColor.Pago = .clear) {
        
        self.loadingOverlayContainer?.removeFromSuperview()
        let loadingOverlayContainer = PagoView()
        loadingOverlayContainer.backgroundColor = backgroundColor.color
        loadingOverlayContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingOverlayContainer)
        loadingOverlayContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        loadingOverlayContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        loadingOverlayContainer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        loadingOverlayContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.view.bringSubviewToFront(loadingOverlayContainer)
        self.loadingOverlayContainer = loadingOverlayContainer
        let infoView = PagoStackedInfoView(presenter: presenter)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        loadingOverlayContainer.addSubview(infoView)
        let heightDiff = -47.0 // nvbar default is 94 //TODO: Make this dynamic
        infoView.centerXAnchor.constraint(equalTo: loadingOverlayContainer.centerXAnchor).isActive = true
        infoView.centerYAnchor.constraint(equalTo: loadingOverlayContainer.centerYAnchor, constant: heightDiff).isActive = true
        self.loadingOverlayContainer?.isHidden = true
    }
    
    public func removePopHandler() {
        
        self.backButtonOverlay?.removeFromSuperview()
    }
    
    public func setupForPopHandler() {
        
        if let backButtonOverlay = backButtonOverlay {
            navigationController?.navigationBar.addSubview(backButtonOverlay)
        } else {
            let transparentButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
            transparentButton.backgroundColor = .clear
            transparentButton.addTarget(self, action: #selector(popAction), for: .touchUpInside)
            navigationController?.navigationBar.addSubview(transparentButton)
            self.backButtonOverlay = transparentButton
        }
    }
    
    @objc func popAction() {
        
        basePresenter.popScreen()
    }
    
    //TODO: This must be refactored and use something generic
    public func showOverlayLoading() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            //NOTE: if the refresh controll is animating it means that the user pulled to refresh, in which case wil not show the loadingOverlayContainer
            guard !self.refreshControl.isRefreshing else { return }
            
            self.loadingOverlayContainer?.isHidden = false
        }
    }
    
    public func hideOverlayLoading() {

        DispatchQueue.main.async { [weak self] in
            self?.loadingOverlayContainer?.isHidden = true
        }
    }
    
    public func loadCustomNavigationImage(placeholder: String = "", url: String) {
        
        let logoURL = URL(string: url)
        let placeholderImage = UIImage(named: placeholder)
        guard let navImageView = navImageView else { return }
        datasource?.loadImage(imageView: navImageView, urlString: logoURL, placeholderImage: placeholderImage) { [weak self] image in
            DispatchQueue.main.async {
                guard let self = self, let image = image else {
                    return
                }
                self.navImageView?.image = image
            }
        }
    }
    
    @objc func didTapBackButton() {
        
        navigationController?.popViewController(animated: true)
    }
    
    public static func fromNib(presenter: ViewControllerPresenter) -> Self {
        let vc = fromNib()
        vc.basePresenter = presenter
        return vc
    }

    @objc open dynamic func didStartedLoading() {}
    
    @objc open dynamic func didFinishLoading() {}
    
    @objc open dynamic func reloadView() {}
    
    public func shouldShowTitle(_ showTitle: Bool) {

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            guard (self.navTitleLabel?.alpha != 1 && showTitle) ||
                    (self.navTitleLabel?.alpha != 0 && !showTitle) else { return }
            
            
            if showTitle {
                self.navTitleLabel?.text = self.basePresenter.navigationTitle
                if !self.rightBarButtonItems.isEmpty {
                    self.navigationItem.setRightBarButtonItems(self.rightBarButtonItems, animated: true)
                    self.navigationView?.hideRightButtons()
                }
            } else {
                if !self.rightBarButtonItems.isEmpty {
                    self.navigationItem.setRightBarButtonItems(nil, animated: true)
                    self.navigationView?.showRightButtons()
                }
            }
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                self.navImageView?.alpha = showTitle ? 0 : 1
                self.navTitleLabel?.alpha = showTitle ? 1 : 0
            }
        }
        
    }

    open func setupNavigation(presenter: PagoNavigationPresenter) {
        
        DispatchQueue.main.async { [weak self] in
            self?.navigationView?.setup(presenter: presenter)
            self?.setupCustomNavigation(rightButtons: presenter.smallRightButtonsPresenters)
            self?.basePresenter.navigationViewDidLoad()
        }
    }
    
    public func snapNavigation(offset: Float?) {
        
        guard let offsetT = offset else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.navigationView?.handleSnap(offset: CGFloat(offsetT), parent: self.view)
        }
    }
    
    public func setupEmptyScreen(presenter: PagoEmptyListScreenPresenter) {
        
        guard emptyScreen == nil else { return }
        let emptyScreen = PagoEmptyListScreenView(presenter: presenter, container: self.view)
        emptyScreen.clipsToBounds = false
        emptyScreen.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(emptyScreen)
        emptyScreen.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        emptyScreen.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -emptyScreenBottomOffset).isActive = true
        emptyScreen.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        emptyScreen.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -24).isActive = true
        emptyScreen.alpha = 0
        emptyScreen.isHidden = true
        self.view.sendSubviewToBack(emptyScreen)
        self.emptyScreen = emptyScreen
        self.view.setNeedsLayout()
    }
    
    public func willShowEmptyScreen() {
        
        basePresenter.willShowEmptyScreen()
    }
    
    public func willHideEmptyScreen() {
        
        basePresenter.willHideEmptyScreen()
    }
    
    public func endRefreshAnimation() {
        
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    public func startRefreshAnimation() {
        
        if !refreshControl.isRefreshing {
            refreshControl.beginRefreshing()
        }
    }
    
    public func dismissKeyboard() {
        
        view.endEditing(true)
    }
}


extension UIScrollView {
    
    func updateContentSize(width: CGFloat = 0, height: CGFloat = 0) {
        
        let currentSize = self.contentSize
        let increasedSize = CGSize(width: currentSize.width + width, height: currentSize.height + height)
        self.contentSize = increasedSize
    }
}
