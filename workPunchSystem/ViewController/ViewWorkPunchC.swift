//
//  ViewController.swift
//  punchSystem
//
//  Created by 李晉杰 on 2022/4/13.
//

import UIKit
import MapKit
import CoreLocation
import SafariServices
import Contacts
import MapViewPlus
class ViewWorkPunchC: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate, UIActionSheetDelegate{
    @IBOutlet weak var mapView: MapViewPlus!  //地圖
    weak var currentCalloutView: UIView?
    @IBOutlet weak var address: UILabel!    //顯示目前地址
    @IBOutlet weak var speed: UILabel!     //顯示目前速度元件
    @IBOutlet weak var latitude: UILabel!  //顯示目前位置元件
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var punch: UIButton! //打卡鈕（不符合使用邏輯拿掉了）
    var locationManager = CLLocationManager() //目前位置用
    let UUID:String = "0ed779af-6757-481f-8656-fbeee87dd440" //作為打給ＡＰＩ唯一識別碼
    let ann = MKPointAnnotation() //大頭針
    var stationPointLat:[Double] = [0]//裝所有能源櫃座標用
    var stationPointLng:[Double] = [0]
    var myPointLat:Double = 0 //目前位置
    var myPointLng:Double = 0
    var punchPointLat:Double = 0 //想要打卡的能源櫃位置
    var punchPointLng:Double = 0
    var punchAuth = false //是否可以打卡（設定２０Ｍ已內）
    var Distance:String = "" //目前位置與打卡點位置的距離
    var cabinetState:String = "NG"
    
    private var userTrackingButton: MKUserTrackingButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.layer.cornerRadius = 10
//        view2.layer.masksToBounds = true
//        view2.layer.cornerRadius = 10
        mapView.showsUserLocation = true

//        self.view.bringSubviewToFront(addrLabel)
        userTrackingButton = MKUserTrackingButton(frame: CGRect(x: 10, y: 12, width: 40, height: 40))
        mapView.addSubview(userTrackingButton)
        userTrackingButton.mapView = mapView
//        self.view.insertSubview(userTrackingButton, aboveSubview: view2 )
        
        mapView.showsUserLocation=true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  //設定為最佳精度
        locationManager.requestWhenInUseAuthorization()  //user授權
        locationManager.startUpdatingLocation()  //開始update user位置
        mapView.delegate = self  //委派給ViewController
        mapView.showsUserLocation = true   //顯示user位置
        mapView.userTrackingMode = .follow
        stationPosition()
        punch.isEnabled = false
    }
    func stationPosition() {
        var lat:[Double] = [0]
        var lng:[Double] = [0]
        var station = [""]
        var add = [""]
        let API = WorkStationAPI<StationClass>()
        API.getApi() { [weak self] apiResult in
//            print(apiResult)
            for i in 0...apiResult.count-1 {
                lat.append(apiResult[i].lat)
                lng.append(apiResult[i].lng)
                station.append(apiResult[i].spDesc)
                add.append(apiResult[i].street)
               
            }
            DispatchQueue.main.async {
                self?.annCreate(lat:lat,lng:lng,station:station,add:add)
                       }
        }
    } //Call FmStation (for 能源站位置)
    
    func annCreate(lat:[Double],lng:[Double],station:[String],add:[String]) {
        for i in 0...lat.count-1{
            let mkAnn = MKPointAnnotation()
            mkAnn.coordinate = CLLocationCoordinate2D(latitude: lat[i], longitude: lng[i])
            mkAnn.title = station[i]
            mkAnn.subtitle = cabinetState//之後要請良吉傳NG（未打卡） OR OK（打過卡的） 的資料過來
            mapView.addAnnotation(mkAnn)
            
//            var annotations: [AnnotationPlus] = []
//                    annotations.append(AnnotationPlus.init(viewModel: BasicCalloutViewModel.init(title: station[i]), coordinate: CLLocationCoordinate2DMake(lat[i], lng[i])))
//                    mapView.setup(withAnnotations: annotations)
////                    mapView.anchorViewCustomizerDelegate = self
            
            
        }
//            mapView.setCenter(CLLocationCoordinate2D(latitude: lat[186], longitude: lng[186]), animated: false )
    } //將FmStation回傳過來的資料顯示在畫面地圖上
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let userLocation: CLLocation = locations[0] //最新的位置在[0]
        myPointLat = userLocation.coordinate.latitude
        myPointLng = userLocation.coordinate.longitude
        latitude.text = String(format: "%.2f",userLocation.coordinate.latitude)
        longitude.text = String(format: "%.2f",userLocation.coordinate.longitude)
        
        
       
