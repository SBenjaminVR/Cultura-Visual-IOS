//
//  EstadisticasAlumno.swift
//  Cultura Visual y Sonora
//
//  Created by Carolina Gonzalez on 5/18/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class EstadisticasAlumno: UIViewController {
    
    var listaIntentos: [Intento] = [Intento]()
    var nombreUsuario: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        obtenerIntentos(addIntentos)
    }
    
    //MARK: - Traer intentos de Firebase
    func obtenerIntentos(_ completion: @escaping ([QueryDocumentSnapshot])->Void) {
        let cuestRef = Firestore.firestore().collection("Intentos").whereField("usuario", isEqualTo: "\(nombreUsuario!)")
          
        cuestRef.getDocuments(completion: { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                  let alerta = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                  let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                  
                  alerta.addAction(accion)
                  
                  self.present(alerta, animated: true, completion: nil)
                  return
            }
            
            let documents = querySnapshot.documents
            completion(documents)
        })
    }
    
    func addIntentos(documents: [QueryDocumentSnapshot]) {
        var usuario: String
        var cuestionario: String
        var correctas: Int
        var incorrectas: Int
        var respuestas: [Int]
        var i = 0
        
        for document in documents {
            usuario = document["usuario"] as? String ?? "(noUser)"
            cuestionario = document["cuestionario"] as? String ?? "(noCuest)"
            correctas = document["correctas"] as? Int ?? 0
            incorrectas = document["incorrectas"] as? Int ?? 0
            respuestas = document["respuestas"] as! [Int]
            
            self.listaIntentos.append(Intento(corr: correctas, incorr: incorrectas, user: usuario, cuest: cuestionario, respUser: respuestas))
            
            i+=1
        }
        
        for i in 0...listaIntentos.count-1 {
            print("INTENTO DE: \(listaIntentos[i].cuestionario)")
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
