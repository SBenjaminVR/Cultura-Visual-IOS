//
//  CuestionarioGeneral.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 5/20/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class CuestionarioGeneral: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var nombre:String!
    var cantPreg:Int = 5
    var tiempo:Double = 4.0
    var nombreUsuario:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        preferredContentSize = CGSize(width: 350, height: 200)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    @IBAction func setQuestionNumber(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            cantPreg = 5
            tiempo = 3.0
        } else if sender.selectedSegmentIndex == 1 {
            cantPreg = 10
            tiempo = 6.0
        } else if sender.selectedSegmentIndex == 2 {
            cantPreg = 20
            tiempo = 10.0
        } else {
            cantPreg = 0
            tiempo = 15.0
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cuest = Cuestionario(nom: "CuestGeneral", numPreg: cantPreg, tiempo: tiempo)
        
        let vista = segue.destination as! DetalleCuestionario
        vista.cuestionarioSeleccionado = cuest
        vista.nombreUsuario = nombreUsuario!
    }
    

}
