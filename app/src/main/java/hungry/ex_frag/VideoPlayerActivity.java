package hungry.ex_frag;

import android.net.Uri;
import android.os.Bundle;
import android.widget.MediaController;
import android.widget.VideoView;
import androidx.appcompat.app.AppCompatActivity;

public class VideoPlayerActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_video_player);

        VideoView videoView = findViewById(R.id.videoView);

        // 비디오 URI 설정 (인텐트로 전달받음)
        Uri videoUri = getIntent().getData();
        if (videoUri != null) {
            videoView.setVideoURI(videoUri);

            // 재생 컨트롤러 추가 (재생, 일시정지, 탐색 등)
            MediaController mediaController = new MediaController(this);
            mediaController.setAnchorView(videoView);
            videoView.setMediaController(mediaController);

            videoView.setOnCompletionListener(mp -> finish()); // 동영상 재생 완료 시 화면 닫기

            videoView.start();
        } else {
            finish(); // URI가 없으면 종료
        }
    }
}
