import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
  	console.log("Connected to the room!");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    
    $("#msg-" + data.post_id).append('<div class="message"> ' + data.content + '</div>')
    console.log("Receiving:")
    console.log(data.content)
    $(`[data-postid=${data.post_id}]`).val("")

    

    //submit_messages = function () {
		//	$(document).on('keydown', '#comment-content-12' , function (event) {	
		//    if (event.keyCode == 13) {
		//    	console.log("hitted")
		//      $('.comment-submit-' + data.post_id).click()
		//      
		//      event.target.value = ''
		//      event.preventDefault()
		//    }
		//	})
		//} //end submit
  }
});

		
		$(document).on('turbolinks:load', function () {
		  submit_messages()
		})

		var submit_messages;
		submit_messages = function () {
		  $('#comment_content').on('keydown', function (event) {
		    if (event.keyCode == 13) {
		    	console.log("hitted")
		      $('.comment-submit').click()
		      
		      event.target.value = ''
		      event.preventDefault()
		    }
		  })
		}
