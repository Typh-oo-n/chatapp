// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// Bring in Phoenix channels client library:
import { Socket, Presence } from "phoenix"

// And connect to the path in "lib/chatapp_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.
let socket = new Socket("/socket", {params: {token: window.userToken}})

// Connect to the socket:
socket.connect()

// Set up channel and presence:
const channel = socket.channel("room:lobby", {})

// Join the channel and handle presence:
channel.join()
  .receive("ok", resp => { 
    console.log("Joined successfully", resp) 
    // Initialize presence tracking
    const presence = new Presence(channel)
    presence.onSync(() => {
      // Handle presence updates here
      console.log("Presence list:", presence.list())
    })
  })
  .receive("error", resp => { console.log("Unable to join", resp) })

// Export the socket instance for use in other modules
export default socket
