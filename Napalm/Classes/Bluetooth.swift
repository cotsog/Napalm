//
//  Bluetooth.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//

import Foundation
import BluetoothKit

/**
 Allows interacting with other devices via LEB.
*/
public class NPFBluetooth: BKAvailabilityObserver, BKCentralDelegate, BKPeripheralDelegate {
    
    /**
     A BKPeripheral for setting up the devices peripheral.
    */
    public let peripheral = BKPeripheral()
    
    /**
     A BKCentral for use in setting up the devices central.
    */
    public let central = BKCentral()
    
    /**
     A string with a Unique Device ID (UUID) for creating the peripheral and central.
    */
    let service: String
    
    /**
     A string with a Unique Device ID (UUID) for creating the peripheral and central.
    */
    let characteristic: String
    
    /**
     An array containing all of the remote peripherals that are detected.
    */
    public var remotePeripherals: [BKRemotePeripheral] = []
    
    /**
     An array containing all of the discoveries that are detected.
     */
    public var discoveries: [BKDiscovery] = []
    
    /**
     The current state of scanning for remote peripherals.
    */
    public var scanState: BKCentral.ContinuousScanState = .stopped
    
    /**
     Initilizes an instance of NPFBluetooth with a serviceUUID and a characteristicUUID.
     
     - parameter serviceUUID: A String with a UUID for the service.
     - parameter characteristicUUID: A String with a UUID for the characteristic.
     
     - return: An instance of NPFBluetooth with a serviceUUID and a characteristicUUID.
    */
    public init(serviceUUID: String, characteristicUUID: String) {
        service = serviceUUID
        characteristic = characteristicUUID
    }
    
    public func availabilityObserver(_ availabilityObservable: BKAvailabilityObservable, availabilityDidChange availability: BKAvailability) {}
    public func availabilityObserver(_ availabilityObservable: BKAvailabilityObservable, unavailabilityCauseDidChange unavailabilityCause: BKUnavailabilityCause) {}
    public func central(_ central: BKCentral, remotePeripheralDidDisconnect remotePeripheral: BKRemotePeripheral) {}
    public func peripheral(_ peripheral: BKPeripheral, remoteCentralDidConnect remoteCentral: BKRemoteCentral) {}
    public func peripheral(_ peripheral: BKPeripheral, remoteCentralDidDisconnect remoteCentral: BKRemoteCentral) {}
    
    /**
     Errors that are thrown if an error occures when creating a central or peripheral.
    */
    enum InitilizationError: ErrorProtocol {
        case peripheralCreationError
        case centralCreationError
    }
    
    /**
     Creates a peripheral so other divices can connect to the current device.
     
     - parameter name: The name of the peripheral.
     
     - throws: `InitilizationError.peripheralCreationError` if an error occured while creating the peripheral.
    */
    public func createPeripheral(withName name: String)throws {
        peripheral.delegate = self
        do {
            let serviceUUID = UUID(uuidString: service)!
            let characteristicUUID = UUID(uuidString: characteristic)!
            let localName = name
            let configuration = BKPeripheralConfiguration(dataServiceUUID: serviceUUID, dataServiceCharacteristicUUID: characteristicUUID, localName: localName)
            try peripheral.startWithConfiguration(configuration)
            // You are now ready for incoming connections
        } catch let error {
            throw InitilizationError.peripheralCreationError
        }
    }
    
    /**
     Creates a central so the device can get data from other devices.
     
     - throws: `InitilizationError.centralCreationError` if an error occured while creating the central.
    */
    public func createCentral()throws {
        central.delegate = self
        central.addAvailabilityObserver(self)
        do {
            let serviceUUID = UUID(uuidString: service)!
            let characteristicUUID = UUID(uuidString: characteristic)!
            let configuration = BKConfiguration(dataServiceUUID: serviceUUID, dataServiceCharacteristicUUID: characteristicUUID)
            try central.startWithConfiguration(configuration)
            // Once the availability observer has been positively notified, you're ready to discover and connect to peripherals.
        } catch let error {
            throw InitilizationError.centralCreationError
        }
    }
    
    /**
     Scans for remote peripherals.
     
     - parameter time: The amount of time in second the central will scan for.
    */
    public func scanForPeripherals(forTimePeriod time: TimeInterval) {
        central.scanWithDuration(time, progressHandler: { newDiscoveries in
                for discovery in newDiscoveries {
                    self.remotePeripherals.append(discovery.remotePeripheral)
                }
            }, completionHandler: { result, error in
                // Handle error.
                // If no error, handle result, [BKDiscovery].
        })
    }
    
    /**
     Scans for remote peripherals continuously with breaks.
     
     - parameter scanInterval: The amount of time in second the central will scan for.
     - parameter breakInterval: The amount of time that goes by after scanning before the central scans again.
    */
    public func scanContinuouslyForPeripherals(withInterval scanInterval: TimeInterval, andBreakTime breakInterval: TimeInterval) {
        central.scanContinuouslyWithChangeHandler({ changes, discoveries in
                for discovery in discoveries {
                    self.remotePeripherals.append(discovery.remotePeripheral)
                }
            }, stateHandler: { newState in
                self.scanState = newState
            }, duration: scanInterval, inBetweenDelay: breakInterval, errorHandler: { error in
                // Handle error.
        })
    }
    
    /**
     Connects the central to the remote peripherals in the remotePeripherals array.
    */
    public func connectToRemotePeripherals() {
        for periph in remotePeripherals {
            central.connect(remotePeripheral: periph) { remotePeripheral, error in }
        }
    }
    
    /**
     Sends data to all the remote centrals that are connected.
     
     - parameter data: A string of the data that will be sent to all remote centrals.
    */
    public func sendDataToRemoteCentrals(data: String) {

        let data = "Hello beloved central!".data(using: String.Encoding.utf8)
        let remoteCentrals = peripheral.connectedRemoteCentrals
        for remoteCentral in remoteCentrals {
            if let data = data {
                peripheral.sendData(data, toRemotePeer: remoteCentral) { data, remoteCentral, error in }
            }
        }
    }
}



