/*import 'package:flutter/material.dart';

import '../agora_api.dart';

class CallScreen extends StatefulWidget {
  final String roomId;
  final bool isVideoCall;

  CallScreen({super.key, required this.roomId, required this.isVideoCall});

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final _client = AgoraClient();
  bool _muted = false;
  bool _speakerphone = false;
  bool _videoEnabled = true;

  @override
  void initState() {
    super.initState();
    _client.joinChannel(widget.roomId);
  }

  @override
  void dispose() {
    super.dispose();
    _client.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isVideoCall ? 'Appel vidéo' : 'Appel audio'),
      ),
      body: Stack(
        children: <Widget>[
          _buildRemoteView(),
          _buildLocalView(),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildRemoteView() {
    return AgoraRenderWidget(
      client: _client,
      preview: false,
    );
  }

  Widget _buildLocalView() {
    return Positioned(
      bottom: 16.0,
      right: 16.0,
      width: 120.0,
      height: 160.0,
      child: AgoraRenderWidget(
        client: _client,
        preview: true,
      ),
    );
  }

  Widget _buildControls() {
    return Positioned(
      bottom: 16.0,
      left: 16.0,
      right: 16.0,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildMuteButton(),
              _buildVideoButton(),
              _buildSwitchCameraButton(),
              _buildSpeakerphoneButton(),
            ],
          ),
          _buildHangUpButton(),
        ],
      ),
    );
  }

  Widget _buildMuteButton() {
    return RawMaterialButton(
      onPressed: () {
        setState(() {
          _muted = !_muted;
        });
        _client.mute(_muted);
      },
      shape: CircleBorder(),
      fillColor: _muted ? Colors.red : Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Icon(Icons.mic),
    );
  }

  Widget _buildVideoButton() {
    return RawMaterialButton(
      onPressed: () {
        setState(() {
          _videoEnabled = !_videoEnabled;
        });
        _client.enableVideo(_videoEnabled);
      },
      shape: CircleBorder(),
      fillColor: _videoEnabled ? Colors.white : Colors.red,
      padding: EdgeInsets.all(16.0),
      child: Icon(Icons.videocam),
    );
  }

  Widget _buildSwitchCameraButton() {
    return RawMaterialButton(
      onPressed: () {
        _client.switchCamera();
      },
      shape: CircleBorder(),
      fillColor: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Icon(Icons.switch_camera),
    );
  }

  Widget _buildSpeakerphoneButton() {
    return RawMaterialButton(
      onPressed: () {
        setState(() {
          _speakerphone = !_speakerphone;
        });
        _client.setSpeakerphone(_speakerphone);
      },
      shape: CircleBorder(),
      fillColor: _speakerphone ? Colors.blue : Colors.white,
      padding: EdgeInsets.all(16.0),
  child: Icon(Icons.volume_up),
);
}

Widget _buildHangUpButton() {
return RawMaterialButton(
onPressed: () {
_client.leaveChannel();
Navigator.of(context).pop();
},
shape: CircleBorder(),
fillColor: Colors.red,
padding: EdgeInsets.all(16.0),
child: Icon(Icons.call_end),
);
}
}*/