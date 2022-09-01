import consumer from "./consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected-----------------------");
  },

  disconnected() {
    console.log("Disconnected-----------------------");
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("Receiving-----------------------");
    $("#message div").last().append(data.body);
    $("#body").val("");
    // Called when there's incoming data on the websocket for this channel
  }
});
