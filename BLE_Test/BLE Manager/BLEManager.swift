//
//  BLEManager.swift
//  BLE_Test
//
//  Created by DIUUMA on 31/10/2021.
//

import Foundation
import CoreBluetooth

protocol BLEManagerDelegate: NSObject {
    // MARK: BLEManagerDelegate centralManager Func protocol
    
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    func centralManagerDiscoverPeripheral(periphera: CBPeripheral)
    func centralManagerDidConnect(connectedPeripheral: CBPeripheral)
    func centralManagerDidFailToConnect(error: BLEManagerError?)
    func centralManagerDidDisconnectPeripheral(error: BLEManagerError?)
    
    // MARK: BLEManagerDelegate Peripheral Func protocol
    
    func peripheralDidDiscoverServices(service: CBService?, error: BLEManagerError?)
    func peripheralDidDiscoverCharacteristic(characteristic: CBCharacteristic?, error: BLEManagerError?)
    
    // MARK:BLE Module Delegage
    func txRxCharacteristicdidSet()
    func didSendCommandFail()
    
    // Accelerometer
    func accelerometerModule(didSetEnable enable: Bool)
    func accelerometer(didSetRange range: BLECommand.SetAccelerometerRange)
    func accelerometer(didSetOutputDataRange range: BLECommand.SetAccelerometerOutputDataRate)

    // Gyro
    func gyroModule(didSetEnable enable: Bool)
    func gyro(didSetRange range: BLECommand.SetGyroRange)
    func gyro(didSetOutputDataRange range: BLECommand.SetGyroOutputDataRate)

    // Magnetometer On Off
    func magnetometerModule(didSetEnable enable: Bool)
    func magnetometer(didSetMagnetometerPreset preset: BLECommand.SetMagnetometerPreset)
    // Quaternion On Off
    func quaternionModule(didSetEnable enable: Bool)
    // LinearAcceleration
    func linearAccelerationModule(didSetEnable enable: Bool)
    // SetSensorFusionMode
    func sensorFusionMode(didSetModeEnable enable: Bool)
    // SetTXPower
    func txPower(didSetTXPower power: BLECommand.SetTXPower)
    // Stream, Logging, Download Logging, OTA
    func otherValueReturn(didReturnData data: Data)
}

enum BLEService {
    case deviceInformation
    case battery
    case mainService
    case fe59
    
    func toServiceUUID() -> CBUUID {
        switch self {
        case .deviceInformation:
            return CBUUID(string: "Device Information")
        case .battery:
            return CBUUID(string: "Battery")
        case .mainService:
            return CBUUID(string: "326A9000-85CB-9195-D9DD-464CFBBAE75A")
        case .fe59:
            return CBUUID(string: "FE59")
        }
    }
}

class BLEManager: NSObject{
    // MARK: Varible
    weak var delegate: BLEManagerDelegate?
    
    var centralManager: CBCentralManager?
    var connectedCBPeripheral: CBPeripheral?
    
    var streamingMode = false
    var loggingMode = false
    var otaMode = false
    
    let txCharacteristicUUID = CBUUID(string: "326A9001-85CB-9195-D9DD-464CFBBAE75A")
    var txCharacteristic: CBCharacteristic? {
        didSet {
            if txCharacteristic != nil &&
               rxCharacteristic != nil {
                delegate?.txRxCharacteristicdidSet()
            }
        }
    }
    
    let rxCharacteristicUUID = CBUUID(string: "326A9006-85CB-9195-D9DD-464CFBBAE75A")
    var rxCharacteristic: CBCharacteristic? {
        didSet {
            if txCharacteristic != nil &&
               rxCharacteristic != nil {
                delegate?.txRxCharacteristicdidSet()
            }
        }
    }
    
    required init(delegate: BLEManagerDelegate) {
        super.init()
        self.delegate = delegate
        centralManager = CBCentralManager(delegate: self, queue: .main)
    }
}

extension BLEManager {
    // MARK: BLEManager Worker
    func sendModuleCommandToTXCharacteristic(command: [UInt8]) {
        let data = Data(command)
        if let txCharacteristic = txCharacteristic {
            setCommand(toCharacteristic: txCharacteristic, withValue: data)
        }
    }
    
