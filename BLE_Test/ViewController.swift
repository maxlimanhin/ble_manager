//
//  ViewController.swift
//  BLE_Test
//
//  Created by DIUUMA on 11/9/2021.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    @IBOutlet weak var logTextView: UITextView!
    
    var bleManager: BLEManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bleManager = BLEManager(
            delegate: self
        )
        
        logTextView.isEditable = false
    }
    
    // MARK: Button Action
    
        // MARK: Acc module btns
    @IBAction func accOnButtonDidPress(_ sender: Any) {
        bleManager?.accelerometerModuleOnOff(command: .accelerometerModuleEnable)
    }
    @IBAction func accOffButtonDidPress(_ sender: Any) {
        bleManager?.accelerometerModuleOnOff(command: .accelerometerModuleDisable)
    }
    @IBAction func setAccelerometerRangeTo2GButtonDidPress(_ sender: Any) {
        bleManager?.setAccelerometerRange(command: .g2)
    }
    @IBAction func setAccelerometerRangeTo4GButtonDidPress(_ sender: Any) {
        bleManager?.setAccelerometerRange(command: .g4)
    }
    @IBAction func setAccelerometerRangeTo9GButtonDidPress(_ sender: Any) {
        bleManager?.setAccelerometerRange(command: .g8)
    }
    @IBAction func setAccelerometerRangeTo16GButtonDidPress(_ sender: Any) {
        bleManager?.setAccelerometerRange(command: .g16)
    }
    @IBAction func setAccelerometerOutputDataRateTo25HzButtonDidPress(_ sender: Any) {
        bleManager?.setAccelerometerOutputDataRate(command: .hz25)
    }
    @IBAction func setAccelerometerOutputDataRateTo50HzButtonDidPress(_ sender: Any) {
        bleManager?.setAccelerometerOutputDataRate(command: .hz50)
    }
    @IBAction func setAccelerometerOutputDataRateTo100HzButtonDidPress(_ sender: Any) {
        bleManager?.setAccelerometerOutputDataRate(command: .hz100)
    }
    
        // MARK: Gyro module btns
    @IBAction func gyroOnButtonDidPress(_ sender: Any) {
        bleManager?.gyroModuleOnOff(command: .gyroModuleEnable)
    }
    @IBAction func gyroOffButtonDidPress(_ sender: Any) {
        bleManager?.gyroModuleOnOff(command: .gyroModuleDisable)
    }
    @IBAction func SetGyroRangeTo125ButtonDidPress(_ sender: Any) {
        bleManager?.setGyroRange(command: .dps125)
    }
    @IBAction func SetGyroRangeTo250ButtonDidPress(_ sender: Any) {
        bleManager?.setGyroRange(command: .dps250)
    }
    @IBAction func SetGyroRangeTo500ButtonDidPress(_ sender: Any) {
        bleManager?.setGyroRange(command: .dps500)
    }
    @IBAction func SetGyroRangeTo1kButtonDidPress(_ sender: Any) {
        bleManager?.setGyroRange(command: .dps1000)
    }
    @IBAction func SetGyroRangeTo2kButtonDidPress(_ sender: Any) {
        bleManager?.setGyroRange(command: .dps2000)
    }
    @IBAction func setGyroOutputDataRateTo25HzButtonDidPress(_ sender: Any) {
        bleManager?.setGyroOutputDataRate(command: .hz25)
    }
    @IBAction func setGyroOutputDataRateTo50HzButtonDidPress(_ sender: Any) {
        bleManager?.setGyroOutputDataRate(command: .hz50)
    }
    @IBAction func setGyroOutputDataRateTo100HzButtonDidPress(_ sender: Any) {
        bleManager?.setGyroOutputDataRate(command: .hz100)
    }
    
        // MARK: Magnetometer module btns
    @IBAction func magnetometerOnButtonDidPress(_ sender: Any) {
        bleManager?.magnetometerModuleOnOff(command: .magnetometerModuleEnable)
    }
    @IBAction func magnetometerOffButtonDidPress(_ sender: Any) {
        bleManager?.magnetometerModuleOnOff(command: .magnetometerModuleDisable)
    }
    @IBAction func setMagnetometerPresetToLowPowerHzButtonDidPress(_ sender: Any) {
        bleManager?.setMagnetometerPreset(command: .low_power)
    }
    @IBAction func setMagnetometerPresetToRegular1ButtonDidPress(_ sender: Any) {
        bleManager?.setMagnetometerPreset(command: .regular1)
    }
    @IBAction func setMagnetometerPresetToRegular2ButtonDidPress(_ sender: Any) {
        bleManager?.setMagnetometerPreset(command: .regular2)
    }
    @IBAction func setMagnetometerPresetToEnhancedRegularButtonDidPress(_ sender: Any) {
        bleManager?.setMagnetometerPreset(command: .enhanced_regular)
    }
    
        // MARK: Magnetometer module btns
    @IBAction func quaternionOnButtonDidPress(_ sender: Any) {
        bleManager?.quaternionModuleOnOff(command: .quaternionModuleEnable)
    }
    @IBAction func quaternionOffButtonDidPress(_ sender: Any) {
        bleManager?.quaternionModuleOnOff(command: .quaternionModuleDisable)
    }
    
        // MARK: LinearAcceleration module btns
    @IBAction func linearAccelerationOnButtonDidPress(_ sender: Any) {
        bleManager?.linearAccelerationModuleOnOff(command: .linearAccelerationModuleEnable)
    }
    @IBAction func linearAccelerationOffButtonDidPress(_ sender: Any) {
        bleManager?.linearAccelerationModuleOnOff(command: .linearAccelerationModuleDisable)
    }
    
        // MARK: SetSensorFusionMode module btns
    @IBAction func setSensorFusionModeOnButtonDidPress(_ sender: Any) {
        bleManager?.SetSensorFusionMode(command: .setSensorFusionModeOn)
    }
    @IBAction func setSensorFusionModeOffButtonDidPress(_ sender: Any) {
        bleManager?.SetSensorFusionMode(command: .setSensorFusionModeOff)
    }
    
        // MARK: SetTXPower Module btns
    @IBAction func setTXPowerToNegative16HzButtonDidPress(_ sender: Any) {
        bleManager?.setTXPower(command: .negative16)
    }
    @IBAction func setTXPowerToNegative8ButtonDidPress(_ sender: Any) {
        bleManager?.setTXPower(command: .negative8)
    }
    @IBAction func setTXPowerToNegative4ButtonDidPress(_ sender: Any) {
        bleManager?.setTXPower(command: .negative4)
    }
    @IBAction func setTXPowerToZeroButtonDidPress(_ sender: Any) {
        bleManager?.setTXPower(command: .zero)
    }
    @IBAction func setTXPowerToPostive4ButtonDidPress(_ sender: Any) {
        bleManager?.setTXPower(command: .postive4)
    }
    
        // MARK: Streaming
    @IBAction func startStreamingButtonDidPress(_ sender: Any) {
        bleManager?.startStreaming()
    }
    @IBAction func stopStreamingButtonDidPress(_ sender: Any) {
        bleManager?.stopStreaming()
    }
    
        // MARK: Logging
    @IBAction func startLoggingButtonDidPress(_ sender: Any) {
        bleManager?.startStreaming()
    }
    @IBAction func stopLoggingButtonDidPress(_ sender: Any) {
        bleManager?.stopStreaming()
    }
    @IBAction func startDownloadingLoggingButtonDidPress(_ sender: Any) {
        bleManager?.startDownloadLoggedData()
    }
    @IBAction func stopDownloadingLoggingButtonDidPress(_ sender: Any) {
        bleManager?.stopDownloadLoggedData()
    }
    
        // MARK: OTA
    @IBAction func startUpdateFirewareButtonDidPress(_ sender: Any) {
        bleManager?.startOTA()
    }
    
        // MARK: Reset
    @IBAction func resetButtonDidPress(_ sender: Any) {
        bleManager?.resetDevice()
    }
    
    func printLog(string: String) {
        logTextView.text.append(string)
        logTextView.text.append("\n")
    }
}

