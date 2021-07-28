//
//  SplashViewController.swift
//  OmdbMovieApp
//
//  Created by Şafak Can Baş on 24.07.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class SplashViewController : UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.logEvent("splash_lunched", parameters: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideNavigationControllerTopBar()
        configureDatabase()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 4.0))
        rootToMovieViewController()
    }
    
    func configureDatabase() {
        let referance = database.document("Loodos/Title")
        referance.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {return}
            guard let fetchedString: String = data.first!.value as? String else {return}
            self.titleLabel.text = fetchedString
        }
    }
    
    func rootToMovieViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MovieViewController") as! MovieViewController
        let navigation = UINavigationController(rootViewController: viewController)
        let sceneDelegate =  UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = navigation
    }
    
}



