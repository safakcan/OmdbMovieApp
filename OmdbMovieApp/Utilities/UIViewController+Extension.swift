//
//  UIViewController+Extension.swift
//  OmdbMovieApp
//
//  Created by Şafak Can Baş on 28.07.2021.
//

import UIKit

extension UIViewController {
    
    func hideNavigationControllerTopBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationControllerTopBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
