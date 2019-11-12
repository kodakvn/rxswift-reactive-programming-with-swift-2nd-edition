//
//  CLLocationManager+Rx.swift
//  Wundercast
//
//  Created by KODAK on 11/11/19.
//  Copyright © 2019 Razeware LLC. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

extension CLLocationManager: HasDelegate {
    public typealias Delegate = CLLocationManagerDelegate
    
    
}

class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {
    public weak private(set) var locationManager: CLLocationManager?
    
    public init(locationManager: ParentObject) {
        self.locationManager = locationManager
        super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register { RxCLLocationManagerDelegateProxy(locationManager: $0) }
    }
    
    
}

extension Reactive where Base: CLLocationManager {
    public var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
    }
    
    var didUpdateLocations: Observable<[CLLocation]> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
            .map { parameters in parameters[1] as! [CLLocation] }
    }
}
