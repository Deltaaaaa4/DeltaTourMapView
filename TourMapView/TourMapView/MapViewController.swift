//
//  MapViewController.swift
//  TourMapView
//
//  Created by Yerlan Tleubayev on 02.07.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    var long: Double = 0.0
    var latti: Double = 0.0
    var titleBig = ""
    let locationManager = CLLocationManager ()
    var userLocation = CLLocation ()
    
    let destinationAnnotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        print(latti)
        print(long)
        let sourceLocation = CLLocationCoordinate2D(latitude: 35.0116, longitude: 135.7681)
        let destinationLocation = CLLocationCoordinate2D(latitude: latti, longitude: long)
        
        // 3.
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5.
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Current location"
        
        if let location = sourcePlacemark.location {
          sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = titleBig
        
        if let location = destinationPlacemark.location {
          destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        // 7.
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile

        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        distanceLabel.text = String(format: "Distance: %.2f m", directions)
        // 8.
        directions.calculate {
          (response, error) -> Void in

          guard let response = response else {
            if let error = error {
              print("Error: \(error)")
            }

            return
          }

          let route = response.routes[0]
          self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)

          let rect = route.polyline.boundingMapRect
          self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        // Do any additional setup after loading the view.
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // Настраиваем линию
        let renderer = MKPolylineRenderer(overlay: overlay)
        // Цвет красный
        renderer.strokeColor = UIColor.red
        // Ширина линии
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    
    @IBAction func showMe(_ sender: Any) {
        let latDelta:CLLocationDegrees = 0.01
        let longDelta:CLLocationDegrees = 0.01

        let span = MKCoordinateSpan (latitudeDelta: latDelta, longitudeDelta: longDelta)

        let region = MKCoordinateRegion (center: userLocation.coordinate, span: span)

        mapView.setRegion(region, animated: true)
//        self.mapView.showAnnotations([destinationAnnotation], animated: true )
    
        
    }
    
    
}



//        let destinationLocation = CLLocationCoordinate2D(latitude: latti, longitude: long)
//
//        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
//
//        if let location = destinationPlacemark.location {
//            destinationAnnotation.coordinate = location.coordinate
//        }
//
//        self.mapView.showAnnotations([destinationAnnotation], animated: true )
//    }
//
//    @IBAction func showMe(_ sender: Any) {
//        self.mapView.showAnnotations([destinationAnnotation], animated: true )
//    }


//

/*
 
 
 //      Запрашиваем разрешение на использование местоположения пользователя
 locationManager.requestWhenInUseAuthorization()
 
 //        delegate нужен для функции didUpdateLocations, которая вызывается при обновлении
 //        местоположения (для этого прописали CLLocationManagerDelegate выше)
 locationManager.delegate = self
 
 // Запускаем слежку за пользователем
 locationManager.startUpdatingLocation()
 
 
 
 // Настраиваем отслеживания жестов - когда двигается карта вызывается didDragMap
 let mapDragRecognizer = UIPanGestureRecognizer(target:self, action: #selector (self.didDragMap))
 //        UIGestureRecognizerDelegate - чтоб мы могли слушать нажатия пользователя по экрану и
 //        отслеживать конкретные жесты
 mapDragRecognizer.delegate = self
 //        / Добавляем наши настройки жестов на карту
 mapView.addGestureRecognizer(mapDragRecognizer)
 
 //      ---------------------  Метка на карте---------------------
 // Новые координаты для метки на карте
 let lat:CLLocationDegrees = latti//36.2048//43.2374454
 let long:CLLocationDegrees = long//138.2529//76.909891
 
 print(lat)
 print(long)
 // Создаем координта передавая долготу и широту
 //        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
 //        // Создаем метку на карте
 //        let anotation = MKPointAnnotation ()
 //        // Задаем коортинаты метке
 //        anotation.coordinate = location
 //        // Задаем название метке
 //        anotation.title = "Title"
 //        // Задаем описание метке
 //        anotation.subtitle = "subtitle"
 //
 //        // Добавляем метку на карту
 //        mapView.addAnnotation(anotation)
 //
 
 
 // Настраиваем долгое нажатие - добавляем новые метки на карту
 //        let longPress = UILongPressGestureRecognizer(target: self, action:
 #selector (self.longPressAction))
 // минимально 2 секунды
 //        longPress.minimumPressDuration = 2
 //        mapView.addGestureRecognizer(longPress)
 
 // MKMapViewDelegate - чтоб отслеживать нажатие на метки на карте (метод didSelect)
 mapView.delegate = self
 
 
 
 
 }
 //        / Вызывается каждый раз пои изменении местоположения нашего пользователя
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
 userLocation = locations [0]
 print (userLocation)
 
 if followMe{
 // Дельта - насколько отдалиться от координат пользователя по долготе и широте
 let latDelta:CLLocationDegrees = 0.01
 let longDelta:CLLocationDegrees = 0.01
 // Создаем область шириной и высотой по дельте
 let span = MKCoordinateSpan (latitudeDelta: latDelta, longitudeDelta: longDelta)
 //        Создаем регион на карте с моими координатоми в центре
 let region = MKCoordinateRegion (center: userLocation.coordinate, span: span)
 //         Приближаем карту с анимацией в данный регион
 mapView.setRegion(region, animated: true)
 
 }
 }
 
 @IBAction func showMe(_ sender: Any) {
 followMe = true
 let latDelta:CLLocationDegrees = 0.01
 let longDelta:CLLocationDegrees = 0.01
 
 let span = MKCoordinateSpan (latitudeDelta: latDelta, longitudeDelta: longDelta)
 
 let region = MKCoordinateRegion (center: userLocation.coordinate, span: span)
 
 mapView.setRegion(region, animated: true)
 
 }
 // Вызывается когда двигаем карту
 @objc func didDragMap (gestureRecognizer: UIGestureRecognizer) {
 // Как только начали двигать карту
 if (gestureRecognizer.state == UIGestureRecognizer.State.began) {
 // Говорим не следовать за пользователем
 followMe = false
 print ("Map drag began" )
 }
 //     Когда закончили двигать карту
 if (gestureRecognizer.state == UIGestureRecognizer.State.ended) {
 print ("Map drag ended" )
 
 }
 }
 
 
 // Долгое нажатие на карту - добавляем новые метки
 @objc func longPressAction(gestureRecognizer: UIGestureRecognizer) {
 print ("gestureRecognizer")
 // Получаем точку нажатия на экране
 let touchPoint = gestureRecognizer.location(in: mapView)
 // Конвертируем точку нажатия на экране в координаты пользователя
 let newCoor: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
 // Создаем метку на карте
 let anotation = MKPointAnnotation ()
 anotation.coordinate = newCoor
 anotation.title = "Title"
 anotation.subtitle = "subtitle"
 mapView.addAnnotation(anotation)
 }
 // MARK: - MapView delegate
 // Вызывается когда нажали на метку на карте
 func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
 print (view.annotation?.title)
 
 // Получаем координаты метки
 
 let location:CLLocation = CLLocation(latitude: (view.annotation?.coordinate.latitude)!,
 longitude: (view.annotation?.coordinate.longitude)!)
 
 // Считаем растояние до метки от нашего пользователя
 let meters: CLLocationDistance = location.distance(from: userLocation)
 distanceLabel.text = String(format: "Distance: %.2f m", meters)
 
 // Routing - построение маршрута
 // 1 Координаты начальной точки А и точки В
 let sourceLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
 longitude: userLocation.coordinate.longitude)
 let destinationLocation = CLLocationCoordinate2D(latitude:
 (view.annotation?.coordinate.latitude)!, longitude:
 (view.annotation?.coordinate.longitude)!)
 //        / 2 упаковка в Placemark
 let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
 let destinationPlacemark = MKPlacemark(coordinate: destinationLocation,
 addressDictionary: nil)
 // 3 упаковка в MapItem
 let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
 let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
 
 // 4 Запрос на построение маршрута
 let directionRequest = MKDirections.Request ()
 //        указываем точку А, то есть нашего пользователя
 directionRequest.source = sourceMapItem
 //         указываем точку В, то есть метку на карте
 directionRequest.destination = destinationMapItem
 //         выбираем на чем будем ехать - на машине
 directionRequest.transportType = .automobile
 //         Calculate the direction
 let directions = MKDirections (request: directionRequest)
 // 5 Запускаем просчет маршрута
 directions.calculate {
 (response, error) -> Void in
 //         Если будет ошибка с маршрутом
 guard let response = response else {
 if let error = error {
 print ("Error: \(error)")
 }
 return
 }
 //         Берем первый машрут
 let route = response.routes[0]
 //        / Рисуем на карте линию маршрута (polyline)
 self.mapView.addOverlay( (route.polyline), level: MKOverlayLevel.aboveRoads)
 
 // Приближаем карту с анимацией в регион всего маршрута
 let rect = route.polyline.boundingMapRect
 self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
 
 }
 
 }
 
 func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
 // Настраиваем линию
 let renderer = MKPolylineRenderer(overlay: overlay)
 // Цвет красный
 renderer.strokeColor = UIColor.red
 // Ширина линии
 renderer.lineWidth = 4.0
 
 return renderer
 }
 }
 

 */