    func sendModuleDataToTXCharacteristic(data: Data) {
        if let txCharacteristic = txCharacteristic {
            setCommand(toCharacteristic: txCharacteristic, withValue: data)
        }
    }
    
    private func setCommand(toCharacteristic characteristic: CBCharacteristic, withValue value: Data) {
        if let connectedCBPeripheral = connectedCBPeripheral,
            characteristic.properties.contains(.write) {
            connectedCBPeripheral.writeValue(value, for: characteristic, type: .withResponse)
        }
    }
}

extension BLEManager {
    // MARK: class function
    func startScanning(services: [CBUUID]?, options: [String : Any]?) {
        centralManager?.scanForPeripherals(withServices: services,  options: options)
    }
    
    func stopScanning() {
        centralManager?.stopScan()
    }
    
    func connectPeripheral(peripheral: CBPeripheral, options: [String : Any]?) {
        connectedCBPeripheral = peripheral
        centralManager?.connect(peripheral, options: options)
    }
    
    func disconnectPeripheral() {
        if let connectedCBPeripheral = connectedCBPeripheral {
            centralManager?.cancelPeripheralConnection(connectedCBPeripheral)
        }
    }
    
    func discoverService() {
        if let connectedCBPeripheral = connectedCBPeripheral {
            connectedCBPeripheral.discoverServices(nil)
        }
    }
    
