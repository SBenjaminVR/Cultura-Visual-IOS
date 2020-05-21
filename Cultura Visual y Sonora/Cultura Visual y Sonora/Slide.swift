//
//  Slide.swift
//  Cultura Visual y Sonora
//
//  Created by user169165 on 4/20/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

protocol protocoloContestaCuestionario {
    func agregaRespuesta(resp : Int, id: Int) -> Void
    func entregaCuestionario() -> Void
    func reiniciarCuestionario() -> Void
}

class Slide: UIView {
    
    // MARK: - Variables
    
    @IBOutlet weak var lblNumeroPregunta: UITextView!
    @IBOutlet weak var imgPregunta: UIImageView!
    @IBOutlet weak var btnRespuestaTexto1: UIButton!
    @IBOutlet weak var btnRespuestaTexto2: UIButton!
    @IBOutlet weak var btnRespuestaTexto3: UIButton!
    @IBOutlet weak var btnRespuestaTexto4: UIButton!
    @IBOutlet weak var btnEntregar: UIButton!
    @IBOutlet weak var btnReiniciar: UIButton!
    
    var id:Int!
    var nombreUsuario:String! = nil
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    //Views para hidear si la pregunta es de V/F
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var delegado : protocoloContestaCuestionario!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func marcarRespuesta(numRespuesta: Int) {
        view1.layer.borderWidth = 0
        view2.layer.borderWidth = 0
        view3.layer.borderWidth = 0
        view4.layer.borderWidth = 0
        
        switch numRespuesta {
        case 1:
            view1.layer.borderWidth = 10
            view1.layer.borderColor = UIColor.red.cgColor
            break;
        case 2:
            view2.layer.borderWidth = 10
            view2.layer.borderColor = UIColor.red.cgColor
            break;
        case 3:
            view3.layer.borderWidth = 10
            view3.layer.borderColor = UIColor.red.cgColor
            break;
        case 4:
            view4.layer.borderWidth = 10
            view4.layer.borderColor = UIColor.red.cgColor
            break;
        default:
            break;
        }
    }
    
    // MARK: - Funcion de botones
    
    @IBAction func actionbtn1(_ sender: UIButton) {
        //print(sender.tag)
        marcarRespuesta(numRespuesta: sender.tag)
        delegado.agregaRespuesta(resp: sender.tag, id: self.id)
    }
    
    @IBAction func finishQuestionnaire(_ sender: UIButton) {
        delegado.entregaCuestionario()
    }
    
    @IBAction func reiniciar(_ sender: UIButton) {
        delegado.reiniciarCuestionario()
    }
}
