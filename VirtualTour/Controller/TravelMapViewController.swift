//
//  TravelMapViewController.swift
//  VirtualTour
//
//  Created by Abdullah alammar on 08/06/2019.
//  Copyright © 2019 Abdullah alammar. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import CoreLocation

class TravelMapViewController: UIViewController , NSFetchedResultsControllerDelegate {
    
    var locationCoordinate : CLLocationCoordinate2D!
    var editMode = false
    var fetchedResultsController : NSFetchedResultsController<Pin>!
    
    @IBOutlet var navigationBar: UINavigationItem!
    
    var context : NSManagedObjectContext {
        return DataController.shared.viewContext
        
    }
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var editBtn: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
setupFechedResultsController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
         fetchedResultsController = nil
    }
    
    
    @IBAction func editBtnTapped(_ sender: UIBarButtonItem) {
        
        if editMode == false {
             editMode = true
            editBtn.title = "Done"
            navigationBar.title = "Tap Pin to Delete"
        }
        
        else {
            editMode = false
            editBtn.title = "Edit"
             navigationBar.title = "Virtual Tourist"
            
        }
        
        
        
    }
    
   
    
    
    func setupFechedResultsController() {
        
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        
        fetchRequest.sortDescriptors = [
        
            NSSortDescriptor(key: "createdAt", ascending: false)
        
        ]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            updateMapView()
        }
        catch {
            
            fatalError("the fech failed : \(error.localizedDescription)")
            
        }
    }
    
    @IBAction func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        
        
        if sender.state != .began {return}
        
        let touchPoint = sender.location(in: mapView)
        
        let pin = Pin(context: context)
        
        pin.coordinate = mapView.convert(touchPoint , toCoordinateFrom: mapView)
        print("pin is not nil  : \(pin.coordinate) " )

        try? context.save()
        
        
    }
    
  
    
    
    
    
    func updateMapView() {
        
        guard let pins = fetchedResultsController.fetchedObjects else {return}
        
        for pin in pins {
            if mapView.annotations.contains(where: {pin.compare(to: $0.coordinate)}) {continue}
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = pin.coordinate
            
            mapView.addAnnotation(annotation)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhotos" {
            
            print("we sent pin here ")
            
            let photosVC = segue.destination as! AlbumViewController
            photosVC.pin = sender as? Pin
           
            
               print("pin coo is \(photosVC.pin?.coordinate.longitude) ")
            
        
        }
    }
    
    

 

}



extension TravelMapViewController : MKMapViewDelegate {
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else {
            return
        }
        
        guard let annotationCo = view.annotation?.coordinate else {
            
            print("No annotation coordinate")
            return
        }
        print("annotationCo   \(annotationCo)")
        
        print("\(#function) lat \(annotation.coordinate.latitude) lon \(annotation.coordinate.longitude)")
        
        
         let pin = fetchedResultsController.fetchedObjects?.filter {$0.compare(to: annotationCo)}.first
        
        
        if editMode == false {
            
            performSegue(withIdentifier: "ShowPhotos", sender: pin)
            
        }
        
        else {
            mapView.deselectAnnotation(view.annotation, animated: true)
           
            context.delete(pin!)
            try? context.save()
              self.mapView.removeAnnotation(view.annotation!)
            updateMapView()
            
            
        }
        
      
        
        
    }
    
   
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateMapView()
    }
    

}

