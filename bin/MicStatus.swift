import Foundation
import CoreAudio

func isInputDeviceInUse(_ deviceID: AudioDeviceID) -> Bool {
    var inUse: UInt32 = 0
    var propertySize = UInt32(MemoryLayout<UInt32>.size)

    var address = AudioObjectPropertyAddress(
        mSelector: kAudioDevicePropertyDeviceIsRunningSomewhere,
        mScope: kAudioObjectPropertyScopeInput,
        mElement: kAudioObjectPropertyElementMaster
    )

    let status = AudioObjectGetPropertyData(deviceID, &address, 0, nil, &propertySize, &inUse)
    return status == noErr && inUse != 0
}

func getAllAudioDevices() -> [AudioDeviceID] {
    var deviceCount: UInt32 = 0
    var propertySize = UInt32(0)

    var address = AudioObjectPropertyAddress(
        mSelector: kAudioHardwarePropertyDevices,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMaster
    )

    if AudioObjectGetPropertyDataSize(AudioObjectID(kAudioObjectSystemObject), &address, 0, nil, &propertySize) != noErr {
        return []
    }

    deviceCount = propertySize / UInt32(MemoryLayout<AudioDeviceID>.size)
    var deviceIDs = [AudioDeviceID](repeating: 0, count: Int(deviceCount))

    if AudioObjectGetPropertyData(AudioObjectID(kAudioObjectSystemObject), &address, 0, nil, &propertySize, &deviceIDs) != noErr {
        return []
    }

    return deviceIDs
}

// Check all input devices to see if any is in use
let devices = getAllAudioDevices()
let micInUse = devices.contains { isInputDeviceInUse($0) }

print(micInUse ? "true" : "false")
