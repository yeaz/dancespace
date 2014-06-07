// Compatibility shim
  navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;

  // PeerJS object
  var peer = new Peer({ key: 'adlet3c4x7gmn29', debug: 3 });
  
  peer.on('open', function(){
    $('#my-id').text(peer.id);
  });

  // Receiving a call
  peer.on('call', function(call){

    // Answer the call automatically (instead of prompting user) for demo purposes
    call.answer(window.localStream);
    step2(call);
  });

  peer.on('error', function(err){
    alert(err.message);
  });

  // Click handlers setup
  $(function(){
    $('#end-call').click(function(){
      window.existingCall.close();
      window.location = '/videochats'
    });

    // Retry if getUserMedia fails
    $('#step1-retry').click(function(){
      $('#step1-error').hide();
      step1();
    });

    // Get things started
    step1();
  });

  function step1 () {
    $('#step1-error').hide();
    // Get audio/video stream
    navigator.getUserMedia({audio: true, video: true}, function(stream){
      // Set your video displays
      $('#my-video').prop('src', URL.createObjectURL(stream));

      window.localStream = stream;
    }, function(){ $('#step1-error').show(); });
    $('#step2').hide();
  }

  function step2(call) {
    // Hang up on an existing call if present
    if (window.existingCall) {
      window.existingCall.close();
    } 

    // Wait for stream on the call, then set peer video display
    call.on('stream', function(stream){
      $('#their-video').prop('src', URL.createObjectURL(stream));
    });

    // UI stuff
    window.existingCall = call;
    $('#their-id').text(call.peer);
    call.on('close', step2);
    $('#step1').hide();
    $('#step2').show();
  }