//        WorkTrackLogAPI().postLog(uid:UUID,lat:String(userLocation.coordinate.latitude),lng:String(userLocation.coordinate.longitude)) //暫時關掉不然很吃效能
//        self.speed.text = String(userLocation.speed)
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemark, error) in
            if error != nil {
                print(error)
            }
            else {
                if let placemark = placemark?[0] {
                    var address = ""
                    if placemark.subThoroughfare != nil {
                        address += placemark.subThoroughfare! + " "
                    }
                    if placemark.thoroughfare != nil {
                        address += placemark.thoroughfare! + "\n"
                    }
                    if placemark.subLocality != nil {
                        address += placemark.subLocality! + "\n"
                    }
                    if placemark.subAdministrativeArea != nil {
                        address += placemark.subAdministrativeArea! + "\n"
                    }
                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + "\n"
                    }
                    if placemark.country != nil {
                        address += placemark.country!
                    }
                    self.address.text = String(address)

                }
            }
        }
    }  //取得目前位置方法，並打資料給FmTrackLog(寫好了，目前沒啟用,之後要開)

    func btnState(punchPoint:(lat:Double,lng:Double)) {
        let lat1 = punchPoint.lat
        let lng1 = punchPoint.lng
        let lat2 = myPointLat
        let lng2 = myPointLng
//        for i in 0...stationPointLat.count-1{
//            let lat2 = stationPointLat[i]
//            let lng2 = stationPointLng[i]
//            getDistance(lat1:lat1,lng1:lng1,lat2:lat2,lng2:lng2)
//        }
//
        getDistance(lat1:lat1,lng1:lng1,lat2:lat2,lng2:lng2)
       

    } //取得目前位置與打卡點位置並傳給getDistance
    
    func radian(d:Double) -> Double {
        return d * Double.pi/180.0
    }
    
    func angle(r:Double) -> Double {
        return r * 180/Double.pi
    }
    
    func getDistance(lat1:Double,lng1:Double,lat2:Double,lng2:Double) -> Double {
        
        let EARTH_RADIUS:Double = 6378137.0
        let radLat1:Double = self.radian(d: lat1)
        let radLat2:Double = self.radian(d: lat2)
        let radLng1:Double = self.radian(d: lng1)
        let radLng2:Double = self.radian(d: lng2)
        let a:Double = radLat1 - radLat2
        let b:Double = radLng1 - radLng2
            
        var s:Double = 2 * asin(sqrt(pow(sin(a/2), 2) + cos(radLat1) * cos(radLat2) * pow(sin(b/2), 2)))
        s = s * EARTH_RADIUS
        
        Distance = String(format: "%.2f", s)
        print("punchPoint:\(lat1),\(lng1)")
        print("myPointLng:\(lat2),\(lng2)")
        print("兩點距離：\(s)")
        if (s <= 30)
        {
            punchAuth = true
        }
            return s
    } //做判斷是否符合５０公尺內，並記錄兩點距離
    
    @IBAction func myLocacaion(_ sender: Any) {
        let location = mapView.userLocation
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
        mapView.setRegion(region, animated: true)
    } //我的位置（按鈕）
    
    @IBAction func punch(_ sender: Any) {//暫時不用
//        let punchPointlng:Double = (self.longitude.text?.toDouble())!
//        let punchPointlat:Double = (self.latitude.text?.toDouble())!
//        ann.coordinate = CLLocationCoordinate2D(latitude: punchPointlat, longitude: punchPointlng)
//        ann.title = "已打卡"
//        mapView.addAnnotation(ann)
//        mapView?.setCenter(ann.coordinate, animated: false)
//       // btnState( punchPoint:(lat:punchPointlat,lng:punchPointlng))
//        //FmCheckInPoint().postLog(uid:UUID,lat:self.latitude.text ?? "" ,lng:self.longitude.text ?? "")
        stationPosition()
    }//暫時拿來當作刷新站點
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation)
            else {
                return nil
            }
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
        if annView == nil {
            annView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        }
        if(annotation.subtitle) == "NG" {
//            let rect = CGRect(origin: .zero, size: CGSize(width: 300, height: 200))
//            let CalloutView = UIView(frame:rect)
            let btn = UIButton(
                frame: CGRect(x: 0, y: 0, width: 100, height: 30))
            btn.alpha = btn.isHighlighted ? 0.5 :1
            btn.setTitleColor(UIColor.systemGray, for: .highlighted)
            btn.layer.cornerRadius = 10
            btn.setTitle("打卡", for: .normal)
            btn.backgroundColor = UIColor.systemGreen
            btn.tag = 100
            btn.addTarget(self, action: #selector(punchBypoint), for: .touchUpInside)
//            CalloutView.addSubview(btn)
          
            let label = UILabel()
            label.numberOfLines = 4
            punchPointLat = annotation.coordinate.latitude
            punchPointLng = annotation.coordinate.longitude
            label.text = "緯度：\(annotation.coordinate.latitude)\n經度：\(annotation.coordinate.longitude)\n狀態：NG"
//            CalloutView.addSubview(label)
            
            let btn2 = UIButton(
            frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            btn2.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
            btn2.addTarget(self, action: #selector(navigation), for: .touchUpInside)
            
            annView?.detailCalloutAccessoryView = label
            annView?.rightCalloutAccessoryView = btn
            annView?.leftCalloutAccessoryView = btn2

//            annView?.canShowCallout = true
//            var config = UIButton.Configuration.plain()
//            annView?.addSubview(btn)
//            let btn2 = UIButton(
//            frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//            btn2.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
//            btn2.addTarget(self, action: #selector(navigation), for: .touchUpInside)
//            annView?.leftCalloutAccessoryView = btn2
//
            
          
            
            
            
            
            
            
            
            
        }
        
        if(annotation.subtitle) == "OK" {
            let label = UILabel()
            label.numberOfLines = 3
            punchPointLat = annotation.coordinate.latitude
            punchPointLng = annotation.coordinate.longitude
            label.text = "緯度：\(annotation.coordinate.latitude)\n經度：\(annotation.coordinate.longitude)\n狀態：OK"
            annView?.detailCalloutAccessoryView = label
            let btn = UIButton(
                frame: CGRect(x: 0, y: 0, width: 100, height: 30))
            btn.setTitle("打卡", for: .normal)
            btn.backgroundColor = UIColor.systemRed
            btn.tag = 100
            btn.addTarget(self, action: #selector(punchBypoint), for: .touchUpInside)
            btn.isEnabled = false
            btn.alpha = 0.5;
            btn.layer.cornerRadius = 10
            annView?.rightCalloutAccessoryView = btn
            
            let btn2 = UIButton(
            frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            btn2.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
            btn2.addTarget(self, action: #selector(navigation), for: .touchUpInside)
            annView?.leftCalloutAccessoryView = btn2
            annView?.pinTintColor = UIColor.green
        }
       
        annView?.canShowCallout = true
        return annView
    }//大頭針與大頭針資訊畫面顯示
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        punchPointLat = (view.annotation?.coordinate.latitude)!
        punchPointLng = (view.annotation?.coordinate.longitude)!
    }//大頭針座標位置取得

    @objc func downloadSheet(sender: AnyObject) {

    let actionSheetController = UIAlertController(title: "Please select", message: "How you would like to utilize the app?", preferredStyle:.actionSheet)

    // Create and add the Cancel action
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        // Just dismiss the action sheet
    }
    actionSheetController.addAction(cancelAction)

    // Create and add first option action
    let takePictureAction = UIAlertAction(title: "Consumer", style: .default) { action -> Void in
        self.performSegue(withIdentifier: "segue_setup_customer", sender: self)
    }
    actionSheetController.addAction(takePictureAction)

    // Create and add a second option action
    let choosePictureAction = UIAlertAction(title: "Service provider", style: .default) { action -> Void in
        self.performSegue(withIdentifier: "segue_setup_provider", sender: self)
    }
    actionSheetController.addAction(choosePictureAction)

    // We need to provide a popover sourceView when using it on iPad
    actionSheetController.popoverPresentationController?.sourceView = sender as! UIView

    // Present the AlertController
    self.present(actionSheetController, animated: true, completion: nil)
}//彈跳視窗暫時沒用到
    
    @objc func navigation(_ sender: Any) {
        let start = CLLocationCoordinate2D(latitude:myPointLat , longitude: myPointLng)
        let end = CLLocationCoordinate2D(latitude: punchPointLat, longitude: punchPointLng)
        let pA = MKPlacemark(coordinate: start, addressDictionary: nil)
        let pB = MKPlacemark(coordinate: end, addressDictionary: nil)
        let miA = MKMapItem(placemark: pA)
        let miB = MKMapItem(placemark: pB)
        miA.name = "您的地點"
        miB.name = "能源站"
        let routes = [miA,miB]
        let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMaps(with: routes, launchOptions: options)
    } //目前位置與想前往之打卡點導航
    
    @objc func punchBypoint(_ sender: Any) {
        btnState( punchPoint:(lat:punchPointLat,lng:punchPointLng))
        if(punchAuth != false) {
            UIApplication.shared.keyWindow?.showToast(text:"兩點距離：\(Distance)公尺（進行打卡中．．．）")
            var state = WorkCheckInPointAPI<StateClass>()
            state.postLog(uid:UUID,lat:self.latitude.text ?? "" ,lng:self.longitude.text ?? "") { [weak self] stateResult in
            DispatchQueue.main.async {
                if (stateResult.status == "OK"){
                    UIApplication.shared.keyWindow?.showToast(text:"打卡成功")
                }
            }
            }
        }
        else {
            UIApplication.shared.keyWindow?.showToast(text:"兩點距離：\(Distance)公尺（距離超過30公尺）")
            print("%.2f",Distance)
        }
    
    } //點擊大頭針打卡
    
    
    
    
    @IBAction func endApp(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        UIApplication.shared.perform(#selector(NSURLConnection.suspended))
    } //關閉應用程式（暫無用）

}

extension String {
func toDouble() -> Double? {
    return NumberFormatter().number(from: self)?.doubleValue
 }
}

extension ViewWorkPunchC: MapViewPlusDelegate {
    func mapView(_ mapView: MapViewPlus, imageFor annotation: AnnotationPlus) -> UIImage {
        return UIImage(named: "basic_annotation_image.png")!
    }
    
    func mapView(_ mapView: MapViewPlus, calloutViewFor annotationView: AnnotationViewPlus) -> CalloutViewPlus{
        let calloutView = Bundle.main.loadNibNamed("BasicCalloutView", owner: nil, options: nil)!.first as! BasicCalloutView
        calloutView.delegate = self
        currentCalloutView = calloutView
        return calloutView
    }
    
    func mapView(_ mapView: MapViewPlus, didAddAnnotations annotations: [AnnotationPlus]) {
        mapView.showAnnotations(annotations, animated: true)
    }
}

extension ViewWorkPunchC: AnchorViewCustomizerDelegate {
    func mapView(_ mapView: MapViewPlus, fillColorForAnchorOf calloutView: CalloutViewPlus) -> UIColor {
        return currentCalloutView?.backgroundColor ?? mapView.defaultFillColorForAnchors
    }
}

extension ViewWorkPunchC: BasicCalloutViewModelDelegate {
    func detailButtonTapped(withTitle title: String) {
        let alert = UIAlertController.init(title: "\(title) tapped", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
