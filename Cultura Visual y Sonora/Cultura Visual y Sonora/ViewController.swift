//
//  ViewController.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }

    @IBAction func logIn(_ sender: UIButton) {
        if tfUser.text == "alumno" {
            performSegue(withIdentifier: "alumno", sender: self)
        } else {
            performSegue(withIdentifier: "maestro", sender: self)
        }
    }
    
    func setBackground() -> Void {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    
    @IBAction func quitarTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

}