extension ViewController: BLEManagerDelegate {
    // MARK: BLEManagerDelegate centralManager Func protocol

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            printLog(string: "centralManagerDidUpdateState unknown")
        case .resetting:
            printLog(string: "centralManagerDidUpdateState resetting")
        case .unsupported:
            printLog(string: "centralManagerDidUpdateState unsupported")
        case .unauthorized:
            printLog(string: "centralManagerDidUpdateState unauthorized")
        case .poweredOff:
            printLog(string: "centralManagerDidUpdateState poweredOff")
        case .poweredOn:
            printLog(string: "centralManagerDidUpdateState poweredOn")
            bleManager?.startScanning(services: [], options: nil)
        @unknown default:
            printLog(string: "centralManagerDidUpdateState Unknow error occured")
        }
    }
    
    func centralManagerDiscoverPeripheral(periphera: CBPeripheral) {
        if periphera.name == "Metajf" {
            bleManager?.connectPeripheral(peripheral: periphera, options: nil)
        }
    }
    
    func centralManagerDidConnect(connectedPeripheral: CBPeripheral) {
        printLog(string: "centralManagerDidConnect \(connectedPeripheral.name ?? "")")
        bleManager?.discoverService()
    }
    
    func centralManagerDidFailToConnect(error: BLEManagerError?) {
        printLog(string: "centralManagerDidFailToConnect")
    }
    
    func centralManagerDidDisconnectPeripheral(error: BLEManagerError?) {
        printLog(string: "DidDisconnectPeripheral")
    }
    
    // MARK: BLEManagerDelegate Peripheral Func protocol
    
    func peripheralDidDiscoverServices(service: CBService?, error: BLEManagerError?) {
    }
    
    func peripheralDidDiscoverCharacteristic(characteristic: CBCharacteristic?, error: BLEManagerError?) {
    }
    
    func txRxCharacteristicDidSet() {
        printLog(string: "didSetTxRxCharacteristic Ready for send Command")
    }
    
    func batteryCharacteristicDidSet() {
        printLog(string: "didSetBattaryCharacteristic Ready for get battary status")
    }
    
    func batteryStatusDidUpdate(batteryStatus status: [UInt8]) {
        printLog(string: "Battery level: \(status[0])")
    }
    
    func didSendCommandFail() {
        printLog(string: "didSendCommandFail")
    }
    
    func accelerometerModule(didSetEnable enable: Bool) {
        printLog(string: "Acc did set to \(enable ? "On":"Off")")
    }
    
    func accelerometer(didSetRange range: BLECommand.SetAccelerometerRange) {
        printLog(string: "accelerometer didSetRange Range: \(range)")
    }
    
    func accelerometer(didSetOutputDataRange range: BLECommand.SetAccelerometerOutputDataRate) {
        printLog(string: "accelerometer didSetOutputDataRange Range: \(range)")
    }
    
    func gyroModule(didSetEnable enable: Bool) {
        printLog(string: "Gyro did set to \(enable ? "On":"Off")")
    }
    
    func gyro(didSetRange range: BLECommand.SetGyroRange) {
        printLog(string: "gyro didSetRange Range: \(range)")
    }
    
    func gyro(didSetOutputDataRange range: BLECommand.SetGyroOutputDataRate) {
        printLog(string: "gyro didSetOutputDataRange Range: \(range)")
    }
    
    func magnetometerModule(didSetEnable enable: Bool) {
        printLog(string: "Magnetometer did set to \(enable ? "On":"Off")")
    }
    
    func magnetometer(didSetMagnetometerPreset preset: BLECommand.SetMagnetometerPreset) {
        printLog(string: "magnetometer didSetMagnetometerPreset preset: \(preset)")
    }
    
    func quaternionModule(didSetEnable enable: Bool) {
        printLog(string: "Quaternion did set to \(enable ? "On":"Off")")
    }
    
    func linearAccelerationModule(didSetEnable enable: Bool) {
        printLog(string: "LinearAcceleration did set to \(enable ? "On":"Off")")
    }
    
    func sensorFusionMode(didSetModeEnable enable: Bool) {
        printLog(string: "ensorFusionMode didSetModeEnable \(enable ? "On":"Off")")
    }
    
    func txPower(didSetTXPower power: BLECommand.SetTXPower) {
        printLog(string: "txPower didSetTXPower power: \(power)")
    }
    
    func otherValueReturn(didReturnData data: Data) {
        printLog(string: "revice data: \([UInt8](data))")
    }
}
