//
//  LoginViewController.swift
//  Itunes
//
//  Created by Anthony  Dupré on 29/03/2019.
//  Copyright © 2019 Anthony  Dupré. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    @IBOutlet weak var SignIn: UIButton!
    @IBOutlet weak var SignUp: UIButton!

    @IBOutlet weak var Mail: UITextField!{
        didSet {
            Mail.setIcon(UIImage(named: "icon_user")!)
            Mail.underlineTextField()
        }
    }

    @IBOutlet weak var Password: UITextField!{
        didSet {
            Password.setIcon(UIImage(named: "icon_password")!)
            Password.underlineTextField()
        }
    }

    @IBAction func signin_Action(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: Mail.text!, password: Password.text!) { [weak self] user, error in
            if(error != nil) {
                let alert : UIAlertView = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: nil, cancelButtonTitle: "Cancel")
                alert.show()
            }
            else {
                let secondVC = self!.storyboard?.instantiateViewController(withIdentifier: "viewCont") as! UINavigationController
                self!.present(secondVC, animated:true, completion:nil)
            }
        }
    }

    @IBAction func signup_Action(_ sender: Any) {
        Auth.auth().createUser(withEmail: Mail.text!, password: Password.text!) { authResult, error in
            print("\(String(describing: error?.localizedDescription))")
            if(error != nil) {
                let alert : UIAlertView = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: nil, cancelButtonTitle: "Cancel")
                alert.show()
            }
            else {
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "viewCont") as! UINavigationController
                self.present(secondVC, animated:true, completion:nil)
            }
        }
    }

    //SEGUE -> LOG to Itunes

    @IBAction func Google(_ sender: Any) {
        guard let url = URL(string: "https://www.google.fr/") else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func Facebook(_ sender: Any) {
        guard let url = URL(string: "https://www.facebook.com/") else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func Twitter(_ sender: Any) {
        guard let url = URL(string: "https://twitter.com/") else { return }
        UIApplication.shared.open(url)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    }

    extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 0, y: 5, width: 20, height: 20))
        iconView.image = image
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }

    func underlineTextField () {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    }

    extension UILabel{
    func underlineLabel() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString);   attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}
