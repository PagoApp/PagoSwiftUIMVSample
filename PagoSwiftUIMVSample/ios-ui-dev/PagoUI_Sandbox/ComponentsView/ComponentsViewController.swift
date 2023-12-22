//
//  ViewController.swift
//  PagoUI_Sandbox
//
//  Created by LoredanaBenedic on 02.01.2023.
//

import UIKit
import PagoUISDK

class ComponentsViewController: UIViewController {
    
    private var tableView = UITableView()
    
    var components: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIConfig {
            self.setupComponentTable()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func setupComponentTable() {
        
        tableView.register(ComponentTableViewCell.self, forCellReuseIdentifier: ComponentTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupUIConfig(completion: @escaping () -> ()) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
            try? DataRepository.setupUI()
            
            
            self.components = DataRepository.PagoComponents.allCases.map({$0.title})
            completion()
        }
    }
}


extension ComponentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComponentTableViewCell.identifier, for: indexPath)
        
        cell.textLabel?.text = String(components[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let navigationController = navigationController,
              let componentType = DataRepository.PagoComponents(rawValue: indexPath.row) else {
            return
        }
        
        switch componentType {
        case .button:
            let coord = PagoButtonsCoordinator(navigationController: navigationController)
            coord.start()
        case .menu:
            let coord = PagoMenusCoordinator(navigationController: navigationController)
            coord.start()
        case .textView:
            //TODO: Add component
            break
        case .images:
            let coord = PagoLoadedImagesCoordinator(navigationController: navigationController)
            coord.start()
        case .custom:
            let coord = PagoCustomComponentCoordinator(navigationController: navigationController)
            coord.start()
        case .pageControllers:
            let coord = PagoPageControllersCoordinator(navigationController: navigationController)
            coord.start()
        case .swiftUIInfoScreen:
            startSwiftUIInfoScreen()
        }
    }
    
    func startSwiftUIInfoScreen() {
        
        if #available(iOS 15.0, *) {
            let infoScreenCoordinator = PagoSUIntroCoordinator(viewController: self)
            let mainAction = { print("Main button was pressed!") }
            let secondaryAction = { print("Secondary button was pressed!") }
            let imageData = BackendImage(url: "https://assets.pago.ro/sdk/bcr/bills/img_scan_bill.png", placeholderImageName: "")
            let title = "Avem nevoie de permisiune pentru utilizarea camerei foto"
            let content = "Pentru a putea scana talonul este necesar accesul la camera foto."
            let mainButtonText = "Oferă acces"
            let secondaryButtonText = "Mai târziu"
            let predicate = PagoSUIntroPredicate(
                image: imageData,
                title: title,
                content: content,
                mainButtonText: mainButtonText,
                secondaryButtonText: secondaryButtonText
            )
            infoScreenCoordinator.start(
                predicate: predicate,
                mainCompletion: mainAction,
                secondaryCompletion: secondaryAction
            )
        } else {
            print("iOS 15.0 or greater is required!")
        }
    }
}
