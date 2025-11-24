import Foundation

class RatoNetSettingsWebBrowser: Codable {
    var home: String?
}

class RatoNetSettingsSrt: Codable {
    var latency: Int32?
    var adaptiveBitrateEnabled: Bool?
    var dnsLookupStrategy: SettingsDnsLookupStrategy?
}

class RatoNetSettingsUrlStreamVideo: Codable {
    var resolution: SettingsStreamResolution?
    var fps: Int?
    var bitrate: UInt32?
    var codec: SettingsStreamCodec?
    var bFrames: Bool?
    var maxKeyFrameInterval: Int32?
}

class RatoNetSettingsUrlStreamAudio: Codable {
    var bitrate: Int?
}

class RatoNetSettingsUrlStreamObs: Codable {
    var webSocketUrl: String
    var webSocketPassword: String

    init(webSocketUrl: String, webSocketPassword: String) {
        self.webSocketUrl = webSocketUrl
        self.webSocketPassword = webSocketPassword
    }
}

class RatoNetSettingsUrlStreamTwitch: Codable {
    var channelName: String
    var channelId: String

    init(channelName: String, channelId: String) {
        self.channelName = channelName
        self.channelId = channelId
    }
}

class RatoNetSettingsUrlStreamKick: Codable {
    var channelName: String

    init(channelName: String) {
        self.channelName = channelName
    }
}

class RatoNetSettingsUrlStream: Codable {
    var name: String
    var url: String
    // periphery:ignore
    var enabled: Bool?
    var selected: Bool?
    var video: RatoNetSettingsUrlStreamVideo?
    var audio: RatoNetSettingsUrlStreamAudio?
    var srt: RatoNetSettingsSrt?
    var obs: RatoNetSettingsUrlStreamObs?
    var twitch: RatoNetSettingsUrlStreamTwitch?
    var kick: RatoNetSettingsUrlStreamKick?

    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

class RatoNetSettingsButton: Codable {
    var type: SettingsQuickButtonType
    var enabled: Bool?

    init(type: SettingsQuickButtonType) {
        self.type = type
    }
}

class RatoNetQuickButtons: Codable {
    var twoColumns: Bool?
    var showName: Bool?
    var enableScroll: Bool?
    // Use "buttons" to enable buttons after disabling all.
    var disableAllButtons: Bool?
    var buttons: [RatoNetSettingsButton]?
}

class RatoNetSettingsRemoteControlServerRelay: Codable, ObservableObject {
    var enabled: Bool
    var baseUrl: String
    var bridgeId: String
}

class RatoNetSettingsRemoteControlAssistant: Codable {
    var enabled: Bool
    var port: UInt16
    var relay: RatoNetSettingsRemoteControlServerRelay?
}

class RatoNetSettingsRemoteControlStreamer: Codable {
    var enabled: Bool
    var url: String
}

class RatoNetSettingsRemoteControl: Codable {
    var assistant: RatoNetSettingsRemoteControlAssistant?
    var streamer: RatoNetSettingsRemoteControlStreamer?
    var password: String
}

class RatoNetSettingsUrl: Codable {
    // The last enabled stream will be selected (if any).
    var streams: [RatoNetSettingsUrlStream]?
    var quickButtons: RatoNetQuickButtons?
    var webBrowser: RatoNetSettingsWebBrowser?
    var remoteControl: RatoNetSettingsRemoteControl?

    func toString() throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .withoutEscapingSlashes]
        return try String.fromUtf8(data: encoder.encode(self))
    }

    static func fromString(query: String) throws -> RatoNetSettingsUrl {
        let query = try JSONDecoder().decode(
            RatoNetSettingsUrl.self,
            from: query.data(using: .utf8)!
        )
        for stream in query.streams ?? [] {
            if let message = isValidUrl(url: cleanUrl(url: stream.url)) {
                throw message
            }
            if let srt = stream.srt {
                if let latency = srt.latency {
                    if latency < 0 {
                        throw "Negative SRT latency"
                    }
                }
            }
            if let obs = stream.obs {
                if let message = isValidWebSocketUrl(url: cleanUrl(url: obs.webSocketUrl)) {
                    throw message
                }
            }
        }
        return query
    }
}
