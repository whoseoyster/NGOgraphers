//
//  ViewController.swift
//  NGOgraphers
//
//  Created by Rishab Ramanathan on 7/21/17.
//  Copyright © 2017 Rishab Ramanathan. All rights reserved.
//

import UIKit
//import ArcGISToolkit
import ArcGIS

class ViewController: UIViewController, AGSGeoViewTouchDelegate, AGSCalloutDelegate {
    @IBOutlet weak var mapView: AGSMapView!
    
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var litButton: CustomButton!
    @IBOutlet weak var earthButton: CustomButton!

    @IBOutlet weak var devButton: CustomButton!
    @IBOutlet weak var deforestationButton: CustomButton!
    
    @IBOutlet weak var underButton: CustomButton!
    
    @IBOutlet weak var watButton: CustomButton!
    
    @IBOutlet weak var envButton: CustomButton!
    @IBOutlet weak var disButton: CustomButton!
    @IBOutlet weak var healthButton: CustomButton!
    
    @IBOutlet weak var educationButton: CustomButton!
    
    @IBOutlet weak var zerenButton: CustomButton!
    
    @IBOutlet weak var violaHealthButton: CustomButton!
    @IBOutlet weak var violaEdButton: CustomButton!
    
    @IBOutlet weak var violaWaterButton: CustomButton!
    
    let portal = AGSPortal.arcGISOnline(withLoginRequired: false)
    var portalItem : AGSPortalItem?
    var map:AGSMap!
    
    var literacy: Bool = false
    var earthquakes: Bool = false
    var development: Bool = false
    var deforestation: Bool = false
    var undernourished: Bool = false
    var education: Bool = false
    var health: Bool = false
    
    var water: Bool = false
    var env: Bool = false
    var disaster: Bool = false
    var zeren: Bool = false
    var violaWater: Bool = false
    var violaEd: Bool = false
    var violaHealth: Bool = false
    
    var literacyLayer: AGSLayer?
    var earthquakesLayer: AGSLayer?
    var developmentLayer: AGSLayer?
    var deforestationLayer: AGSLayer?
    var undernourishedLayer: AGSLayer?
    
    
    var waterLayer: AGSLayer?
    var envLayer: AGSLayer?
    var disLayer: AGSLayer?
    var healthLayer: AGSLayer?
    var educationLayer: AGSLayer?
    
    var zerenLayer: AGSLayer?
    var violaHealthLayer: AGSLayer?
    var violaEdLayer: AGSLayer?
    var violaWaterLayer: AGSLayer?
    
    //private var featureTable:AGSServiceFeatureTable!
    private var featureLayer:AGSFeatureLayer!
    
    private var waterFeatures = [AGSFeature]()
    private var envFeatures = [AGSFeature]()
    private var disFeatures = [AGSFeature]()
    
    
    var popupController : PopupController?
    var legendVC: LegendViewController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Add a basemap tiled layer
        //map = AGSMap(url: URL(string: "http://www.arcgis.com/home/webmap/viewer.html?webmap=7b980d1c37204592bb1cd8dea4d78582&extent=-180,-35.4493,44.4368,73.2307")!)
        
        filterView.layer.cornerRadius = 15
        filterView.clipsToBounds = true
        filterView.isHidden = true
        
//        litButton.layer.cornerRadius = 15
//        filterView.clipsToBounds = true

        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Adelle Sans", size: 20)!]
        
        

