/*import "package:agora_rtc_engine/agora_rtc_engine.dart";

class AgoraClient {
  RtcEngine? _engine;
  String? _channelName;
  int? _userId;

  AgoraClient({String? channelName, int? userId}) {
    _channelName = channelName;
    _userId = userId;
  }

  Future<void> joinChannel(String roomId) async {
    if (_engine == null) {
      _engine = await RtcEngine.createWithConfig(RtcEngineConfig(APP_ID));
      _engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess $channel, uid $uid');
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print('userOffline uid $uid, reason $reason');
        },
      ));
    }
    await _engine.joinChannel(TOKEN, _channelName, null, _userId);
  }

  Future<void> leaveChannel() async {
    await _engine.leaveChannel();
    _engine.destroy();
    _engine = null;
  }
}
*/