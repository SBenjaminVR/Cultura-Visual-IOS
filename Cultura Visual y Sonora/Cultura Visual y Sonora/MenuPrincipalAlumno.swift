//
//  MenuPrincipalAlumno.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class MenuPrincipalAlumno: UIViewController, UIPopoverPresentationControllerDelegate {

    var nombreUsuario:String! = nil
    @IBOutlet weak var btnCerrar: UIButton!
    @IBOutlet weak var btnCuestionario: UIButton!
    @IBOutlet weak var btnGeneral: UIButton!
    @IBOutlet weak var btnEstadisticas: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        var maximoFont: CGFloat
        var maximoBtnPequeno: CGFloat
            
        if (width > 1125) {
            maximoFont = 44
            maximoBtnPequeno = 28
        }
        else {
            maximoFont = 24
            maximoBtnPequeno = 16
        }
        ajustarFontSize(label: btnCerrar.titleLabel!, bold: false, maxSize: maximoBtnPequeno)
        ajustarFontSize(label: btnCuestionario.titleLabel!, bold: false, maxSize: maximoFont)
        ajustarFontSize(label: btnGeneral.titleLabel!, bold: false, maxSize: maximoFont)
        ajustarFontSize(label: btnEstadisticas.titleLabel!, bold: false, maxSize: maximoFont)
        }
        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return UIInterfaceOrientationMask.portrait
        }
        
        override var shouldAutorotate: Bool {
            return false
        }
        
        func ajustarFontSize(label: UILabel, bold: Bool, maxSize: CGFloat) -> CGFloat {
            let maxFontSize: CGFloat = maxSize
            let minFontSize: CGFloat = 10

            if bold {
                label.font = UIFont(name: "HelveticaNeue-Bold", size: maxFontSize)!
            }
            else {
                label.font = UIFont(name: "HelveticaNeue", size: maxFontSize)!
            }
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = minFontSize/maxFontSize
            
            return label.font.pointSize
        }
        
    func setBackground() -> Void {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "shinyBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func adaptivePresentationStyle (for controller:
        UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cuestionarios" {
            let navCon = segue.destination as! UINavigationController
            let tableViewCon = navCon.topViewController as! ListaCuestionariosA
            tableViewCon.nombreUsuario = nombreUsuario
        }
        
        if segue.identifier == "estadisticas" {
            let navController = segue.destination as! UINavigationController
            let vista = navController.topViewController as! EstadisticasAlumno
            vista.nombreUsuario = nombreUsuario!
        }
        
        if segue.identifier == "popOver" {
            let vistaPopOver = segue.destination as! CuestionarioGeneral
            vistaPopOver.popoverPresentationController!.delegate = self
            vistaPopOver.nombreUsuario = nombreUsuario!
        }
    }
    

}
