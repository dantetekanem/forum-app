App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    var link = "<a href='"+data.path+"'>"+data.message+"</a>";

    $.toast({
      text: link,
      heading: "New notification",
      position: {
        top: "10px",
        right: "10px"
      },
      hideAfter: 5000
    })
  }
});
