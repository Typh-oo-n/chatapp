// Import the socket setup
import "./user_socket.js"

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"

// Import Phoenix LiveView and any other dependencies
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"

// Fetch the CSRF token for security purposes
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

// Initialize LiveSocket with the CSRF token and additional options
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken}
})

// Configure and display a topbar progress indicator during LiveView navigation
topbar.config({ barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// Connect if there are any LiveViews on the page
liveSocket.connect()

// Expose liveSocket on window for debugging or latency simulation
window.liveSocket = liveSocket
