//
//  ViewController.swift
//  TSI-MKOverlay-Callout
//
//  Created by Diego on 4/11/17.
//  Copyright © 2017 Diego. All rights reserved.
//

import Cocoa
import MapKit

extension MKPolygon
{
    func contains(coordinate: CLLocationCoordinate2D) -> Bool
    {
        let polygonRenderer = MKPolygonRenderer(polygon: self)
        let currentMapPoint: MKMapPoint = MKMapPointForCoordinate(coordinate)
        let polygonViewPoint: CGPoint = polygonRenderer.point(for: currentMapPoint)
        return polygonRenderer.path.contains(polygonViewPoint)
    }
}

struct MyFigure
{
    var name: String
    var coordinates: [CLLocationCoordinate2D]
    var polygon: MKPolygon
}

class ViewController: NSViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var figures = [MyFigure]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.445382956560934, longitude: -99.117824745970992), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        figures = Utils.getFigures()
        mapView.addOverlays(figures.map{$0.polygon})
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        if let polygon = overlay as? MKPolygon
        {
            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.lineWidth = 1.0
            renderer.strokeColor = NSColor.red
            renderer.fillColor = NSColor(colorLiteralRed: 1.0, green: 0.0, blue: 0.0, alpha: 0.1)
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }


}