    func discoverCharacteristics(service: CBService) {
        if let connectedCBPeripheral = connectedCBPeripheral {
            connectedCBPeripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func resetDevice() {
        sendModuleCommandToTXCharacteristic(command: BLECommand.General.reset.toCommand())
    }
    
    func accelerometerModuleOnOff(command: BLECommand.AccelerometerModule) {
        sendModuleCommandToTXCharacteristic(command: command.toCommand())
    }
    
    func setAccelerometerRange(command: BLECommand.SetAccelerometerRange) {
        sendModuleCommandToTXCharacteristic(command: command.toCommand())
    }
    
    func setAccelerometerOutputDataRate(command: BLECommand.SetAccelerometerOutputDataRate) {
        sendModuleCommandToTXCharacteristic(command: command.toCommand())
    }
    
    func gyroModuleOnOff(command: BLECommand.GyroModule) {
        sendModuleCommandToTXCharacteristic(command: command.toCommand())
    }
    
    func setGyroRange(command: BLECommand.SetGyroRange) {
        sendModuleCommandToTXCharacteristic(command: command.toCommand())
    }
    
    func setGyroOutputDataRate(command: BLECommand.SetGyroOutputDataRate) {
        sendModuleCommandToTXCharacteristic(command: command.toCommand())
    }
    
    func magnetometerModuleOnOff(command: BLECommand.MagnetometerModule) {
        sendModuleCommandToTXCharacteristic(command: command.toCommand())
    }
    
    func setMagnetometerPreset(command: BLECommand.SetMagnetometerPreset) {
        sendModuleCommandToTXCharacteristic(command: command.toCommand())
    }
    
    func quaternionModuleOnOff(command: BLECommand.QuaternionModule) {
        sendModuleCommandToTXCharacteristic(command: command.toCommand())
    }
    
    func linearAccelerationModuleOnOff(command: BLECommand.LinearAcceleration) {
        sendModuleCommandToTXCharacteristic(command: command.toCommand())
    }
    
    func SetSensorFusionMode(command: BLECommand.SetSensorFusionMode) {
        sendModuleCommandToTXCharacteristic(command: command.toCommand())
    }
    
    func setTXPower(command: BLECommand.SetTXPower) {
        sendModuleCommandToTXCharacteristic(command: command.toCommand())
    }
    
    func startStreaming() {
        sendModuleCommandToTXCharacteristic(command: BLECommand.Streaming.startStreaming.toCommand())
        streamingMode = true
    }
    
    func stopStreaming() {
        sendModuleCommandToTXCharacteristic(command: BLECommand.Streaming.stopStreaming.toCommand())
        streamingMode = false
    }
    
    func startLogging() {
        sendModuleCommandToTXCharacteristic(command: BLECommand.Logging.startLogging.toCommand())
        loggingMode = true
    }
    func stopLogging() {
        sendModuleCommandToTXCharacteristic(command: BLECommand.Logging.stopLogging.toCommand())
        loggingMode = false
    }
    func startDownloadLoggedData() {
        sendModuleCommandToTXCharacteristic(command: BLECommand.DownloadLoggedData.downloadOn.toCommand())
    }
    func stopDownloadLoggedData() {
        sendModuleCommandToTXCharacteristic(command: BLECommand.DownloadLoggedData.downloadOff.toCommand())
    }
    
    func startOTA() {
        sendModuleCommandToTXCharacteristic(command: BLECommand.Updatefirmware.updateFirmware.toCommand())
    }
    func sendOTAData(data: Data) {
        sendModuleDataToTXCharacteristic(data: data)
    }
    func stopOTA(commandData command: [UInt8]) {
        sendModuleCommandToTXCharacteristic(command: command)
    }
}

extension BLEManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        delegate?.centralManagerDidUpdateState(central)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        delegate?.centralManagerDiscoverPeripheral(periphera: peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        connectedCBPeripheral?.delegate = self
        delegate?.centralManagerDidConnect(connectedPeripheral: peripheral)
        stopScanning()
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        delegate?.centralManagerDidFailToConnect(error: .failToConnectPeripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        delegate?.centralManagerDidDisconnectPeripheral(error: .disconnectToPeripheral)
    }
}

extension BLEManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil {
            delegate?.peripheralDidDiscoverServices(
                service: nil,
                error: .discoverServicesFail
            )
        } else {
            for service in peripheral.services! {
                connectedCBPeripheral?.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if error != nil {
            delegate?.peripheralDidDiscoverCharacteristic(
                characteristic: nil,
                error: .discoverCharacteristicsFail
            )
        }
        for chararcteristice in service.characteristics! {
            if rxCharacteristic == nil && chararcteristice.uuid == rxCharacteristicUUID {
                rxCharacteristic = chararcteristice
                if let rxCharacteristic = rxCharacteristic {
                    connectedCBPeripheral?.setNotifyValue(true, for: rxCharacteristic)
                }
            } else if txCharacteristic == nil && chararcteristice.uuid == txCharacteristicUUID {
                txCharacteristic = chararcteristice
            }
            
            delegate?.peripheralDidDiscoverCharacteristic(
                characteristic: chararcteristice,
                error: nil
            )
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            delegate?.didSendCommandFail()
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            delegate?.didSendCommandFail()
            return
        }
        guard let returnData = characteristic.value else { return }
        let returnValue = [UInt8](returnData)
        if characteristic.uuid == rxCharacteristicUUID {
            // Acc
            if returnValue == BLECommand.AccelerometerModule.accelerometerModuleEnable.toCommand() {
                delegate?.accelerometerModule(didSetEnable: true)
            } else if returnValue == BLECommand.AccelerometerModule.accelerometerModuleDisable.toCommand() {
                delegate?.accelerometerModule(didSetEnable: false)
            } else if returnValue == BLECommand.SetAccelerometerRange.g2.toCommand() {
                delegate?.accelerometer(didSetRange: .g2)
            } else if returnValue == BLECommand.SetAccelerometerRange.g4.toCommand() {
                delegate?.accelerometer(didSetRange: .g4)
            } else if returnValue == BLECommand.SetAccelerometerRange.g8.toCommand() {
                delegate?.accelerometer(didSetRange: .g8)
            } else if returnValue == BLECommand.SetAccelerometerRange.g16.toCommand() {
                delegate?.accelerometer(didSetRange: .g16)
            } else if returnValue == BLECommand.SetAccelerometerOutputDataRate.hz25.toCommand() {
                delegate?.accelerometer(didSetOutputDataRange: .hz25)
            } else if returnValue == BLECommand.SetAccelerometerOutputDataRate.hz50.toCommand() {
                delegate?.accelerometer(didSetOutputDataRange: .hz50)
            } else if returnValue == BLECommand.SetAccelerometerOutputDataRate.hz100.toCommand() {
                delegate?.accelerometer(didSetOutputDataRange: .hz100)
            }
            // Gyro On Off
            else if returnValue == BLECommand.GyroModule.gyroModuleEnable.toCommand() {
                delegate?.gyroModule(didSetEnable: true)
            } else if returnValue == BLECommand.GyroModule.gyroModuleDisable.toCommand() {
                delegate?.gyroModule(didSetEnable: false)
            } else if returnValue == BLECommand.SetGyroRange.dps125.toCommand() {
                delegate?.gyro(didSetRange: .dps125)
            } else if returnValue == BLECommand.SetGyroRange.dps250.toCommand() {
                delegate?.gyro(didSetRange: .dps250)
            } else if returnValue == BLECommand.SetGyroRange.dps500.toCommand() {
                delegate?.gyro(didSetRange: .dps500)
            } else if returnValue == BLECommand.SetGyroRange.dps1000.toCommand() {
                delegate?.gyro(didSetRange: .dps1000)
            } else if returnValue == BLECommand.SetGyroRange.dps2000.toCommand() {
                delegate?.gyro(didSetRange: .dps2000)
            } else if returnValue == BLECommand.SetGyroOutputDataRate.hz25.toCommand() {
                delegate?.gyro(didSetOutputDataRange: .hz25)
            } else if returnValue == BLECommand.SetGyroOutputDataRate.hz50.toCommand() {
                delegate?.gyro(didSetOutputDataRange: .hz50)
            } else if returnValue == BLECommand.SetGyroOutputDataRate.hz100.toCommand() {
                delegate?.gyro(didSetOutputDataRange: .hz100)
            }
            // Magnetometer On Off
            else if returnValue == BLECommand.MagnetometerModule.magnetometerModuleEnable.toCommand() {
                delegate?.magnetometerModule(didSetEnable: true)
            } else if returnValue == BLECommand.MagnetometerModule.magnetometerModuleDisable.toCommand() {
                delegate?.magnetometerModule(didSetEnable: false)
            } else if returnValue == BLECommand.SetMagnetometerPreset.low_power.toCommand() {
                delegate?.magnetometer(didSetMagnetometerPreset: .low_power)
            } else if returnValue == BLECommand.SetMagnetometerPreset.regular1.toCommand() {
                delegate?.magnetometer(didSetMagnetometerPreset: .regular1)
            } else if returnValue == BLECommand.SetMagnetometerPreset.regular2.toCommand() {
                delegate?.magnetometer(didSetMagnetometerPreset: .regular2)
            } else if returnValue == BLECommand.SetMagnetometerPreset.enhanced_regular.toCommand() {
                delegate?.magnetometer(didSetMagnetometerPreset: .enhanced_regular)
            }
            // Quaternion On Off
            else if returnValue == BLECommand.QuaternionModule.quaternionModuleEnable.toCommand() {
                delegate?.quaternionModule(didSetEnable: true)
            } else if returnValue == BLECommand.QuaternionModule.quaternionModuleDisable.toCommand() {
                delegate?.quaternionModule(didSetEnable: false)
            }
            // LinearAcceleration
            else if returnValue == BLECommand.LinearAcceleration.linearAccelerationModuleEnable.toCommand() {
                delegate?.linearAccelerationModule(didSetEnable: true)
            } else if returnValue == BLECommand.LinearAcceleration.linearAccelerationModuleDisable.toCommand() {
                delegate?.linearAccelerationModule(didSetEnable: false)
            }
            // SetSensorFusionMode
            else if returnValue == BLECommand.SetSensorFusionMode.setSensorFusionModeOn.toCommand() {
                delegate?.sensorFusionMode(didSetModeEnable: true)
            } else if returnValue == BLECommand.SetSensorFusionMode.setSensorFusionModeOn.toCommand() {
                delegate?.sensorFusionMode(didSetModeEnable: false)
            }
            // SetTXPower
            else if returnValue == BLECommand.SetTXPower.negative16.toCommand() {
                delegate?.txPower(didSetTXPower: .negative16)
            } else if returnValue == BLECommand.SetTXPower.negative8.toCommand() {
                delegate?.txPower(didSetTXPower: .negative8)
            } else if returnValue == BLECommand.SetTXPower.negative4.toCommand() {
                delegate?.txPower(didSetTXPower: .negative4)
            } else if returnValue == BLECommand.SetTXPower.zero.toCommand() {
                delegate?.txPower(didSetTXPower: .zero)
            } else if returnValue == BLECommand.SetTXPower.postive4.toCommand() {
                delegate?.txPower(didSetTXPower: .postive4)
            }
            // Stream, Logging, Download Logging, OTA
            else {
                delegate?.otherValueReturn(didReturnData: returnData)
            }
        }
    }
}