        let portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: false)
        let portalItem = AGSPortalItem(portal: portal, itemID: "704b853ddee54ac489e63ec821ceaa9b")
        map = AGSMap(item: portalItem) //7b980d1c37204592bb1cd8dea4d78582
        //self.mapView.map = AGSMap(url: url as! URL)
        self.map.maxScale = 800000.0
        self.map.minScale = 100000000.0
        
        self.mapView.touchDelegate = self
        self.mapView.callout.delegate = self
        
        //popupController = PopupController(geoViewController: self, geoView: mapView)
        
        
        // add button that will show the SwitchBasemapViewController
        
        self.mapView.map = map
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
        //Monitor the loading of the layers
        self.mapView.layerViewStateChangedHandler = { (layer:AGSLayer, state:AGSLayerViewState) in
            switch state.status {
            case AGSLayerViewStatus.active:
                self.setLayer(layer: layer, trigger:"active")
                //print("Active - '", layer.name,"'")
            case AGSLayerViewStatus.notVisible:
                self.setLayer(layer: layer, trigger:"not visible")            //print("Not Visible - ", layer.name)
            case AGSLayerViewStatus.outOfScale: break//print("Out of Scale - ", layer.name)
            case AGSLayerViewStatus.loading:
                print("Loading - '", layer.name,"'")
                if !(layer.name.contains("World") || layer.name.contains("NGOs")) {
                    layer.isVisible = false
                } else {
                    layer.showInLegend = false
                }
                
                self.setLayer(layer: layer, trigger:"loading")
            case AGSLayerViewStatus.error:break//print("Error - ", layer.name)
            default:
                self.setLayer(layer: layer, trigger:"default")//print("Unknown - ", layer.name)
            }
        }
        
    }
    
    @IBAction func showLegend(_ sender: Any) {
        if let legendVC = legendVC{
            navigationController?.pushViewController(legendVC, animated: true)
        }
    }
    
    func setLayer(layer:AGSLayer, trigger:String) {
        layer.showInLegend = true
        if (layer.name.contains("Literacy") && self.literacyLayer == nil) {
            self.literacyLayer = layer
            return
        }
        if (layer.name.contains("Earthquakes") && self.earthquakesLayer == nil) {
            self.earthquakesLayer = layer
            return
        }
        if (layer.name.contains("Undernourished") && self.undernourishedLayer == nil) {
            self.undernourishedLayer = layer
            return
        }
        if (layer.name.contains("Tree") && self.deforestationLayer == nil) {
            self.deforestationLayer = layer
            return
        }
        if (layer.name.contains("Development") && self.developmentLayer == nil) {
            self.developmentLayer = layer
            return
        }
        if (layer.name.contains("CW") && self.waterLayer == nil) {
            self.waterLayer = layer
            return
        }
        if (layer.name.contains("ENV") && self.envLayer == nil) {
            self.envLayer = layer
            return
        }
        if (layer.name.contains("DR") && self.disLayer == nil) {
            self.disLayer = layer
            return
        }
        if (layer.name.contains("HE") && self.healthLayer == nil) {
            self.healthLayer = layer
            return
        }
        if (layer.name.contains("EDU") && self.educationLayer == nil) {
            self.educationLayer = layer
            return
        }
        if (layer.name.contains("HotSpot_Medical") && self.violaHealthLayer == nil) {
            self.violaHealthLayer = layer
            return
        }
        if (layer.name.contains("HotSpot_Education") && self.violaEdLayer == nil) {
            self.violaEdLayer = layer
            return
        }
        if (layer.name.contains("HotSpot_Water") && self.violaWaterLayer == nil) {
            self.violaWaterLayer = layer
            return
        }
        if (layer.name.contains("Overview") && self.zerenLayer == nil) {
            self.zerenLayer = layer
            return
        }
    }
    
