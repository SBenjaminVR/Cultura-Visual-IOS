//
//  EstadisticasAlumno.swift
//  Cultura Visual y Sonora
//
//  Created by El cantu on 5/21/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class customTableViewCell: UITableViewCell{
    @IBOutlet weak var lbCuestionario: UILabel!
    @IBOutlet weak var lbCalifa: UILabel!
    
}

class EstadisticasAlumno: UITableViewController {
    
    var listaIntentos: [Intento] = [Intento]()
    var nombreUsuario: String!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "Mis Estadisticas"
        
        obtenerIntentos(addIntentos)
    }
    
    // MARK: - Traer Intentos de Firebase
    
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
        
        tableView.reloadData()
       }
    
    @IBAction func volverAtras(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaIntentos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! customTableViewCell

        if listaIntentos[indexPath.row].cuestionario != "CuestGeneral" {
            cell.lbCuestionario.text = listaIntentos[indexPath.row].cuestionario
        } else {
            cell.lbCuestionario.text = "Cuestionario General"
        }
        
        let cCorrectas =  Double(listaIntentos[indexPath.row].correctas)
        let cIncorrectas = Double(listaIntentos[indexPath.row].incorrectas)
        var califa = cCorrectas / (cCorrectas+cIncorrectas)
        
        if(califa >= 0.70){
            cell.lbCalifa.textColor = UIColor.green
        }
        else if(califa >= 0.30 ){
            cell.lbCalifa.textColor = UIColor(red: 254/255, green: 205/255, blue: 46/255, alpha: 1)
        }
        else{
            cell.lbCalifa.textColor = UIColor.red
        }
        
        califa *= 100

        cell.lbCalifa.text = "\(Int(califa))%"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78.0
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
