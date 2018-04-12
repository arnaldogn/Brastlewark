//
//  LoginViewController.swift
//  Brastlewark
//
//  Created by Arnaldo Gnesutta on 11/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import GoogleSignIn
import Swinject

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    private let gSignIn: GIDSignInButton = {
        let button = GIDSignInButton()
        return button
    }()
    private let loginTitle: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "Brastlewark"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    private lazy var skipForNow: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15
        button.setTitle("Skip for now", for: .normal)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skipForNowTapped(sender:))))
        return button
    }()
    private var googleAPIKey: String? {
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary?["Google"] as? [String: Any] else {
            return nil
        }
        return infoDictionary["APIKey"] as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservers()
        setupGoogleSignIn()
    }
    
    private func setupGoogleSignIn() {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = googleAPIKey
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receiveToggleAuthUINotification(notification:)),
                                               name: NSNotification.Name(rawValue: Notification.toggleUI),
                                               object: nil)
        
        
    }
    
    private func setupConstraints() {
        let views = ["skipForNow": skipForNow,
                     "gSignIn": gSignIn]
        view.addConstraints(
            NSLayoutConstraint.constraints("V:[gSignIn]-20-[skipForNow]-50-|", views: views))
        
        gSignIn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        skipForNow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        skipForNow.widthAnchor.constraint(equalTo: gSignIn.widthAnchor).isActive = true
        loginTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true
        loginTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupViews() {
        view.addSubviewsForAutolayout(loginTitle, gSignIn, skipForNow)
        setupConstraints()
    }
    
    private func toggleAuthUI() {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            // Signed in
            presentMainController()
        }
    }
    
    private func presentMainController() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let container = appDelegate.container
        guard let mainViewController = container.resolve(MainViewController.self) else { return }
        let navigationController = UINavigationController(rootViewController: mainViewController)
        present(navigationController, animated: false, completion: nil)
    }
    
    private func isSignInNotification(_ notification: NSNotification) -> Bool {
        return notification.name.rawValue == Notification.toggleUI
    }
    
    @objc private func receiveToggleAuthUINotification(notification: NSNotification) {
        if isSignInNotification(notification) {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: Notification.toggleUI),
                                                      object: nil)
            self.toggleAuthUI()
        }
    }

    @objc private func skipForNowTapped(sender: AnyObject) {
        presentMainController()
    }

}

