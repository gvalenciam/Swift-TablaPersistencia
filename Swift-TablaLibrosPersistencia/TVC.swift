//
//  TVC.swift
//  Swift-TablaLibros
//
//  Created by Gerardo Valencia on 1/15/16.
//  Copyright © 2016 Gerardo Valencia. All rights reserved.
//

import UIKit
import CoreData

var libros : Array<Array<String>> = Array<Array<String>>()
var imagenes : Array<UIImage> = Array<UIImage>()
var titulo = ""
var autor = ""
var banderayacargo = 0

class TVC: UITableViewController {

    var index = 10
    var nuevotitulo = ""
    var nuevoautor = ""
    
    /*
    @IBAction func Go(sender: AnyObject) {
        
        libros.append([titulo,autor])
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: libros.count-1, inSection: 0)], withRowAnimation: .Automatic)
        tableView.endUpdates()
        tableView.reloadData()
        
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (banderayacargo == 0 && libros.count == 0)
        {
        let libroEntidad = NSEntityDescription.entityForName("Libro", inManagedObjectContext: contextoGlobal)
        
        let peticion = libroEntidad?.managedObjectModel.fetchRequestTemplateForName("petLibros")
        
        do
        {
            let librosEntidad = try contextoGlobal.executeFetchRequest(peticion!)
            
            for libroEntidad2 in librosEntidad
            {
                let tituloCelda = libroEntidad2.valueForKey("titulo") as! String
                let autorCelda = libroEntidad2.valueForKey("autor") as! String
                let imagenCelda = libroEntidad2.valueForKey("tiene") as! NSObject
                
                let img = UIImage(data: imagenCelda.valueForKey("imagen") as! NSData)
                
                libros.append([tituloCelda,autorCelda])
                imagenes.append(img!)
            }
        }
        catch
        {
            
        }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return libros.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Celda", forIndexPath: indexPath)

        cell.textLabel?.text = libros[indexPath.row][0]
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "Return")
        {
            let next = segue.destinationViewController as! VistaDetalleViewController
            index = tableView.indexPathForSelectedRow!.row
            next.indice = index
            //print(libros[next.indice][0])
            tit = libros[next.indice][0]
            aut = libros[next.indice][1]
            ima = imagenes[next.indice]
        }
        else if (segue.identifier == "Go")
        {
            tit = "-"
            aut = "-"
            ima = nil
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
