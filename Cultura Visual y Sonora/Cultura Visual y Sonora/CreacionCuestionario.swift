//
//  CreacionCuestionario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class CreacionCuestionario: UIViewController {
    
    // MARK: - Variables
    
    @IBOutlet weak var tipoPreguntas: UISegmentedControl! //Segmented Control para mostrar el tipo de Preguntas
    @IBOutlet weak var tipoRespuestas: UISegmentedControl! //Segmented Control para mostrar el tipo de Respuestas
    @IBOutlet weak var imagenDeLaPregunta: UIImageView! //Imagen representando la pregunta
    @IBOutlet weak var btnCargaraImagenPregunta: UIButton! //Boton para cargar esa imagen
    @IBOutlet weak var tfPregunta: UITextField! //Text Field para la pregunta
    
    //Imagenes para preguntas
    @IBOutlet weak var imgR1: UIImageView!
    @IBOutlet weak var imgR2: UIImageView!
    @IBOutlet weak var imgR3: UIImageView!
    @IBOutlet weak var imgR4: UIImageView!
    
    //Botones para cargar la imagen
    @IBOutlet weak var btnR1: UIButton!
    @IBOutlet weak var btnR2: UIButton!
    @IBOutlet weak var btnR3: UIButton!
    @IBOutlet weak var btnR4: UIButton!
    
    //TextFields para cargar imagen
    @IBOutlet weak var tfRespuesta1: UITextField!
    @IBOutlet weak var tfRespuesta2: UITextField!
    @IBOutlet weak var tfRespuesta3: UITextField!
    @IBOutlet weak var tfRespuesta4: UITextField!
    
    @IBOutlet weak var btnAgregarPregunta: UIButton! //Boton para agregrar pregunta a arreglo de preguntas
    
    @IBOutlet weak var btnCrearCuestionario: UIButton! //Boton para crear el cuestionario
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
