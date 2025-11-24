import UIKit
import VideoToolbox

// Protocol overview
// +----------------+-------------+-------------+
// | 4b header size | <m>b header | <n>b buffer |
// +----------------+-------------+-------------+

let ratonetAppGroup = "group.com.eerimoq.RatoNet"

extension String: @retroactive Error {}

enum SampleBufferType: Codable {
    case videoFormat
    case videoBuffer
}

struct SampleBufferHeader: Codable {
    var type: SampleBufferType
    var size: Int
    var presentationTimeStamp: Double
    var isSync: Bool
}

func createContainerDir(appGroup: String) throws -> URL {
    let fileManager = FileManager.default
    guard let containerDir = fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
        throw "Failed to create container directory"
    }
    try fileManager.createDirectory(at: containerDir, withIntermediateDirectories: true)
    return containerDir
}

func createSocketPath(containerDir: URL) -> URL {
    return containerDir.appendingPathComponent("sb.sock")
}

func removeFile(path: URL) {
    try? FileManager.default.removeItem(at: path)
}

func createAddr(path: URL) throws -> sockaddr_un {
    let path = path.path
    var addr = sockaddr_un()
    addr.sun_family = sa_family_t(AF_UNIX)
    let pathLength = path.withCString { Int(strlen($0)) }
    guard MemoryLayout.size(ofValue: addr.sun_path) > pathLength else {
        throw "sample-buffer: unix socket path \(path) too long"
    }
    _ = withUnsafeMutablePointer(to: &addr.sun_path.0) { addrPtr in
        path.withCString {
            strncpy(addrPtr, $0, pathLength)
        }
    }
    return addr
}

func createSocket() throws -> Int32 {
    let fd = Darwin.socket(AF_UNIX, SOCK_STREAM, 0)
    if fd == -1 {
        throw "Failed to create unix socket"
    }
    return fd
}

func setIgnoreSigPipe(fd: Int32) throws {
    var on: Int32 = 1
    if setsockopt(fd, SOL_SOCKET, SO_NOSIGPIPE, &on, socklen_t(MemoryLayout<Int32>.size)) == -1 {
        throw "Failed to set ignore sigpipe"
    }
}

extension Data {
    mutating func setUInt32Be(value: UInt32, offset: Int = 0) {
        withUnsafeMutableBytes { data in data.storeBytes(
            of: value.bigEndian,
            toByteOffset: offset,
            as: UInt32.self
        ) }
    }

    func getUInt32Be(offset: Int = 0) -> UInt32 {
        return withUnsafeBytes { data in
            data.load(fromByteOffset: offset, as: UInt32.self)
        }.bigEndian
    }
}