//    func queryForState(_ type:String, featureTable: AGSServiceFeatureTable) {
//        //un select if any features already selected
//
//        
//        let queryParams = AGSQueryParameters()
//        queryParams.whereClause = "1=1"
//        
//        featureTable.queryFeatures(with: queryParams, queryFeatureFields: AGSQueryFeatureFields.loadAll) { (result:AGSFeatureQueryResult?, error:Error?) in
//            if let error = error {
//                print(error.localizedDescription)
//                //update selected features array
//                //self?.selectedFeatures.removeAll(keepingCapacity: false)
//            }
//            else if let features = result?.featureEnumerator().allObjects {
//                if features.count > 0 {
//                    for feature in features {
//                        //print("feature: \(feature.attributes)")
//                        //print("coordinates: \(feature.geometry)")
//                        
//                        if (type == "cw") {
//                            self.waterFeatures.append(feature)
//                        }
//                        if (type == "env") {
//                            self.envFeatures.append(feature)
//                        }
//                        if (type == "dis") {
//                            self.disFeatures.append(feature)
//                        }
//                    }
//                    //self?.featureLayer.select(features)
//                    //zoom to the selected feature
//                    //self?.mapView.setViewpointGeometry(features[0].geometry!, padding: 80, completion: nil)
//                }
//            }
//
//        }
//        
//    }
    
    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {

        let c = mapView.identifyLayers(atScreenPoint: screenPoint, tolerance: 10, returnPopupsOnly: true, maximumResultsPerLayer: 12) { [weak self] (identifyResults, error) -> Void in
            
            if error == nil {
                var popups = [AGSPopup]()
                for identifyResult in identifyResults! {
                    if (identifyResult.layerContent.name.contains("CW") ||
                        identifyResult.layerContent.name.contains("ENV") ||
                        identifyResult.layerContent.name.contains("DR") ||
                        identifyResult.layerContent.name.contains("HE") ||
                        identifyResult.layerContent.name.contains("EDU")) {
                        identifyResult.layerContent.showInLegend = true
                        popups.append(contentsOf: identifyResult.popups)
                        identifyResult.sublayerResults.forEach{popups.append(contentsOf: $0.popups)}
                    }
                }
                if (popups.count > 0) {
                    print("Julio")
                    print(popups[0].geoElement.attributes)
                    globalVars.projectData = popups[0].geoElement.attributes
                    self?.performSegue(withIdentifier: "showProject", sender: self)
                }
            }
            else if let error = error {
                print("error identifying popups \(error)")
            }
        }

    }
    
    @IBAction func literacyButton(_ sender: Any) {
        if literacy {
            literacy = false
            literacyLayer?.isVisible = false
            
            litButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            litButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
            
        } else {
            literacy = true
            literacyLayer?.isVisible = true

            litButton.backgroundColor = UIColor(red: (15/255), green: (173/255), blue: (82/255), alpha: 1.0)
            litButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    @IBAction func earthquakesButton(_ sender: Any) {
        if earthquakes {
            earthquakes = false
            earthquakesLayer?.isVisible = false
            earthButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            earthButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            earthquakes = true
            earthquakesLayer?.isVisible = true
            earthButton.backgroundColor = UIColor(red: (15/255), green: (173/255), blue: (82/255), alpha: 1.0)
            earthButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    @IBAction func developmentButton(_ sender: Any) {
        if development {
            development = false
            developmentLayer?.isVisible = false
            devButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            devButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            development = true
            developmentLayer?.isVisible = true
            devButton.backgroundColor = UIColor(red: (15/255), green: (173/255), blue: (82/255), alpha: 1.0)
            devButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    @IBAction func deforestationClicked(_ sender: Any) {
        if deforestation {
            deforestation = false
            deforestationLayer?.isVisible = false
            deforestationButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            deforestationButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            deforestation = true
            deforestationLayer?.isVisible = true
            deforestationButton.backgroundColor = UIColor(red: (15/255), green: (173/255), blue: (82/255), alpha: 1.0)
            deforestationButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }

    @IBAction func undernourishedClicked(_ sender: Any) {
        if undernourished {
            undernourished = false
            undernourishedLayer?.isVisible = false
            underButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            underButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            undernourished = true
            undernourishedLayer?.isVisible = true
            underButton.backgroundColor = UIColor(red: (15/255), green: (173/255), blue: (82/255), alpha: 1.0)
            underButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    @IBAction func waterClicked(_ sender: Any) {
        if water {
            water = false
            waterLayer?.isVisible = false
            watButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            watButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            water = true
            waterLayer?.isVisible = true
            watButton.backgroundColor = UIColor(red: (15/255), green: (173/255), blue: (82/255), alpha: 1.0)
            watButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    @IBAction func environmentalClicked(_ sender: Any) {
        if env {
            env = false
            envLayer?.isVisible = false
            envButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            envButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            env = true
            envLayer?.isVisible = true
            envButton.backgroundColor = UIColor(red: (15/255), green: (173/255), blue: (82/255), alpha: 1.0)
            envButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    @IBAction func disasterClicked(_ sender: Any) {
        if disaster {
            disaster = false
            disLayer?.isVisible = false
            disButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            disButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            disaster = true
            disLayer?.isVisible = true
            disButton.backgroundColor = UIColor(red: (15/255), green: (173/255), blue: (82/255), alpha: 1.0)
            disButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    @IBAction func educationClicked(_ sender: Any) {
        if education {
            education = false
            educationLayer?.isVisible = false
            educationButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            educationButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            education = true
            educationLayer?.isVisible = true
            educationButton.backgroundColor = UIColor(red: (15/255), green: (173/255), blue: (82/255), alpha: 1.0)
            educationButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    @IBAction func healthClicked(_ sender: Any) {
        if health {
            health = false
            healthLayer?.isVisible = false
            healthButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            healthButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            health = true
            healthLayer?.isVisible = true
            healthButton.backgroundColor = UIColor(red: (15/255), green: (173/255), blue: (82/255), alpha: 1.0)
            healthButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    @IBAction func zerenClicked(_ sender: Any) {
        if zeren {
            zeren = false
            zerenLayer?.isVisible = false
            zerenButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            zerenButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            zeren = true
            zerenLayer?.isVisible = true
            zerenButton.backgroundColor = UIColor(red: (227/255), green: (143/255), blue: (109/255), alpha: 1.0)
            zerenButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    @IBAction func violaEdClicked(_ sender: Any) {
        if violaEd {
            violaEd = false
            violaEdLayer?.isVisible = false
            violaEdButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            violaEdButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            violaEd = true
            violaEdLayer?.isVisible = true
            violaEdButton.backgroundColor = UIColor(red: (227/255), green: (143/255), blue: (109/255), alpha: 1.0)
            violaEdButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    @IBAction func violaWaterClicked(_ sender: Any) {
        if violaWater {
            violaWater = false
            violaWaterLayer?.isVisible = false
            violaWaterButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            violaWaterButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            violaWater = true
            violaWaterLayer?.isVisible = true
            violaWaterButton.backgroundColor = UIColor(red: (227/255), green: (143/255), blue: (109/255), alpha: 1.0)
            violaWaterButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    @IBAction func violaHealthClicked(_ sender: Any) {
        if violaHealth {
            violaHealth = false
            violaHealthLayer?.isVisible = false
            violaHealthButton.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
            violaHealthButton.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        } else {
            violaHealth = true
            violaHealthLayer?.isVisible = true
            violaHealthButton.backgroundColor = UIColor(red: (227/255), green: (143/255), blue: (109/255), alpha: 1.0)
            violaHealthButton.setTitleColor(UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0), for: UIControlState.normal)
        }
        legendVC = LegendViewController.makeLegendViewController(geoView: mapView)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func filterButtonClicked(_ sender: Any) {

        if filterView.isHidden {
            //self.filtersConstr.constant = -110
            filterView.isHidden = false
            self.filterView.frame = CGRect(x: 420, y: 125, width: 335, height: 497)
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, animations: {
                self.filterView.frame = CGRect(x: 94, y: 125, width: 335, height: 497)
                //self.filtersConstr.constant = -15
                self.view.layoutIfNeeded()
            })
        } else {
            //self.filtersConstr.constant = -15
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, animations: {
                self.filterView.frame = CGRect(x: 420, y: 125, width: 335, height: 497)
                //self.filtersConstr.constant = -110
                self.view.layoutIfNeeded()
            }, completion:{(finished : Bool)  in
                if (finished) {
                    self.filterView.isHidden = true
                }
            });
        }

    }
    


}

