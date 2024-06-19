import Foundation
import Metal
import MetalKit

class MetalRenderer: NSObject, MTKViewDelegate {
  var device: MTLDevice!
  var commandQueue: MTLCommandQueue!

  override init() {
    super.init()
    device = MTLCreateSystemDefaultDevice()
    commandQueue = device.makeCommandQueue()
  }

  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    // Handle view size changes
  }

  func draw(in view: MTKView) {
    guard let drawable = view.currentDrawable else { return }
    guard let renderPassDescriptor = view.currentRenderPassDescriptor else { return }

    let commandBuffer = commandQueue.makeCommandBuffer()
    let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)

    renderEncoder?.endEncoding()
    commandBuffer?.present(drawable)
    commandBuffer?.commit()
  }
}

let device = MTLCreateSystemDefaultDevice()!
let metalView = MTKView(frame: CGRect(x: 0, y: 0, width: 800, height: 600), device: device)
let renderer = MetalRenderer()
metalView.delegate = renderer

// Set up the application window
let app = NSApplication.shared
app.setActivationPolicy(.regular)

let window = NSWindow(
  contentRect: NSRect(x: 0, y: 0, width: 800, height: 600),
  styleMask: [.titled, .closable, .resizable, .miniaturizable],
  backing: .buffered, defer: false)
window.center()
window.setFrameAutosaveName("Main Window")
window.contentView = metalView
window.makeKeyAndOrderFront(nil)

app.run()
