//
//  RegistroUsuario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class RegistroUsuario: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfCorreo: UITextField!
    @IBOutlet weak var tfContrasena: UITextField!
    @IBOutlet weak var tfConfirmar: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    func setBackground() -> Void {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "shinyBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @IBAction func crearCuenta(_ sender: Any) {
        
        if ((tfNombre?.text) != nil) && ((tfCorreo?.text) != nil) && ((tfContrasena?.text) != nil) && ((tfConfirmar?.text) != nil) {
            
        //Falta encriptar contraseña
            let nuevoUser = Usuario(nom: tfNombre.text!, tipo: "Alumno", user: tfCorreo.text!, passw: tfContrasena.text!)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
